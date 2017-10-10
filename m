From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
Date: Tue, 10 Oct 2017 09:19:14 +0200
Message-ID: <CAPDyKFpzuctUJ7FB9thMi0h602iJZc=kbs7iaVb+0oNCC4K4ng@mail.gmail.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
 <e4e5fa8b-b6a5-dc70-fbfc-6328493cd073@gmail.com> <1507599473.19789.1.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:56263 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752305AbdJJHTP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Oct 2017 03:19:15 -0400
Received: by mail-it0-f51.google.com with SMTP id l196so1285172itl.4
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2017 00:19:15 -0700 (PDT)
In-Reply-To: <1507599473.19789.1.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>

On 10 October 2017 at 03:37, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> On Mon, 2017-10-09 at 16:54 +0200, Matthias Brugger wrote:
>>
>> On 10/09/2017 01:35 PM, Chaotian Jing wrote:
>> > the driver has updated to have an explicit compatible, so update
>> > binding file according to the driver change.
>> >
>> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>> > ---
>> >   Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
>> >   1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > index 3e0a97c..2bb585b 100644
>> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>> > @@ -8,8 +8,8 @@ and the properties used by the msdc driver.
>> >
>> >   Required properties:
>> >   - compatible: value should be either of the following.
>> > -   "mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>> > -   "mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
>> > +   "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>> > +   "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>>
>> You can merge this with patch 1.
>
> OK, will merge it in next patch.

No, please don't!

I would like DT documentation changes to be posted in separate
patches. Moreover, those should be before driver changes, when you
order the changes in your series.

In this way, the bindings can be reviewed and acked separately, which
makes it more convenient.

Kind regards
Uffe
