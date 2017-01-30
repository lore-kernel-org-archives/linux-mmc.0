From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: Re: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Mon, 30 Jan 2017 10:34:26 -0200
Message-ID: <87poj4loa5.fsf@dilma.collabora.co.uk>
References: <20170116142342.21283-1-krisman@collabora.co.uk>
        <CAPDyKFpowPmbwvHL9NL60zAABfW53sDKkp0Ag5aXs4jZZLC=Dg@mail.gmail.com>
        <87wpdg9uob.fsf@dilma.collabora.co.uk>
        <CAPDyKFq2aUkk4qzcLNoityHbOYTHCq_OiO9HVLuWjcGSJX0aWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbdA3Mef (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 07:34:35 -0500
In-Reply-To: <CAPDyKFq2aUkk4qzcLNoityHbOYTHCq_OiO9HVLuWjcGSJX0aWw@mail.gmail.com>
        (Ulf Hansson's message of "Mon, 30 Jan 2017 09:19:07 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 27 January 2017 at 20:20, Gabriel Krisman Bertazi
> <krisman@collabora.co.uk> wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> On 16 January 2017 at 15:23, Gabriel Krisman Bertazi
>>> <krisman@collabora.co.uk> wrote:
>>>> One of our kernelCI boxes hanged at boot because a faulty eSDHC
>>>> device
>>>> was triggering spurious CARD_INT interrupts for SD cards, causing
>>>> CMD52
>>>> reads, which are not allowed for SD devices.  This adds a sanity
>>>> check
>>>> to the interruption path, preventing that illegal command from
>>>> getting
>>>> sent if the CARD_INT interruption should be disabled.
>>>>
>>>> This quirk allows that particular machine to resume boot despite the
>>>> faulty hardware, instead of getting hung dealing with thousands of
>>>> mishandled interrupts.
>>>>
>>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
>>>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>>>> CC: linux-mmc@vger.kernel.org
>>>
>>> Thanks, applied for next with update commit msg header and by
>>> removing
>>> the CCs from the changelog.
>>
>> Hi Ulf,
>>
>> Thanks for applying.  Although, I saw it got queued to the next merge
>> window, but I we believe it to be -rc material, since it fixes a hang
>> in our kernelCI boxes[1], and is preventing us from testing other
>> features
>> in this box.  Can you consider submitting it to Linus for the next
>> -rc?
>> it will be much appreciated!
>
> I can do that, but perhaps this should then be tagged for stable as
> well?
>

Thanks Ulf.  Yes, it should go to stable releases as well.  I tested it
on 4.4 and 4.9 already.

-- 
Gabriel Krisman Bertazi
