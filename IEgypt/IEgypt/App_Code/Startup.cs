using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(IEgypt.Startup))]
namespace IEgypt
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
