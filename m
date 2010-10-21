From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
Date: Thu, 21 Oct 2010 22:20:13 +0800
Message-ID: <AANLkTinJuoVnCRcfr7T2P_SkizqaV6BkGLPpRPw34guC@mail.gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101021141302.GA11912@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35875 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756306Ab0JUOUO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2010 10:20:14 -0400
Received: by gyb13 with SMTP id 13so467480gyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Oct 2010 07:20:13 -0700 (PDT)
In-Reply-To: <20101021141302.GA11912@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, eric.y.miao@gmail.com, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Thu, Oct 21, 2010 at 10:13 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Zhangfei,
>
> On Mon, Oct 18, 2010 at 08:32:46AM -0400, zhangfei gao wrote:
>> Update with comments from Matt and Eric.
>> Test with sd and emmc.
>>
>> >From e5dd554ed4d3488a83d9a4888d68d1d85482f747 Mon Sep 17 00:00:00 2=
001
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Mon, 20 Sep 2010 10:51:28 -0400
>> Subject: [PATCH] mmc: add support of sdhci-pxa driver
>>
>> =A0 =A0 =A0 Support Marvell PXA168/PXA910/MMP2 SD Host Controller
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 32 ++++
>> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 ++
>> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0259 +++++++=
+++++++++++++++++++++++++
>> =A04 files changed, 304 insertions(+), 0 deletions(-)
>> =A0create mode 100644 arch/arm/plat-pxa/include/plat/sdhci.h
>> =A0create mode 100644 drivers/mmc/host/sdhci-pxa.c
>
> I'll take the drivers/mmc/ hunks, but you should send the plat-pxa/
> patch through the ARM tree.

Thanks a lot, what a relief :)
>
> Thanks,
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
>
