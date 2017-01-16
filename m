From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RFC PATCH 1/3] mmc: sdhci: Add platform_dumpregs callback
 support to sdhci_ops.
Date: Mon, 16 Jan 2017 07:45:48 +0530
Message-ID: <111ae8a1-c626-9285-5704-0af45f4b510d@codeaurora.org>
References: <1483097531-9991-1-git-send-email-riteshh@codeaurora.org>
 <1483097531-9991-2-git-send-email-riteshh@codeaurora.org>
 <20170113222125.GA22862@mini-rhel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47630 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdAPCP6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jan 2017 21:15:58 -0500
In-Reply-To: <20170113222125.GA22862@mini-rhel.redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremy McNicoll <jmcnicol@redhat.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org, subhashj@codeaurora.org

Hi Jeremy,

Thanks for the review.

On 1/14/2017 3:51 AM, Jeremy McNicoll wrote:
> On Fri, Dec 30, 2016 at 05:02:09PM +0530, Ritesh Harjani wrote:
>> From: Sahitya Tummala <stummala@codeaurora.org>
>>
>> Add new host operation ->platform_dumpregs to provide a
>> mechanism through which host drivers can dump platform
>> specific registers in addition to SDHC registers
>> during error conditions.
>>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 3 +++
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 4 insertions(+)
>>
>
> This change and 2/3 look like they can be squished together into
> one patch.  At least that is how I did it,

I felt it is better this way to keep sdhci and sdhci-msm patches 
separate. This patch provides mechanism and patch 3/3 provides
implementation of ->platform_dumpregs in sdhci-msm.

Regards
Ritesh


>
> https://patchwork.kernel.org/patch/9442449/
>
> -jeremy
>
>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 2390980..73a8918 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -101,6 +101,9 @@ static void sdhci_dumpregs(struct sdhci_host *host)
>>  			       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
>>  	}
>>
>> +	if (host->ops->platform_dumpregs)
>> +		host->ops->platform_dumpregs(host);
>> +
>>  	pr_err(DRIVER_NAME ": ===========================================\n");
>>  }
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 0b66f21..400f3a1 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -564,6 +564,7 @@ struct sdhci_ops {
>>  					 struct mmc_card *card,
>>  					 unsigned int max_dtr, int host_drv,
>>  					 int card_drv, int *drv_type);
>> +	void	(*platform_dumpregs)(struct sdhci_host *host);
>>  };
>>
>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> --
>> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project.
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
