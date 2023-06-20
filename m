Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C83DEB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 09:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjFTJ2e (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjFTJ2N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 05:28:13 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C604510F3
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 02:27:59 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8P9Kj025133;
        Tue, 20 Jun 2023 11:27:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=MQP1qzhduyTRIhdraMIzHRMNtSs6IghZAWvDMnCnb9U=;
 b=CW4E1xeJ2OITcXBJ9AHpOs6JZmTV4kN+A1a3vOQ5+m8+a9psrg6G5hbtkEq48Uoy7yHq
 FxtdVWqex+FvylZXFn4Dn1dxHrRoZdjF+Z8FBwdIZj+Hm1MaKaFdL5tL7XwM8qiANEL4
 l6xtJQXUR1/BbPw0PJVUbvm2VkZ+IERg1jkSoLnvBp5Ctr5MEMrdSiVNWTW7exyJIm15
 7t8HkJUVwo+H7V2cwyfgrbVtrni3y7/Rb2LvM3osPwokdL3aBGJvUWnzBLX9/IxiT2be
 N2i8gCKpOERCR9oBJjYdlt0X3bXrch5AbvUYP3KZG8eIFp9IC35oa6mID8OUVS0y51L8 tA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rb8k8rfmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 11:27:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A781100071;
        Tue, 20 Jun 2023 11:27:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B827215BEB;
        Tue, 20 Jun 2023 11:27:52 +0200 (CEST)
Received: from [10.201.21.210] (10.201.21.210) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 20 Jun
 2023 11:27:51 +0200
Message-ID: <a09b7efa-c74d-bc5a-44c0-5710c1aa078b@foss.st.com>
Date:   Tue, 20 Jun 2023 11:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>
References: <20230620091113.33393-1-ulf.hansson@linaro.org>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <20230620091113.33393-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_06,2023-06-16_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/20/23 11:11, Ulf Hansson wrote:
> The ux500 variant doesn't have a HW based timeout to use for busy-end IRQs.
> To avoid hanging and waiting for the card to stop signaling busy, let's
> schedule a delayed work, according to the corresponding cmd->busy_timeout
> for the command. If work gets to run, let's kick the IRQ handler to
> completed the currently running request/command.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/host/mmci.c             | 50 ++++++++++++++++++++++++++---
>   drivers/mmc/host/mmci.h             |  3 +-
>   drivers/mmc/host/mmci_stm32_sdmmc.c |  3 +-
>   3 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 8a661ea1a2d1..61d761646462 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -37,6 +37,7 @@
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/reset.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/workqueue.h>
>   
>   #include <asm/div64.h>
>   #include <asm/io.h>
> @@ -682,7 +683,8 @@ static void ux500_busy_clear_mask_done(struct mmci_host *host)
>    *                     |                 |
>    *                    IRQ1              IRQ2
>    */
> -static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> +static bool ux500_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
> +				u32 status, u32 err_msk)
>   {
>   	void __iomem *base = host->base;
>   	int retries = 10;
> @@ -726,6 +728,8 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>   				       host->variant->busy_detect_mask,
>   				       base + MMCIMASK0);
>   				host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
> +				schedule_delayed_work(&host->ux500_busy_timeout_work,
> +				      msecs_to_jiffies(cmd->busy_timeout));
>   				goto out_ret_state;
>   			}
>   			retries--;
> @@ -753,6 +757,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>   		} else {
>   			dev_dbg(mmc_dev(host->mmc),
>   				"lost busy status when waiting for busy start IRQ\n");
> +			cancel_delayed_work(&host->ux500_busy_timeout_work);
>   			ux500_busy_clear_mask_done(host);
>   		}
>   		break;
> @@ -761,6 +766,7 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>   		if (!(status & host->variant->busy_detect_flag)) {
>   			host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);
>   			writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +			cancel_delayed_work(&host->ux500_busy_timeout_work);
>   			ux500_busy_clear_mask_done(host);
>   		} else {
>   			dev_dbg(mmc_dev(host->mmc),
> @@ -1277,6 +1283,7 @@ static void
>   mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>   {
>   	void __iomem *base = host->base;
> +	bool busy_resp = cmd->flags & MMC_RSP_BUSY;
>   	unsigned long long clks;
>   
>   	dev_dbg(mmc_dev(host->mmc), "op %02x arg %08x flags %08x\n",
> @@ -1304,10 +1311,11 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>   	host->busy_status = 0;
>   	host->busy_state = MMCI_BUSY_DONE;
>   
> -	if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> -		if (!cmd->busy_timeout)
> -			cmd->busy_timeout = 10 * MSEC_PER_SEC;
> +	/* Assign a default timeout if the core does not provide one */
> +	if (busy_resp && !cmd->busy_timeout)
> +		cmd->busy_timeout = 10 * MSEC_PER_SEC;
>   
> +	if (busy_resp && host->variant->busy_timeout) {
>   		if (cmd->busy_timeout > host->mmc->max_busy_timeout)
>   			clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
>   		else
> @@ -1448,7 +1456,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>   
>   	/* Handle busy detection on DAT0 if the variant supports it. */
>   	if (busy_resp && host->variant->busy_detect)
> -		if (!host->ops->busy_complete(host, status, err_msk))
> +		if (!host->ops->busy_complete(host, cmd, status, err_msk))
>   			return;
>   
>   	host->cmd = NULL;
> @@ -1495,6 +1503,34 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>   	}
>   }
>   
> +/*
> + * This busy timeout worker is used to "kick" the command IRQ if a
> + * busy detect IRQ fails to appear in reasonable time. Only used on
> + * variants with busy detection IRQ delivery.
> + */
> +static void ux500_busy_timeout_work(struct work_struct *work)
> +{
> +	struct mmci_host *host = container_of(work, struct mmci_host,
> +					ux500_busy_timeout_work.work);
> +	unsigned long flags;
> +	u32 status;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (host->cmd) {
> +		dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
> +
> +		/* If we are still busy let's tag on a cmd-timeout error. */
> +		status = readl(host->base + MMCISTATUS);
> +		if (status & host->variant->busy_detect_flag)
> +			status |= MCI_CMDTIMEOUT;
> +
> +		mmci_cmd_irq(host, host->cmd, status);
> +	}
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
>   static int mmci_get_rx_fifocnt(struct mmci_host *host, u32 status, int remain)
>   {
>   	return remain - (readl(host->base + MMCIFIFOCNT) << 2);
> @@ -2309,6 +2345,10 @@ static int mmci_probe(struct amba_device *dev,
>   			goto clk_disable;
>   	}
>   
> +	if (host->variant->busy_detect)
> +		INIT_DELAYED_WORK(&host->ux500_busy_timeout_work,
> +				  ux500_busy_timeout_work);

Hi Ulf,

STM32 variants also have busy_detect = true.
Could that be an issue to initialize this work, which seem dedicated to 
ux500?
I haven't tested the patch yet. Will do that soon.


Yann

> +
>   	writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
>   
>   	amba_set_drvdata(dev, mmc);
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 12a7bbd3ce26..69b2439842dd 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -393,7 +393,7 @@ struct mmci_host_ops {
>   	void (*dma_error)(struct mmci_host *host);
>   	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
>   	void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
> -	bool (*busy_complete)(struct mmci_host *host, u32 status, u32 err_msk);
> +	bool (*busy_complete)(struct mmci_host *host, struct mmc_command *cmd, u32 status, u32 err_msk);
>   	void (*pre_sig_volt_switch)(struct mmci_host *host);
>   	int (*post_sig_volt_switch)(struct mmci_host *host, struct mmc_ios *ios);
>   };
> @@ -451,6 +451,7 @@ struct mmci_host {
>   	void			*dma_priv;
>   
>   	s32			next_cookie;
> +	struct delayed_work	ux500_busy_timeout_work;
>   };
>   
>   #define dma_inprogress(host)	((host)->dma_in_progress)
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 953d1be4e379..f07cfbeafe2e 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -372,7 +372,8 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
>   	return datactrl;
>   }
>   
> -static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
> +static bool sdmmc_busy_complete(struct mmci_host *host, struct mmc_command *cmd,
> +				u32 status, u32 err_msk)
>   {
>   	void __iomem *base = host->base;
>   	u32 busy_d0, busy_d0end, mask, sdmmc_status;

