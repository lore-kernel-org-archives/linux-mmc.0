From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v3 11/12] arm64: dts: marvell: add sdhci support for
 Armada 7K/8K
Date: Mon, 12 Dec 2016 22:18:49 +0100
Message-ID: <CAPv3WKekT7Ge94PSHTCZ9gCte7=C-3fX6DfCZOhq0mNpXW56eQ@mail.gmail.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
 <923c97f32a828b579756bf86946689ed54a0a174.1481279228.git-series.gregory.clement@free-electrons.com>
 <20161209200729.GO14217@n2100.armlinux.org.uk> <87bmwhdrx7.fsf@free-electrons.com>
 <20161212191651.GV14217@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36519 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbcLLVSv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Dec 2016 16:18:51 -0500
Received: by mail-io0-f179.google.com with SMTP id 136so19351303iou.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2016 13:18:50 -0800 (PST)
In-Reply-To: <20161212191651.GV14217@n2100.armlinux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>, Kostya Porotchkin <kostap@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Doug Jones <dougj@marvell.com>, Ryan Gao <ygao@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastia

Hi Gregory,

2016-12-12 20:16 GMT+01:00 Russell King - ARM Linux <linux@armlinux.org.uk>=
:
> On Mon, Dec 12, 2016 at 05:37:56PM +0100, Gregory CLEMENT wrote:
>> Hi Russell King,
>>
>>  On ven., d=C3=A9c. 09 2016, Russell King - ARM Linux <linux@armlinux.or=
g.uk> wrote:
>>
>> > On Fri, Dec 09, 2016 at 11:30:07AM +0100, Gregory CLEMENT wrote:
>> >> Also enable it on the Armada 7040 DB board
>> >>
>> >> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> >
>> > Hi,
>> >
>> > Can this also be added to the cp110 on the 7k/8k SoCs as well, or does
>> > it rely on other unmerged support?
>>
>> I did not add this one because until now I had not the hardware setup
>> available to test it.
>>
>> But at least I can add the ressources in the device tree and now I can
>> test it partially.
>
> There's another option: add the DT resources in a separate patch, send
> it out for someone else to test.  When it comes back with a tested-by,
> then it can be included along with the rest of the patch set.

I work on A7040-DB with SD slot from AP and CP eMMC. If you have the
board, you can use eMMC module from A3720-DB and plug it to CON11.
Some small soldering may be required. Anyway, you can also just let me
test it:)

Best regards,
Marcin
