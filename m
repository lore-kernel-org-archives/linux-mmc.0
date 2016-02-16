From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 00/25] MMC/SDHCI fixes
Date: Tue, 16 Feb 2016 14:08:34 +0100
Message-ID: <CAPDyKFr9yxCwywVfXGHxQ5oiEuLbeCv0Btt7SKJZv9gz3+FuDg@mail.gmail.com>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
	<CAPDyKFqEEHudbQ=GiQzrvrTMRynuBzFMNH5K1Yh3ZVU7UsW2mA@mail.gmail.com>
	<56BDAAB0.6010209@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34386 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbcBPNIf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Feb 2016 08:08:35 -0500
Received: by mail-yw0-f175.google.com with SMTP id h129so138508748ywb.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Feb 2016 05:08:34 -0800 (PST)
In-Reply-To: <56BDAAB0.6010209@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

[...]

>
> I have taken the liberty of re-organizing Russell's patches to put the
> bug fixes first with stable cc's.  I also did 2 tweaks which result in
> final code having the diff below to the original:
>
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f857cb2a3d05..03fbb36580f7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2270,7 +2270,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
>                  * will time out.
>                  */
>                 if (host->cmd->data &&
> -                   intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT) ==
> +                   (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
>                      SDHCI_INT_CRC) {
>                         host->cmd = NULL;
>                         return;
> @@ -2920,7 +2920,8 @@ int sdhci_add_host(struct sdhci_host *host)
>                         pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
>                                 mmc_hostname(mmc));
>                         host->flags &= ~SDHCI_USE_ADMA;
> -               } else if (dma & SDHCI_ADMA2_MASK) {
> +               } else if ((dma + host->align_buffer_sz) &
> +                          (SDHCI_ADMA2_DESC_ALIGN - 1)) {
>                         pr_warn("%s: unable to allocate aligned ADMA descriptor\n",
>                                 mmc_hostname(mmc));
>                         host->flags &= ~SDHCI_USE_ADMA;
>
>
> Where I have made changes, they are indicated in the patch commit.
>
> I did some basic testing of eMMC, SD card and SDIO, for the fixes alone
> and also the entire patch set.
>
> Russell, please let me know if this is OK, and if so, Ulf please consider
> pulling:
>
>
> The following changes since commit 7d9e20d2be0d836c4eb7afca901eced34274c8dd:
>
>   Merge branch 'fixes' into next (2016-02-08 16:22:56 +0100)
>
> are available in the git repository at:
>
>
>   git://git.infradead.org/users/ahunter/linux-sdhci.git master
>
> for you to fetch changes up to eb6bf3c3513d2e2ab77d86bc6c2f2755073f0745:
>
>   mmc: sdhci: further code simplication (2016-02-11 16:24:46 +0200)
>
> ----------------------------------------------------------------
> Russell King (22):
>       mmc: sdhci: move initialisation of command error member
>       mmc: sdhci: clean up command error handling
>       mmc: sdhci: fix command response CRC error handling
>       mmc: sdhci: avoid unnecessary mapping/unmapping of align buffer
>       mmc: sdhci: plug DMA mapping leak on error
>       mmc: sdhci-pxav3: fix higher speed mode capabilities
>       mmc: sdhci: further fix for DMA unmapping in sdhci_post_req()
>       mmc: sdhci: fix data timeout (part 1)
>       mmc: sdhci: fix data timeout (part 2)
>       mmc: sdhci: allocate alignment and DMA descriptor buffer together
>       mmc: sdhci: clean up coding style in sdhci_adma_table_pre()
>       mmc: sdhci: avoid walking SG list for writes
>       mmc: sdhci: factor out common DMA cleanup in sdhci_finish_data()
>       mmc: sdhci: move sdhci_pre_dma_transfer()
>       mmc: sdhci: factor out sdhci_pre_dma_transfer() from sdhci_adma_table_pre()
>       mmc: sdhci: pass the cookie into sdhci_pre_dma_transfer()
>       mmc: sdhci: always unmap a mapped data transfer in sdhci_post_req()
>       mmc: sdhci: clean up host cookie handling
>       mmc: sdhci: cleanup DMA un-mapping
>       mmc: sdhci: prepare DMA address/size quirk handling consolidation
>       mmc: sdhci: consolidate the DMA/ADMA size/address quicks
>       mmc: sdhci: further code simplication
>
>  drivers/mmc/host/sdhci-pxav3.c |   6 ++-
>  drivers/mmc/host/sdhci.c       | 444 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------------------------
>  drivers/mmc/host/sdhci.h       |   4 +-
>  3 files changed, 200 insertions(+), 254 deletions(-)
>
>
> Regards
> Adrian


Thanks Adrian!

I have pulled in the changes, or actually cherry-picked them as I have
re-based my next branch.

Also, I have added Gregory's tested-by tag.

Kind regards
Uffe
