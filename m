From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 4/6] mmc: tmio: add eMMC support
Date: Mon, 19 Sep 2016 20:31:55 +0300
Message-ID: <ddb477a7-4b3c-e67a-22fc-93432c4c75cb@cogentembedded.com>
References: <20160919124921.8172-1-wsa+renesas@sang-engineering.com>
 <20160919124921.8172-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160919124921.8172-5-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 09/19/2016 03:49 PM, Wolfram Sang wrote:

> We need to add R1 without CRC support, refactor the bus width routine a
> little and extend a quirk check. To support "non-removable;" we need a
> workaround which will be hopefully removed when reworking PM soon.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/tmio_mmc.h     |  3 +++
>  drivers/mmc/host/tmio_mmc_pio.c | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 4b501f2d529f6e..637581faf756b1 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -79,6 +79,9 @@
>  #define	CLK_CTL_DIV_MASK	0xff
>  #define	CLK_CTL_SCLKEN		BIT(8)
>
> +#define CARD_OPT_WIDTH8		BIT(13)
> +#define CARD_OPT_WIDTH		BIT(15)
> +
>  #define TMIO_BBS		512		/* Boot block size */
>
>  /* Definitions for values the CTRL_SDIO_STATUS register can take. */
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 46b5a456243b84..a0f05eb4f34490 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
[...]
> @@ -922,14 +925,16 @@ static void tmio_mmc_power_off(struct tmio_mmc_host *host)
>  static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
>  				unsigned char bus_width)
>  {
> -	switch (bus_width) {
> -	case MMC_BUS_WIDTH_1:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> -		break;
> -	case MMC_BUS_WIDTH_4:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
> -		break;
> -	}
> +	u16 reg = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
> +				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
> +
> +	/* reg now applies to MMC_BUS_WIDTH_4 */
> +	if (bus_width == MMC_BUS_WIDTH_1)
> +		reg |= CARD_OPT_WIDTH;
> +	else if (bus_width == MMC_BUS_WIDTH_8)
> +		reg |= CARD_OPT_WIDTH8;

    Why not *switch*?

[...]

MBR, Sergei
