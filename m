From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 2/4] mmc: dt-bindings: update Mediatek MMC bindings
Date: Wed, 14 Oct 2015 09:26:59 +0800
Message-ID: <1444786019.29605.6.camel@mhfsdcap03>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
	 <1444729078-26585-3-git-send-email-chaotian.jing@mediatek.com>
	 <20151013103845.GA4189@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([218.249.47.110]:35596 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752810AbbJNB1M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2015 21:27:12 -0400
In-Reply-To: <20151013103845.GA4189@leverpostej>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Howard Chen <ibanezchen@gmail.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Kumar Gala <galak@codeaurora.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Tue, 2015-10-13 at 11:38 +0100, Mark Rutland wrote:
> On Tue, Oct 13, 2015 at 05:37:56PM +0800, Chaotian Jing wrote:
> > Add 400Mhz clock source for HS400 mode
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index a1adfa4..745bee2 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -17,6 +17,11 @@ Required properties:
> >  - vmmc-supply: power to the Core
> >  - vqmmc-supply: power to the IO
> >  
> > +Optional properties:
> > +- clocks: 400mhz clock source for HS400
> > +- clock-names: "400mhz"
> 
> Is that really what the input line is called?
> 
> > +- hs400-ds-delay: HS400 DS delay setting
> 
> What is the format of this? Where can I derive the correct value?
> 
> Mark.
> 
This is the value of register PAD_DS_TUNE(0x188), in general, this value
is the default value of register PAD_DS_TUNE(different platform has
different value, 0x14015 is the default value of MT8173). And, this
register is used to tune data in HS400 mode, but as you know, HS400 mode
do not support CMD21, so we need find a "best" value to cover HS400
mode, if default value does not work, we have an off-line calibration
program to find the best value.
> > +
> >  Examples:
> >  mmc0: mmc@11230000 {
> >  	compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
> > @@ -24,9 +29,12 @@ mmc0: mmc@11230000 {
> >  	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
> >  	vmmc-supply = <&mt6397_vemc_3v3_reg>;
> >  	vqmmc-supply = <&mt6397_vio18_reg>;
> > -	clocks = <&pericfg CLK_PERI_MSDC30_0>, <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
> > -	clock-names = "source", "hclk";
> > +	clocks = <&pericfg CLK_PERI_MSDC30_0>,
> > +	         <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
> > +		 <&topckgen CLK_TOP_MSDCPLL_D2> ;
> > +	clock-names = "source", "hclk", "400mhz";
> >  	pinctrl-names = "default", "state_uhs";
> >  	pinctrl-0 = <&mmc0_pins_default>;
> >  	pinctrl-1 = <&mmc0_pins_uhs>;
> > +	hs400-ds-delay = <0x14015>;
> >  };
> > -- 
> > 1.8.1.1.dirty
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 


