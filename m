From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Enable MMC card reader for RICOH [1180:e823]
Date: Thu, 26 May 2011 23:01:04 -0400
Message-ID: <m3fwo0u9sf.fsf@pullcord.laptop.org>
References: <1306426745-3636-1-git-send-email-manoj.iyer@canonical.com>
	<1306426745-3636-2-git-send-email-manoj.iyer@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42928 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085Ab1E0DAA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 May 2011 23:00:00 -0400
In-Reply-To: <1306426745-3636-2-git-send-email-manoj.iyer@canonical.com>
	(Manoj Iyer's message of "Thu, 26 May 2011 11:19:05 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manoj Iyer <manoj.iyer@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, philipl@overt.org, w.sang@pengutronix.de

Hi Manoj,

On Thu, May 26 2011, Manoj Iyer wrote:
> Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
> ---
>  drivers/pci/quirks.c    |    2 ++
>  include/linux/pci_ids.h |    1 +
>  2 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e8a1406..02145e9 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2761,6 +2761,8 @@ static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C832, ricoh_mmc_fixup_r5c832);
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C832, ricoh_mmc_fixup_r5c832);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE823, ricoh_mmc_fixup_r5c832);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE823, ricoh_mmc_fixup_r5c832);
>  #endif /*CONFIG_MMC_RICOH_MMC*/
>  
>  #if defined(CONFIG_DMAR) || defined(CONFIG_INTR_REMAP)
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24787b7..2269dac 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1537,6 +1537,7 @@
>  #define PCI_DEVICE_ID_RICOH_RL5C476	0x0476
>  #define PCI_DEVICE_ID_RICOH_RL5C478	0x0478
>  #define PCI_DEVICE_ID_RICOH_R5C822	0x0822
> +#define PCI_DEVICE_ID_RICOH_R5CE823	0xe823
>  #define PCI_DEVICE_ID_RICOH_R5C832	0x0832
>  #define PCI_DEVICE_ID_RICOH_R5C843	0x0843

Do you not need a corresponding entry in drivers/mmc/host/sdhci-pci.c's
pci_device_id struct?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
