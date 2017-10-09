From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 01/12] mmc: dt-bindings: update Mediatek MMC bindings
Date: Mon, 9 Oct 2017 10:16:29 +0800
Message-ID: <1507515389.19789.0.camel@mhfsdcap03>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
         <1505207272-16983-2-git-send-email-chaotian.jing@mediatek.com>
         <20170913141026.43oh4n4foipmahsk@rob-hp-laptop>
         <1505355021.8308.4.camel@mhfsdcap03>
         <CAPDyKFrUe-0hEsxVRQSZvujcXY8WrR6m-0DMW=VwDDLvz7Lexw@mail.gmail.com>
         <1506475100.19851.9.camel@mhfsdcap03>
         <1506650162.19851.12.camel@mhfsdcap03>
         <CAPDyKFoiJJ=NM8EZ7mh+91Nj=EBYcAJmvZ3Z+xskeU3qB40HEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoiJJ=NM8EZ7mh+91Nj=EBYcAJmvZ3Z+xskeU3qB40HEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2017-10-02 at 08:53 +0200, Ulf Hansson wrote:
> [...]
> 
> >> > >> >  Required properties:
> >> > >> > -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
> >> > >> > +- compatible: value should be either of the following.
> >> > >> > +   "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
> >> > >> > +   "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
> >> > >> > +   "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
> >> > >> > +   "mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
> >> > >> > +- reg: physical base address of the controller and length
> >> > >> >  - interrupts: Should contain MSDC interrupt number
> >> > >> > -- clocks: MSDC source clock, HCLK
> >> > >> > -- clock-names: "source", "hclk"
> >> > >> > +- clocks: MSDC source clock, HCLK, source_cg
> >> > >> > +- clock-names: "source", "hclk", "source_cg"
> >> > >>
> >> > >> All chips support source_cg? That's not backwards compatible for
> >> > >> existing compatible strings if the driver requires it.
> >> > > Not all chips support source_cg, for chips which do not support
> >> > > source_cg, no need source_cg here, and the driver will parse it
> >> > > to know if current chip support it.
> >> >
> >> > In such case you must not add add a required binding for it. I think
> >> > that is what Rob is trying to point out for you.
> >> >
> >> > [...]
> >> >
> >> > Kind regards
> >> > Uffe
> >> The source_cg is required(MUST) at MT2712 and future SoCs, but not
> >> required(do not have it) at previous SoCs, so that put it at required
> >> properties, let the driver to handle it.
> 
> Then you must explain that in the binding...
> 
> On 29 September 2017 at 03:56, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > On Wed, 2017-09-27 at 09:18 +0800, Chaotian Jing wrote:
> >> On Wed, 2017-09-27 at 00:33 +0200, Ulf Hansson wrote:
> >> > On 14 September 2017 at 04:10, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> >> > > On Wed, 2017-09-13 at 09:10 -0500, Rob Herring wrote:
> >> > >> On Tue, Sep 12, 2017 at 05:07:41PM +0800, Chaotian Jing wrote:
> >> > >> > Change the comptiable for support of multi-platform
> >> > >> > Add description for reg
> >> > >> > Add description for source_cg
> >> > >> > Add description for mediatek,latch-ck
> >> > >>
> >> > >> This is at least the 3rd patch with exactly the same vague subject.
> >> > >> Please make the subject somewhat unique.
> >> > >>
> >> > > Thx, will change the subject at next version
> >> > >> >
> >> > >> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> > >> > ---
> >> > >> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 13 ++++++++++---
> >> > >> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >> > >> >
> >> > >> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> >> > >> > index 4182ea3..405cd06 100644
> >> > >> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> >> > >> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
> >> > >> > @@ -7,10 +7,15 @@ This file documents differences between the core properties in mmc.txt
> >> > >> >  and the properties used by the msdc driver.
> >> > >> >
> >
> > Any other comments about it ? still must not add a required binding for
> > it ? if add a optional binding for it, how to add it ? as cannot
> > duplicate "clocks" & "clock-names" in one node.
> >
> >
> 
> I suggest you keep the description of the new clock name part of the
> "Required properties:" header. However, after each clock name,
> explicit state when the clock is required/optional. Something along
> the lines as sdhci-msm does it.
> Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> 
> Kind regards
> Uffe

Thx, I will send a new series of patch v2 to review.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
