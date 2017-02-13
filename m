From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: Re: [PATCH] mmc: core: fix multi-bit bus width without high-speed
 mode
Date: Mon, 13 Feb 2017 14:00:07 +0200
Message-ID: <9236dab4-69b3-a0f0-42c5-9278cb6ff0a1@bitwise.fi>
References: <20170213114641.372-1-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:38927 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbdBMMAN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 13 Feb 2017 07:00:13 -0500
In-Reply-To: <20170213114641.372-1-anssi.hannula@bitwise.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

On 13.2.2017 13:46, Anssi Hannula wrote:
[...]
> Fix the code to allow 4-bit and 8-bit widths even without high-speed
> mode, as before.
>
> Tested with a Zynq-7000 PicoZed 7020 board.
>
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>

FYI, looks like the above CC bounced.


> Cc: <stable@vger.kernel.org>
> Fixes: 577fb13199b1 ("mmc: rework selection of bus speed mode")
> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b61b52f9..0fccca0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1706,10 +1706,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		err = mmc_select_hs400(card);
>  		if (err)
>  			goto free_card;
> -	} else if (mmc_card_hs(card)) {
> +	} else {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
> -		if (err > 0) {
> +		if (err > 0 && mmc_card_hs(card)) {
>  			err = mmc_select_hs_ddr(card);
>  			if (err)
>  				goto free_card;

-- 
Anssi Hannula / Bitwise Oy
+358503803997

