From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/12] mmc: dt-bindings: update Mediatek MMC bindings
Date: Mon, 2 Oct 2017 08:53:37 +0200
Message-ID: <CAPDyKFoiJJ=NM8EZ7mh+91Nj=EBYcAJmvZ3Z+xskeU3qB40HEw@mail.gmail.com>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
 <1505207272-16983-2-git-send-email-chaotian.jing@mediatek.com>
 <20170913141026.43oh4n4foipmahsk@rob-hp-laptop> <1505355021.8308.4.camel@mhfsdcap03>
 <CAPDyKFrUe-0hEsxVRQSZvujcXY8WrR6m-0DMW=VwDDLvz7Lexw@mail.gmail.com>
 <1506475100.19851.9.camel@mhfsdcap03> <1506650162.19851.12.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:52401 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbdJBGxi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 02:53:38 -0400
Received: by mail-it0-f52.google.com with SMTP id c195so6242023itb.1
        for <linux-mmc@vger.kernel.org>; Sun, 01 Oct 2017 23:53:38 -0700 (PDT)
In-Reply-To: <1506650162.19851.12.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>

[...]

>> > >> >  Required properties:
>> > >> > -- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
>> > >> > +- compatible: value should be either of the following.
>> > >> > +   "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>> > >> > +   "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>> > >> > +   "mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
>> > >> > +   "mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
>> > >> > +- reg: physical base address of the controller and length
>> > >> >  - interrupts: Should contain MSDC interrupt number
>> > >> > -- clocks: MSDC source clock, HCLK
>> > >> > -- clock-names: "source", "hclk"
>> > >> > +- clocks: MSDC source clock, HCLK, source_cg
>> > >> > +- clock-names: "source", "hclk", "source_cg"
>> > >>
>> > >> All chips support source_cg? That's not backwards compatible for
>> > >> existing compatible strings if the driver requires it.
>> > > Not all chips support source_cg, for chips which do not support
>> > > source_cg, no need source_cg here, and the driver will parse it
>> > > to know if current chip support it.
>> >
>> > In such case you must not add add a required binding for it. I think
>> > that is what Rob is trying to point out for you.
>> >
>> > [...]
>> >
>> > Kind regards
>> > Uffe
>> The source_cg is required(MUST) at MT2712 and future SoCs, but not
>> required(do not have it) at previous SoCs, so that put it at required
>> properties, let the driver to handle it.

Then you must explain that in the binding...

On 29 September 2017 at 03:56, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On Wed, 2017-09-27 at 09:18 +0800, Chaotian Jing wrote:
>> On Wed, 2017-09-27 at 00:33 +0200, Ulf Hansson wrote:
>> > On 14 September 2017 at 04:10, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> > > On Wed, 2017-09-13 at 09:10 -0500, Rob Herring wrote:
>> > >> On Tue, Sep 12, 2017 at 05:07:41PM +0800, Chaotian Jing wrote:
>> > >> > Change the comptiable for support of multi-platform
>> > >> > Add description for reg
>> > >> > Add description for source_cg
>> > >> > Add description for mediatek,latch-ck
>> > >>
>> > >> This is at least the 3rd patch with exactly the same vague subject.
>> > >> Please make the subject somewhat unique.
>> > >>
>> > > Thx, will change the subject at next version
>> > >> >
>> > >> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>> > >> > ---
>> > >> >  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 13 ++++++++++---
>> > >> >  1 file changed, 10 insertions(+), 3 deletions(-)
>> > >> >
>> > >> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > >> > index 4182ea3..405cd06 100644
>> > >> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > >> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > >> > @@ -7,10 +7,15 @@ This file documents differences between the core properties in mmc.txt
>> > >> >  and the properties used by the msdc driver.
>> > >> >
>
> Any other comments about it ? still must not add a required binding for
> it ? if add a optional binding for it, how to add it ? as cannot
> duplicate "clocks" & "clock-names" in one node.
>
>

I suggest you keep the description of the new clock name part of the
"Required properties:" header. However, after each clock name,
explicit state when the clock is required/optional. Something along
the lines as sdhci-msm does it.
Documentation/devicetree/bindings/mmc/sdhci-msm.txt

Kind regards
Uffe
