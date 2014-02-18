From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 4/8] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Tue, 18 Feb 2014 21:49:21 +0100
Message-ID: <5303C751.5090809@redhat.com>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch> <20140217100234.15040.84232.stgit@pagira.o2s.ch> <20140218153731.GK3142@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBZEOR6MAKGQES4ARLWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140218153731.GK3142@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?ISO-8859-1?Q?Davi?= =?ISO-8859-1?Q?d_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 02/18/2014 04:37 PM, Maxime Ripard wrote:

<snip>

>> +
>> +	for (i = 0; i < data->sg_len; i++) {
>> +		pdes[i].config = SDXC_IDMAC_DES0_CH | SDXC_IDMAC_DES0_OWN |
>> +				 SDXC_IDMAC_DES0_DIC;
>> +
>> +		if (data->sg[i].length == max_len)
>> +			pdes[i].buf_size = 0; /* 0 == max_len */
>> +		else
>> +			pdes[i].buf_size = data->sg[i].length;
>> +
>> +		pdes[i].buf_addr_ptr1 = sg_dma_address(&data->sg[i]);
>> +		pdes[i].buf_addr_ptr2 = (u32)&pdes_pa[i + 1];
>> +	}
>> +
>> +	pdes[0].config |= SDXC_IDMAC_DES0_FD;
>> +	pdes[i - 1].config = SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD;
>> +
>> +	wmb(); /* Ensure idma_des hit main mem before we start the idmac */
>
> wmb ensure the proper ordering of the instructions, not flushing the
> caches like what your comment implies.

Since I put that comment there, allow me to explain. A modern ARM
cpu core has 2 or more units handling stores. One for regular
memory stores, and one for io-mem stores. Regular mem stores can
be re-ordered, io stores cannot. Normally there is no "syncing"
between the 2 store units. Cache flushing is not an issue here
since the memory holding the descriptors for the idma controller
is allocated cache coherent, which on arm means it is not cached.

What is an issue here is the io-store starting the idmac hitting
the io-mem before the descriptors hit the main-mem, the wmb()
ensures this does not happen.


