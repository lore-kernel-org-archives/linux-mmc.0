From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Tue, 15 Nov 2016 09:11:04 +0200
Message-ID: <bd5c78ca-746a-2a96-4b44-ee14ce39b917@intel.com>
References: <1479136348-30706-1-git-send-email-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9749 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932343AbcKOHQC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Nov 2016 02:16:02 -0500
In-Reply-To: <1479136348-30706-1-git-send-email-michael@walle.cc>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, yangbo lu <yangbo.lu@freescale.com>

On 14/11/16 17:12, Michael Walle wrote:
> Since commit 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy
> cards in __mmc_switch()") the ESDHC driver is broken:
>   mmc0: Card stuck in programming state! __mmc_switch
>   mmc0: error -110 whilst initialising MMC card
> 
> Since this commit __mmc_switch() uses ->card_busy(), which is
> sdhci_card_busy() for the esdhc driver. sdhci_card_busy() uses the
> PRESENT_STATE register, specifically the DAT0 signal level bit. But the
> ESDHC uses a non-conformant PRESENT_STATE register, thus a read fixup is
> required to make the driver work again.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> Fixes: 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy cards in __mmc_switch()")
> ---
> v3:
>  - explain the bits in the comments
>  - use bits[19:0] from the original value, all other will be taken from the
>    fixup value.
> 
> v2:
>  - use lower bits of the original value (that was actually a typo)
>  - add fixes tag
>  - fix typo
> 
>  drivers/mmc/host/sdhci-of-esdhc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index fb71c86..74cf3b1 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -66,6 +66,19 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>  			return ret;
>  		}
>  	}
> +	/*
> +	 * The DAT[3:0] line signal levels and the CMD line signal level are
> +	 * not compatible with standard SDHC register. The line signal levels
> +	 * DAT[7:0] are at bits 31:24 and the line signal level is at bit 23.
> +	 * All other bits are the same as in the standard SDHC register.
> +	 */
> +	if (spec_reg == SDHCI_PRESENT_STATE) {
> +		ret = value & 0x000fffff;
> +		ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
> +		ret |= (value << 1) & 0x01000000;

Please define the command line level bit in sdhci.h and use that here.
e.g.

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 766df17fb7eb..2570455b219a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -73,6 +73,7 @@
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
+#define  SDHCI_CMD_LVL		0x01000000
 
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01


> +		return ret;
> +	}
> +
>  	ret = value;
>  	return ret;
>  }
> 

