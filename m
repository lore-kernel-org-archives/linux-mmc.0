From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Thu, 15 Mar 2012 11:05:09 +0800
Message-ID: <20120315030508.GC13022@shlinux2.ap.freescale.net>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120314194123.GR26642@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:35088
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246Ab2CODDb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 23:03:31 -0400
Content-Disposition: inline
In-Reply-To: <20120314194123.GR26642@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Guo Shawn-R65073 <r65073@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "cjb@laptop.org" <cjb@laptop.org>, "rdunlap@xenotime.net" <rdunlap@xenotime.net>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>

On Thu, Mar 15, 2012 at 03:41:23AM +0800, Sascha Hauer wrote:
> On Tue, Mar 13, 2012 at 04:47:04PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > This patch includes basic dt support which can boot via nfs rootfs.
> > 
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.txt |    4 +
> >  arch/arm/boot/dts/imx28-evk.dts               |   31 +++++++++
> >  arch/arm/boot/dts/imx28.dtsi                  |   88 +++++++++++++++++++++++++
> >  arch/arm/mach-mxs/Kconfig                     |    9 +++
> >  arch/arm/mach-mxs/Makefile                    |    1 +
> >  arch/arm/mach-mxs/imx28-dt.c                  |   67 +++++++++++++++++++
> >  6 files changed, 200 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> > index 54bddda..9f21faf 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> > @@ -1,6 +1,10 @@
> 
> > +
> > +static const char *imx28_dt_compat[] __initdata = {
> > +	"fsl,imx28-evk",
> > +	NULL,
> > +};
> > +
> 
> I suggest to add a generic "fsl,imx28" entry here. It helps people to
> start an unpatched kernel on their boards.
> 
Good point.
Thanks for reminder.

Regards
Dong Aisheng

