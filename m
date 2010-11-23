From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time. Change Kconfig
Date: Mon, 22 Nov 2010 21:46:14 -0500
Message-ID: <AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38770 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0KWCqO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2010 21:46:14 -0500
Received: by qyk12 with SMTP id 12so1154374qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2010 18:46:14 -0800 (PST)
In-Reply-To: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei.gao@gmail.com, cjb@laptop.org
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, markb@marvell.com

On Wed, Nov 17, 2010 at 9:56 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
> From 9de09a0575163c223f0aed0842daec9161b2f72e Mon Sep 17 00:00:00 200=
1
> From: Philip Rakity <prakity@marvell.com>
> Date: Wed, 17 Nov 2010 18:52:16 -0800
> Subject: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time. Ch=
ange Kconfig
>
> sdhci-pxa.c currently only supports mmp2. =A0pxa168 and pxa9xx
> controllers are not quite compatible with this code.
>
> Disable the ability to select them until sdhci-pxa is changes
> to support these systems.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Mark Brown <markb@marvell.com>
> ---
> =A0drivers/mmc/host/Kconfig | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f8fa9ef..de138de 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -168,12 +168,12 @@ config MMC_SDHCI_S3C
>
> =A0config MMC_SDHCI_PXA
> =A0 =A0 =A0 =A0tristate "Marvell PXA168/PXA910/MMP2 SD Host Controlle=
r support"
> - =A0 =A0 =A0 depends on ARCH_PXA || ARCH_MMP
> + =A0 =A0 =A0 depends on (ARCH_PXA || ARCH_MMP) && (MACH_MARVELL_JASP=
ER || MACH_FLINT)
> =A0 =A0 =A0 =A0select MMC_SDHCI
> =A0 =A0 =A0 =A0select MMC_SDHCI_IO_ACCESSORS
> =A0 =A0 =A0 =A0help
> - =A0 =A0 =A0 =A0 This selects the Marvell(R) PXA168/PXA910/MMP2 SD H=
ost Controller.
> - =A0 =A0 =A0 =A0 If you have a PXA168/PXA910/MMP2 platform with SD H=
ost Controller
> + =A0 =A0 =A0 =A0 This selects the Marvell(R) MMP2 SD Host Controller=
=2E
> + =A0 =A0 =A0 =A0 If you have a MMP2 platform with SD Host Controller
> =A0 =A0 =A0 =A0 =A0and a card slot, say Y or M here.
>
> =A0 =A0 =A0 =A0 =A0If unsure, say N.
> --
> 1.6.0.4
>

Currently the driver sdhci-pxa only supports the 88AP610 (MMP2)
platform only. Until the sdhci-pxa code fixed or forked to support
pxa168 and pxa910 we need to Philip's patch. Any feedback on this
would be good thanks.
