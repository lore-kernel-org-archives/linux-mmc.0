From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: add dependence in Kconfig for pxav2/pxav3
Date: Mon, 20 Jun 2011 17:36:40 +0800
Message-ID: <BANLkTikVCp7xSrfdQtmi22Drs4KLntiD8A@mail.gmail.com>
References: <1308552287-18752-1-git-send-email-zhangfei.gao@marvell.com>
	<201106201007.33908.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55333 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab1FTJgl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 05:36:41 -0400
Received: by vxb39 with SMTP id 39so763298vxb.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 02:36:40 -0700 (PDT)
In-Reply-To: <201106201007.33908.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, Jun 20, 2011 at 4:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 20 June 2011 08:44:47 Zhangfei Gao wrote:
>> =A0 =A0 =A0 =A0 Without depends, MMC_SDHCI_PXAV3/2 can be chosen in =
other platfrom.
>> =A0 =A0 =A0 =A0 Build error will occur since plat/sdhci.h is located=
 at arch/arm/plat-pxa/
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0drivers/mmc/host/Kconfig | =A0 =A02 ++
>> =A01 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 198ddda..d33a3e2 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -183,6 +183,7 @@ config MMC_SDHCI_S3C
>>
>> =A0config MMC_SDHCI_PXAV3
>> =A0 =A0 =A0 =A0 tristate "Marvell MMP2 SD Host Controller support (P=
XAV3)"
>> + =A0 =A0 =A0 depends on ARCH_MMP
>> =A0 =A0 =A0 =A0 select MMC_SDHCI
>> =A0 =A0 =A0 =A0 select MMC_SDHCI_PLTFM
>> =A0 =A0 =A0 =A0 default CPU_MMP2
>
> Why not just move the header file to include/linux/platform_data/?
>
> Then you can build the driver on all platforms, which improves the
> build test coverage.
>
> =A0 =A0 =A0 =A0Arnd

Hi, Arnd,

Thanks a lot again :)
It is really a good suggestion, is include/linux/platform_data/ is newl=
y added?
Will move the header file to platform_data/pxa_sdhci.h
arch/arm/plat-pxa/include/plat/sdhci.h =3D>
include/linux/platform_data/pxa_sdhci.h

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
