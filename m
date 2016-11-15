From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v7 13/14] mmc: sdhci-msm: Add calibration tuning for
 CDCLP533 circuit
Date: Tue, 15 Nov 2016 09:54:03 +0530
Message-ID: <f6867bd1-359b-e863-b358-b2c900fd224c@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
 <1479103248-9491-14-git-send-email-riteshh@codeaurora.org>
 <20161114195928.GK5177@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54486 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbcKOEYN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2016 23:24:13 -0500
In-Reply-To: <20161114195928.GK5177@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org



On 11/15/2016 1:29 AM, Stephen Boyd wrote:
> On 11/14, Ritesh Harjani wrote:
>> @@ -575,6 +729,15 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>>  	dev_dbg(mmc_dev(mmc), "%s: clock=%u uhs=%u ctrl_2=0x%x\n",
>>  		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
>>  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>> +
>> +	spin_unlock_irq(&host->lock);
>> +	/* CDCLP533 HW calibration is only required for HS400 mode*/
>> +	if (host->clock > CORE_FREQ_100MHZ &&
>> +	    msm_host->tuning_done && !msm_host->calibration_done &&
>> +	    (mmc->ios.timing == MMC_TIMING_MMC_HS400))
>
> Drop useless parenthesis.
Ok, sure.
>
>> +		if (!sdhci_msm_cdclp533_calibration(host))
>> +			msm_host->calibration_done = true;
>> +	spin_lock_irq(&host->lock);
>>  }
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
