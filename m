From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [RESEND RFC 1/3] mmc: sdhci: Add platform_dumpregs callback
 support to sdhci_ops.
Date: Fri, 20 Jan 2017 11:29:07 +0530
Message-ID: <71f3125b-8fcf-4df1-5151-7f4c41067227@codeaurora.org>
References: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
 <1484030515-16722-2-git-send-email-riteshh@codeaurora.org>
 <7cfc2b6c-fa3f-a8cb-d684-472c3dbacf2f@rock-chips.com>
 <d8e5b1fe-1f4e-f6f9-6f94-f5c7adc027f3@codeaurora.org>
 <79ff44d2-c20d-2dc7-9a0a-d77fb00df46d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdATGBV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 01:01:21 -0500
In-Reply-To: <79ff44d2-c20d-2dc7-9a0a-d77fb00df46d@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com


On 1/19/2017 4:13 PM, Adrian Hunter wrote:
> On 18/01/17 09:57, Ritesh Harjani wrote:
>> Hi Shawn,
>>
>> On 1/10/2017 2:45 PM, Shawn Lin wrote:
>>> On 2017/1/10 14:41, Ritesh Harjani wrote:
>>>> From: Sahitya Tummala <stummala@codeaurora.org>
>>>>
>>>> Add new host operation ->platform_dumpregs to provide a
>>>> mechanism through which host drivers can dump platform
>>>> specific registers in addition to SDHC registers
>>>> during error conditions.
>>>>
>>>
>>> Although we have been preventing from adding new callback
>>> for sdhci core, this one makes sense as there are more and more
>>> vendor registers outside the scope of SDHCI spec.
>
> We are not prevented from adding new callbacks, but they have to represent
> logical functions not quirks.
>
> This patch seems fine to me except the name "platform_dumpregs" because
I took platform prefix similar to platform_execute_tuning.


> "platform" doesn't mean "platform" here.  Just plain "dumpregs" is better.
Sure, I will only keep "dumpregs" in next revision.

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
