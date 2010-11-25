From: Philip Rakity <prakity@marvell.com>
Subject: RE: [PATCH] sdhci: Kconfig: MMC_SDHCI_PXA: CPU_MMP2 no need
 IO_ACCESSORS
Date: Wed, 24 Nov 2010 22:33:19 -0800
Message-ID: <43E4817426ED174AA81263BCECB4351D13200C5384@sc-vexch3.marvell.com>
References: <6AF03C74-B11E-44E6-B085-35B2D2E8D8D3@marvell.com>,<AANLkTikPhD4DOOU9iC4zEiZqsy+k+mZa2x6i7faxd8SE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48953 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750973Ab0KYGj5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 25 Nov 2010 01:39:57 -0500
In-Reply-To: <AANLkTikPhD4DOOU9iC4zEiZqsy+k+mZa2x6i7faxd8SE@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


Need io accressors for pxa168 otherwise need to touch sdhci.c for returning certain register values.
________________________________________
From: zhangfei gao [zhangfei.gao@gmail.com]
Sent: Wednesday, November 24, 2010 9:31 PM
To: Philip Rakity
Cc: linux-mmc; Mark Brown
Subject: Re: [PATCH] sdhci: Kconfig: MMC_SDHCI_PXA: CPU_MMP2 no need IO_ACCESSORS

On Wed, Nov 24, 2010 at 4:30 PM, Philip Rakity <prakity@marvell.com> wrote:
> Resend as plain text
>
> From 5ffe0546fb3d70dd97af178e474fbcdfa64ea4e8 Mon Sep 17 00:00:00 2001
> From: Philip Rakity <prakity@marvell.com>
> Date: Wed, 24 Nov 2010 13:25:47 -0800
> Subject: [PATCH] sdhci: Kconfig: MMC_SDHCI_PXA: CPU_MMP2 no need IO_ACCESSORS
>
> read and write to MMP2 controller in sdhci-pxa does not use
> IO_ACCESSORS.  MMP2 hardware does not require special handling
> for read and write.
>
> change Kconfig to not set this option.  Speed Improvement.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f8fa9ef..f48532f 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -170,7 +170,7 @@ config MMC_SDHCI_PXA
>        tristate "Marvell PXA168/PXA910/MMP2 SD Host Controller support"
>        depends on ARCH_PXA || ARCH_MMP
>        select MMC_SDHCI
> -       select MMC_SDHCI_IO_ACCESSORS
> +       select MMC_SDHCI_IO_ACCESSORS if !CPU_MMP2
>        help
>          This selects the Marvell(R) PXA168/PXA910/MMP2 SD Host Controller.
>          If you have a PXA168/PXA910/MMP2 platform with SD Host Controller
> --
> 1.6.0.4
>
>
Thanks,
Could pxa168 can read HOST_VERSION from SDHCI_HOST_VERSION (BIT 0:7),
if so,  MMC_SDHCI_IO_ACCESSORS can be removed at all.
