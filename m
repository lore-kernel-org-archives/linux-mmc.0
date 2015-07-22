From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v3] mmc: sleep notification
Date: Wed, 22 Jul 2015 16:40:54 +0200
Message-ID: <CAPDyKFqV4pQYUUtZYJjFP72KNeAQJMV9qMV1uN2sKCT0At3s4g@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE64FAAD701@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFoPqwDC_w1QTe7zQtJfH_5m2Gp_5uewJKy=x_LeaFqYhA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53343C1F6EA@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFoZuNoYB1KA4bt64+qoeEmjioW9qCnwkhYAnnSD4jMxag@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53343C409C9@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36528 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934306AbbGVOkz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jul 2015 10:40:55 -0400
Received: by qkdv3 with SMTP id v3so154400818qkd.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2015 07:40:55 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED53343C409C9@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 18 June 2015 at 16:57, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
> Hi Ulf,
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Monday, June 15, 2015 11:24 AM
>> To: Alex Lemberg
>> Cc: Avi Shchislowski; linux-mmc
>> Subject: Re: [RFC PATCH v3] mmc: sleep notification
>>
>> On 8 June 2015 at 15:17, Alex Lemberg <Alex.Lemberg@sandisk.com>
>> wrote:
>> > Hi Ulf,
>> >
>> > [...]
>> >
>> >>
>> >> One of my comments for v2, was that I think you should remove all
>> >> code which was related to HPI to interrupt sleep notification from
>> >> the runtime PM resume path. Instead I wanted you to add that
>> >> functionality as separate patch based on top of this patch.
>> >>
>> >> You haven't done that in v3, why?
>> >
>> > The sleep_notify call was moved to suspend() per your recommendation.
>> > As far as I understand, no new requests should be sent during
>> > mmc_suspend() process, thus HPI support is not needed anymore.
>> > Is this the correct assumption?
>>
>> Yes.
>>
>> I don't think you need mmc_card_set_sleep_notify() and the corresponding
>> new MMC_STATE_SLEEP_NOTIFY , mmc_device_prg_state(), etc.
>
> mmc_card_set_sleep_notify(), MMC_STATE_SLEEP_NOTIFY and the corresponding - We are removing it from the current patch. Probably will add them as a separate patch in future.

Great!

> mmc_device_prg_state() - is required for waiting for Sleep_Notification completion/timeout, although we would like to leave this function.

Doesn't __mmc_switch() already deal with this? No, I don't think it's needed.

>
>>
>> Overall, I think this patch could be simplified yet another step.
>>
>> > The only case where HPI is used in this patch - is during sleep_notify
>> timeout error.
>>
>> Why?
>
> In case of timeout error, we would like to handle it by sending HPI - to let device interrupt/stop the prg state.

Is that according to the spec? I think it would be better to try a
reset sequence to recover, by using CMD0 and so forth, what do you
think?

>
>>
>> One final question, I noticed that you have removed the check for
>> MMC_CAP2_FULL_PWR_CYCLE in the _mmc_suspend() function, why?
>
> As far as we understand, this MMC_CAP2_FULL_PWR_CYCLE was used to distinguish between PON (when the power can be cut)
> and Sleep (when the power have to stay ON).
> Now we have Sleep_Notification PON, which allows to cut the power also in case of Sleep.
> Hope the interpretation above is correct.

Unfortunate your interpretation is wrong.

MMC_CAP2_FULL_PWR_CYCLE, indicates whether the mmc host can cut *both*
VCC and VCCQ.

For the suspend case, the default behaviour is to send CMD5 (sleep),
as we don't trust hosts to set MMC_CAP2_FULL_PWR_CYCLE even if it
potentially could.
Keeping this policy is important, as we don't want to issue PON unless
we know that we will be cutting both VCC and VCCQ.

Kind regards
Uffe
