From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 6/6] mmc: sdhci: remove CONFIG_MMC_DEBUG from the
 driver
Date: Wed, 19 Jul 2017 10:16:34 +0300
Message-ID: <0daed43c-f648-b536-9a5c-dc43cde7da63@intel.com>
References: <1500368376-160272-1-git-send-email-shawn.lin@rock-chips.com>
 <1500368503-160501-1-git-send-email-shawn.lin@rock-chips.com>
 <1500368503-160501-2-git-send-email-shawn.lin@rock-chips.com>
 <b21d0902-826c-c4b2-0bf0-7ff453a9bfa6@intel.com>
 <9e8e1a62-84ca-ce43-5b8d-debcda6e103c@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbdGSHWu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Jul 2017 03:22:50 -0400
In-Reply-To: <9e8e1a62-84ca-ce43-5b8d-debcda6e103c@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 19/07/17 03:32, Shawn Lin wrote:
> Hi Adrian,
> 
> On 2017/7/18 17:38, Adrian Hunter wrote:
>> On 18/07/17 12:01, Shawn Lin wrote:
>>> sdhci uses CONFIG_MMC_DEBUG for showing ADMA descriptor
>>> when occurring ADMA error. And it's also used to  dump the
>>> registers whenever calling sdhci_add_host.
>>>
>>> On one hand, I don't see any burden to always print the state
>>> ADMA descriptor as it's rare and will help folks better understand
>>> what was happening when seeing ADMA error.
>>>
>>> On the other, git-blame points out that CONFIG_MMC_DEBUG for
>>> sdhci_add_host was added since it's merged for the first time.
>>> I don't know what exactly the intention was, but I guess folks
>>> don't need it at all? IMHO, it's another all-or-none proposition.
>>> I'd prefer to remove this sdhci_dumpregs from sdhci_add_host totally.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> ---
>>>
>>>   drivers/mmc/host/sdhci.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index ecd0d43..82f1761 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -2502,7 +2502,6 @@ static void sdhci_cmd_irq(struct sdhci_host *host,
>>> u32 intmask)
>>>           sdhci_finish_command(host);
>>>   }
>>>   -#ifdef CONFIG_MMC_DEBUG
>>>   static void sdhci_adma_show_error(struct sdhci_host *host)
>>>   {
>>>       void *desc = host->adma_table;
>>> @@ -2530,9 +2529,6 @@ static void sdhci_adma_show_error(struct sdhci_host
>>> *host)
>>>               break;
>>>       }
>>>   }
>>> -#else
>>> -static void sdhci_adma_show_error(struct sdhci_host *host) { }
>>> -#endif
>>>     static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>>>   {
>>> @@ -3747,10 +3743,6 @@ int __sdhci_add_host(struct sdhci_host *host)
>>>           goto untasklet;
>>>       }
>>>   -#ifdef CONFIG_MMC_DEBUG
>>> -    sdhci_dumpregs(host);
>>> -#endif
>>
>> We should still DBG() the interesting registers like SDHCI_HOST_VERSION,
>> SDHCI_PRESENT_STATE, SDHCI_CAPABILITIES, SDHCI_CAPABILITIES_1.  Better to do
>> it earlier on though, like in sdhci_setup_host() after checking
>> mmc_regulator_get_supply().
>>
> 
> Okay. So would you like to kill the CONFIG_MMC_DEBUG around
> this dempregs and keep the output log always there OR you still
> want to keep it under CONFIG_MMC_DEBUG?

We absolutely want register dumps if there are unexpected errors, so the dump
cannot use dynamic debug.  But we also want to be able to see the interesting
registers at probe time.  We could make use of DYNAMIC_DEBUG_BRANCH and
DEFINE_DYNAMIC_DEBUG_METADATA but that is not something that is commonly done.
So that leaves adding a few extra pr_debugs (DBG macro for sdhci) at probe time
i.e. Remove CONFIG_MMC_DEBUG and add something like:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ecd0d4350e8a..1b619ccc27f5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3230,6 +3230,13 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
+	DBG("Version:   0x%08x | Present:  0x%08x\n",
+	    sdhci_readw(host, SDHCI_HOST_VERSION),
+	    sdhci_readl(host, SDHCI_PRESENT_STATE));
+	DBG("Caps:      0x%08x | Caps_1:   0x%08x\n",
+	    sdhci_readl(host, SDHCI_CAPABILITIES),
+	    sdhci_readl(host, SDHCI_CAPABILITIES_1));
+
 	sdhci_read_caps(host);
 
 	override_timeout_clk = host->timeout_clk;


