From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RESEND RFC 1/3] mmc: sdhci: Add platform_dumpregs callback
 support to sdhci_ops.
Date: Wed, 18 Jan 2017 13:27:53 +0530
Message-ID: <d8e5b1fe-1f4e-f6f9-6f94-f5c7adc027f3@codeaurora.org>
References: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
 <1484030515-16722-2-git-send-email-riteshh@codeaurora.org>
 <7cfc2b6c-fa3f-a8cb-d684-472c3dbacf2f@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7cfc2b6c-fa3f-a8cb-d684-472c3dbacf2f@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 1/10/2017 2:45 PM, Shawn Lin wrote:
> On 2017/1/10 14:41, Ritesh Harjani wrote:
>> From: Sahitya Tummala <stummala@codeaurora.org>
>>
>> Add new host operation ->platform_dumpregs to provide a
>> mechanism through which host drivers can dump platform
>> specific registers in addition to SDHC registers
>> during error conditions.
>>
>
> Although we have been preventing from adding new callback
> for sdhci core, this one makes sense as there are more and more
> vendor registers outside the scope of SDHCI spec.
Sure thanks, shall I add your Reviewed-by on this patch 1/3.
Would you be able to review other as well?



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
