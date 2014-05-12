From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 5/5] mmc: dw_mmc: use the mmc regulator API into core.c
Date: Mon, 12 May 2014 12:41:54 -0500
Message-ID: <1399916514.5497.1.camel@linux-builds1>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
	 <1399893256-7071-6-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:36214
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751145AbaELRon (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 May 2014 13:44:43 -0400
In-Reply-To: <1399893256-7071-6-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org

On Mon, 2014-05-12 at 20:14 +0900, Jaehoon Chung wrote:
> Use the mmc regulator API into core.c instead of enabling locally.
> It can use the "vmmc", and optional "vqmmc".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   61 ++++++++++++++++++---------------------------
>  1 file changed, 24 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e0e933d..3ab7231 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -937,6 +937,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>  	u32 regs;
> +	int ret;
>  
>  	switch (ios->bus_width) {
>  	case MMC_BUS_WIDTH_4:
> @@ -975,16 +976,36 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	switch (ios->power_mode) {
>  	case MMC_POWER_UP:
> +		if (!IS_ERR(mmc->supply.vmmc))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +
>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
>  		regs = mci_readl(slot->host, PWREN);
>  		regs |= (1 << slot->id);
>  		mci_writel(slot->host, PWREN, regs);
> +

Looks like stray newline here?

Dinh


