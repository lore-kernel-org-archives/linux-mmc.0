From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc-k3: Fix DDR52 mode by setting required clock
 divisor
Date: Tue, 3 Apr 2018 19:31:24 +0800
Message-ID: <e3ec3a77-f2f3-2164-4dbb-80e1ba3ebc63@rock-chips.com>
References: <20180329182423.21201-1-ryan@edited.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329182423.21201-1-ryan@edited.us>
Sender: linux-kernel-owner@vger.kernel.org
To: oscardagrach <ryan@edited.us>
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2018/3/30 2:24, oscardagrach wrote:

Need at least one line commit body.

> Signed-off-by: oscardagrach <ryan@edited.us>
> ---
>   drivers/mmc/host/dw_mmc-k3.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 89cdb3d533bb..efc546cb4db8 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -194,8 +194,14 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>   	int ret;
>   	unsigned int clock;
>   
> -	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
> -
> +	/* CLKDIV must be 1 for DDR52/8-bit mode */
> +	if (ios->bus_width == MMC_BUS_WIDTH_8 &&
> +		ios->timing == MMC_TIMING_MMC_DDR52) {
> +		mci_writel(host, CLKDIV, 0x1);
> +		clock = ios->clock;
> +	} else {
> +		clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
> +	}

I undertand DDR52/8-bit need CLKDIV fixed 1, but shouldn't the following
change is more sensible?

if (ios->bus_width == MMC_BUS_WIDTH_8 && ios->timing ==
MMC_TIMING_MMC_DDR52)
	clock = ios->clock * 2;
else
	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;


The reason is ios->clock is 52MHz and you could claim 104MHz from the
clock provider and let dw_mmc core take care of the divder to be 1.
Otherwise, you just force it to be DDR52/8-bit with a clk rate of 26MHz.

>   	ret = clk_set_rate(host->biu_clk, clock);
>   	if (ret)
>   		dev_warn(host->dev, "failed to set rate %uHz\n", clock);
> 
