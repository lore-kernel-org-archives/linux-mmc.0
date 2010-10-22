From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Fri, 22 Oct 2010 16:44:07 +0800
Message-ID: <AANLkTik8=HXEG4h2toVf7ut8TGk04HMv1DR_BxoevOC0@mail.gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101021141302.GA11912@void.printf.net>
	<20101021145249.GA13095@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35207 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0JVIy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2010 04:54:56 -0400
Received: by wwe15 with SMTP id 15so577272wwe.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2010 01:54:55 -0700 (PDT)
In-Reply-To: <20101021145249.GA13095@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Wolfram Sang <w.sang@pengutronix.de>, "eric.y.miao" <eric.y.miao@gmail.com>, Matt Fleming <matt@console-pimps.org>

On Thu, Oct 21, 2010 at 10:52 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Oct 21, 2010 at 03:13:02PM +0100, Chris Ball wrote:
>> On Mon, Oct 18, 2010 at 08:32:46AM -0400, zhangfei gao wrote:
>> > Update with comments from Matt and Eric.
>> > Test with sd and emmc.
>> >
>> > >From e5dd554ed4d3488a83d9a4888d68d1d85482f747 Mon Sep 17 00:00:00=
 2001
>> > From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> > Date: Mon, 20 Sep 2010 10:51:28 -0400
>> > Subject: [PATCH] mmc: add support of sdhci-pxa driver
>> >
>> > =A0 =A0 Support Marvell PXA168/PXA910/MMP2 SD Host Controller
>> >
>> > Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> > ---
>> > =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 32 ++++
>> > =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +=
+
>> > =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01=
 +
>> > =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0259 +++++=
+++++++++++++++++++++++++++
>> > =A04 files changed, 304 insertions(+), 0 deletions(-)
>> > =A0create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
>> > =A0create mode 100644 drivers/mmc/host/sdhci-pxa.c
>>
>> I'll take the drivers/mmc/ hunks, but you should send the plat-pxa/
>> patch through the ARM tree.
>
> Oh. =A0If we do that then the driver won't compile until everything's
> together, because it #includes <plat/sdhci.h>. =A0Haojian/Eric, what =
do
> you prefer here? =A0Should I take the arch/arm/ hunk via the MMC tree=
?
> (If so, please provide ACKs.)
>

Acked-by: Haojian Zhuang.

I'm fine on this. Please merge it via the MMC tree.


Thanks
Haojian
