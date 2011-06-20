From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 18:02:51 +0800
Message-ID: <BANLkTinGM3YUxYHgFBs9KMOrjWe1m8Esww@mail.gmail.com>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com>
	<201106201007.33908.arnd@arndb.de>
	<BANLkTikVCp7xSrfdQtmi22Drs4KLntiD8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57522 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab1FTKCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 06:02:51 -0400
Received: by vxb39 with SMTP id 39so774535vxb.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 03:02:51 -0700 (PDT)
In-Reply-To: <BANLkTikVCp7xSrfdQtmi22Drs4KLntiD8A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

>>
>> Why not just move the header file to include/linux/platform_data/?
>>
>> Then you can build the driver on all platforms, which improves the
>> build test coverage.
>>
>> =A0 =A0 =A0 =A0Arnd
>
> Hi, Arnd,
>
> Thanks a lot again :)
> It is really a good suggestion, is include/linux/platform_data/ is ne=
wly added?
> Will move the header file to platform_data/pxa_sdhci.h
> arch/arm/plat-pxa/include/plat/sdhci.h =3D>
> include/linux/platform_data/pxa_sdhci.h

In test of build sdhci-pxav3/2 with x86_64_defconfig, link error
occurs for undefined clk_*, such as clk_enable/disable, etc.
The CLKDEV_LOOKUP is selected in arch/arm/Kconfig, but not selected in
arch/x86/Kconfig.
Any suggestion?

Thanks
