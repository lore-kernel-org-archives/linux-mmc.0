Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB8FC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839FB207C3
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHUOFa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:05:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:13349 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgHUOF3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 10:05:29 -0400
IronPort-SDR: Jc7Fv7OT4/Ccdyd+oRyBVaJlEWE59tmrvoySdyJ/muYMmNxSlX5D24p3mrpROCsjt1VygJKm98
 atuLG90lY3LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="217074549"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="217074549"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 07:05:28 -0700
IronPort-SDR: 8Khx1VGbvE3rMi/UZQkQ9MhBoCEA/OFMGNShgD6mRVGhafjgFy0zB4EhVSyatx02YkpaaEHZjc
 tJGCtT8O7l+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="297951887"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga006.jf.intel.com with ESMTP; 21 Aug 2020 07:05:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH V3 10/21] mmc: sdhci: UHS-II support, dump UHS-II
 registers
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw
References: <20200710111034.29456-1-benchuanggli@gmail.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bd374ef8-8b8b-031b-0e59-d6f881cb9330@intel.com>
Date:   Fri, 21 Aug 2020 17:04:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710111034.29456-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/07/20 2:10 pm, Ben Chuang wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> Dump UHS-II specific registers, if available, in sdhci_dumpregs()
> for informative/debugging use.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 37b1158c1c0c..c2f6923d296c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -111,6 +111,30 @@ void sdhci_dumpregs(struct sdhci_host *host)
>  		}
>  	}
>  
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    host->mmc && host->mmc->flags & MMC_UHS2_SUPPORT) {
> +		SDHCI_DUMP("==================== UHS2 ==================\n");
> +		SDHCI_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
> +			   sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
> +			   sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
> +		SDHCI_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
> +			   sdhci_readw(host, SDHCI_UHS2_COMMAND),
> +			   sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
> +		SDHCI_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
> +			   sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
> +			   sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
> +		SDHCI_DUMP("Dev Int Code:  0x%08x\n",
> +			   sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
> +		SDHCI_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
> +			   sdhci_readw(host, SDHCI_UHS2_SW_RESET),
> +			   sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
> +		SDHCI_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
> +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS),
> +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN));
> +		SDHCI_DUMP("ErrSigEn:  0x%08x\n",
> +			   sdhci_readl(host, SDHCI_UHS2_ERR_INT_SIG_EN));
> +	}
> +

Let's make this a host op instead ie.

	if (host->ops->dump_uhs2_regs)
		host->ops->dump_uhs2_regs(host);

>  	if (host->ops->dump_vendor_regs)
>  		host->ops->dump_vendor_regs(host);
>  
> 

