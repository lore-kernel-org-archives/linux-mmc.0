Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F89FC56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C3C20872
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgKZISF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:18:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:54713 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgKZISE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:18:04 -0500
IronPort-SDR: AewR5CY8IsbQ4pz2kMGp2WPKRd2plhbDHS5XZSvyXeY1RWKOfL0dpnzjBurDdMBECCpQYo6wJ9
 fkEO97pKueFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="171474425"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="171474425"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:18:03 -0800
IronPort-SDR: g8f7YfLRjj03BNpD0ce9pRIHtrRjDBSp6+UszhtutHwzFC5Fl6buDGScotMz50IMEcYMc5C8e5
 5XECdmvqEoZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362722072"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:18:00 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 17/27] mmc: sdhci-uhs2: add detect_init() to
 detect the interface
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-18-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <38b7390f-7845-292b-77e1-33b610196cfd@intel.com>
Date:   Thu, 26 Nov 2020 10:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-18-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> Sdhci_uhs2_do_detect_init() is a sdhci version of mmc's uhs2_detect_init
> operation. After detected, the host's UHS-II capabilities will be set up
> here and interrupts will also be enabled.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 160 ++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 637464748cc4..994dff967e85 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -391,12 +391,172 @@ void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static int sdhci_uhs2_interface_detect(struct sdhci_host *host)
> +{
> +	int timeout = 100;

Please comment on where timeouts / delays come from. e.g. as per spec

> +
> +	udelay(200); /* wait for 200us before check */
> +
> +	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +		SDHCI_UHS2_IF_DETECT)) {


Can be read_poll_timeout(sdhci_readl,...,host, SDHCI_PRESENT_STATE)

> +		if (timeout == 0) {
> +			pr_warn("%s: not detect UHS2 interface in 200us.\n",
> +				mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return -EIO;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +
> +	/* Enable UHS2 error interrupts */
> +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> +				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
> +
> +	timeout = 150;
> +	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +		SDHCI_UHS2_LANE_SYNC)) {

Ditto

> +		if (timeout == 0) {
> +			pr_warn("%s: UHS2 Lane sync fail in 150ms.\n",
> +				mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return -EIO;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +
> +	DBG("%s: UHS2 Lane synchronized in UHS2 mode, PHY is initialized.\n",
> +	    mmc_hostname(host->mmc));
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_init(struct sdhci_host *host)
> +{
> +	u16 caps_ptr = 0;
> +	u32 caps_gen = 0;
> +	u32 caps_phy = 0;
> +	u32 caps_tran[2] = {0, 0};
> +	struct mmc_host *mmc = host->mmc;
> +
> +	/*
> +	 * TODO: may add corresponding members in sdhci_host to
> +	 * keep these caps.
> +	 */
> +	caps_ptr = sdhci_readw(host, SDHCI_UHS2_HOST_CAPS_PTR);
> +	if (caps_ptr < 0x100 || caps_ptr > 0x1FF) {
> +		pr_err("%s: SDHCI_UHS2_HOST_CAPS_PTR(%d) is wrong.\n",
> +		       mmc_hostname(mmc), caps_ptr);
> +		return -ENODEV;
> +	}
> +	caps_gen = sdhci_readl(host,
> +			       caps_ptr + SDHCI_UHS2_HOST_CAPS_GEN_OFFSET);
> +	caps_phy = sdhci_readl(host,
> +			       caps_ptr + SDHCI_UHS2_HOST_CAPS_PHY_OFFSET);
> +	caps_tran[0] = sdhci_readl(host,
> +				   caps_ptr + SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET);
> +	caps_tran[1] = sdhci_readl(host,
> +				   caps_ptr
> +					+ SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET);
> +
> +	/* General Caps */
> +	mmc->uhs2_caps.dap = caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK;
> +	mmc->uhs2_caps.gap = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK) >>
> +			     SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT;
> +	mmc->uhs2_caps.n_lanes = (caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK)
> +			>> SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT;
> +	mmc->uhs2_caps.addr64 =
> +		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64) ? 1 : 0;
> +	mmc->uhs2_caps.card_type =
> +		(caps_gen & SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK) >>
> +		SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT;
> +
> +	/* PHY Caps */
> +	mmc->uhs2_caps.phy_rev = caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK;
> +	mmc->uhs2_caps.speed_range =
> +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT;
> +	mmc->uhs2_caps.n_lss_sync =
> +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT;
> +	mmc->uhs2_caps.n_lss_dir =
> +		(caps_phy & SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT;
> +	if (mmc->uhs2_caps.n_lss_sync == 0)
> +		mmc->uhs2_caps.n_lss_sync = 16 << 2;
> +	else
> +		mmc->uhs2_caps.n_lss_sync <<= 2;
> +	if (mmc->uhs2_caps.n_lss_dir == 0)
> +		mmc->uhs2_caps.n_lss_dir = 16 << 3;
> +	else
> +		mmc->uhs2_caps.n_lss_dir <<= 3;
> +
> +	/* LINK/TRAN Caps */
> +	mmc->uhs2_caps.link_rev =
> +		caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK;
> +	mmc->uhs2_caps.n_fcu =
> +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT;
> +	if (mmc->uhs2_caps.n_fcu == 0)
> +		mmc->uhs2_caps.n_fcu = 256;
> +	mmc->uhs2_caps.host_type =
> +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT;
> +	mmc->uhs2_caps.maxblk_len =
> +		(caps_tran[0] & SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK)
> +		>> SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT;
> +	mmc->uhs2_caps.n_data_gap =
> +		caps_tran[1] & SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK;
> +
> +	return 0;
> +}
> +
> +static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
> +{
> +        struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	int ret = -EIO;
> +
> +	DBG("%s: begin UHS2 init.\n", __func__);
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (sdhci_uhs2_interface_detect(host)) {
> +		pr_warn("%s: cannot detect UHS2 interface.\n",
> +			mmc_hostname(host->mmc));
> +		goto out;
> +	}
> +
> +	if (sdhci_uhs2_init(host)) {
> +		pr_warn("%s: UHS2 init fail.\n", mmc_hostname(host->mmc));
> +		goto out;
> +	}
> +
> +	/* Init complete, do soft reset and enable UHS2 error irqs. */
> +	sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
> +	sdhci_uhs2_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> +				  SDHCI_UHS2_ERR_INT_STATUS_MASK);
> +	/*
> +	 * !!! SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE was cleared
> +	 * by SDHCI_UHS2_SW_RESET_SD
> +	 */
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +	ret = 0;
> +out:
> +	spin_unlock_irqrestore(&host->lock, flags);
> +	return ret;
> +}
> +
>  static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  {
>  	host->mmc_host_ops.start_signal_voltage_switch =
>  		sdhci_uhs2_start_signal_voltage_switch;
>  	host->mmc_host_ops.set_ios = sdhci_uhs2_set_ios;
>  
> +	if (!host->mmc_host_ops.uhs2_detect_init)
> +		host->mmc_host_ops.uhs2_detect_init = sdhci_uhs2_do_detect_init;
> +
>  	return 0;
>  }
>  
> 

