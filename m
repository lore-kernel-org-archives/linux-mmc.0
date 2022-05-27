Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E9BC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 27 May 2022 08:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349881AbiE0I6f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 May 2022 04:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbiE0I5N (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2022 04:57:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1765DA5D
        for <linux-mmc@vger.kernel.org>; Fri, 27 May 2022 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653641679; x=1685177679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ptqDiLazAIoYSsK1wVA1rX2ayFn37orDq7uYxEvqYsc=;
  b=k83BMAfUtJM0/O5cAKg2QsnWxzvP1NmqHl2WVvZTFXuuP6mKiNPtA6Wq
   S8/B5BK/WggiF/2Skx0PD9ZDAE02SRsb+B6EymSGuBze7sGa35JAwWY8/
   jawDGXomVIbE0JNEx3tg8373Hkm6cfsed0BTbFetD0dO9bjC/zFysxaTV
   SzvV2rc1dtt3qi/JHo1+GnbfGmeGiy58MxRgCUvoDyrurBoU6eLf4rEzK
   ipycp6iVEIyCusSLvWwnsJvDaPkHwdMAfuP9GDBvWIyx6y/zNKOLPc6AR
   fxxR4JDRfegydxBFdujQ/uRy103c99BGUZ5251xChuV81iG7SqzWUaJnH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="360812023"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="360812023"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:54:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="603764041"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 01:54:36 -0700
Message-ID: <e1e83c5e-2c73-baa6-16fa-ddadbc278aec@intel.com>
Date:   Fri, 27 May 2022 11:54:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [RESEND] mmc: sdhci-pci-gli: Improve Random 4K Read Performance
 of GL9763E
Content-Language: en-US
To:     jasonlai.genesyslogic@gmail.com, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, SeanHY.chen@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, victor.shih@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
References: <20220526070819.22151-1-jason.lai@genesyslogic.com.tw>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220526070819.22151-1-jason.lai@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/05/22 10:08, jasonlai.genesyslogic@gmail.com wrote:
> From: Jason Lai <jasonlai.genesyslogic@gmail.com>
> 
> Resend this patch due to code base updated to 5.18.0-rc3.
> 
> This patch is based on patch [1] and remove data transfer length checking.
> 
> Due to flaws in hardware design, GL9763E takes long time to exit from L1
> state. The I/O performance will suffer severe impact if it often enter and
> and exit L1 state.
> 
> Unfortunately, entering and exiting L1 state is signal handshake in
> physical layer, software knows nothiong about it. The only way to stop
> entering L1 state is to disable hardware LPM negotiation on GL9763E.
> 
> To improve read performance and take battery life into account, we reject
> L1 negotiation while executing MMC_READ_MULTIPLE_BLOCK command and enable L1
> negotiation again when receiving non-MMC_READ_MULTIPLE_BLOCK command.
> 
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=510801&archive
> =both

Really needs Ulf's response, but a minor comment below.

> 
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 60 +++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d09728c37d03..86200b73c0b0 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -95,9 +95,12 @@
>  #define PCIE_GLI_9763E_SCR	 0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
>  
> +#define PCIE_GLI_9763E_CFG       0x8A0
> +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
> +
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MID 0x54
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x54		// Set L1 entry delay time to 21us
>  
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -144,6 +147,10 @@
>  
>  #define GLI_MAX_TUNING_LOOP 40
>  
> +struct gli_host {
> +	bool lpm_negotiation_enabled;
> +};
> +
>  /* Genesys Logic chipset */
>  static inline void gl9750_wt_on(struct sdhci_host *host)
>  {
> @@ -818,6 +825,53 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
>  	sdhci_dumpregs(mmc_priv(mmc));
>  }
>  
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
> +{
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +	value &= ~GLI_9763E_VHS_REV;
> +	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> +
> +	if (enable)
> +		value &= ~GLI_9763E_CFG_LPSN_DIS;
> +	else
> +		value |= GLI_9763E_CFG_LPSN_DIS;
> +
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +	value &= ~GLI_9763E_VHS_REV;
> +	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
> +static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct mmc_command *cmd;
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct gli_host *gli_host = sdhci_pci_priv(slot);
> +
> +	cmd = mrq->cmd;
> +
> +	if (cmd && (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) && gli_host->lpm_negotiation_enabled) {
> +		gl9763e_set_low_power_negotiation(slot, false);
> +		gli_host->lpm_negotiation_enabled = false;
> +	} else {
> +		if (gli_host->lpm_negotiation_enabled == false) {

Is this logic right?  Wouldn't it also get here with
	cmd->opcode == MMC_READ_MULTIPLE_BLOCK &&
	gli_host->lpm_negotiation_enabled == false

and then you don't want the following?

> +			gl9763e_set_low_power_negotiation(slot, true);
> +			gli_host->lpm_negotiation_enabled = true;
> +		}
> +	}
> +
> +	sdhci_request(mmc, mrq);
> +}
> +
>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -1016,6 +1070,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  	gli_pcie_enable_msi(slot);
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  					gl9763e_hs400_enhanced_strobe;
> +
> +	host->mmc_host_ops.request = gl9763e_request;
> +
>  	gli_set_gl9763e(slot);
>  	sdhci_enable_v4_mode(host);
>  
> @@ -1109,4 +1166,5 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  	.allow_runtime_pm = true,
>  #endif
>  	.add_host       = gl9763e_add_host,
> +	.priv_size      = sizeof(struct gli_host),
>  };

