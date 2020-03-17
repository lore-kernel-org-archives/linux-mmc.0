Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4472BC10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B2920724
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQJvt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:51:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:50246 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgCQJvt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 05:51:49 -0400
IronPort-SDR: Pv04wx8ubKeROIhJt/sdR6Z9dH9vSby0aAU8kmAqQumqa70yhELiBR8kNMw/1r4RtgYwiYXr86
 IBEg6YXKJ/Ew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 02:51:48 -0700
IronPort-SDR: WRgaP+g++U6lcGt/jKTVHHQkcluBhNYKWQNLBUe/yCec9/WwGqbezmEzwxpR7iSfjmQUfhuxiJ
 Ugc7Y9nHblWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="443697480"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga005.fm.intel.com with ESMTP; 17 Mar 2020 02:51:45 -0700
Subject: Re: [PATCH v1 2/3] mmc: tegra: Implement HW busy wait timeout based
 on command busy time
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        ulf.hansson@linaro.org, baolin.wang@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        bradleybolen@gmail.com, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     anrao@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1583799205-8442-1-git-send-email-skomatineni@nvidia.com>
 <1583799205-8442-2-git-send-email-skomatineni@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ae9f09a9-8f39-8dc0-c1c8-fdf40fcea1f6@intel.com>
Date:   Tue, 17 Mar 2020 11:51:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583799205-8442-2-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/03/20 2:13 am, Sowjanya Komatineni wrote:
> Tegra host supports HW busy detection and timeouts based on the
> count programmed in SDHCI_TIMEOUT_CONTROL register and max busy
> timeout it supports is 11s in finite busy wait mode.
> 
> Some operations like SLEEP_AWAKE, ERASE and flush cache through
> SWITCH commands take longer than 11s and Tegra host supports
> infinite HW busy wait mode where HW waits forever till the card
> is busy without HW timeout.
> 
> This patch implements Tegra specific set_timeout sdhci_ops to allow
> switching between finite and infinite HW busy detection wait modes
> based on the device command expected operation time.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 31 +++++++++++++++++++++++++++++++

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 403ac44..40a221d 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -45,6 +45,7 @@
>  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
>  
>  #define SDHCI_TEGRA_VENDOR_MISC_CTRL			0x120
> +#define SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT		BIT(0)
>  #define SDHCI_MISC_CTRL_ENABLE_SDR104			0x8
>  #define SDHCI_MISC_CTRL_ENABLE_SDR50			0x10
>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
> @@ -1227,6 +1228,34 @@ static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
>  	return 0;
>  }
>  
> +static void tegra_sdhci_set_timeout(struct sdhci_host *host,
> +				    struct mmc_command *cmd)
> +{
> +	u32 val;
> +
> +	/*
> +	 * HW busy detection timeout is based on programmed data timeout
> +	 * counter and maximum supported timeout is 11s which may not be
> +	 * enough for long operations like cache flush, sleep awake, erase.
> +	 *
> +	 * ERASE_TIMEOUT_LIMIT bit of VENDOR_MISC_CTRL register allows
> +	 * host controller to wait for busy state until the card is busy
> +	 * without HW timeout.
> +	 *
> +	 * So, use infinite busy wait mode for operations that may take
> +	 * more than maximum HW busy timeout of 11s otherwise use finite
> +	 * busy wait mode.
> +	 */
> +	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> +	if (cmd && cmd->busy_timeout >= 11 * HZ)
> +		val |= SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
> +	else
> +		val &= ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
> +	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> +
> +	__sdhci_set_timeout(host, cmd);
> +}
> +
>  static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>  	.write_l    = tegra_cqhci_writel,
>  	.enable	= sdhci_tegra_cqe_enable,
> @@ -1366,6 +1395,7 @@ static const struct sdhci_ops tegra210_sdhci_ops = {
>  	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>  	.voltage_switch = tegra_sdhci_voltage_switch,
>  	.get_max_clock = tegra_sdhci_get_max_clock,
> +	.set_timeout = tegra_sdhci_set_timeout,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
> @@ -1403,6 +1433,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
>  	.voltage_switch = tegra_sdhci_voltage_switch,
>  	.get_max_clock = tegra_sdhci_get_max_clock,
>  	.irq = sdhci_tegra_cqhci_irq,
> +	.set_timeout = tegra_sdhci_set_timeout,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> 

