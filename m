Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E1C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 19:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA5664F4B
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 19:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhCOTUZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 15:20:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:6919 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231734AbhCOTUI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Mar 2021 15:20:08 -0400
IronPort-SDR: 1B2f4NggYTcV+t0LRF1itrIntFCM4jcApNif2xB5Jdri6VGsBBXbNdZBsfJ/RvjUC2DkBT8qAR
 WhrXAzynIVcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="209057080"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="209057080"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 12:20:07 -0700
IronPort-SDR: u6WrTe8ExYVixIoManbVCeSyjSYTxQnaX1ZO3MGp0EIBJbdToGCUPSln8qrCvpbZSJJCtrNBCG
 Xj6vbfqXbkpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="410755769"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2021 12:20:05 -0700
Subject: Re: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <8236f89c-720e-f8bd-86d0-9654175de659@intel.com>
 <MN2PR12MB361668C9AC2463E1E89478E0AB6C9@MN2PR12MB3616.namprd12.prod.outlook.com>
 <BN8PR12MB35561363D36DA2E37DBA5461D36C9@BN8PR12MB3556.namprd12.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <040a6307-9fba-0185-f913-a81816f1da62@intel.com>
Date:   Mon, 15 Mar 2021 21:20:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BN8PR12MB35561363D36DA2E37DBA5461D36C9@BN8PR12MB3556.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/03/21 7:00 pm, Liming Sun wrote:
> Thanks Adrian. Yes, I did consider adding this ACPI support into sdhci-of-dwcmshc.c, but not sure which one is the preferred way.
> Is this (sdhci-of-dwcmshc.c) what you recommend? I'll post the revised changes in patch v2.

Yes, that is generally preferred I think.

> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Monday, March 15, 2021 4:34 AM
>> To: Liming Sun <limings@nvidia.com>; Ulf Hansson <ulf.hansson@linaro.org>;
>> Khalil Blaiech <kblaiech@nvidia.com>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA
>> BlueField-3 SoC
>>
>> On 12/03/21 3:48 pm, Liming Sun wrote:
>>> This commit adds ACPI support for the BlueField-3 SoC which uses
>>> the DWC_mshc eMMC controller. The boundary check logic in static
>>> function dwcmshc_adma_write_desc() comes from sdhci-of-dwcmshc.c.
>>
>> Did you consider adding ACPI support to sdhci-of-dwcmshc.c ?
>> Other drivers have taken that approach, see sdhci-xenon.c or sdhci-iproc.c
>>
>>>
>>> Signed-off-by: Liming Sun <limings@nvidia.com>
>>> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
>>> ---
>>>  drivers/mmc/host/sdhci-acpi.c | 64
>> +++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 64 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>> index 54205e3..6448e94e 100644
>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>> @@ -716,6 +716,68 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct
>> platform_device *pdev,
>>>  	.priv_size	= sizeof(struct amd_sdhci_host),
>>>  };
>>>
>>> +/* Check DMA address/length boundary. */
>>> +static inline bool dwcmshc_adma_boundary_ok(dma_addr_t addr, int len)
>>> +{
>>> +	return (addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1));
>>> +}
>>> +
>>> +/*
>>> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
>>> + * so that each DMA transfer doesn't exceed the boundary.
>>> + */
>>> +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void
>> **desc,
>>> +				    dma_addr_t addr, int len, unsigned int cmd)
>>> +{
>>> +	int tmplen, offset;
>>> +
>>> +	if (likely(!len || dwcmshc_adma_boundary_ok(addr, len))) {
>>> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
>>> +		return;
>>> +	}
>>> +
>>> +	offset = addr & (SZ_128M - 1);
>>> +	tmplen = SZ_128M - offset;
>>> +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
>>> +
>>> +	addr += tmplen;
>>> +	len -= tmplen;
>>> +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
>>> +}
>>> +
>>> +static int sdhci_acpi_emmc_nvda_bf_probe_slot(struct platform_device
>> *pdev,
>>> +					      struct acpi_device *adev)
>>> +{
>>> +	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
>>> +	struct sdhci_host *host = c->host;
>>> +	u32 extra;
>>> +
>>> +	/* Extra adma table cnt for cross 128M boundary handling. */
>>> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev),
>> SZ_128M);
>>> +	extra = min(extra, (u32)SDHCI_MAX_SEGS);
>>> +	host->adma_table_cnt += extra;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct sdhci_ops sdhci_acpi_ops_nvda_bf = {
>>> +	.set_clock		= sdhci_set_clock,
>>> +	.set_bus_width		= sdhci_set_bus_width,
>>> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>>> +	.reset			= sdhci_reset,
>>> +	.adma_write_desc	= dwcmshc_adma_write_desc,
>>> +};
>>> +
>>> +static const struct sdhci_acpi_chip sdhci_acpi_chip_nvda_bf = {
>>> +	.ops = &sdhci_acpi_ops_nvda_bf,
>>> +};
>>> +
>>> +static const struct sdhci_acpi_slot sdhci_acpi_slot_nvda_bf_emmc = {
>>> +	.chip		= &sdhci_acpi_chip_nvda_bf,
>>> +	.caps		= MMC_CAP_8_BIT_DATA |
>> MMC_CAP_NONREMOVABLE,
>>> +	.probe_slot	= sdhci_acpi_emmc_nvda_bf_probe_slot,
>>> +};
>>> +
>>>  struct sdhci_acpi_uid_slot {
>>>  	const char *hid;
>>>  	const char *uid;
>>> @@ -740,6 +802,7 @@ struct sdhci_acpi_uid_slot {
>>>  	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
>>>  	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
>>>  	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
>>> +	{ "MLNXBF30", NULL, &sdhci_acpi_slot_nvda_bf_emmc },
>>>  	{ },
>>>  };
>>>
>>> @@ -757,6 +820,7 @@ struct sdhci_acpi_uid_slot {
>>>  	{ "QCOM8051" },
>>>  	{ "QCOM8052" },
>>>  	{ "AMDI0040" },
>>> +	{ "MLNXBF30" },
>>>  	{ },
>>>  };
>>>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
>>>
> 

