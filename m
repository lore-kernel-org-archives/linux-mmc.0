From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH-v2 0/3] mmc: sdhci-pxav3: Fix tabbing issue
Date: Tue, 15 Sep 2015 19:36:11 +0530
Message-ID: <55F825D3.9070501@linaro.org>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
 <CAPDyKFov6uADy_o944hZS9es6hkr4WM9EV1t9MXe94TcwEHuwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33446 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbIOOGR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Sep 2015 10:06:17 -0400
Received: by pacex6 with SMTP id ex6so178298131pac.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2015 07:06:16 -0700 (PDT)
In-Reply-To: <CAPDyKFov6uADy_o944hZS9es6hkr4WM9EV1t9MXe94TcwEHuwQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>



On Tuesday 15 September 2015 05:58 PM, Ulf Hansson wrote:
> On 7 September 2015 at 13:31, Vaibhav Hiremath
> <vaibhav.hiremath@linaro.org> wrote:
>> Trivial patch-series, which fixes the tabbing issue in the driver,
>> uses the BIT macro for bit fields and prints notice on -EPROBE_DEFER
>> in sdhci_add_host() function on regulator unavailability.
>>
>> V1 => V2
>> ========
>>   - Fixed all comments from Joe, mostly alignment changes
>>   - Separated BIT macro usage patch into new one.
>>   - changed error to kernel notice for EPROBE_DEFER in sdhci_add_host()
>>
>> Note: This patch-series should get merged before another series -
>>
>> [PATCH-v2 0/7] mmc: sdhci-pxav3: Enable support for PXA1928 SDCHI controller
>>
>> Vaibhav Hiremath (3):
>>    mmc: sdhci-pxav3: Fix tabbing issue
>>    mmc: sdhci-pxav3: Use BIT macro for bit field definitions
>>    mmc: sdhci: print notice on -EPROBE_DEFER in sdhci_add_host() fn
>>
>>   drivers/mmc/host/sdhci-pxav3.c | 46 +++++++++++++++++++++---------------------
>>   drivers/mmc/host/sdhci.c       |  5 ++++-
>>   2 files changed, 27 insertions(+), 24 deletions(-)
>>
>> --
>> 1.9.1
>>
>
> Hi Vaibhav,
>
> FYI, I won't be picking up any of these patches. Primarily because I
> don't think they improves the code and other people also seems to
> agree to that.
>
> Regarding patch1 and similar patches which deals with only fixing
> checkpatch warnings/errors. In most cases I don't like such changes,
> as they makes it harder to use "git blame" when you want to find out
> which commit that introduced a change.
>


Honestly, I also agree with you.
But recently I have been told to do these changed to get my
main/feature changes accepted :)

No issues, I am OK to drop them.
These are just beautification changes and as you rightly
said it makes 'git blame' difficult to find original change commit.


Thanks,
Vaibhav
