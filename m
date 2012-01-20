From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/31] ARM: amba: mxs: convert to use amba_device_alloc
Date: Fri, 20 Jan 2012 12:39:23 +0000
Message-ID: <20120120123923.GP16726@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAhZ-0005EY-BZ@rmk-PC.arm.linux.org.uk>
 <20120120122535.GA25917@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120120122535.GA25917@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, STEricsson <STEricsson_nomadik_linux@list.st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 20, 2012 at 08:25:39PM +0800, Shawn Guo wrote:
> On Fri, Jan 20, 2012 at 09:24:05AM +0000, Russell King - ARM Linux wrote:
> > Convert MXS to use the new amba_device_alloc APIs.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-mxs/devices.c |    8 +++++---
> >  1 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mxs/devices.c b/arch/arm/mach-mxs/devices.c
> > index fe3e847..052d8dd 100644
> > --- a/arch/arm/mach-mxs/devices.c
> > +++ b/arch/arm/mach-mxs/devices.c
> > @@ -77,16 +77,18 @@ struct platform_device *__init mxs_add_platform_device_dmamask(
> >  
> >  int __init mxs_add_amba_device(const struct amba_device *dev)
> >  {
> > -	struct amba_device *adev = kmalloc(sizeof(*adev), GFP_KERNEL);
> > +	struct amba_device *adev = amba_device_alloc(dev->init_name,
> 
> The 'dev->init_name' needs to be 'dev->dev.init_name'.  Otherwise, we
> see the compile error below.

Good catch, fixed, and ack added, thanks.
