From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: fix changing bus witdh in hs400es mode
Date: Fri, 3 Mar 2017 11:43:05 +0800
Message-ID: <78c1d56c-5272-f6c6-bb55-447857acb6b8@rock-chips.com>
References: <1488462454-905-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488462454-905-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Gwendal Grignou <gwendal@chromium.org>, Dong Aisheng <aisheng.dong@nxp.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Poitr,

On 2017/3/2 21:47, Piotr Sroka wrote:
> Fix the code to avoid changing bus width if HS400ES mode is selected.
>

Thanks for catching this, but Guenter posted a fix[1] already. :)

[1]: https://patchwork.kernel.org/patch/9599261/

> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7fd7228..c7d9c9f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1730,7 +1730,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		err = mmc_select_hs400(card);
>  		if (err)
>  			goto free_card;
> -	} else {
> +	} else if (!mmc_card_hs400(card)) {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
>  		if (err > 0 && mmc_card_hs(card)) {
>


-- 
Best Regards
Shawn Lin
