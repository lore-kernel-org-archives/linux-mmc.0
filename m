Received: from mail-m15595.qiye.163.com (mail-m15595.qiye.163.com [101.71.155.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768A1552FD
	for <linux-mmc@vger.kernel.org>; Mon,  2 Feb 2026 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769994287; cv=none; b=OfjPqjo7ovo3QbqWMKpL5OiP5Tj/vZUvm1ToeyDOgT/fdcToTyV71/GKOPadaenFv/kQE49g3oKaAkcuBq+o48GpS6RuAXFO+3g7vfz7Quqmb+dluTGUhXXkcBP0iwuqPwBdAIfqIDY2m2RYZnxeRrPhagoR7PaX6zy829VOSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769994287; c=relaxed/simple;
	bh=LWKH0eupwc6IzEDpn5wNSMq9PZLsyF4WPVEMFBpt9cM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QWI1YVcZYNvk/0zu9l+dgDsSZcImMm8DtkO7FX0Hmdh6znF6Xm3tsTThtrgXHrWGUaf5m00TBakXlUO8NGz4T3sKjliobgWvk/oE/wEQ4jKTpQGCS2VbQ6r0XuecZEr2YTUZ2farWMbaBHAybb4bCcxKIn3NfOLA7Q7BjLoHYbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=akRy08k1; arc=none smtp.client-ip=101.71.155.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="akRy08k1"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32b9ee235;
	Mon, 2 Feb 2026 09:04:34 +0800 (GMT+08:00)
Message-ID: <460c4c15-0a9b-49c0-a451-b87224bdbb7e@rock-chips.com>
Date: Mon, 2 Feb 2026 09:04:32 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260131020039.45966-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c1be1456609cckunmb41c75ab62b71c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1NQ1ZLT0xMHkpDGBlDTx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=akRy08k1FxnI6+iYnk0ZMCXd/oYhm4DEnqs6s5L4njXSL3Sk7Qg0a6spkRxZy5Am58bUnfBJ7vWbWtOv6+ZuuxUNvWXnUFaye1YQIlfgel2QHZpdp5SwGJCcxO5tQsCzlqWxdc3ed3GwndoBr626JhmmFM8swI+aMRUQMIh67lU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bQNI0/Lr6T+a7tREsXHXcWmIyn6f26+eF7e+nbZzqXM=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/31 星期六 10:00, Ethan Nelson-Moore 写道:
> Three MMC drivers have unnecessary module_init and module_exit functions
> that are empty or just print a message. Remove them. Note that if a
> module_init function exists, a module_exit function must also exist;
> otherwise, the module cannot be unloaded.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc.c      | 13 -------------

Thanks for you patch. For dw_mmc,
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

>   drivers/mmc/host/sdhci-pltfm.c | 13 -------------
>   drivers/mmc/host/sdhci-uhs2.c  | 13 +------------
>   3 files changed, 1 insertion(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9e74b675e92d..613d74d2e946 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3693,19 +3693,6 @@ int dw_mci_runtime_resume(struct device *dev)
>   EXPORT_SYMBOL(dw_mci_runtime_resume);
>   #endif /* CONFIG_PM */
>   
> -static int __init dw_mci_init(void)
> -{
> -	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
> -	return 0;
> -}
> -
> -static void __exit dw_mci_exit(void)
> -{
> -}
> -
> -module_init(dw_mci_init);
> -module_exit(dw_mci_exit);
> -
>   MODULE_DESCRIPTION("DW Multimedia Card Interface driver");
>   MODULE_AUTHOR("NXP Semiconductor VietNam");
>   MODULE_AUTHOR("Imagination Technologies Ltd");
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 7f6ac636f040..d4fb60c1ef69 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -215,19 +215,6 @@ const struct dev_pm_ops sdhci_pltfm_pmops = {
>   };
>   EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
>   
> -static int __init sdhci_pltfm_drv_init(void)
> -{
> -	pr_info("sdhci-pltfm: SDHCI platform and OF driver helper\n");
> -
> -	return 0;
> -}
> -module_init(sdhci_pltfm_drv_init);
> -
> -static void __exit sdhci_pltfm_drv_exit(void)
> -{
> -}
> -module_exit(sdhci_pltfm_drv_exit);
> -
>   MODULE_DESCRIPTION("SDHCI platform and OF driver helper");
>   MODULE_AUTHOR("Intel Corporation");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index c459a08d01da..41e49c6cc751 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -1126,7 +1126,7 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
>   
>   /*****************************************************************************\
>    *                                                                           *
> - * Driver init/exit                                                          *
> + * Driver init                                                               *
>    *                                                                           *
>   \*****************************************************************************/
>   
> @@ -1138,17 +1138,6 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>   	return 0;
>   }
>   
> -static int __init sdhci_uhs2_mod_init(void)
> -{
> -	return 0;
> -}
> -module_init(sdhci_uhs2_mod_init);
> -
> -static void __exit sdhci_uhs2_mod_exit(void)
> -{
> -}
> -module_exit(sdhci_uhs2_mod_exit);
> -
>   /*****************************************************************************\
>    *
>    * Device allocation/registration                                            *

