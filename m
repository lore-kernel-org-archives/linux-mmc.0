From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Fri, 9 Sep 2016 20:27:56 +0300
Message-ID: <898fafe5-1257-3dab-6d85-896da7bb0291@cogentembedded.com>
References: <20160909155238.17852-1-chris.brandt@renesas.com>
 <20160909155238.17852-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160909155238.17852-3-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 09/09/2016 06:52 PM, Chris Brandt wrote:

> For the r7s72100 SOC, the DATA_PORT register was change to be 32-bits wide.
> Therefore a new flag has been created that will allow 32-bit reads/writes
> to the DATA_PORT register instead of 16-bit (because 16-bits accesses are
> not supported).
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
[...]
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 017a4dc..c38542d 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -439,10 +439,45 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
>  {
>  	int is_read = host->data->flags & MMC_DATA_READ;
>  	u8  *buf8;
> +	u32 data;
>
>  	/*
>  	 * Transfer the data
>  	 */
> +	if (host->pdata->flags & TMIO_MMC_32BIT_DATA_PORT) {
> +		if (is_read)
> +			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
> +					   count >> 2);
> +		else
> +			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
> +					    count >> 2);
> +
> +		/* if count was multiple of 4 */
> +		if (!(count & 0x3))
> +			return;
> +
> +		buf8 = (u8 *)(buf + (count >> 2));
> +		count %= 4;
> +
> +		if (is_read) {
> +			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, &data, 1);
> +			while (count--) {
> +				*buf8 = data * 0xFF;

    'data & 0xFF', perhaps?

> +				data = data >> 8;
> +				buf8++;
> +			}
> +		} else {
> +			data = *buf8++;
> +			if (count > 1)
> +				data |= (*buf8++ << 8);
> +			if (count > 2)
> +				data |= (*buf8++ << 16);
> +			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, &data, 1);
> +		}
> +
> +		return;
> +	}
> +
>  	if (is_read)
>  		sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
>  	else

MBR, Sergei
