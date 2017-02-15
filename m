From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 16/18] mmc: meson-gx: improve response reading and sending stop command
Date: Wed, 15 Feb 2017 11:34:49 -0800
Message-ID: <m2y3x76yee.fsf@baylibre.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
        <bac15e8c-6f17-e96c-0f43-01db0df74a1b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36457 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdBOTew (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 14:34:52 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so33638171pfu.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 11:34:52 -0800 (PST)
In-Reply-To: <bac15e8c-6f17-e96c-0f43-01db0df74a1b@gmail.com> (Heiner
        Kallweit's message of "Tue, 14 Feb 2017 21:07:09 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Stopping execution at the beginning of command processing (again) is
> not needed as reading SD_EMMC_CMD_RSP implicitely stops execution.
> We just have to take care of the case that a command doesn't return a
> response. Therefore read SD_EMMC_CMD_RSP always.
>
> In addition we can read the response in the main irq handler already,
> we don't have to do this in the threaded handler.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 25b46d36..6721aee2 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -510,9 +510,6 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  
>  	WARN_ON(host->mrq != NULL);
>  
> -	/* Stop execution */
> -	writel(0, host->regs + SD_EMMC_START);
> -
>  	host->mrq = mrq;
>  	meson_mmc_start_cmd(mmc, mrq->cmd);
>  }
> @@ -521,12 +518,16 @@ static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
>  
> +	/*
> +	 * reading SD_EMMC_CMD_RSP stops processing, therefore read
> +	 * this register even if command has no response
> +	 */
>  	if (cmd->flags & MMC_RSP_136) {
>  		cmd->resp[0] = readl(host->regs + SD_EMMC_CMD_RSP3);
>  		cmd->resp[1] = readl(host->regs + SD_EMMC_CMD_RSP2);
>  		cmd->resp[2] = readl(host->regs + SD_EMMC_CMD_RSP1);
>  		cmd->resp[3] = readl(host->regs + SD_EMMC_CMD_RSP);
> -	} else if (cmd->flags & MMC_RSP_PRESENT) {
> +	} else {
>  		cmd->resp[0] = readl(host->regs + SD_EMMC_CMD_RSP);
>  	}
>  }
> @@ -564,6 +565,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  		goto out;
>  	}
>  
> +	meson_mmc_read_resp(host->mmc, cmd);
> +
>  	cmd->error = 0;
>  	if (status & IRQ_RXD_ERR_MASK) {
>  		dev_dbg(host->dev, "Unhandled IRQ: RXD error\n");
> @@ -610,10 +613,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
>  	/* ack all (enabled) interrupts */
>  	writel(status, host->regs + SD_EMMC_STATUS);
>  
> -	if (ret == IRQ_HANDLED) {
> -		meson_mmc_read_resp(host->mmc, cmd);
> +	if (ret == IRQ_HANDLED)
>  		meson_mmc_request_done(host->mmc, cmd->mrq);
> -	}
>  
>  	spin_unlock(&host->lock);
>  	return ret;
> @@ -643,7 +644,6 @@ static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
>  		data->bytes_xfered = xfer_bytes;
>  	}
>  
> -	meson_mmc_read_resp(host->mmc, cmd);
>  	if (mmc_op_multi(cmd->opcode))
>  		meson_mmc_start_cmd(host->mmc, data->stop);
>  	else
