From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH v4 2/3] mmc: core: Factor out the alignment of erase size
Date: Tue, 6 Sep 2016 06:34:35 +0200
Message-ID: <20160906043435.GA10158@rhlx01.hs-esslingen.de>
References: <2b6b5b930d0f37a219d5786a6b56b17516a90abd.1473130123.git.baolin.wang@linaro.org>
 <48c332c9c688796b7ea157046b8feb68a11e60d4.1473130123.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <48c332c9c688796b7ea157046b8feb68a11e60d4.1473130123.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, dianders@chromium.org, heiko@sntech.de, david@protonic.nl, hdegoede@redhat.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 06, 2016 at 10:55:11AM +0800, Baolin Wang wrote:
> In order to clean up the mmc_erase() function and do some optimization
> for erase size alignment, factor out the guts of erase size alignment
> into mmc_align_erase_size() function.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/mmc/core/core.c |   60 +++++++++++++++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 7d7209d..5f93eef 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2202,6 +2202,37 @@ out:
>  	return err;
>  }
>  
> +static unsigned int mmc_align_erase_size(struct mmc_card *card,
> +					 unsigned int *from,
> +					 unsigned int *to,
> +					 unsigned int nr)
> +{
> +	unsigned int from_new = *from, nr_new = nr, rem;
> +
> +	rem = from_new % card->erase_size;
> +	if (rem) {
> +		rem = card->erase_size - rem;
> +		from_new += rem;
> +		if (nr_new > rem)
> +			nr_new -= rem;
> +		else
> +			return 0;
> +	}
> +
> +	rem = nr_new % card->erase_size;
> +	if (rem)
> +		nr_new -= rem;
> +
> +	if (nr_new == 0)
> +		return 0;
> +
> +	/* 'from' and 'to' are inclusive */
> +	*to = from_new + nr_new - 1;
> +	*from = from_new;
> +
> +	return nr_new;
> +}
> +
>  /**
>   * mmc_erase - erase sectors.
>   * @card: card to erase
> @@ -2234,31 +2265,14 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
>  	}
>  
>  	if (arg == MMC_ERASE_ARG) {
> -		rem = from % card->erase_size;
> -		if (rem) {
> -			rem = card->erase_size - rem;
> -			from += rem;
> -			if (nr > rem)
> -				nr -= rem;
> -			else
> -				return 0;
> -		}
> -		rem = nr % card->erase_size;
> -		if (rem)
> -			nr -= rem;
> +		nr = mmc_align_erase_size(card, &from, &to, nr);
> +		if (nr == 0)
> +			return 0;
> +	} else {
> +		/* 'from' and 'to' are inclusive */
> +		to -= 1;
>  	}
>  
> -	if (nr == 0)
> -		return 0;
> -
> -	to = from + nr;
> -
> -	if (to <= from)
> -		return -EINVAL;

Hmm, this is swallowing -EINVAL behaviour
i.e., now possibly violating protocol?

(this may easily be ok - haven't done an extensive review -
but since the commit has that characteristic change,
the commit message should contain that detail)

Thanks for the cleanup work & HTH,

Andreas Mohr
