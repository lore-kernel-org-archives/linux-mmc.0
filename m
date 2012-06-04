From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3] MMC: core: cap MMC card timeouts at UINT_MAX
Date: Mon, 04 Jun 2012 11:13:08 +0300
Message-ID: <4FCC6E14.4010603@intel.com>
References: <CAEV-rjehr=zWTetxoBCwx0FR5ZzOqZxOTFHAuv1+3u+K=YqAAw@mail.gmail.com> <1338556815-26487-1-git-send-email-torne@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338556815-26487-1-git-send-email-torne@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Torne (Richard Coles)" <torne@google.com>
Cc: cjb@laptop.org, linus.walleij@linaro.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ben@decadent.org.uk
List-Id: linux-mmc@vger.kernel.org

On 01/06/12 16:20, Torne (Richard Coles) wrote:
> From: "Torne (Richard Coles)" <torne@google.com>
> 
> MMC CSD info can specify very large, ridiculous timeouts, big enough to
> overflow timeout_ns. This can result in the card timing out on every
> operation because the wrapped timeout value is far too small.
> 
> Fix the overflow by capping the result at UINT_MAX.  Cards specifying
> longer timeouts are almost certainly insane, and host controllers
> generally cannot support timeouts that long in any case.
> 
> Signed-off-by: Torne (Richard Coles) <torne@google.com>
> ---
>  drivers/mmc/core/core.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..74ec3d4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -512,7 +512,16 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  	if (data->flags & MMC_DATA_WRITE)
>  		mult <<= card->csd.r2w_factor;
>  
> -	data->timeout_ns = card->csd.tacc_ns * mult;
> +	/*
> +	 * The timeout in nanoseconds may overflow with some cards. Cap it at
> +	 * UINT_MAX to avoid the overflow; host controllers cannot generally
> +	 * generate timeouts that long anyway.
> +	 */
> +	if (card->csd.tacc_ns <= UINT_MAX / mult)
> +		data->timeout_ns = card->csd.tacc_ns * mult;
> +	else
> +		data->timeout_ns = UINT_MAX;
> +
>  	data->timeout_clks = card->csd.tacc_clks * mult;
>  
>  	/*

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
