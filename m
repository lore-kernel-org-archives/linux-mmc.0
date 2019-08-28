From: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH] mmc: core: Fix init of SD cards reporting an invalid
 VDD range
Date: Tue, 27 Aug 2019 18:15:18 -0700
Message-ID: <20190827181518.2e7aaa44@fido6>
References: <20190827081043.15443-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190827081043.15443-1-ulf.hansson@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 10:10:43 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The OCR register defines the supported range of VDD voltages for SD
> cards. However, it has turned out that some SD cards reports an
> invalid voltage range, for example having bit7 set.
> 
> When a host supports MMC_CAP2_FULL_PWR_CYCLE and some of the voltages
> from the invalid VDD range, this triggers the core to run a power
> cycle of the card to try to initialize it at the lowest common
> supported voltage. Obviously this fails, since the card can't support
> it.
> 
> Let's fix this problem, by clearing invalid bits from the read OCR
> register for SD cards, before proceeding with the VDD voltage
> negotiation.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Philip Langdale <philipl@overt.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index d681e8aaca83..fe914ff5f5d6 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1292,6 +1292,12 @@ int mmc_attach_sd(struct mmc_host *host)
>  			goto err;
>  	}
>  
> +	/*
> +	 * Some SD cards claims an out of spec VDD voltage range.
> Let's treat
> +	 * these bits as being in-valid and especially also bit7.
> +	 */
> +	ocr &= ~0x7FFF;
> +
>  	rocr = mmc_select_voltage(host, ocr);
>  
>  	/*

Looks right. Tried it out and worked as expected.

Reviewed-by: Philip Langdale <philipl@overt.org>

--phil
