From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 3/4] mmc: meson-gx: switch to dynamic timeout values
Date: Fri, 24 Mar 2017 15:59:14 -0700
Message-ID: <m2tw6ie0xp.fsf@baylibre.com>
References: <f6960395-370e-16b0-1a2a-2a1fce720d45@gmail.com>
        <c6a47d71-edc7-5396-e275-07432dffad3a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34577 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753449AbdCXW7R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 18:59:17 -0400
Received: by mail-pg0-f44.google.com with SMTP id 21so1905722pgg.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Mar 2017 15:59:16 -0700 (PDT)
In-Reply-To: <c6a47d71-edc7-5396-e275-07432dffad3a@gmail.com> (Heiner
        Kallweit's message of "Fri, 24 Mar 2017 23:10:58 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Currently we use a fixed timeout of 4s for all data transfers. Switch
> to dynamic timeout values by making use of data->timeout_ns.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index b0a9317b..e637b3ba 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -169,6 +169,18 @@ struct sd_emmc_desc {
>  #define CMD_RESP_MASK GENMASK(31, 1)
>  #define CMD_RESP_SRAM BIT(0)
>  
> +static unsigned int meson_mmc_get_timeout(struct mmc_data *data)

nit: add an _msecs to the func name for clarity/readability.

> +{
> +	unsigned int timeout = data->timeout_ns / NSEC_PER_MSEC;
> +
> +	if (!timeout)
> +		return SD_EMMC_CMD_TIMEOUT_DATA;
> +
> +	timeout = roundup_pow_of_two(timeout);
> +
> +	return min(timeout, 32768U); /* max. 2^15 ms */
> +}
> +
>  static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
>  {
>  	struct mmc_host *mmc = host->mmc;
> @@ -448,7 +460,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
>  	if (data) {
>  		cmd_cfg |= CMD_CFG_DATA_IO;
>  		cmd_cfg |= FIELD_PREP(CMD_CFG_TIMEOUT_MASK,
> -				      ilog2(SD_EMMC_CMD_TIMEOUT_DATA));
> +				      ilog2(meson_mmc_get_timeout(data)));
>  
>  		if (data->blocks > 1) {
>  			cmd_cfg |= CMD_CFG_BLOCK_MODE;

Otherwise,

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
