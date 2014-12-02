From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: sdhci: Disable re-tuning for HS400
Date: Tue, 2 Dec 2014 15:06:18 +0100
Message-ID: <CAPDyKFrAmQyO=eUL-WS=etLeuFh8Ncefk5mocJraq8LjR_Ci9Q@mail.gmail.com>
References: <1417439766-5063-1-git-send-email-adrian.hunter@intel.com>
	<1417439766-5063-4-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFq30Qkx8rW1ixavv=UdBjcQfsz6kDvcfmcTq4A4ziptUQ@mail.gmail.com>
	<547D8FB2.1020400@intel.com>
	<CAPDyKFq=TxzGmQws6RmtchfxN9FBqUryirA306AW0wANZzn0-g@mail.gmail.com>
	<547DB054.80907@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:37499 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaLBOGT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Dec 2014 09:06:19 -0500
Received: by mail-qc0-f173.google.com with SMTP id i17so9396419qcy.18
        for <linux-mmc@vger.kernel.org>; Tue, 02 Dec 2014 06:06:18 -0800 (PST)
In-Reply-To: <547DB054.80907@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 2 December 2014 at 13:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 02/12/14 13:20, Ulf Hansson wrote:
>> On 2 December 2014 at 11:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 02/12/14 11:35, Ulf Hansson wrote:
>>>> On 1 December 2014 at 14:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> Re-tuning for HS400 mode must be done in HS200
>>>>> mode. Currently there is no support for that.
>>>>> That needs to be reflected in the code.
>>>>> Specifically, if tuning is executed in HS400 mode
>>>>> then return an error, and if the re-tuning timer
>>>>> is running when switching to HS400 mode, then
>>>>> disable the timer.
>>>>>
>>>>> Note that periodic re-tuning is not expected
>>>>> to be needed for HS400 but re-tuning is still
>>>>> needed after the host controller has lost power.
>>>>
>>>> Why can't the old values be restored instead of trigger a re-tuning?
>>>
>>> The "values" (not sure what you mean by that) are not available to the
>>> driver. Even if they were the operating conditions may have changed, (i.e.
>>> temperature change) so the old "values" could still be wrong.
>>
>> The "values" I refer to is those which we "calculated" during the
>> tuning process.
>>
>> What I had in mind, was that we should save these values at runtime PM
>> suspend. And restore them at runtime PM resume. For some mmc
>> controllers the "values" are typically just a some bits in a
>> controller register, but that might not be true for all cases.
>>
>> Regarding the temperature change, etc. I think that is what the
>> periodic retuning should be taken care off.
>>
>> Could you elaborate on why the "values" is not available to the driver?
>
> The "optimal sampling point" has no corresponding register or value
> in SDHCI.

Is that really the case for all sdhci variants? For sure I am not an
sdhci expert, but I just find it to be a very poor HW design.

Especially if the sdhci controller may lose power frequently, it will
add a significant latency for each runtime PM resume cycle, right!?

Anyway, thanks for sharing the information.

Kind regards
Uffe
