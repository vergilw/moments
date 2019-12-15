### Moments 
项目使用Cocoapods管理第三方依赖，运行前需`pod install`

### 朋友圈实现说明
页面整体使用UITableView实现，将一个Tweet分为header（头像、名字、正文、z媒体资源），comment（评论列表），separtor（分割线），三种类型Cell实现。

MomentsBaseCell为基础类型Moment，包含头像、名字、正文
MomentsImageCell、MomentsMultiImageCell继承了MomentsBaseCell，扩展了媒体资源显示。
