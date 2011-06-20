From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 18:26:27 +0800
Message-ID: <BANLkTi=_qEQT5f_FcAEYz2Y5p6FGJU+P5Q@mail.gmail.com>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com>
	<201106201007.33908.arnd@arndb.de>
	<BANLkTikVCp7xSrfdQtmi22Drs4KLntiD8A@mail.gmail.com>
	<BANLkTinGM3YUxYHgFBs9KMOrjWe1m8Esww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48909 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab1FTK03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 06:26:29 -0400
Received: by vws1 with SMTP id 1so751095vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 03:26:28 -0700 (PDT)
In-Reply-To: <BANLkTinGM3YUxYHgFBs9KMOrjWe1m8Esww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, Jun 20, 2011 at 6:02 PM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
>>>
>>> Why not just move the header file to include/linux/platform_data/?
>>>
>>> Then you can build the driver on all platforms, which improves the
>>> build test coverage.
>>>
>>> =A0 =A0 =A0 =A0Arnd
>>
>> Hi, Arnd,
>>
>> Thanks a lot again :)
>> It is really a good suggestion, is include/linux/platform_data/ is n=
ewly added?
>> Will move the header file to platform_data/pxa_sdhci.h
>> arch/arm/plat-pxa/include/plat/sdhci.h =3D>
>> include/linux/platform_data/pxa_sdhci.h
>
> In test of build sdhci-pxav3/2 with x86_64_defconfig, link error
> occurs for undefined clk_*, such as clk_enable/disable, etc.
> The CLKDEV_LOOKUP is selected in arch/arm/Kconfig, but not selected i=
n
> arch/x86/Kconfig.
> Any suggestion?
>
> Thanks
>

Hi Arnd

Currently, clk_enable, clk_disable, clk_get_rate realization are
located at arch.
Driver/clk/clkdev.c only realize clk_get/put.

I am afraid it may difficult to build the driver on other arch, like
x86,  so we may still need "depends on ARCH_MMP" for safety.

Thanks
