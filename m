From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH] mmc: core: Let mmc_send_tuning() to take struct
 mmc_host* as parameter
Date: Fri, 5 Dec 2014 19:03:26 +0800
Message-ID: <20141205110325.GB21173@shlinux1.ap.freescale.net>
References: <1417776083-13499-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0104.outbound.protection.outlook.com ([65.55.169.104]:19411
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751325AbaLELgZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 06:36:25 -0500
Content-Disposition: inline
In-Reply-To: <1417776083-13499-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Stephen Boyd <sboyd@codeaurora.org>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On Fri, Dec 05, 2014 at 11:41:23AM +0100, Ulf Hansson wrote:
> To be able to use mmc_send_tuning() prior the struct mmc_card has been
> allocated, let's convert it to take the struct mmc_host* as parameter
> instead.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Dong Aisheng <b29396@freescale.com>

Regards
Dong Aisheng

> ---
>  drivers/mmc/core/mmc_ops.c | 7 +++----
>  include/linux/mmc/core.h   | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 12b2a32..3b044c5 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -547,14 +547,13 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  }
>  EXPORT_SYMBOL_GPL(mmc_switch);
>  
> -int mmc_send_tuning(struct mmc_card *card)
> +int mmc_send_tuning(struct mmc_host *host)
>  {
>  	struct mmc_request mrq = {NULL};
>  	struct mmc_command cmd = {0};
>  	struct mmc_data data = {0};
>  	struct scatterlist sg;
> -	struct mmc_host *mmc = card->host;
> -	struct mmc_ios *ios = &mmc->ios;
> +	struct mmc_ios *ios = &host->ios;
>  	const u8 *tuning_block_pattern;
>  	int size, err = 0;
>  	u8 *data_buf;
> @@ -596,7 +595,7 @@ int mmc_send_tuning(struct mmc_card *card)
>  	data.sg_len = 1;
>  	sg_init_one(&sg, data_buf, size);
>  
> -	mmc_wait_for_req(mmc, &mrq);
> +	mmc_wait_for_req(host, &mrq);
>  
>  	if (cmd.error) {
>  		err = cmd.error;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index c4bdaa1..cb2b040 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -154,7 +154,7 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
>  extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
>  			bool, bool);
>  extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
> -extern int mmc_send_tuning(struct mmc_card *card);
> +extern int mmc_send_tuning(struct mmc_host *host);
>  extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>  
>  #define MMC_ERASE_ARG		0x00000000
> -- 
> 1.9.1
> 
