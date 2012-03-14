From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v1 3/5] ARM: imx28evk: add mmc dt support
Date: Wed, 14 Mar 2012 08:30:35 +0100
Message-ID: <20120314073035.GI18320@game.jcrosoft.org>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-4-git-send-email-b29396@freescale.com>
 <4F5F5C22.1080506@gmail.com>
 <20120313165214.GO26642@pengutronix.de>
 <4F5F879E.4030407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:53216 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753601Ab2CNHm7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 03:42:59 -0400
Received: from mail621.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 56015DC5E25
	for <linux-mmc@vger.kernel.org>; Wed, 14 Mar 2012 08:46:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F5F879E.4030407@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, vinod.koul@linux.intel.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, rdunlap@xenotime.net, kernel@pengutronix.de, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On 12:45 Tue 13 Mar     , Rob Herring wrote:
> On 03/13/2012 11:52 AM, Sascha Hauer wrote:
> > On Tue, Mar 13, 2012 at 09:39:30AM -0500, Rob Herring wrote:
> >> On 03/13/2012 03:47 AM, Dong Aisheng wrote:
> >>> From: Dong Aisheng <dong.aisheng@linaro.org>
> >>>
> >>> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> >>> ---
> >>>  arch/arm/boot/dts/imx28-evk.dts |   14 ++++++++++++++
> >>>  arch/arm/boot/dts/imx28.dtsi    |   33 +++++++++++++++++++++++++++++++++
> >>>  arch/arm/mach-mxs/imx28-dt.c    |    2 ++
> >>>  3 files changed, 49 insertions(+), 0 deletions(-)
> >>
> >> snip
> >>
> >>> diff --git a/arch/arm/mach-mxs/imx28-dt.c b/arch/arm/mach-mxs/imx28-dt.c
> >>> index 78d1129..429b88e 100644
> >>> --- a/arch/arm/mach-mxs/imx28-dt.c
> >>> +++ b/arch/arm/mach-mxs/imx28-dt.c
> >>> @@ -23,6 +23,8 @@ static const struct of_dev_auxdata imx28_auxdata_lookup[] __initconst = {
> >>>  	OF_DEV_AUXDATA("arm,pl011", MX28_DUART_BASE_ADDR, "duart", NULL),
> >>>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC0_BASE_ADDR, "imx28-fec.0", NULL),
> >>>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC1_BASE_ADDR, "imx28-fec.1", NULL),
> >>> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP0_BASE_ADDR, "mxs-mmc.0", NULL),
> >>> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP1_BASE_ADDR, "mxs-mmc.1", NULL),
> >>
> >> Why is this needed?
> > 
> > These are needed for the drivers which have still the mxs-mmc.* names
> > to find their clocks. Alternatively we could also add the appropriate
> > clocks to the clock file. Don't know if that's better though.
> 
> Ah, yes I should have known that... If clk lookup is all that's needed,
> I'd suggest adding the necessary clk lookups either here or in the clock
> code. Not much difference, but at least it removes the use of
> *_BASE_ADDR defines.
Agreed we do this on AT91

Best Regards,
J.
