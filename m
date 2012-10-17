From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH 1/3] drivers: mmc: core: sdio.c: fixed lines with > 80
 chars
Date: Wed, 17 Oct 2012 21:35:06 +0200
Message-ID: <2287CF3D-1EF7-4474-9821-165256A03758@nvidia.com>
References: <n> <1350483199-3048-1-git-send-email-antiroot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:10002 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433Ab2JQTfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 15:35:16 -0400
In-Reply-To: <1350483199-3048-1-git-send-email-antiroot@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sangho Yi <antiroot@gmail.com>
Cc: "prakity@marvell.com" <prakity@marvell.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "ulf.hansson@stericsson.com" <ulf.hansson@stericsson.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On 17 Oct 2012, at 15:13, Sangho Yi <antiroot@gmail.com> wrote:

> Fixed coding style warning cases for exceeding 80 chars per line on
> sdio.c.
> 
> Signed-off-by: Sangho Yi <antiroot@gmail.com>
> ---
> drivers/mmc/core/sdio.c |    6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 2273ce6..14326e8 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -47,7 +47,8 @@ static int sdio_read_fbr(struct sdio_func *func)
> 
> 	if (data == 0x0f) {
> 		ret = mmc_io_rw_direct(func->card, 0, 0,
> -			SDIO_FBR_BASE(func->num) + SDIO_FBR_STD_IF_EXT, 0, &data);
> +			SDIO_FBR_BASE(func->num) + SDIO_FBR_STD_IF_EXT,
> +			0, &data);
> 		if (ret)
> 			goto out;
> 	}
> @@ -619,7 +620,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
> 		card->type = MMC_TYPE_SD_COMBO;
> 
> 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
> -		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
> +			memcmp(card->raw_cid, oldcard->raw_cid,
> +			sizeof(card->raw_cid)) != 0)) {
could you ident the sizeof one more tab stop
> 			mmc_remove_card(card);
> 			return -ENOENT;
> 		}
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

