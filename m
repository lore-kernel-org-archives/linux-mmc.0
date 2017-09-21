From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/12] mmc: dt-bindings: update Mediatek MMC bindings
Date: Thu, 21 Sep 2017 13:38:27 +0200
Message-ID: <CACRpkdbfCFL3w6bMzT2D2rukhVkzdHPpsfZO6vYQtv_SHSjgOQ@mail.gmail.com>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
 <1505207272-16983-2-git-send-email-chaotian.jing@mediatek.com>
 <20170913141026.43oh4n4foipmahsk@rob-hp-laptop> <1505355021.8308.4.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:56351 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdIULi3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Sep 2017 07:38:29 -0400
Received: by mail-it0-f54.google.com with SMTP id g18so232442itg.5
        for <linux-mmc@vger.kernel.org>; Thu, 21 Sep 2017 04:38:28 -0700 (PDT)
In-Reply-To: <1505355021.8308.4.camel@mhfsdcap03>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream@mediatek.com

On Thu, Sep 14, 2017 at 4:10 AM, Chaotian Jing
<chaotian.jing@mediatek.com> wrote:
> On Wed, 2017-09-13 at 09:10 -0500, Rob Herring wrote:
>> On Tue, Sep 12, 2017 at 05:07:41PM +0800, Chaotian Jing wrote:

>> > +- mediatek,latch-ck: Some projects do not support enhance_rx, need set correct latch-ck to avoid data crc
>>
>> What's a project?
> eg, MT2701

Replace the word "project" with the word "system" or "SoC" in
your patch.

Yours,
Linus Walleij
