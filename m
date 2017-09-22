From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v2] mmc: dt-bindings: Add reg/source_cg/latch-ck for
 Mediatek MMC bindings
Date: Fri, 22 Sep 2017 19:59:08 +0800
Message-ID: <1506081548.28930.1.camel@mhfsdcap03>
References: <1505958774-14410-1-git-send-email-chaotian.jing@mediatek.com>
         <CACRpkdaco5XnWK-gAdGLWFZtjqnM16iT424ist5Zmd3RyAXAEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:53443 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752039AbdIVL7R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 07:59:17 -0400
In-Reply-To: <CACRpkdaco5XnWK-gAdGLWFZtjqnM16iT424ist5Zmd3RyAXAEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream@mediatek.com

On Fri, 2017-09-22 at 13:25 +0200, Linus Walleij wrote:
> On Thu, Sep 21, 2017 at 3:52 AM, Chaotian Jing
> <chaotian.jing@mediatek.com> wrote:
> 
> > +- mediatek,latch-ck: Some projects do not support enhance_rx, need set correct latch-ck to avoid data crc
> > +                    error caused by stop clock(fifo full)
> 
> I think I wrote elsewhere: replace "projects" with "systems" or "SoCs".

Sorry about that, will change to SoCs at v3.
> 
> Yours,
> Linus Walleij


