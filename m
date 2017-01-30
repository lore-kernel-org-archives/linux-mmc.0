From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Mon, 30 Jan 2017 09:19:07 +0100
Message-ID: <CAPDyKFq2aUkk4qzcLNoityHbOYTHCq_OiO9HVLuWjcGSJX0aWw@mail.gmail.com>
References: <20170116142342.21283-1-krisman@collabora.co.uk>
 <CAPDyKFpowPmbwvHL9NL60zAABfW53sDKkp0Ag5aXs4jZZLC=Dg@mail.gmail.com> <87wpdg9uob.fsf@dilma.collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35514 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbdA3ITJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 03:19:09 -0500
Received: by mail-wm0-f42.google.com with SMTP id b65so21302183wmf.0
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2017 00:19:08 -0800 (PST)
In-Reply-To: <87wpdg9uob.fsf@dilma.collabora.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

On 27 January 2017 at 20:20, Gabriel Krisman Bertazi
<krisman@collabora.co.uk> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> On 16 January 2017 at 15:23, Gabriel Krisman Bertazi
>> <krisman@collabora.co.uk> wrote:
>>> One of our kernelCI boxes hanged at boot because a faulty eSDHC device
>>> was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
>>> reads, which are not allowed for SD devices.  This adds a sanity check
>>> to the interruption path, preventing that illegal command from getting
>>> sent if the CARD_INT interruption should be disabled.
>>>
>>> This quirk allows that particular machine to resume boot despite the
>>> faulty hardware, instead of getting hung dealing with thousands of
>>> mishandled interrupts.
>>>
>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
>>> CC: Ulf Hansson <ulf.hansson@linaro.org>
>>> CC: linux-mmc@vger.kernel.org
>>
>> Thanks, applied for next with update commit msg header and by removing
>> the CCs from the changelog.
>
> Hi Ulf,
>
> Thanks for applying.  Although, I saw it got queued to the next merge
> window, but I we believe it to be -rc material, since it fixes a hang
> in our kernelCI boxes[1], and is preventing us from testing other features
> in this box.  Can you consider submitting it to Linus for the next -rc?
> it will be much appreciated!

I can do that, but perhaps this should then be tagged for stable as well?

Or was this a regression in 4.10?

Kind regards
Uffe

>
> [1]  <https://kernelci.org/boot/id/5881c81859b5140b59f6c3ae/>
>
> Thanks.
>
> --
> Gabriel Krisman Bertazi
