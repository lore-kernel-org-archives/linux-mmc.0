Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83087C11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CC2613ED
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 12:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhF3MYI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 08:24:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:11104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234627AbhF3MYI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Jun 2021 08:24:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="293973846"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="293973846"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="419972979"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2021 05:21:37 -0700
Subject: Re: [PATCH] [RESEND] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Renius Chen <reniuschengl@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Chuang@genesyslogic.com.tw
References: <20210624032543.101861-1-reniuschengl@gmail.com>
 <916ea01b-4265-0964-9139-8f50b80ea66e@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9d720c5d-f15b-ff4f-ec42-77907b419f1b@intel.com>
Date:   Wed, 30 Jun 2021 15:21:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <916ea01b-4265-0964-9139-8f50b80ea66e@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/06/21 3:18 pm, Adrian Hunter wrote:
> On 24/06/21 6:25 am, Renius Chen wrote:
>> During a sequence of random 4K read operations, the performance will be
>> reduced due to spending much time on entering/exiting the low power state
>> between requests. We disable the low power state negotiation of GL9763E
>> during a sequence of random 4K read operations to improve the performance
>> and enable it again after the operations have finished.
>>
>> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 86 ++++++++++++++++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index 302a7579a9b3..0105f728ccc4 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -88,6 +88,9 @@
>>  #define PCIE_GLI_9763E_SCR	 0x8E0
>>  #define   GLI_9763E_SCR_AXI_REQ	   BIT(9)
>>  
>> +#define PCIE_GLI_9763E_CFG       0x8A0
>> +#define   GLI_9763E_CFG_LPSN_DIS   BIT(12)
>> +
>>  #define PCIE_GLI_9763E_CFG2      0x8A4
>>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
>>  #define   GLI_9763E_CFG2_L1DLY_MID 0x54
>> @@ -691,6 +694,86 @@ static void sdhci_gl9763e_dumpregs(struct mmc_host *mmc)
>>  	sdhci_dumpregs(mmc_priv(mmc));
>>  }
>>  
>> +static void gl9763e_request(struct mmc_host *mmc, struct mmc_request *mrq)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +	struct mmc_command *cmd;
>> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
>> +	struct pci_dev *pdev = slot->chip->pdev;
>> +	u32 value;
>> +	static bool start_4k_r;
>> +	static int  continuous_4k_r;
> 
> Please do not use static variables.  Instead define a struct for them and
> set .priv_size in sdhci_pci_fixes e.g.
> 
> struct sdhci_pci_gli {
> 	static bool start_4k_r;
> 	static int  continuous_4k_r;
> };

Cut'n'pasted without paying attention.  This was meant to be:

struct sdhci_pci_gli {
	bool start_4k_r;
	int  continuous_4k_r;
};

> 
> const struct sdhci_pci_fixes sdhci_gl9763e = {
> 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> 	.probe_slot	= gli_probe_slot_gl9763e,
> 	.ops            = &sdhci_gl9763e_ops,
> #ifdef CONFIG_PM_SLEEP
> 	.resume		= sdhci_cqhci_gli_resume,
> 	.suspend	= sdhci_cqhci_gli_suspend,
> #endif
> 	.add_host       = gl9763e_add_host,
> 	.priv_size      = sizeof(struct sdhci_pci_gli);
> };
> 
> And then you can get a pointer to it:
> 
> struct sdhci_pci_gli *sdhci_pci_gli = sdhci_pci_priv(slot);
> 
> 
>> +
>> +	cmd = (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23)) ? mrq->sbc : mrq->cmd;
> 
> mrq->cmd is always the main command, so why look at mrq->sbc?
> 
>> +
>> +	if (cmd->opcode == MMC_READ_MULTIPLE_BLOCK) {
>> +		if (cmd->data->blocks == 8) {
>> +			continuous_4k_r++;
>> +
>> +			if ((!start_4k_r) && (continuous_4k_r >= 3)) {
>> +				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>> +				value &= ~GLI_9763E_VHS_REV;
>> +				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
>> +				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>> +
>> +				pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
>> +				value |= GLI_9763E_CFG_LPSN_DIS;
>> +				pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
>> +
>> +				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>> +				value &= ~GLI_9763E_VHS_REV;
>> +				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
>> +				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>> +
>> +				start_4k_r = true;
>> +			}
>> +		} else {
>> +			continuous_4k_r = 0;
>> +
>> +			if (start_4k_r) {
>> +				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>> +				value &= ~GLI_9763E_VHS_REV;
>> +				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
>> +				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>> +
>> +				pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
>> +				value &= ~GLI_9763E_CFG_LPSN_DIS;
>> +				pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
>> +
>> +				pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>> +				value &= ~GLI_9763E_VHS_REV;
>> +				value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
>> +				pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>> +
>> +				start_4k_r = false;
>> +			}
>> +		}
>> +	} else {
>> +		continuous_4k_r = 0;
>> +
>> +		if (start_4k_r)	{
>> +			pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>> +			value &= ~GLI_9763E_VHS_REV;
>> +			value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
>> +			pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>> +
>> +			pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
>> +			value &= ~GLI_9763E_CFG_LPSN_DIS;
>> +			pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
>> +
>> +			pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>> +			value &= ~GLI_9763E_VHS_REV;
>> +			value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
>> +			pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>> +
>> +			start_4k_r = false;
>> +		}
> 
> The code chunk above is the same as the previous and almost
> the same as the one before that.  Please make a separate function
> 
>> +	}
>> +
>> +	sdhci_request(mmc, mrq);
>> +}
>> +
>> +
>>  static void sdhci_gl9763e_cqe_pre_enable(struct mmc_host *mmc)
>>  {
>>  	struct cqhci_host *cq_host = mmc->cqe_private;
>> @@ -848,6 +931,9 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>>  	gli_pcie_enable_msi(slot);
>>  	host->mmc_host_ops.hs400_enhanced_strobe =
>>  					gl9763e_hs400_enhanced_strobe;
>> +
>> +	host->mmc_host_ops.request = gl9763e_request;
>> +
>>  	gli_set_gl9763e(slot);
>>  	sdhci_enable_v4_mode(host);
>>  
>>
> 

