From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: modify DATA register offset
Date: Mon, 17 Oct 2011 11:53:53 +0100
Message-ID: <4E9C0941.1030507@imgtec.com>
References: <4E9C0527.50706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:21479 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab1JQKx5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 06:53:57 -0400
In-Reply-To: <4E9C0527.50706@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

On 10/17/2011 11:36 AM, Jaehoon Chung wrote:
> In dw_mmc 2.40a spec, Data register's offset is changed.
> Now we used Data register offset is 0x100. but if somebody use 2.40a
> controller, must use 0x200 for Data register.
> 
> This patch is added version-id checking point and using SDMMC_DATA(x)
> instead of SDMMC_DATA. (assume 2.40a is the latest version)
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James

> ---
> v2:
>  - modify SDMMC_DATA(x) (x) instead of (0x100 + (x)) reviewed by James.
>  - add comment for new fields in dw_mci struct
>  - fix typo
> 
>  drivers/mmc/host/dw_mmc.c  |   66 ++++++++++++++++++++++++++++++--------------
>  drivers/mmc/host/dw_mmc.h  |   13 ++++++++-
>  include/linux/mmc/dw_mmc.h |    4 ++
>  3 files changed, 61 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 701f14e..3aaeb08 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1043,7 +1043,8 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
>  		buf += len;
>  		cnt -= len;
>  		if (!sg_next(host->sg) || host->part_buf_count == 2) {
> -			mci_writew(host, DATA, host->part_buf16);
> +			mci_writew(host, DATA(host->data_offset),
> +					host->part_buf16);
>  			host->part_buf_count = 0;
>  		}
>  	}
> @@ -1060,21 +1061,23 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
>  			cnt -= len;
>  			/* push data from aligned buffer into fifo */
>  			for (i = 0; i < items; ++i)
> -				mci_writew(host, DATA, aligned_buf[i]);
> +				mci_writew(host, DATA(host->data_offset),
> +						aligned_buf[i]);
>  		}
>  	} else
>  #endif
>  	{
>  		u16 *pdata = buf;
>  		for (; cnt >= 2; cnt -= 2)
> -			mci_writew(host, DATA, *pdata++);
> +			mci_writew(host, DATA(host->data_offset), *pdata++);
>  		buf = pdata;
>  	}
>  	/* put anything remaining in the part_buf */
>  	if (cnt) {
>  		dw_mci_set_part_bytes(host, buf, cnt);
>  		if (!sg_next(host->sg))
> -			mci_writew(host, DATA, host->part_buf16);
> +			mci_writew(host, DATA(host->data_offset),
> +					host->part_buf16);
>  	}
>  }
>  
> @@ -1089,7 +1092,8 @@ static void dw_mci_pull_data16(struct dw_mci *host, void *buf, int cnt)
>  			int items = len >> 1;
>  			int i;
>  			for (i = 0; i < items; ++i)
> -				aligned_buf[i] = mci_readw(host, DATA);
> +				aligned_buf[i] = mci_readw(host,
> +						DATA(host->data_offset));
>  			/* memcpy from aligned buffer into output buffer */
>  			memcpy(buf, aligned_buf, len);
>  			buf += len;
> @@ -1100,11 +1104,11 @@ static void dw_mci_pull_data16(struct dw_mci *host, void *buf, int cnt)
>  	{
>  		u16 *pdata = buf;
>  		for (; cnt >= 2; cnt -= 2)
> -			*pdata++ = mci_readw(host, DATA);
> +			*pdata++ = mci_readw(host, DATA(host->data_offset));
>  		buf = pdata;
>  	}
>  	if (cnt) {
> -		host->part_buf16 = mci_readw(host, DATA);
> +		host->part_buf16 = mci_readw(host, DATA(host->data_offset));
>  		dw_mci_pull_final_bytes(host, buf, cnt);
>  	}
>  }
> @@ -1117,7 +1121,8 @@ static void dw_mci_push_data32(struct dw_mci *host, void *buf, int cnt)
>  		buf += len;
>  		cnt -= len;
>  		if (!sg_next(host->sg) || host->part_buf_count == 4) {
> -			mci_writel(host, DATA, host->part_buf32);
> +			mci_writel(host, DATA(host->data_offset),
> +					host->part_buf32);
>  			host->part_buf_count = 0;
>  		}
>  	}
> @@ -1134,21 +1139,23 @@ static void dw_mci_push_data32(struct dw_mci *host, void *buf, int cnt)
>  			cnt -= len;
>  			/* push data from aligned buffer into fifo */
>  			for (i = 0; i < items; ++i)
> -				mci_writel(host, DATA, aligned_buf[i]);
> +				mci_writel(host, DATA(host->data_offset),
> +						aligned_buf[i]);
>  		}
>  	} else
>  #endif
>  	{
>  		u32 *pdata = buf;
>  		for (; cnt >= 4; cnt -= 4)
> -			mci_writel(host, DATA, *pdata++);
> +			mci_writel(host, DATA(host->data_offset), *pdata++);
>  		buf = pdata;
>  	}
>  	/* put anything remaining in the part_buf */
>  	if (cnt) {
>  		dw_mci_set_part_bytes(host, buf, cnt);
>  		if (!sg_next(host->sg))
> -			mci_writel(host, DATA, host->part_buf32);
> +			mci_writel(host, DATA(host->data_offset),
> +						host->part_buf32);
>  	}
>  }
>  
> @@ -1163,7 +1170,8 @@ static void dw_mci_pull_data32(struct dw_mci *host, void *buf, int cnt)
>  			int items = len >> 2;
>  			int i;
>  			for (i = 0; i < items; ++i)
> -				aligned_buf[i] = mci_readl(host, DATA);
> +				aligned_buf[i] = mci_readl(host,
> +						DATA(host->data_offset));
>  			/* memcpy from aligned buffer into output buffer */
>  			memcpy(buf, aligned_buf, len);
>  			buf += len;
> @@ -1174,11 +1182,11 @@ static void dw_mci_pull_data32(struct dw_mci *host, void *buf, int cnt)
>  	{
>  		u32 *pdata = buf;
>  		for (; cnt >= 4; cnt -= 4)
> -			*pdata++ = mci_readl(host, DATA);
> +			*pdata++ = mci_readl(host, DATA(host->data_offset));
>  		buf = pdata;
>  	}
>  	if (cnt) {
> -		host->part_buf32 = mci_readl(host, DATA);
> +		host->part_buf32 = mci_readl(host, DATA(host->data_offset));
>  		dw_mci_pull_final_bytes(host, buf, cnt);
>  	}
>  }
> @@ -1191,7 +1199,8 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
>  		buf += len;
>  		cnt -= len;
>  		if (!sg_next(host->sg) || host->part_buf_count == 8) {
> -			mci_writew(host, DATA, host->part_buf);
> +			mci_writew(host, DATA(host->data_offset),
> +					host->part_buf);
>  			host->part_buf_count = 0;
>  		}
>  	}
> @@ -1208,21 +1217,23 @@ static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
>  			cnt -= len;
>  			/* push data from aligned buffer into fifo */
>  			for (i = 0; i < items; ++i)
> -				mci_writeq(host, DATA, aligned_buf[i]);
> +				mci_writeq(host, DATA(host->data_offset),
> +						aligned_buf[i]);
>  		}
>  	} else
>  #endif
>  	{
>  		u64 *pdata = buf;
>  		for (; cnt >= 8; cnt -= 8)
> -			mci_writeq(host, DATA, *pdata++);
> +			mci_writeq(host, DATA(host->data_offset), *pdata++);
>  		buf = pdata;
>  	}
>  	/* put anything remaining in the part_buf */
>  	if (cnt) {
>  		dw_mci_set_part_bytes(host, buf, cnt);
>  		if (!sg_next(host->sg))
> -			mci_writeq(host, DATA, host->part_buf);
> +			mci_writeq(host, DATA(host->data_offset),
> +					host->part_buf);
>  	}
>  }
>  
> @@ -1237,7 +1248,8 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
>  			int items = len >> 3;
>  			int i;
>  			for (i = 0; i < items; ++i)
> -				aligned_buf[i] = mci_readq(host, DATA);
> +				aligned_buf[i] = mci_readq(host,
> +						DATA(host->data_offset));
>  			/* memcpy from aligned buffer into output buffer */
>  			memcpy(buf, aligned_buf, len);
>  			buf += len;
> @@ -1248,11 +1260,11 @@ static void dw_mci_pull_data64(struct dw_mci *host, void *buf, int cnt)
>  	{
>  		u64 *pdata = buf;
>  		for (; cnt >= 8; cnt -= 8)
> -			*pdata++ = mci_readq(host, DATA);
> +			*pdata++ = mci_readq(host, DATA(host->data_offset));
>  		buf = pdata;
>  	}
>  	if (cnt) {
> -		host->part_buf = mci_readq(host, DATA);
> +		host->part_buf = mci_readq(host, DATA(host->data_offset));
>  		dw_mci_pull_final_bytes(host, buf, cnt);
>  	}
>  }
> @@ -1952,6 +1964,18 @@ static int dw_mci_probe(struct platform_device *pdev)
>  	}
>  
>  	/*
> +	 * In 2.40a spec, Data offset is changed.
> +	 * Need to check the version-id and set data-offset for DATA register.
> +	 */
> +	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
> +	dev_info(&pdev->dev, "Version ID is %04x\n", host->verid);
> +
> +	if (host->verid < DW_MMC_240A)
> +		host->data_offset = DATA_OFFSET;
> +	else
> +		host->data_offset = DATA_240A_OFFSET;
> +
> +	/*
>  	 * Enable interrupts for command done, data over, data empty, card det,
>  	 * receive ready and error such as transmit, receive timeout, crc error
>  	 */
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index bfa3c1c..72c071f 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -14,6 +14,8 @@
>  #ifndef _DW_MMC_H_
>  #define _DW_MMC_H_
>  
> +#define DW_MMC_240A		0x240a
> +
>  #define SDMMC_CTRL		0x000
>  #define SDMMC_PWREN		0x004
>  #define SDMMC_CLKDIV		0x008
> @@ -51,7 +53,14 @@
>  #define SDMMC_IDINTEN		0x090
>  #define SDMMC_DSCADDR		0x094
>  #define SDMMC_BUFADDR		0x098
> -#define SDMMC_DATA		0x100
> +#define SDMMC_DATA(x)		(x)
> +
> +/*
> + * Data offset is difference according to Version
> + * Lower than 2.40a : data register offest is 0x100
> + */
> +#define DATA_OFFSET		0x100
> +#define DATA_240A_OFFSET	0x200
>  
>  /* shift bit field */
>  #define _SBF(f, v)		((v) << (f))
> @@ -130,6 +139,8 @@
>  #define SDMMC_IDMAC_ENABLE		BIT(7)
>  #define SDMMC_IDMAC_FB			BIT(1)
>  #define SDMMC_IDMAC_SWRESET		BIT(0)
> +/* Version ID register define */
> +#define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
>  
>  /* Register access macros */
>  #define mci_readl(dev, reg)			\
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 6b46819..adcd438 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -72,6 +72,8 @@ struct mmc_data;
>   *	rate and timeout calculations.
>   * @current_speed: Configured rate of the controller.
>   * @num_slots: Number of slots available.
> + * @verid: Denote Version ID.
> + * @data_offset: Set the offset of DATA register according to VERID.
>   * @pdev: Platform device associated with the MMC controller.
>   * @pdata: Platform data associated with the MMC controller.
>   * @slot: Slots sharing this MMC controller.
> @@ -147,6 +149,8 @@ struct dw_mci {
>  	u32			current_speed;
>  	u32			num_slots;
>  	u32			fifoth_val;
> +	u16			verid;
> +	u16			data_offset;
>  	struct platform_device	*pdev;
>  	struct dw_mci_board	*pdata;
>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];

