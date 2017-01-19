From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND RFC 1/3] mmc: sdhci: Add platform_dumpregs callback
 support to sdhci_ops.
Date: Thu, 19 Jan 2017 12:43:01 +0200
Message-ID: <79ff44d2-c20d-2dc7-9a0a-d77fb00df46d@intel.com>
References: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
 <1484030515-16722-2-git-send-email-riteshh@codeaurora.org>
 <7cfc2b6c-fa3f-a8cb-d684-472c3dbacf2f@rock-chips.com>
 <d8e5b1fe-1f4e-f6f9-6f94-f5c7adc027f3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <d8e5b1fe-1f4e-f6f9-6f94-f5c7adc027f3@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Shawn Lin <shawn.lin@rock-chips.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

On 18/01/17 09:57, Ritesh Harjani wrote:
> Hi Shawn,
> 
> On 1/10/2017 2:45 PM, Shawn Lin wrote:
>> On 2017/1/10 14:41, Ritesh Harjani wrote:
>>> From: Sahitya Tummala <stummala@codeaurora.org>
>>>
>>> Add new host operation ->platform_dumpregs to provide a
>>> mechanism through which host drivers can dump platform
>>> specific registers in addition to SDHC registers
>>> during error conditions.
>>>
>>
>> Although we have been preventing from adding new callback
>> for sdhci core, this one makes sense as there are more and more
>> vendor registers outside the scope of SDHCI spec.

We are not prevented from adding new callbacks, but they have to represent
logical functions not quirks.

This patch seems fine to me except the name "platform_dumpregs" because
"platform" doesn't mean "platform" here.  Just plain "dumpregs" is better.
