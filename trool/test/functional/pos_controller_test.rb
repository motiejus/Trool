require 'test_helper'

class PosControllerTest < ActionController::TestCase
  setup do
    content = File.open(Rails.root.to_s+'/test/git.pot', 'r').read
    parser = PotInputParser.new content
    pot = Pot.new({ :filedata => content }.merge parser.parse_meta)
    @po = Po.new
    @po.pot = pot
    @po.populate_from_pot
    @po.save
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create po" do
    assert_difference('Po.count') do
      post :create, :po => { :lang => 'LT', :translator => 'Trans' },
                    :pot => { :id => @po.pot.id },
                    :data => ''
    end

    assert_redirected_to po_path(assigns(:po))

    # Either pot or po data should be given
    assert_raise(NoMethodError) do
        post :create, :po => { :lang => 'LT', :translator => 'Trans' },
                      :data => ''
    end
  end

  test "should show po" do
    get :show, :id => @po.to_param
    assert_response :success
  end

  test "should show download" do
    resp = get :download, :id => @po.to_param
    assert_match /"Unmerged paths:"\n/, resp.body
    assert_response :success
  end

  # TODO
  #test "should get edit" do
  #  get :edit, :id => @po.to_param
  #  assert_response :success
  #end

  # TODO
  #test "should update po" do
  #  put :update, :id => @po.to_param, :po => @po.attributes
  #  assert_redirected_to po_path(assigns(:po))
  #end

  # TODO
  #test "should destroy po" do
  #  assert_difference('Po.count', -1) do
  #    delete :destroy, :id => @po.to_param
  #  end

  #  assert_redirected_to pos_path
  #end
end