>> +static int sunxi_mmc_prepare_dma(struct sunxi_mmc_host *smc_host,
>> +				 struct mmc_data *data)
>> +{
>> +	u32 dma_len;
>> +	u32 i;
>> +	u32 temp;
>> +	struct scatterlist *sg;
>> +
>> +	dma_len = dma_map_sg(mmc_dev(smc_host->mmc), data->sg, data->sg_len,
>> +			     sunxi_mmc_get_dma_dir(data));
>> +	if (dma_len == 0) {
>> +		dev_err(mmc_dev(smc_host->mmc), "dma_map_sg failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	for_each_sg(data->sg, sg, data->sg_len, i) {
>> +		if (sg->offset & 3 || sg->length & 3) {
>> +			dev_err(mmc_dev(smc_host->mmc),
>> +				"unaligned scatterlist: os %x length %d\n",
>> +				sg->offset, sg->length);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	sunxi_mmc_init_idma_des(smc_host, data);
>> +
>> +	temp = mci_readl(smc_host, REG_GCTRL);
>> +	temp |= SDXC_DMA_ENABLE_BIT;
>> +	mci_writel(smc_host, REG_GCTRL, temp);
>> +	temp |= SDXC_DMA_RESET;
>> +	mci_writel(smc_host, REG_GCTRL, temp);
>
> Does it really need to be done in two steps?

We don't know, so this is probably best left as is.


>
> (Newline)
>
>> +	mci_writel(smc_host, REG_DMAC, SDXC_IDMAC_SOFT_RESET);
>> +
>> +	if (!(data->flags & MMC_DATA_WRITE))
>> +		mci_writel(smc_host, REG_IDIE, SDXC_IDMAC_RECEIVE_INTERRUPT);
>> +
>> +	mci_writel(smc_host, REG_DMAC, SDXC_IDMAC_FIX_BURST | SDXC_IDMAC_IDMA_ON);
>> +
>> +	return 0;
>> +}
>> +
>> +static void sunxi_mmc_send_manual_stop(struct sunxi_mmc_host *host,
>> +				       struct mmc_request *req)
>> +{
>> +	u32 cmd_val = SDXC_START | SDXC_RESP_EXPIRE | SDXC_STOP_ABORT_CMD
>> +			| SDXC_CHECK_RESPONSE_CRC | MMC_STOP_TRANSMISSION;
>> +	u32 ri = 0;
>> +	unsigned long expire = jiffies + msecs_to_jiffies(1000);
>> +
>> +	mci_writel(host, REG_CARG, 0);
>> +	mci_writel(host, REG_CMDR, cmd_val);
>> +
>> +	do {
>> +		ri = mci_readl(host, REG_RINTR);
>> +	} while (!(ri & (SDXC_COMMAND_DONE | SDXC_INTERRUPT_ERROR_BIT)) &&
>> +		 time_before(jiffies, expire));
>> +
>> +	if (ri & SDXC_INTERRUPT_ERROR_BIT) {
>> +		dev_err(mmc_dev(host->mmc), "send stop command failed\n");
>> +		if (req->stop)
>> +			req->stop->resp[0] = -ETIMEDOUT;
>> +	} else {
>> +		if (req->stop)
>> +			req->stop->resp[0] = mci_readl(host, REG_RESP0);
>> +	}
>> +
>> +	mci_writel(host, REG_RINTR, 0xffff);
>> +}
>> +
>> +static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *smc_host)
>> +{
>> +	struct mmc_command *cmd = smc_host->mrq->cmd;
>> +	struct mmc_data *data = smc_host->mrq->data;
>> +
>> +	/* For some cmds timeout is normal with sd/mmc cards */
>> +	if ((smc_host->int_sum & SDXC_INTERRUPT_ERROR_BIT) == SDXC_RESP_TIMEOUT &&
>> +			(cmd->opcode == SD_IO_SEND_OP_COND || cmd->opcode == SD_IO_RW_DIRECT))
>> +		return;
>> +
>> +	dev_err(mmc_dev(smc_host->mmc),
>
> I'd rather put it at a debug loglevel.

Erm, this only happens if something is seriously wrong.


>> +	/* Make sure the controller is in a sane state before enabling irqs */
>> +	ret = sunxi_mmc_init_host(host->mmc);
>> +	if (ret)
>> +		return ret;
>> +
>> +	host->irq = platform_get_irq(pdev, 0);
>> +	ret = devm_request_irq(&pdev->dev, host->irq, sunxi_mmc_irq, 0,
>> +			       "sunxi-mmc", host);
>> +	if (ret == 0)
>> +		disable_irq(host->irq);
>
> The disable_irq is useless here. Just exit.

No it is not note the ret == 0, this is not an error handling path!

This is done under an if because we want to do the sunxi_mmc_exit_host
regardless of the request_irq succeeding or not.

>
>> +
>> +	/* And put it back in reset */
>> +	sunxi_mmc_exit_host(host);
>
> Hu? If it's in reset, how can it generate some IRQs?

Yes, that is why we do the whole dance of init controller, get irq,
disable irq, drop it back in reset (until the mmc subsys does a power on
of the mmc card / sdio dev).

Sometime the controller asserts the irq in reset for some reason, so
without the dance as soon as we do the devm_request_irq we get an irq,
and worse, not only do we get an irq, we cannot clear it since writing to
the interrupt status register does not work when the controller is in reset,
so we get stuck re-entering the irq handler.

>
>> +	return ret;
>> +}
>> +
>> +static int sunxi_mmc_probe(struct platform_device *pdev)
>> +{
>> +	struct sunxi_mmc_host *host;
>> +	struct mmc_host *mmc;
>> +	int ret;
>> +
>> +	mmc = mmc_alloc_host(sizeof(struct sunxi_mmc_host), &pdev->dev);
>> +	if (!mmc) {
>> +		dev_err(&pdev->dev, "mmc alloc host failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	ret = mmc_of_parse(mmc);
>> +	if (ret)
>> +		goto error_free_host;
>> +
>> +	host = mmc_priv(mmc);
>> +	host->mmc = mmc;
>> +	spin_lock_init(&host->lock);
>> +	tasklet_init(&host->tasklet, sunxi_mmc_tasklet, (unsigned long)host);
>> +
>> +	ret = sunxi_mmc_resource_request(host, pdev);
>> +	if (ret)
>> +		goto error_free_host;
>> +
>> +	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
>> +					  &host->sg_dma, GFP_KERNEL);
>> +	if (!host->sg_cpu) {
>> +		dev_err(&pdev->dev, "Failed to allocate DMA descriptor mem\n");
>> +		ret = -ENOMEM;
>> +		goto error_free_host;
>> +	}
>> +
>> +	mmc->ops		= &sunxi_mmc_ops;
>> +	mmc->max_blk_count	= 8192;
>> +	mmc->max_blk_size	= 4096;
>> +	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
>> +	mmc->max_seg_size	= (1 << host->idma_des_size_bits);
>> +	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
>> +	/* 400kHz ~ 50MHz */
>> +	mmc->f_min		=   400000;
>> +	mmc->f_max		= 50000000;
>> +	/* available voltages */
>> +	if (!IS_ERR(host->vmmc))
>> +		mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vmmc);
>> +	else
>> +		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
>> +
>> +	mmc->caps = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>> +		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |
>> +		MMC_CAP_UHS_DDR50 | MMC_CAP_SDIO_IRQ | MMC_CAP_DRIVER_TYPE_A;
>> +	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP;
>> +
>> +	ret = mmc_add_host(mmc);
>> +
>> +	if (ret)
>> +		goto error_free_dma;
>> +
>> +	dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq);
>> +	platform_set_drvdata(pdev, mmc);
>
> This should be before the registration. Otherwise, you're racy.

Nope, we only need this to get the data on sunxi_mmc_remove, everywhere
else the data is found through the mmc-host struct.

>
>> +	return 0;
>> +
>> +error_free_dma:
>> +	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>> +error_free_host:
>> +	mmc_free_host(mmc);
>> +	return ret;
>> +}
>> +
>> +static int sunxi_mmc_remove(struct platform_device *pdev)
>> +{
>> +	struct mmc_host	*mmc = platform_get_drvdata(pdev);
>> +	struct sunxi_mmc_host *host = mmc_priv(mmc);
>> +
>> +	mmc_remove_host(mmc);
>> +	sunxi_mmc_exit_host(host);
>> +	tasklet_disable(&host->tasklet);
>> +	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
>> +	mmc_free_host(mmc);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver sunxi_mmc_driver = {
>> +	.driver = {
>> +		.name	= "sunxi-mmc",
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table = of_match_ptr(sunxi_mmc_of_match),
>> +	},
>> +	.probe		= sunxi_mmc_probe,
>> +	.remove		= sunxi_mmc_remove,
>> +};
>> +module_platform_driver(sunxi_mmc_driver);
>> +
>> +MODULE_DESCRIPTION("Allwinner's SD/MMC Card Controller Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("David Lanzend?rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>");
>> +MODULE_ALIAS("platform:sunxi-mmc");
>> diff --git a/drivers/mmc/host/sunxi-mmc.h b/drivers/mmc/host/sunxi-mmc.h
>> new file mode 100644
>> index 0000000..75eaa02
>> --- /dev/null
>> +++ b/drivers/mmc/host/sunxi-mmc.h
>> @@ -0,0 +1,239 @@
>> +/*
>> + * Driver for sunxi SD/MMC host controllers
>> + * (C) Copyright 2007-2011 Reuuimlla Technology Co., Ltd.
>> + * (C) Copyright 2007-2011 Aaron Maoye <leafy.myeh-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf@public.gmane.org>
>> + * (C) Copyright 2013-2014 O2S GmbH <www.o2s.ch>
>> + * (C) Copyright 2013-2014 David Lanzend?rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
>> + * (C) Copyright 2013-2014 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + */
>> +
>> +#ifndef __SUNXI_MMC_H__
>> +#define __SUNXI_MMC_H__
>> +
>> +/* register offset definitions */
>> +#define SDXC_REG_GCTRL	(0x00) /* SMC Global Control Register */
>> +#define SDXC_REG_CLKCR	(0x04) /* SMC Clock Control Register */
>> +#define SDXC_REG_TMOUT	(0x08) /* SMC Time Out Register */
>> +#define SDXC_REG_WIDTH	(0x0C) /* SMC Bus Width Register */
>> +#define SDXC_REG_BLKSZ	(0x10) /* SMC Block Size Register */
>> +#define SDXC_REG_BCNTR	(0x14) /* SMC Byte Count Register */
>> +#define SDXC_REG_CMDR	(0x18) /* SMC Command Register */
>> +#define SDXC_REG_CARG	(0x1C) /* SMC Argument Register */
>> +#define SDXC_REG_RESP0	(0x20) /* SMC Response Register 0 */
>> +#define SDXC_REG_RESP1	(0x24) /* SMC Response Register 1 */
>> +#define SDXC_REG_RESP2	(0x28) /* SMC Response Register 2 */
>> +#define SDXC_REG_RESP3	(0x2C) /* SMC Response Register 3 */
>> +#define SDXC_REG_IMASK	(0x30) /* SMC Interrupt Mask Register */
>> +#define SDXC_REG_MISTA	(0x34) /* SMC Masked Interrupt Status Register */
>> +#define SDXC_REG_RINTR	(0x38) /* SMC Raw Interrupt Status Register */
>> +#define SDXC_REG_STAS	(0x3C) /* SMC Status Register */
>> +#define SDXC_REG_FTRGL	(0x40) /* SMC FIFO Threshold Watermark Registe */
>> +#define SDXC_REG_FUNS	(0x44) /* SMC Function Select Register */
>> +#define SDXC_REG_CBCR	(0x48) /* SMC CIU Byte Count Register */
>> +#define SDXC_REG_BBCR	(0x4C) /* SMC BIU Byte Count Register */
>> +#define SDXC_REG_DBGC	(0x50) /* SMC Debug Enable Register */
>> +#define SDXC_REG_HWRST	(0x78) /* SMC Card Hardware Reset for Register */
>> +#define SDXC_REG_DMAC	(0x80) /* SMC IDMAC Control Register */
>> +#define SDXC_REG_DLBA	(0x84) /* SMC IDMAC Descriptor List Base Addre */
>> +#define SDXC_REG_IDST	(0x88) /* SMC IDMAC Status Register */
>> +#define SDXC_REG_IDIE	(0x8C) /* SMC IDMAC Interrupt Enable Register */
>> +#define SDXC_REG_CHDA	(0x90)
>> +#define SDXC_REG_CBDA	(0x94)
>> +
>> +#define mci_readl(host, reg) \
>> +	readl((host)->reg_base + SDXC_##reg)
>> +#define mci_writel(host, reg, value) \
>> +	writel((value), (host)->reg_base + SDXC_##reg)
>
> Please use some inline functions here.
>
>> +/* global control register bits */
>> +#define SDXC_SOFT_RESET		BIT(0)
>> +#define SDXC_FIFO_RESET		BIT(1)
>> +#define SDXC_DMA_RESET		BIT(2)
>> +#define SDXC_HARDWARE_RESET		(SDXC_SOFT_RESET|SDXC_FIFO_RESET|SDXC_DMA_RESET)
>> +#define SDXC_INTERRUPT_ENABLE_BIT		BIT(4)
>> +#define SDXC_DMA_ENABLE_BIT		BIT(5)
>> +#define SDXC_DEBOUNCE_ENABLE_BIT	BIT(8)
>> +#define SDXC_POSEDGE_LATCH_DATA	BIT(9)
>> +#define SDXC_DDR_MODE		BIT(10)
>> +#define SDXC_MEMORY_ACCESS_DONE	BIT(29)
>> +#define SDXC_ACCESS_DONE_DIRECT	BIT(30)
>> +#define SDXC_ACCESS_BY_AHB	BIT(31)
>> +#define SDXC_ACCESS_BY_DMA	(0U << 31)
>
> Isn't it 0?

Yes, but is is the inverse of ACCESS_BY_DMA, which
this makes much clearer then just 0 does.

>
>> +/* clock control bits */
>> +#define SDXC_CARD_CLOCK_ON		BIT(16)
>> +#define SDXC_LOW_POWER_ON		BIT(17)
>> +/* bus width */
>> +#define SDXC_WIDTH1		(0)
>> +#define SDXC_WIDTH4		(1)
>> +#define SDXC_WIDTH8		(2)
>> +/* smc command bits */
>> +#define SDXC_RESP_EXPIRE		BIT(6)
>> +#define SDXC_LONG_RESPONSE		BIT(7)
>> +#define SDXC_CHECK_RESPONSE_CRC	BIT(8)
>> +#define SDXC_DATA_EXPIRE		BIT(9)
>> +#define SDXC_WRITE		BIT(10)
>> +#define SDXC_SEQUENCE_MODE		BIT(11)
>> +#define SDXC_SEND_AUTO_STOP	BIT(12)
>> +#define SDXC_WAIT_PRE_OVER	BIT(13)
>> +#define SDXC_STOP_ABORT_CMD	BIT(14)
>> +#define SDXC_SEND_INIT_SEQUENCE	BIT(15)
>> +#define SDXC_UPCLK_ONLY		BIT(21)
>> +#define SDXC_READ_CEATA_DEV		BIT(22)
>> +#define SDXC_CCS_EXPIRE		BIT(23)
>> +#define SDXC_ENABLE_BIT_BOOT		BIT(24)
>> +#define SDXC_ALT_BOOT_OPTIONS		BIT(25)
>> +#define SDXC_BOOT_ACK_EXPIRE		BIT(26)
>> +#define SDXC_BOOT_ABORT		BIT(27)
>> +#define SDXC_VOLTAGE_SWITCH	        BIT(28)
>> +#define SDXC_USE_HOLD_REGISTER	        BIT(29)
>> +#define SDXC_START	        BIT(31)
>> +/* interrupt bits */
>> +#define SDXC_RESP_ERROR		BIT(1)
>> +#define SDXC_COMMAND_DONE		BIT(2)
>> +#define SDXC_DATA_OVER		BIT(3)
>> +#define SDXC_TX_DATA_REQUEST		BIT(4)
>> +#define SDXC_RX_DATA_REQUEST		BIT(5)
>> +#define SDXC_RESP_CRC_ERROR		BIT(6)
>> +#define SDXC_DATA_CRC_ERROR		BIT(7)
>> +#define SDXC_RESP_TIMEOUT	BIT(8)
>> +#define SDXC_DATA_TIMEOUT	BIT(9)
>> +#define SDXC_VOLTAGE_CHANGE_DONE		BIT(10)
>> +#define SDXC_FIFO_RUN_ERROR		BIT(11)
>> +#define SDXC_HARD_WARE_LOCKED	BIT(12)
>> +#define SDXC_START_BIT_ERROR	BIT(13)
>> +#define SDXC_AUTO_COMMAND_DONE	BIT(14)
>> +#define SDXC_END_BIT_ERROR		BIT(15)
>> +#define SDXC_SDIO_INTERRUPT		BIT(16)
>> +#define SDXC_CARD_INSERT		BIT(30)
>> +#define SDXC_CARD_REMOVE		BIT(31)
>> +#define SDXC_INTERRUPT_ERROR_BIT		(SDXC_RESP_ERROR | SDXC_RESP_CRC_ERROR | \
>> +				 SDXC_DATA_CRC_ERROR | SDXC_RESP_TIMEOUT | \
>> +				 SDXC_DATA_TIMEOUT | SDXC_FIFO_RUN_ERROR | \
>> +				 SDXC_HARD_WARE_LOCKED | SDXC_START_BIT_ERROR | \
>> +				 SDXC_END_BIT_ERROR) /* 0xbbc2 */
>> +#define SDXC_INTERRUPT_DONE_BIT		(SDXC_AUTO_COMMAND_DONE | SDXC_DATA_OVER | \
>> +				 SDXC_COMMAND_DONE | SDXC_VOLTAGE_CHANGE_DONE)
>> +/* status */
>> +#define SDXC_RXWL_FLAG		BIT(0)
>> +#define SDXC_TXWL_FLAG		BIT(1)
>> +#define SDXC_FIFO_EMPTY		BIT(2)
>> +#define SDXC_FIFO_FULL		BIT(3)
>> +#define SDXC_CARD_PRESENT	BIT(8)
>> +#define SDXC_CARD_DATA_BUSY	BIT(9)
>> +#define SDXC_DATA_FSM_BUSY	BIT(10)
>> +#define SDXC_DMA_REQUEST		BIT(31)
>> +#define SDXC_FIFO_SIZE		(16)
>> +/* Function select */
>> +#define SDXC_CEATA_ON		(0xceaaU << 16)
>> +#define SDXC_SEND_IRQ_RESPONSE		BIT(0)
>> +#define SDXC_SDIO_READ_WAIT		BIT(1)
>> +#define SDXC_ABORT_READ_DATA		BIT(2)
>> +#define SDXC_SEND_CCSD		BIT(8)
>> +#define SDXC_SEND_AUTO_STOPCCSD	BIT(9)
>> +#define SDXC_CEATA_DEV_INTERRUPT_ENABLE_BIT	BIT(10)
>> +/* IDMA controller bus mod bit field */
>> +#define SDXC_IDMAC_SOFT_RESET	BIT(0)
>> +#define SDXC_IDMAC_FIX_BURST	BIT(1)
>> +#define SDXC_IDMAC_IDMA_ON	BIT(7)
>> +#define SDXC_IDMAC_REFETCH_DES	BIT(31)
>> +/* IDMA status bit field */
>> +#define SDXC_IDMAC_TRANSMIT_INTERRUPT	BIT(0)
>> +#define SDXC_IDMAC_RECEIVE_INTERRUPT	BIT(1)
>> +#define SDXC_IDMAC_FATAL_BUS_ERROR	BIT(2)
>> +#define SDXC_IDMAC_DESTINATION_INVALID	BIT(4)
>> +#define SDXC_IDMAC_CARD_ERROR_SUM	BIT(5)
>> +#define SDXC_IDMAC_NORMAL_INTERRUPT_SUM	BIT(8)
>> +#define SDXC_IDMAC_ABNORMAL_INTERRUPT_SUM BIT(9)
>> +#define SDXC_IDMAC_HOST_ABORT_INTERRUPT_TX	BIT(10)
>> +#define SDXC_IDMAC_HOST_ABORT_INTERRUPT_RX	BIT(10)
>> +#define SDXC_IDMAC_IDLE		(0U << 13)
>
> Ditto
>
>> +#define SDXC_IDMAC_SUSPEND	(1U << 13)
>> +#define SDXC_IDMAC_DESC_READ	(2U << 13)
>> +#define SDXC_IDMAC_DESC_CHECK	(3U << 13)
>> +#define SDXC_IDMAC_READ_REQUEST_WAIT	(4U << 13)
>> +#define SDXC_IDMAC_WRITE_REQUEST_WAIT	(5U << 13)
>> +#define SDXC_IDMAC_READ		(6U << 13)
>> +#define SDXC_IDMAC_WRITE		(7U << 13)
>> +#define SDXC_IDMAC_DESC_CLOSE	(8U << 13)
>
> Please use BIT as much as possible here.

Erm lets not do that, nor remove the 0 << 13, this are all
values to store in a multi-bit field which lives in bits 13-xx,
changing the values which happen to be power of 2 into BIT
macros is not helpful.

>
>
>> +
>> +/*
>> +* If the idma-des-size-bits of property is ie 13, bufsize bits are:
>> +*  Bits  0-12: buf1 size
>> +*  Bits 13-25: buf2 size
>> +*  Bits 26-31: not used
>> +* Since we only ever set buf1 size, we can simply store it directly.
>> +*/
>> +#define SDXC_IDMAC_DES0_DIC	BIT(1)  /* disable interrupt on completion */
>> +#define SDXC_IDMAC_DES0_LD	BIT(2)  /* last descriptor */
>> +#define SDXC_IDMAC_DES0_FD	BIT(3)  /* first descriptor */
>> +#define SDXC_IDMAC_DES0_CH	BIT(4)  /* chain mode */
>> +#define SDXC_IDMAC_DES0_ER	BIT(5)  /* end of ring */
>> +#define SDXC_IDMAC_DES0_CES	BIT(30) /* card error summary */
>> +#define SDXC_IDMAC_DES0_OWN	BIT(31) /* 1-idma owns it, 0-host owns it */
>
> Overall, I prefer to have the registers right beneath the register
> declaration. It's easier to spot what bits belong to what registers
> that way.
>
>> +struct sunxi_idma_des {
>> +	u32	config;
>> +	u32	buf_size;
>> +	u32	buf_addr_ptr1;
>> +	u32	buf_addr_ptr2;
>> +};
>
> Some comments on top of this structure would be great.
>
>> +struct sunxi_mmc_host {
>> +	struct mmc_host *mmc;
>> +	struct regulator *vmmc;
>> +
>> +	/* IO mapping base */
>> +	void __iomem *reg_base;
>> +
>> +	spinlock_t lock;
>> +	struct tasklet_struct tasklet;
>> +
>> +	/* clock management */
>> +	struct clk *clk_ahb;
>> +	struct clk *clk_mod;
>> +
>> +	/* ios information */
>> +	u32		clk_mod_rate;
>> +	u32		bus_width;
>> +	u32		idma_des_size_bits;
>> +	u32		ddr;
>> +	u32		voltage_switching;
>> +
>> +	/* irq */
>> +	int		irq;
>> +	u32		int_sum;
>> +	u32		sdio_imask;
>> +
>> +	/* flags */
>> +	u32		power_on:1;
>> +	u32		io_flag:1;
>> +	u32		wait_dma:1;
>
> bool?
>
>> +	dma_addr_t	sg_dma;
>> +	void		*sg_cpu;
>> +
>> +	struct mmc_request *mrq;
>> +	u32		ferror;
>> +};
>
> Please be consistent in your spacing, either align the variable names,
> or don't, but make a decision :)
>
>> +#define MMC_CLK_400K            0
>> +#define MMC_CLK_25M             1
>> +#define MMC_CLK_50M             2
>> +#define MMC_CLK_50MDDR          3
>> +#define MMC_CLK_50MDDR_8BIT     4
>> +#define MMC_CLK_100M            5
>> +#define MMC_CLK_200M            6
>> +#define MMC_CLK_MOD_NUM         7
>
> Wouldn't an enum be better here?
>
>> +
>> +struct sunxi_mmc_clk_dly {
>> +	u32 mode;
>> +	u32 oclk_dly;
>> +	u32 sclk_dly;
>> +};
>
> Comments here would be great too.
>
> Thanks for working on this!
> Maxime
>




Regards,

Hans
