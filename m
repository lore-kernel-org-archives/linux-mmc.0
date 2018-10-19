From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 6/6] mmc: mediatek: drop too much code of tuning method
Date: Fri, 19 Oct 2018 10:54:21 +0200
Message-ID: <513726cb-79e8-ca4d-e887-bf63c833260b@gmail.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
 <1539415250-32337-7-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539415250-32337-7-git-send-email-chaotian.jing@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
List-Id: linux-mmc@vger.kernel.org



On 13/10/2018 09:20, Chaotian Jing wrote:
> the tuning code is becoming more and more bloated, let's make the
> set cmd/data delay to inline function to avoid too much redundant code.
> 
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 133 +++++++++++++---------------------------------
>  1 file changed, 38 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
[...]> @@ -1923,17 +1898,8 @@ static int msdc_tune_together(struct mmc_host
*mmc, u32 opcode)
>  	sdr_clr_bits(host->base + MSDC_IOCON,
>  		     MSDC_IOCON_DSPL | MSDC_IOCON_W_DSPL);
>  	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
> -		if (host->top_base) {
> -			sdr_set_field(host->top_base + EMMC_TOP_CMD,
> -				      PAD_CMD_RXDLY, i);
> -			sdr_set_field(host->top_base + EMMC_TOP_CONTROL,
> -				      PAD_DAT_RD_RXDLY, i);
> -		} else {
> -			sdr_set_field(host->base + tune_reg,
> -				      MSDC_PAD_TUNE_CMDRDLY, i);
> -			sdr_set_field(host->base + tune_reg,
> -				      MSDC_PAD_TUNE_DATRRDLY, i);
> -		}
> +		msdc_set_cmd_delay(host, i);
> +		msdc_set_data_delay(host, i);

Put the clean-up before introducing msdc_tune_together, that makes the series
much easier to read.

Thanks,
Matthias
