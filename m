From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH v3] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Tue, 15 Nov 2016 08:28:03 +0100
Message-ID: <1689774.ZqPk1S03Lz@ws-stein>
References: <1479136348-30706-1-git-send-email-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479136348-30706-1-git-send-email-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Michael Walle <michael@walle.cc>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, yangbo lu <yangbo.lu@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On Monday 14 November 2016 16:12:27, Michael Walle wrote:
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
> Fixes: 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy cards in
> __mmc_switch()") ---
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
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> b/drivers/mmc/host/sdhci-of-esdhc.c index fb71c86..74cf3b1 100644
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
                                          ^
I guess there is a "command" missing, no?

Best regards,
Alexander
