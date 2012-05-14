From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc:sdio:retry CMD52/53 when error happens
Date: Mon, 14 May 2012 14:57:58 +0200
Message-ID: <4FB10156.2080900@stericsson.com>
References: <1336984792-13956-1-git-send-email-yongd@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:60129 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755855Ab2ENM6W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 08:58:22 -0400
In-Reply-To: <1336984792-13956-1-git-send-email-yongd@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yongd <yongd@marvell.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "stefan.xk.nilsson@stericsson.com" <stefan.xk.nilsson@stericsson.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "svenkatr@ti.com" <svenkatr@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Yongd,

 From my perspective I don't think this patch is wanted.

A retry mechanism is likely very much hw-SDIO device dependent. Upper 
layers (SDIO func driver) is thus the only software that is able to 
handle retries correctly.

Kind regards
Ulf Hansson


On 05/14/2012 10:39 AM, yongd wrote:
>    Set sdio CMD52/53's retry time as MMC_CMD_RETRIES. As a result,
> sdio might benefit from core-internal CMD retry mechanism when
> some errors happen(CRC, etc).
>
> Signed-off-by: yongd<yongd@marvell.com>
> ---
>   drivers/mmc/core/sdio_ops.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index d29e206..884c27e 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -86,7 +86,7 @@ static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
>   	cmd.arg |= in;
>   	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
>
> -	err = mmc_wait_for_cmd(host,&cmd, 0);
> +	err = mmc_wait_for_cmd(host,&cmd, MMC_CMD_RETRIES);
>   	if (err)
>   		return err;
>
> @@ -147,6 +147,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>   	else
>   		cmd.arg |= 0x08000000 | blocks;		/* block mode */
>   	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
> +	cmd.retries = MMC_CMD_RETRIES;
>
>   	data.blksz = blksz;
>   	/* Code in host drivers/fwk assumes that "blocks" always is>=1 */

