From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v7 14/14] sdhci: sdhci-msm: update dll configuration
Date: Tue, 15 Nov 2016 09:53:27 +0530
Message-ID: <a182baf9-4ec5-8491-0385-94f37999f854@codeaurora.org>
References: <1479103248-9491-1-git-send-email-riteshh@codeaurora.org>
 <1479103248-9491-15-git-send-email-riteshh@codeaurora.org>
 <20161114195749.GJ5177@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20161114195749.GJ5177@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, Krishna Konda <kkonda@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org



On 11/15/2016 1:27 AM, Stephen Boyd wrote:
> On 11/14, Ritesh Harjani wrote:
>> @@ -903,7 +998,33 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>>  			config |= CORE_HC_SELECT_IN_EN;
>>  			writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
>>  		}
>> +		if (!msm_host->clk_rate && !msm_host->use_cdclp533) {
>> +			/*
>> +			 * Poll on DLL_LOCK or DDR_DLL_LOCK bits in
>> +			 * CORE_DLL_STATUS to be set.  This should get set
>> +			 * within 15 us at 200 MHz.
>> +			 */
>> +			rc = readl_relaxed_poll_timeout(host->ioaddr +
>> +							CORE_DLL_STATUS,
>> +							dll_lock,
>> +							(dll_lock &
>> +							(CORE_DLL_LOCK |
>> +							CORE_DDR_DLL_LOCK)), 10,
>> +							1000);
>> +			if (rc == -ETIMEDOUT)
>> +				pr_err("%s: Unable to get DLL_LOCK/DDR_DLL_LOCK, dll_status: 0x%08x\n",
>> +				       mmc_hostname(host->mmc), dll_lock);
>> +		}
>>  	} else {
>> +		if (!msm_host->use_cdclp533) {
>> +			/* set CORE_PWRSAVE_DLL bit in CORE_VENDOR_SPEC3 */
>
> These types of comments are totally useless. The code says
> exactly what is being done, and the comment is actually wrong in
> this case. Please remove all these "set/clear bit X in register
> Y" comments.
Ok, done.

>
>> +			config = readl_relaxed(host->ioaddr +
>> +					CORE_VENDOR_SPEC3);
>> +			config &= ~CORE_PWRSAVE_DLL;
>> +			writel_relaxed(config, host->ioaddr +
>> +					CORE_VENDOR_SPEC3);
>> +		}
>> +
>>  		/* Select the default clock (free running MCLK) */
>>  		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
>>  		config &= ~CORE_HC_MCLK_SEL_MASK;
>> @@ -1100,6 +1221,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>  		msm_host->use_14lpp_dll_reset = true;
>>
>>  	/*
>> +	 * SDCC 5 controller with major version 1, minor version 0x34 and later
>> +	 * with HS 400 mode support will use CM DLL instead of CDC LP 533 DLL.
>> +	 */
>> +	if ((core_major == 1) && (core_minor < 0x34))
>
> Drop useless parenthesis please.
Done.
>
>> +		msm_host->use_cdclp533 = true;
>> +
>> +	/*
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
