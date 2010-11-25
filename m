From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] sdhci: Kconfig: MMC_SDHCI_PXA: CPU_MMP2 no need IO_ACCESSORS
Date: Thu, 25 Nov 2010 00:31:25 -0500
Message-ID: <AANLkTikPhD4DOOU9iC4zEiZqsy+k+mZa2x6i7faxd8SE@mail.gmail.com>
References: <6AF03C74-B11E-44E6-B085-35B2D2E8D8D3@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35841 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab0KYFb0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2010 00:31:26 -0500
Received: by fxm13 with SMTP id 13so449295fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2010 21:31:25 -0800 (PST)
In-Reply-To: <6AF03C74-B11E-44E6-B085-35B2D2E8D8D3@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On Wed, Nov 24, 2010 at 4:30 PM, Philip Rakity <prakity@marvell.com> wr=
ote:
> Resend as plain text
>
> From 5ffe0546fb3d70dd97af178e474fbcdfa64ea4e8 Mon Sep 17 00:00:00 200=
1
> From: Philip Rakity <prakity@marvell.com>
> Date: Wed, 24 Nov 2010 13:25:47 -0800
> Subject: [PATCH] sdhci: Kconfig: MMC_SDHCI_PXA: CPU_MMP2 no need IO_A=
CCESSORS
>
> read and write to MMP2 controller in sdhci-pxa does not use
> IO_ACCESSORS. =A0MMP2 hardware does not require special handling
> for read and write.
>
> change Kconfig to not set this option. =A0Speed Improvement.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> =A0drivers/mmc/host/Kconfig | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f8fa9ef..f48532f 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -170,7 +170,7 @@ config MMC_SDHCI_PXA
> =A0 =A0 =A0 =A0tristate "Marvell PXA168/PXA910/MMP2 SD Host Controlle=
r support"
> =A0 =A0 =A0 =A0depends on ARCH_PXA || ARCH_MMP
> =A0 =A0 =A0 =A0select MMC_SDHCI
> - =A0 =A0 =A0 select MMC_SDHCI_IO_ACCESSORS
> + =A0 =A0 =A0 select MMC_SDHCI_IO_ACCESSORS if !CPU_MMP2
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This selects the Marvell(R) PXA168/PXA910/MMP2 SD =
Host Controller.
> =A0 =A0 =A0 =A0 =A0If you have a PXA168/PXA910/MMP2 platform with SD =
Host Controller
> --
> 1.6.0.4
>
>
Thanks,
Could pxa168 can read HOST_VERSION from SDHCI_HOST_VERSION (BIT 0:7),
if so,  MMC_SDHCI_IO_ACCESSORS can be removed at all.
