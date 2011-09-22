From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: modified the DMA threshold for SD card
Date: Thu, 22 Sep 2011 11:13:44 +0100
Message-ID: <4E7B0A58.8040408@imgtec.com>
References: <4E7B0797.4030605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:53885 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab1IVKNs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Sep 2011 06:13:48 -0400
In-Reply-To: <4E7B0797.4030605@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 09/22/2011 11:01 AM, Jaehoon Chung wrote:
> This patch modified the DMA threshold.
> 
> I didn't know exactly why need this threshold.
> But if this value is 16, we didn't read SCR register for SD card.
> Because in mmc_app_send_scr this values are used data.blocks=1 and data.blksz=8.
> (data.blocks * data.blksz = 8...so return -EINVAL)

The idea is that for a small transaction the time to set up the DMA is
probably not worth the effort, therefore it does it using PIO mode (see
dw_mci_submit_data, if dw_mci_submit_data_dma fails, it sets itself up
for pio mode instead).

So if it's using PIO mode and the SCR cannot be read, then PIO mode is
broken. What's the value of the register HCON? dw_mci_probe reads it and
decides which pio push and pull function to use based on the host data
width. I've only tested one of them as we only have one configuration of
hardware available, but you may have a different one.

Cheers
James

> 
> We didn't read the SCR register, then maybe should be set with wrong configuration.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0ed1d28..64e08e2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -47,7 +47,7 @@
>  				 DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
>  #define DW_MCI_SEND_STATUS	1
>  #define DW_MCI_RECV_STATUS	2
> -#define DW_MCI_DMA_THRESHOLD	16
> +#define DW_MCI_DMA_THRESHOLD	8
>  
>  #ifdef CONFIG_MMC_DW_IDMAC
>  struct idmac_desc {

