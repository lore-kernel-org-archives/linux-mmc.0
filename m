From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] mmc: meson-gx: factor out setting response configuration bits
Date: Tue, 28 Mar 2017 08:05:04 -0700
Message-ID: <m2y3vpa1cv.fsf@baylibre.com>
References: <b9a9a85b-8975-abca-7901-b557ea7ccc13@gmail.com>
        <aeb1c108-59c9-664d-ad5d-c28d95176f36@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34021 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbdC1PFk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Mar 2017 11:05:40 -0400
Received: by mail-pg0-f48.google.com with SMTP id 21so75308136pgg.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Mar 2017 08:05:06 -0700 (PDT)
In-Reply-To: <aeb1c108-59c9-664d-ad5d-c28d95176f36@gmail.com> (Heiner
        Kallweit's message of "Mon, 27 Mar 2017 22:02:32 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Factor out setting the response configuration bits thus further reducing
> complexity of function meson_mmc_start_cmd.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 0de32008..0036680b 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -456,6 +456,23 @@ static void meson_mmc_set_blksz(struct mmc_host *mmc, unsigned int blksz)
>  	writel(cfg, host->regs + SD_EMMC_CFG);
>  }
>  
> +static void meson_mmc_set_response_bits(struct mmc_command *cmd, u32 *cmd_cfg)
> +{
> +	if (cmd->flags & MMC_RSP_PRESENT) {
> +		if (cmd->flags & MMC_RSP_136)
> +			*cmd_cfg |= CMD_CFG_RESP_128;
> +		*cmd_cfg |= CMD_CFG_RESP_NUM;
> +
> +		if (!(cmd->flags & MMC_RSP_CRC))
> +			*cmd_cfg |= CMD_CFG_RESP_NOCRC;
> +
> +		if (cmd->flags & MMC_RSP_BUSY)
> +			*cmd_cfg |= CMD_CFG_R1B;
> +	} else {
> +		*cmd_cfg |= CMD_CFG_NO_RESP;
> +	}
> +}
> +
>  static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>  	struct meson_host *host = mmc_priv(mmc);
> @@ -469,20 +486,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  	cmd_cfg |= FIELD_PREP(CMD_CFG_CMD_INDEX_MASK, cmd->opcode);
>  	cmd_cfg |= CMD_CFG_OWNER;  /* owned by CPU */
>  
> -	/* Response */
> -	if (cmd->flags & MMC_RSP_PRESENT) {
> -		if (cmd->flags & MMC_RSP_136)
> -			cmd_cfg |= CMD_CFG_RESP_128;
> -		cmd_cfg |= CMD_CFG_RESP_NUM;
> -
> -		if (!(cmd->flags & MMC_RSP_CRC))
> -			cmd_cfg |= CMD_CFG_RESP_NOCRC;
> -
> -		if (cmd->flags & MMC_RSP_BUSY)
> -			cmd_cfg |= CMD_CFG_R1B;
> -	} else {
> -		cmd_cfg |= CMD_CFG_NO_RESP;
> -	}
> +	meson_mmc_set_response_bits(cmd, &cmd_cfg);
>  
>  	/* data? */
>  	if (data) {
