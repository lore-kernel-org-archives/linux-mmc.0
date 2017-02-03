From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: Checking BKOPS status prior to Suspend
Date: Fri, 3 Feb 2017 12:46:44 +0100
Message-ID: <CAPDyKFqD00jmG=HesANpGv_=FP_cKodFkv2SdkX5DihLTbP_tA@mail.gmail.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
 <1485076535-20572-3-git-send-email-uri.yanai@sandisk.com> <CAPDyKFqiiWxUaYYkmPX_Zcym2fJ_muYM2WF2erd5LLd_OCY=5A@mail.gmail.com>
 <dc423c8d-ae55-2437-9f6e-b099a68c9d59@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36805 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdBCLqr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 06:46:47 -0500
Received: by mail-wm0-f53.google.com with SMTP id c85so24763389wmi.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 03:46:46 -0800 (PST)
In-Reply-To: <dc423c8d-ae55-2437-9f6e-b099a68c9d59@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Uri Yanai <uri.yanai@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>

On 3 February 2017 at 10:33, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> Hi,
>
> On 2/2/2017 6:19 PM, Ulf Hansson wrote:
>>
>> + Adrian, Shawn-Lin, Jaehoon, Ritesh
>>
>> On 22 January 2017 at 10:15, Uri Yanai <uri.yanai@sandisk.com> wrote:
>>>
>>> In case of Runtime Suspend, check the device BKOPS level.
>>> Return =E2=80=93EBUSY if device need more time to complete its internal=
 BKOPS.
>
> Do we need to abort the runtime suspend at all even though we are using
> CMD5?
>
> From what I understood from the spec is as follows - (please correct me i=
f I
> am wrong) -
> CMD7 -> CMD5 -> Busy line de-asserted by device(means autobkops execution=
 is
> complete) -> Enter sleep mode.
>
> Is the above understanding correct? In that case we may not need to abort
> the runtime suspend right?
> Since CMD5 completion should ensure that background operation execution i=
s
> complete (until then the busy line will be kept asserted).
>
> Opinion?

Unfortunate the eMMC spec isn't crystal clear on this point. Anyway,
my interpretation of it is not as yours. Let me elaborate on my view.

In case we have enabled POWERED_ON bit (0x1) in POWER_OFF_NOTIFICATION
register byte, during the card initialization, and we later want to
put the device into sleep state by using CMD5. Then we need to follow
the below sequence:
1) Using CMD6, write SLEEP_NOTIFICATION bits (0x4) to
POWER_OFF_NOTIFICATION register byte.
2) Wait for busy! Maximum time specified in
SLEEP_NOTIFICATION_TIME[216] (worst case 83.88s).
3) Put the card to sleep by send CMD5 and wait for busy (current
implemented method of issuing sleep).

As we have enabled POWERED_ON for those cards that supports
POWER_OFF_NOTIFICATION (added in eMMC 4.5 spec), then we also need to
follow the above sequence for when sending sleep (CMD5).

This may become a severe problem, because the SLEEP_NOTIFICATION_TIME
may be ridiculously long and since it immediately affects the total
system suspend time for the platform.

We need to think of something clever here to avoid a long sleep
notification timeout from happen.

[...]

>>
>> Hmm.
>>
>> Shouldn't we abort (return -EBUSY) also in the system PM suspend case
>> and not only for runtime PM suspend?
>
>
> My opinion - Auto bkops generally is meant for device to autonomously
> initiate the background transfer whenever the device is idle -> in such
> cases, we expect the device to keep it's autobkops exception level under
> control.
> In that case will it be good idea to abort the suspend as well?

I follow your reasoning and it seems reasonable. However, see my comment be=
low.

>
> Off-course unless we would like to cover a case where device is not idle =
at
> all and during this heavy device usage suspend is getting triggered manua=
lly
> - which gives no time for device to do auto-bkops
> Please correct me if my understanding is wrong?

This is the case that I thought off. Don't you think this could be a
valid scenario for an Android device?

[...]

It seems like we are discussing several related things at the same
time. Perhaps this is the only way, as they are so closely related.

Kind regards
Uffe
