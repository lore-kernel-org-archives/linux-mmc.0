Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E596C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EA064E90
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhCOIdc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:33:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:51623 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhCOId0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Mar 2021 04:33:26 -0400
IronPort-SDR: p90FytXK6lNyVfyiuc0C9EA2y3rdVKEM3gbP/D+5JJwlGk9UXTxxzHCUATqgflJFPVMjncyu5/
 NUkYcVLM0MCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="188414655"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="188414655"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 01:33:24 -0700
IronPort-SDR: ZgEVDje230GewEXPvE8PeHo8e/TZ8o7bNkwgoEYdgu0xed67WxuNlJpx2QA93FLv/F/CEFOqKF
 PkwmsR4ykJsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="590253278"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2021 01:33:22 -0700
Subject: Re: [PATCH v1 1/1] mmc: sdhci-acpi: Add support for NVIDIA
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Khalil Blaiech <kblaiech@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8236f89c-720e-f8bd-86d0-9654175de659@intel.com>
Date:   Mon, 15 Mar 2021 10:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/21 3:48 pm, Liming Sun wrote:
> This commit adds ACPI support for the BlueField-3 SoC which uses
> the DWC_mshc eMMC controller. The boundary check logic in static
> function dwcmshc_adma_write_desc() comes from sdhci-of-dwcmshc.c.

Did you consider adding ACPI support to sdhci-of-dwcmshc.c ?
Other drivers have taken that approach, see sdhci-xenon.c or sdhci-iproc.c

> 
> Signed-off-by: Liming Sun <limings@nvidia.com>
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-acpi.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 54205e3..6448e94e 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -716,6 +716,68 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>  	.priv_size	= sizeof(struct amd_sdhci_host),
>  };
>  
> +/* Check DMA address/length boundary. */
> +static inline bool dwcmshc_adma_boundary_ok(dma_addr_t addr, int len)
> +{
> +	return (addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1));
> +}
> +
> +/*
> + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that each DMA transfer doesn't exceed the boundary.
> + */
> +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> +				    dma_addr_t addr, int len, unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	if (likely(!len || dwcmshc_adma_boundary_ok(addr, len))) {
> +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +		return;
> +	}
> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +}
> +
> +static int sdhci_acpi_emmc_nvda_bf_probe_slot(struct platform_device *pdev,
> +					      struct acpi_device *adev)
> +{
> +	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
> +	struct sdhci_host *host = c->host;
> +	u32 extra;
> +
> +	/* Extra adma table cnt for cross 128M boundary handling. */
> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
> +	extra = min(extra, (u32)SDHCI_MAX_SEGS);
> +	host->adma_table_cnt += extra;
> +
> +	return 0;
> +}
> +
> +static const struct sdhci_ops sdhci_acpi_ops_nvda_bf = {
> +	.set_clock		= sdhci_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.reset			= sdhci_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
> +};
> +
> +static const struct sdhci_acpi_chip sdhci_acpi_chip_nvda_bf = {
> +	.ops = &sdhci_acpi_ops_nvda_bf,
> +};
> +
> +static const struct sdhci_acpi_slot sdhci_acpi_slot_nvda_bf_emmc = {
> +	.chip		= &sdhci_acpi_chip_nvda_bf,
> +	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
> +	.probe_slot	= sdhci_acpi_emmc_nvda_bf_probe_slot,
> +};
> +
>  struct sdhci_acpi_uid_slot {
>  	const char *hid;
>  	const char *uid;
> @@ -740,6 +802,7 @@ struct sdhci_acpi_uid_slot {
>  	{ "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
>  	{ "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
>  	{ "AMDI0040", NULL, &sdhci_acpi_slot_amd_emmc },
> +	{ "MLNXBF30", NULL, &sdhci_acpi_slot_nvda_bf_emmc },
>  	{ },
>  };
>  
> @@ -757,6 +820,7 @@ struct sdhci_acpi_uid_slot {
>  	{ "QCOM8051" },
>  	{ "QCOM8052" },
>  	{ "AMDI0040" },
> +	{ "MLNXBF30" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
> 

