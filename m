From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Fri, 27 Dec 2013 14:13:22 +0800
Message-ID: <52BD1A82.7090101@linaro.org>
References: <1386987174-1788-3-git-send-email-zhangfei.gao@linaro.org> <1387199536-7053-1-git-send-email-zhangfei.gao@linaro.org> <52BBB1B0.8040907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:46215 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3L0GNb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Dec 2013 01:13:31 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so7063275pab.23
        for <linux-mmc@vger.kernel.org>; Thu, 26 Dec 2013 22:13:31 -0800 (PST)
In-Reply-To: <52BBB1B0.8040907@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhigang Wang <brooke.wangzhigang@huawei.com>, cpgs@samsung.com

Dear Jaehoon

Thanks for the reviewing.

On 12/26/2013 12:33 PM, Jaehoon Chung wrote:

>> +config MMC_DW_K3
>> +	tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
>> +	depends on MMC_DW
>> +	select MMC_DW_PLTFM
>> +	select MMC_DW_IDMAC
>
> Only use the IDMAC?

IDMAC has to be set here since we found the controller have some issue 
in non-dma mode.


>> +static unsigned long k3_dwmmc_caps[4] = {
>> +	MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED,
>> +	MMC_CAP_8_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
>> +	0,
>> +	0,
>> +};
>
> If supports-highspeed is defined at dt-file,
> then MMC_CAP_SD_HIGHSEEPD and MMC_CAP_MMC_HIGHSPEED should set in dw-mmc.c

Yes, good catch, they can be removed.

>
>> +
>> +static const struct dw_mci_drv_data k3_drv_data = {
>> +	.caps			= k3_dwmmc_caps,
>> +	.set_ios		= dw_mci_k3_set_ios,
>> +	.parse_dt		= dw_mci_k3_parse_dt,
>> +};
>> +
>> +static const struct of_device_id dw_mci_k3_match[] = {
>> +	{ .compatible = "hisilicon,hi4511-dw-mshc", .data = &k3_drv_data, },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, dw_mci_k3_match);
>> +
>> +static int dw_mci_k3_probe(struct platform_device *pdev)
>> +{
>> +	const struct dw_mci_drv_data *drv_data;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
>> +	drv_data = match->data;
>> +
>> +	return dw_mci_pltfm_register(pdev, drv_data);
>> +}
>> +
>> +static int dw_mci_k3_suspend(struct device *dev)
>> +{
>> +	struct dw_mci *host = dev_get_drvdata(dev);
>> +	int ret = 0;
>> +
>> +	ret = dw_mci_suspend(host);
>> +	if (!ret)
>> +		clk_disable_unprepare(host->ciu_clk);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dw_mci_k3_resume(struct device *dev)
>> +{
>> +	struct dw_mci *host = dev_get_drvdata(dev);
>> +	int ret = 0;
>> +
>> +	ret = clk_prepare_enable(host->ciu_clk);
>> +	if (ret) {
>> +		dev_err(host->dev, "failed to enable ciu clock\n");
>> +		return ret;
>> +	}
>> +
>> +	return dw_mci_resume(host);
>> +}
>
> Clock control need in suspend/resume? ciu-clk is used into dw-mmc.c.

The ciu-clk is required here not only for power, but also clk prepare 
have to be triggered in the resume operation as well as init process, 
otherwise sd register access will fail. Some tuning registers accessing 
have been abstracted to clock.

Thanks

