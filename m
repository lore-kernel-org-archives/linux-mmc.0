From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v3 0/6] Add multiple GPIO and external clock to MMC pwrseq_simple
Date: Wed, 04 Feb 2015 16:06:57 +0100
Message-ID: <54D23591.7050208@collabora.co.uk>
References: <1422543608-24704-1-git-send-email-javier.martinez@collabora.co.uk> <CAPDyKFqx-dhhVmtGnP2YpmR63Y20Ns=YyxnYrE2ewTuNXPA7Ag@mail.gmail.com> <54CB81EF.8030603@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:55560 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755411AbbBDPHF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Feb 2015 10:07:05 -0500
In-Reply-To: <54CB81EF.8030603@collabora.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Arend van Spriel <arend@broadcom.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello Kukjin,

On 01/30/2015 02:06 PM, Javier Martinez Canillas wrote:
> On 01/30/2015 12:13 PM, Ulf Hansson wrote:
>>>
>>> Patch #1 extends the simple MMC power sequence DT binding to support more
>>> than one GPIO and patch #2 adds the actual implementation.
>>>
>>> In the same way, patch #3 and #4 extend the simple MMC power sequence DT
>>> binding and pwrseq_simple driver to support an optional external clock.
>>>
>>> Finally as an example, patch #5 and patch #6 adds support for the wifi
>>> chip in the Exynos5250 Snow that needs all these resources. These two
>>> patches were added to the series only for completeness and should be
>>> picked by Kukjin through his linux-samsung tree.
>>>
>>> Best regards,
>>> Javier
>> 
>> Thanks Javier! I have applied patch 1 -> 4 for my next branch.
>> 
>> I made some minor fix to patch4, I send a separate response to that
>> patch so you know.
>>
> 
> Great, thanks a lot!
> 
> Kukjin,
> 
> Could you please pick patches #5 and #6 then now that Ulf picked the others?
>

I noticed that you are applying patches to your Samsung tree, do you want me to
re-send patches #5 and #6 or is OK for you to pick them from from this series?

Best regards,
Javier





