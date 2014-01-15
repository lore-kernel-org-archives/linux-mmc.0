From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 15:59:19 +0000
Message-ID: <20140115155919.GN15937@n2100.arm.linux.org.uk>
References: <52D6A9FF.3000603@linaro.org> <1389801061-6023-1-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37672 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752298AbaAOP7d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 10:59:33 -0500
Content-Disposition: inline
In-Reply-To: <1389801061-6023-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, Sachin Kamat <sachin.kamat@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wed, Jan 15, 2014 at 11:51:01PM +0800, Zhangfei Gao wrote:
> Introduced from commit bf626e5550f24aec24975a0e85ad8e572ca76a6b
> CDETECT is ignored since negated return value of mmc_gpio_get_cd(mmc)
> can not be checked by IS_ERR_VALUE.
> Add spin_lock_bh(&host->lock) for atomic accessing DW_MMC_CARD_PRESENT,
> otherwise sd detect may occasionally fail.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reported-by: Kevin Hilman <khilman@linaro.org>
> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c  |   12 +++++++++---
>  include/linux/mmc/dw_mmc.h |    1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a776f24f4311..8326e54b96a8 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1033,7 +1033,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  	int present;
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	struct dw_mci_board *brd = slot->host->pdata;
> -	int gpio_cd = !mmc_gpio_get_cd(mmc);
> +	struct dw_mci *host = slot->host;
> +	int gpio_cd = mmc_gpio_get_cd(mmc);
>  
>  	/* Use platform get_cd function, else try onboard card detect */
>  	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
> @@ -1041,11 +1042,12 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>  	else if (brd->get_cd)
>  		present = !brd->get_cd(slot->id);
>  	else if (!IS_ERR_VALUE(gpio_cd))
> -		present = !!gpio_cd;
> +		present = gpio_cd ^ brd->cd_inverted;

I assume you haven't read the contents of mmc_gpio_get_cd()?

int mmc_gpio_get_cd(struct mmc_host *host)
{
        struct mmc_gpio *ctx = host->slot.handler_priv;

        if (!ctx || !gpio_is_valid(ctx->cd_gpio))
                return -ENOSYS;

        return !gpio_get_value_cansleep(ctx->cd_gpio) ^
                !!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
}
EXPORT_SYMBOL(mmc_gpio_get_cd);

What facility does host->caps2 give you here?  Yes, you don't need
your own cd_inverted stuff.  You should check that you're interpreting
this correctly.  When this returns true, there is a card present.

When MMC_CAP2_CD_ACTIVE_HIGH is set, gpio_get_value_cansleep() must
return non-zero when a card is inserted.  When it isn't set,
gpio_get_value_cansleep must return zero when a card is inserted.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
