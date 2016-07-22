From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-msm: Add set_uhs_signaling() implementation
Date: Fri, 22 Jul 2016 11:37:38 +0300
Message-ID: <5791DB52.1010205@linaro.org>
References: <1468939945-15233-1-git-send-email-georgi.djakov@linaro.org>
 <578F4F55.5060406@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <578F4F55.5060406@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, riteshh@codeaurora.org, bjorn.andersson@linaro.org, srinivas.kandagatla@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 07/20/2016 01:15 PM, Adrian Hunter wrote:
> On 19/07/16 17:52, Georgi Djakov wrote:
>> From: Ritesh Harjani <riteshh@codeaurora.org>
>>
>> To allow UHS mode to work properly, we need to implement a Qualcomm
>> specific set_uhs_signaling() callback function. This function differs
>> from the sdhci_set_uhs_signaling() in that we need check the clock
>> rate and enable UHS timing only if the frequency is above 100MHz.
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>
>> This patch resolves the mmc_select_hs200 timeouts noticed after merging
>> commit a5c1f3e55c99 ("mmc: mmc: do not use CMD13 to get status after
>> speed mode switch")
>>
>> mmc0: mmc_select_hs200 failed, error -110
>> mmc0: error -110 whilst initialising MMC card
>> mmc0: Reset 0x1 never completed.
>> sdhci: =========== REGISTER DUMP (mmc0)===========
>> sdhci: Sys addr: 0x00000000 | Version: 0x00002e02
>> sdhci: Blk size: 0x00004000 | Blk cnt: 0x00000000
>> sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
>> sdhci: Present: 0x01f80000 | Host ctl: 0x00000000
>> sdhci: Power: 0x00000000 | Blk gap: 0x00000000
>> sdhci: Wake-up: 0x00000000 | Clock: 0x00000003
>> sdhci: Timeout: 0x00000000 | Int stat: 0x00000000
>> sdhci: Int enab: 0x00000000 | Sig enab: 0x00000000
>> sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>> sdhci: Caps: 0x322dc8b2 | Caps_1: 0x00008007
>> sdhci: Cmd: 0x00000000 | Max curr: 0x00000000
>> sdhci: Host ctl2: 0x00000000
>> sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000000000000
>> sdhci: ===========================================
> 
> This information needs to be in the commit message.  I think you should add
> a fixes tag too. e.g.
> 
> Fixes: a5c1f3e55c99 ("mmc: mmc: do not use CMD13 to get status after...")
> 
> Otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks Adrian!

Ulf, do you want me to resend?

BR,
Georgi
