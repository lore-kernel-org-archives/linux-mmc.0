From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 01/12] mmc: dt-bindings: Add reg/source_cg/latch-ck
 for Mediatek MMC bindings
Date: Sat, 14 Oct 2017 10:12:46 +0800
Message-ID: <1507947166.19789.17.camel@mhfsdcap03>
References: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
         <1507689696-25928-2-git-send-email-chaotian.jing@mediatek.com>
         <20171013215016.bkuwhhhnkvgilump@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013215016.bkuwhhhnkvgilump@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 2017-10-13 at 16:50 -0500, Rob Herring wrote:
> On Wed, Oct 11, 2017 at 10:41:25AM +0800, Chaotian Jing wrote:
> > Change the comptiable for support of multi-platform
> > Make compatible explicit
> > Add description for reg
> > Add description for source_cg
> > Add description for mediatek,latch-ck
> > Note that source_cg and mediatek,latch-ck are optional for some projects,
> > eg, MT2701 do not have source_cg, and MT2712 do not need
> > mediatek,latch-ck
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > index 4182ea3..2bb585b 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > @@ -7,10 +7,18 @@ This file documents differences between the core properties in mmc.txt
> >  and the properties used by the msdc driver.
> >  
> >  Required properties:
> > -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
> > +- compatible: value should be either of the following.
> > +	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> > +	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> > +	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> > +	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> > +- reg: physical base address of the controller and length
> >  - interrupts: Should contain MSDC interrupt number
> > -- clocks: MSDC source clock, HCLK
> > -- clock-names: "source", "hclk"
> > +- clocks: Should contain phandle for the clock feeding the MMC controller
> > +- clock-names: Should contain the following:
> > +	"source" - source clock (required)
> > +	"hclk" - HCLK which used for host (required)
> > +	"source_cg" - independent source clock gate (required for MT2712)
> >  - pinctrl-names: should be "default", "state_uhs"
> >  - pinctrl-0: should contain default/high speed pin ctrl
> >  - pinctrl-1: should contain uhs mode pin ctrl
> > @@ -30,6 +38,8 @@ Optional properties:
> >  - mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
> >  				       If present,HS400 command responses are sampled on rising edges.
> >  				       If not present,HS400 command responses are sampled on falling edges.
> > +- mediatek,latch-ck: Some SoCs do not support enhance_rx, need set correct latch-ck to avoid data crc
> > +		     error caused by stop clock(fifo full)
> 
> What values are supported? What's the default if not present.
> 
> Be clear what compatible strings this property applies to or doesn't 
> apply to.
OK, will make it more clearly at next version.
Thx!
> 
> Rob


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
