From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 04/14] mmc: sdhci-msm: Change poor style writel/readl
 of registers
Date: Wed, 9 Nov 2016 17:25:28 +0530
Message-ID: <4f889254-9c5b-b459-7566-1b8b1ff5cbd0@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-5-git-send-email-riteshh@codeaurora.org>
 <20161108230724.GO16026@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161108230724.GO16026-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kdorfman-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Stephen,

On 11/9/2016 4:37 AM, Stephen Boyd wrote:
> On 11/07, Ritesh Harjani wrote:
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 8ef44a2a..42f42aa 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -137,8 +137,9 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
>>  	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>>
>>  	/* Set CK_OUT_EN bit of DLL_CONFIG register to 1. */
>> -	writel_relaxed((readl_relaxed(host->ioaddr + CORE_DLL_CONFIG)
>> -			| CORE_CK_OUT_EN), host->ioaddr + CORE_DLL_CONFIG);
>> +	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
>> +	config |= CORE_CK_OUT_EN;
>> +	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>>
>>  	/* Wait until CK_OUT_EN bit of DLL_CONFIG register becomes '1' */
>>  	rc = msm_dll_poll_ck_out_en(host, 1);
>> @@ -305,6 +306,7 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>>  	struct mmc_host *mmc = host->mmc;
>>  	int wait_cnt = 50;
>>  	unsigned long flags;
>> +	u32 config = 0;
>
> It needs to be initialized?
No, will make it uninitialized.

>
>>
>>  	spin_lock_irqsave(&host->lock, flags);
>>
>> @@ -313,33 +315,40 @@ static int msm_init_cm_dll(struct sdhci_host *host)
>>  	 * tuning is in progress. Keeping PWRSAVE ON may
>>  	 * turn off the clock.
>>  	 */
>> -	writel_relaxed((readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC)
>> -			& ~CORE_CLK_PWRSAVE), host->ioaddr + CORE_VENDOR_SPEC);
>> +	config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
>
> It's written here unconditionally though?
>
>> +	config &= ~CORE_CLK_PWRSAVE;
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
