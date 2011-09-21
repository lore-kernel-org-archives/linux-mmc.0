From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] mmc: core: Add default timeout value for CMD6.
Date: Wed, 21 Sep 2011 13:45:21 -0400
Message-ID: <m262kl6b7y.fsf@bob.laptop.org>
References: <1315466232-27487-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48273 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab1IURpm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 13:45:42 -0400
In-Reply-To: <1315466232-27487-1-git-send-email-tgih.jun@samsung.com>
	(Seungwon Jeon's message of "Thu, 8 Sep 2011 16:17:12 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Hi,

On Thu, Sep 08 2011, Seungwon Jeon wrote:
> EXT_CSD[248] includes the default maximum timeout for CMD6.
> This field is added at eMMC4.5 Spec. And it can be used for default
> timeout except for some operations which don't define the timeout(i.e.
> background operation, sanitize, flush cache) in eMMC4.5 Spec.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/mmc.c   |   19 +++++++++++++++----
>  include/linux/mmc/card.h |    1 +
>  include/linux/mmc/mmc.h  |    1 +
>  3 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5700b1c..a72d879 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -410,6 +410,15 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  	else
>  		card->erased_byte = 0x0;
>
> +	if (card->ext_csd.rev >= 6)
> +		card->ext_csd.generic_cmd6_time = 10 *
> +			ext_csd[EXT_CSD_GENERIC_CMD6_TIME];
> +	else
> +		card->ext_csd.generic_cmd6_time = 0;
> +
>  out:
>  	return err;
>  }
> @@ -668,7 +677,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  	 */

The patch is corrupt at this point:

patching file drivers/mmc/core/mmc.c
patch: **** malformed patch at line 39: @@ -668,7 +677,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
