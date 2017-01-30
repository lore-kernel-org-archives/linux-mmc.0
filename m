From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Mon, 30 Jan 2017 14:40:30 +0200
Message-ID: <2b37a0fa-46e3-ec4e-3f9c-9e1bb7dcda1e@intel.com>
References: <20170116142342.21283-1-krisman@collabora.co.uk>
 <CAPDyKFpowPmbwvHL9NL60zAABfW53sDKkp0Ag5aXs4jZZLC=Dg@mail.gmail.com>
 <87wpdg9uob.fsf@dilma.collabora.co.uk>
 <CAPDyKFq2aUkk4qzcLNoityHbOYTHCq_OiO9HVLuWjcGSJX0aWw@mail.gmail.com>
 <87poj4loa5.fsf@dilma.collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2193 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753332AbdA3Mrz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Jan 2017 07:47:55 -0500
In-Reply-To: <87poj4loa5.fsf@dilma.collabora.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

On 30/01/17 14:34, Gabriel Krisman Bertazi wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
>> On 27 January 2017 at 20:20, Gabriel Krisman Bertazi
>> <krisman@collabora.co.uk> wrote:
>>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>>
>>>> On 16 January 2017 at 15:23, Gabriel Krisman Bertazi
>>>> <krisman@collabora.co.uk> wrote:
>>>>> One of our kernelCI boxes hanged at boot because a faulty eSDHC
>>>>> device
>>>>> was triggering spurious CARD_INT interrupts for SD cards, causing
>>>>> CMD52
>>>>> reads, which are not allowed for SD devices.  This adds a sanity
>>>>> check
>>>>> to the interruption path, preventing that illegal command from
>>>>> getting
>>>>> sent if the CARD_INT interruption should be disabled.
>>>>>
>>>>> This quirk allows that particular machine to resume boot despite the
>>>>> faulty hardware, instead of getting hung dealing with thousands of
>>>>> mishandled interrupts.
>>>>>
>>>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
>>>>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> CC: linux-mmc@vger.kernel.org
>>>>
>>>> Thanks, applied for next with update commit msg header and by
>>>> removing
>>>> the CCs from the changelog.
>>>
>>> Hi Ulf,
>>>
>>> Thanks for applying.  Although, I saw it got queued to the next merge
>>> window, but I we believe it to be -rc material, since it fixes a hang
>>> in our kernelCI boxes[1], and is preventing us from testing other
>>> features
>>> in this box.  Can you consider submitting it to Linus for the next
>>> -rc?
>>> it will be much appreciated!
>>
>> I can do that, but perhaps this should then be tagged for stable as
>> well?
>>
> 
> Thanks Ulf.  Yes, it should go to stable releases as well.  I tested it
> on 4.4 and 4.9 already.

Did you test normal SDIO operation was unaffected?  Please do that before
sending it to stable.

