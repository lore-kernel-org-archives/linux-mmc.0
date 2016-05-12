From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH/RFC 1/3] mmc: tmio: Add tuning support
Date: Thu, 12 May 2016 06:12:44 +0000
Message-ID: <SG2PR06MB091980ABDB9B697B47A1AE98D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
 <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1462859524-28522-2-git-send-email-horms+renesas@verge.net.au>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Simon-san,

> From: Behalf Of Simon Horman
> Sent: Tuesday, May 10, 2016 2:52 PM
> 
> From: Ai Kyuse <ai.kyuse.uw@renesas.com>
> 
> Add tuning support for use with SDR104 mode
> 
> Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have some minor comments :)

< snip >
> @@ -753,6 +785,157 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
>  	return 0;
>  }
> 
> +#define TMIO_MMC_MAX_TUNING_LOOP 40
> +
> +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +	struct mmc_ios *ios = &mmc->ios;
> +
> +	unsigned long timeout, val;
> +	unsigned long *tap;
> +	int tuning_loop_counter = TMIO_MMC_MAX_TUNING_LOOP;
< snip >
> +	/*
> +	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
> +	 * of loops reaches 40 times or a timeout of 150ms occurs.
> +	 */
> +	timeout = 150;

The tuning_loop_counter is 40 and timeout is 150.
However,

> +	do {
> +		if (host->prepare_tuning)
> +			host->prepare_tuning(host, val % num);
> +
> +		if (!tuning_loop_counter && !timeout)
> +			break;

< snip >

> +		tuning_loop_counter--;
> +		timeout--;
> +		mdelay(1);
> +	} while ((val < (num * 2)) && (tuning_loop_counter || timeout));

They will be decreased by 1. So, I think we don't need either variable.

> +	/*
> +	 * The Host Driver has exhausted the maximum number of loops allowed,
> +	 * so use fixed sampling frequency.
> +	 */
> +	if (tuning_loop_counter || timeout) {
> +		if (host->select_tuning) {
> +			ret = host->select_tuning(host, tap);
> +			if (ret < 0)
> +				goto out;
> +		}
> +		host->done_tuning = true;
> +	} else {
> +		dev_warn(&host->pdev->dev, ": Tuning procedure failed\n");

The first 2 charactors ": " is strange to me.

> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +out:
> +	kfree(data_buf);
> +err_data:
> +	kfree(tap);
> +err_tap:
> +	if (ret < 0 && host->hw_reset)
> +		host->hw_reset(host);

We can use tmio_mmc_hw_reset() of this patch.
Then, we can remove the condition of "host->hw_reset".

Best regards,
Yoshihiro Shimoda

> +	return ret;
> +
> +}
> +
>  /* Process requests from the MMC layer */
>  static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
> @@ -778,6 +961,43 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> 
>  	spin_unlock_irqrestore(&host->lock, flags);
> 
> +	if (host->inquiry_tuning && host->inquiry_tuning(host) &&
> +	    !host->done_tuning) {
> +		/* Start retuning */
> +		ret = tmio_mmc_execute_tuning(mmc, MMC_SEND_TUNING_BLOCK);
> +		if (ret)
> +			goto fail;
> +		/* Restore request */
> +		host->mrq = mrq;
> +	}
> +
> +	if (mrq->sbc) {
> +		init_completion(&host->completion);
> +		ret = tmio_mmc_start_command(host, mrq->sbc);
> +		if (ret)
> +			goto fail;
> +		ret = wait_for_completion_timeout(&host->completion,
> +					msecs_to_jiffies(CMDREQ_TIMEOUT));
> +		if (ret < 0)
> +			goto fail;
> +		if (!ret) {
> +			ret = -ETIMEDOUT;
> +			goto fail;
> +		}
> +		host->last_req_ts = jiffies;
> +		host->mrq = mrq;
> +		if (host->inquiry_tuning && host->inquiry_tuning(host) &&
> +		    !host->done_tuning) {
> +			/* Start retuning */
> +			ret = tmio_mmc_execute_tuning(mmc,
> +						      MMC_SEND_TUNING_BLOCK);
> +			if (ret)
> +				goto fail;
> +			/* Restore request */
> +			host->mrq = mrq;
> +		}
> +	}
> +
>  	if (mrq->data) {
>  		ret = tmio_mmc_start_data(host, mrq->data);
>  		if (ret)
> @@ -967,6 +1187,16 @@ static int tmio_mmc_card_busy(struct mmc_host *mmc)
>  	return !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS) & TMIO_STAT_DAT0);
>  }
> 
> +static void tmio_mmc_hw_reset(struct mmc_host *mmc)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +
> +	if (host->hw_reset)
> +		host->hw_reset(host);
> +
> +	host->done_tuning = false;
> +}
> +
>  static struct mmc_host_ops tmio_mmc_ops = {
>  	.request	= tmio_mmc_request,
>  	.set_ios	= tmio_mmc_set_ios,
> @@ -975,6 +1205,8 @@ static struct mmc_host_ops tmio_mmc_ops = {
>  	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
>  	.card_busy	= tmio_mmc_card_busy,
>  	.multi_io_quirk	= tmio_multi_io_quirk,
> +	.execute_tuning = tmio_mmc_execute_tuning,
> +	.hw_reset	= tmio_mmc_hw_reset,
>  };
> 
>  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> @@ -1084,6 +1316,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>  	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
>  	mmc->max_seg_size = mmc->max_req_size;
> 
> +	_host->done_tuning = false;
>  	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
>  				  mmc->caps & MMC_CAP_NEEDS_POLL ||
>  				  mmc->caps & MMC_CAP_NONREMOVABLE ||
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 7a26286db895..6c22b21f2d73 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -104,6 +104,9 @@
>   */
>  #define TMIO_MMC_CLK_ACTUAL		(1 << 10)
> 
> +/* Some controllers have UHS-I sampling clock controller */
> +#define TMIO_MMC_HAS_UHS_SCC		(1 << 11)
> +
>  int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
>  int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
>  void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
> --
> 2.1.4
