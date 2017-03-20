From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V1] mmc: core: fix still flush cache when eMMC cache off
Date: Mon, 20 Mar 2017 15:33:51 +0800
Message-ID: <654bc1ac-f3d3-d958-de7b-aeb926668cbf@rock-chips.com>
References: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:60483 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdCTHin (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 03:38:43 -0400
In-Reply-To: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "axboe@fb.com" <axboe@fb.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>

Hi

On 2017/3/19 8:45, Bean Huo (beanhuo) wrote:
> This patch fixes the issue that mmc_blk_issue_rq still
> flushes cache when eMMC cache has already been off
> through user space tool, such as mmc-utils.

I did a quick test and see the case you refer to, so

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> The reason is that card->ext_csd.cache_ctrl isn't reset.
>
> Signed-off-by: beanhuo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/block.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1621fa0..fb3635ac 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -64,6 +64,7 @@ MODULE_ALIAS("mmc:block");
>  #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
>  #define MMC_SANITIZE_REQ_TIMEOUT 240000
>  #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
> +#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
>
>  #define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
>  				  (rq_data_dir(req) == WRITE))
> @@ -535,6 +536,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>  		return data.error;
>  	}
>
> +	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
> +	    (cmd.opcode == MMC_SWITCH) && (card->ext_csd.cache_size > 0)) {
> +		if (MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1)
> +			card->ext_csd.cache_ctrl = 1;
> +		else
> +			card->ext_csd.cache_ctrl = 0;
> +	}
> +
>  	/*
>  	 * According to the SD specs, some commands require a delay after
>  	 * issuing the command.
>

