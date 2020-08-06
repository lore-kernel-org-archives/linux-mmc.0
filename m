Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50886C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 00:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9C22CAE
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 00:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YJdzPn9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgHFAHM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 20:07:12 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1251 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHFAHL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 20:07:11 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2b497d0000>; Wed, 05 Aug 2020 17:06:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 05 Aug 2020 17:07:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 05 Aug 2020 17:07:11 -0700
Received: from [10.2.172.190] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Aug
 2020 00:07:10 +0000
Subject: Re: [PATCH v2 6/6] sdhci: tegra: Add missing TMCLK for data timeout
To:     Adrian Hunter <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <1596515363-27235-1-git-send-email-skomatineni@nvidia.com>
 <1596515363-27235-7-git-send-email-skomatineni@nvidia.com>
 <d131fc8c-fa1f-cb67-fe6a-955d3582d1d6@intel.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <8e8f3742-f80e-c58b-4d7b-99b5a455b157@nvidia.com>
Date:   Wed, 5 Aug 2020 17:07:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d131fc8c-fa1f-cb67-fe6a-955d3582d1d6@intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596672381; bh=FbTeM4DKgB2Vhjb2SOpeG8Wwy4zacBAFsfEnf77sC7I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=YJdzPn9nPnzU3hlltw22wl4p1BG8ANDx2Ph5j6Cx1WXK5drU4jYiSmP/XP6MNiob/
         i7k9E1Sg9eNWPoXuH2wNm57iQt1Eu40ugzu44gVJ2Hx+eZ9zPHAhS8MfQIEW0ZiEWI
         r2DfZjFcAyIKH9qpI4dWtAGqb+WhhpJcgEDIqyWcoV+wxM98Xgg/eprZku8xZuv6kq
         tw11yO8ml9xopUEUFH4G9x/N4MLNUIDEI8PygRrbR50wOLUfmsO2NBM2qWXXEAzQMA
         GKoNFfjw0B0/EcDqNilhjT7ZdcGs7eLNSiYO3Y5tjCH+uqC17N4TwuLObzAObHpyyd
         ViwJgwGPo8+4g==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 8/5/20 1:06 AM, Adrian Hunter wrote:
> On 4/08/20 7:29 am, Sowjanya Komatineni wrote:
>> commit b5a84ecf025a ("mmc: tegra: Add Tegra210 support")
> So that could be a Fixes tag also?

Thanks Adrian. Will resend with fixes tag.

Sowjanya

>
>> Tegra210 and later has a separate sdmmc_legacy_tm (TMCLK) used by Tegra
>> SDMMC hawdware for data timeout to achive better timeout than using
>> SDCLK and using TMCLK is recommended.
>>
>> USE_TMCLK_FOR_DATA_TIMEOUT bit in Tegra SDMMC register
>> SDHCI_TEGRA_VENDOR_SYS_SW_CTRL can be used to choose either TMCLK or
>> SDCLK for data timeout.
>>
>> Default USE_TMCLK_FOR_DATA_TIMEOUT bit is set to 1 and TMCLK is used
>> for data timeout by Tegra SDMMC hardware and having TMCLK not enabled
>> is not recommended.
>>
>> So, this patch fixes it.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>> ---
>>   drivers/mmc/host/sdhci-tegra.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index 31ed321..c0b9405 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -140,6 +140,7 @@ struct sdhci_tegra_autocal_offsets {
>>   struct sdhci_tegra {
>>   	const struct sdhci_tegra_soc_data *soc_data;
>>   	struct gpio_desc *power_gpio;
>> +	struct clk *tmclk;
>>   	bool ddr_signaling;
>>   	bool pad_calib_required;
>>   	bool pad_control_available;
>> @@ -1611,6 +1612,44 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>>   		goto err_power_req;
>>   	}
>>   
>> +	/*
>> +	 * Tegra210 has a separate SDMMC_LEGACY_TM clock used for host
>> +	 * timeout clock and SW can choose TMCLK or SDCLK for hardware
>> +	 * data timeout through the bit USE_TMCLK_FOR_DATA_TIMEOUT of
>> +	 * the register SDHCI_TEGRA_VENDOR_SYS_SW_CTRL.
>> +	 *
>> +	 * USE_TMCLK_FOR_DATA_TIMEOUT bit default is set to 1 and SDMMC uses
>> +	 * 12Mhz TMCLK which is advertised in host capability register.
>> +	 * With TMCLK of 12Mhz provides maximum data timeout period that can
>> +	 * be achieved is 11s better than using SDCLK for data timeout.
>> +	 *
>> +	 * So, TMCLK is set to 12Mhz and kept enabled all the time on SoC's
>> +	 * supporting SDR104 mode and when not using SDCLK for data timeout.
>> +	 */
>> +
>> +	if ((soc_data->nvquirks & NVQUIRK_ENABLE_SDR104) &&
>> +	    !(soc_data->pdata->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
>> +		clk = devm_clk_get(&pdev->dev, "tmclk");
>> +		if (IS_ERR(clk)) {
>> +			rc = PTR_ERR(clk);
>> +			if (rc == -EPROBE_DEFER)
>> +				goto err_power_req;
>> +
>> +			dev_warn(&pdev->dev, "failed to get tmclk: %d\n", rc);
>> +			clk = NULL;
>> +		}
>> +
>> +		clk_set_rate(clk, 12000000);
>> +		rc = clk_prepare_enable(clk);
>> +		if (rc) {
>> +			dev_err(&pdev->dev,
>> +				"failed to enable tmclk: %d\n", rc);
>> +			goto err_power_req;
>> +		}
>> +
>> +		tegra_host->tmclk = clk;
>> +	}
>> +
>>   	clk = devm_clk_get(mmc_dev(host->mmc), NULL);
>>   	if (IS_ERR(clk)) {
>>   		rc = PTR_ERR(clk);
>> @@ -1654,6 +1693,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>>   err_rst_get:
>>   	clk_disable_unprepare(pltfm_host->clk);
>>   err_clk_get:
>> +	clk_disable_unprepare(tegra_host->tmclk);
>>   err_power_req:
>>   err_parse_dt:
>>   	sdhci_pltfm_free(pdev);
>> @@ -1671,6 +1711,7 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
>>   	reset_control_assert(tegra_host->rst);
>>   	usleep_range(2000, 4000);
>>   	clk_disable_unprepare(pltfm_host->clk);
>> +	clk_disable_unprepare(tegra_host->tmclk);
>>   
>>   	sdhci_pltfm_free(pdev);
>>   
>>
