From: Vijay Viswanath <vviswana@codeaurora.org>
Subject: Re: [PATCH V2 4/4] mmc: host: Register changes for sdcc V5
Date: Fri, 15 Jun 2018 11:14:41 +0530
Message-ID: <4a215e3a-16af-4574-efca-0ebe5960705a@codeaurora.org>
References: <1527587561-27448-1-git-send-email-vviswana@codeaurora.org>
 <1527587561-27448-5-git-send-email-vviswana@codeaurora.org>
 <152884592336.16708.2751337614926643627@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152884592336.16708.2751337614926643627@swboyd.mtv.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, jeremymc@redhat.com, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org



On 6/13/2018 4:55 AM, Stephen Boyd wrote:
> Quoting Vijay Viswanath (2018-05-29 02:52:41)
>> @@ -137,6 +125,12 @@
>>   /* Timeout value to avoid infinite waiting for pwr_irq */
>>   #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>>   
>> +#define MSM_HOST_READL(msm_host, host, offset) \
>> +       msm_host->var_ops->msm_readl_relaxed(host, offset)
>> +
>> +#define MSM_HOST_WRITEL(msm_host, val, host, offset) \
>> +       msm_host->var_ops->msm_writel_relaxed(val, host, offset)
> 
> Is there a reason these macros are capitalized? We don't have READL and
> WRITEL macros in the kernel because function-like macros are typically
> lowercase.
> 

will change them to lower case. Didn't notice that...

>> +
>>   struct sdhci_msm_offset {
>>          u32 core_hc_mode;
>>          u32 core_mci_data_cnt;
>> @@ -268,6 +262,14 @@ struct sdhci_msm_host {
>>          const struct sdhci_msm_offset *offset;
>>   };
>>   
>> +const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> 
> static?
> 

will do

>> +{
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       return msm_host->offset;
>> +}
>> +
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
