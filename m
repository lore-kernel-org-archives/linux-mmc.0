From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] mmc: tmio: enable odd number size transfer
Date: Mon, 08 Sep 2014 12:50:24 +0400
Message-ID: <540D6DD0.0@cogentembedded.com>
References: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 9/8/2014 8:29 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> Current tmio is using sd_ctrl_read16/write16_rep()
> for data transfer.
> It works if transfer size was even number,
> but, last 1 byte will be ignored if
> transfer size was odd number.
> This patch adds new tmio_mmc_transfer_data()
> and solve this issue.

> Tested-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/mmc/host/tmio_mmc_pio.c |   42 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)

> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index ba45413..817ec7d 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -376,6 +376,43 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
>   	return 0;
>   }
>
> +static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
> +				   unsigned short *buf,
> +				   unsigned int count)
> +{
> +	int is_read = host->data->flags & MMC_DATA_READ;
> +	u16 extra;
> +	u8  *extra8;
> +	u8  *buf8;
> +
> +	/*
> +	 * Transfer the data
> +	 */
> +	if (is_read)
> +		sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
> +	else
> +		sd_ctrl_write16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
> +
> +	/* count was even number */
> +	if (!(count & 0x1))
> +		return;
> +
> +	/* count was odd number */
> +
> +	extra8 = (u8 *)&extra;
> +	buf8 = (u8 *)(buf + ((count - 1) >> 1));

    You don't need to subtract 1.

> +
> +	if (is_read) {
> +		extra = sd_ctrl_read16(host, CTL_SD_DATA_PORT);
> +
> +		buf8[1] = extra8[1];
> +	} else {
> +		extra = buf8[1] << 8;

    Hm, why [1] here and above? Shouldn't it be [0] instead?

> +
> +		sd_ctrl_write16(host, CTL_SD_DATA_PORT, extra);
> +	}
> +}
> +
>   /*
>    * This chip always returns (at least?) as much data as you ask for.
>    * I'm unsure what happens if you ask for less than a block. This should be

WBR, Sergei

