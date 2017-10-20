From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH v2 4/4] mmc: sdhci-msm: Add sdhci msm register write APIs
 which wait for pwr irq
Date: Fri, 20 Oct 2017 16:24:39 +0530
Message-ID: <cf405901-e711-4ef9-dffd-1e94a023c4a1@codeaurora.org>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
 <20171014073118.GD1575@tuxbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbdJTKyp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 06:54:45 -0400
In-Reply-To: <20171014073118.GD1575@tuxbook>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, riteshh@codeaurora.org, subhashj@codeaurora.org

On 10/14/2017 1:01 PM, Bjorn Andersson wrote:
> On Tue 26 Sep 22:34 PDT 2017, Vijay Viswanath wrote:
> 
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> [..]
>> +	if (!done) {
>> +		if (!wait_event_timeout(msm_host->pwr_irq_wait,
>> +				msm_host->pwr_irq_flag,
>> +				msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
>> +			__WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
>> +					mmc_hostname(host->mmc), req_type);
> 
> Bumped my MSM8974AB device to latest linux-next and found this patch; I
> see this print every five seconds during boot and the eMMC never comes
> up.
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Hi Bjorn,

I couldn't get one 8974 device. I tested the latest linux-next on db410c 
and its not showing any issue. 8974 is an older msm and has some 
differences in the controller like your "mmc: sdhci-msm: Enable delay 
circuit calibration clocks" patch.

I am currently going through the programming guide to see what could be 
the reason. Can you please share the full logs from the device with me 
so that I can focus my search?

Thanks,
Vijay
