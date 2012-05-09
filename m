From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 9 May 2012 19:42:27 +0530
Message-ID: <CANfBPZ-PDNuNhG0HubLdtaoYa4HPkjPyYcHJ0re-80kDmYLZqQ@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
 <edaffb8a034e4ed87b2f7c63d759c1d2.squirrel@www.codeaurora.org>
 <CANfBPZ_+K0y8zKJcyqzThrc=w+ea54C0m9voqHoaoCUfpA8QAA@mail.gmail.com> <143f1a4dd9fcd3b243bfc484242481b6.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:35027 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756903Ab2EIOMu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 10:12:50 -0400
Received: by eaan1 with SMTP id n1so150966eaa.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 May 2012 07:12:47 -0700 (PDT)
In-Reply-To: <143f1a4dd9fcd3b243bfc484242481b6.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kdorfman@codeaurora.org
Cc: linux-mmc@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>, Jae hoon Chung <jh80.chung@gmail.com>, Chris Ball <cjb@laptop.org>

On Wed, May 9, 2012 at 7:36 PM,  <kdorfman@codeaurora.org> wrote:
>> On Wed, May 9, 2012 at 6:47 PM, =A0<kdorfman@codeaurora.org> wrote:
>
>>>> @@ -403,6 +403,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>>> =A0{
>>>> =A0 =A0 =A0 int err;
>>>> =A0 =A0 =A0 u32 status;
>>>> + =A0 =A0 unsigned long starttime;
>>>>
>>>> =A0 =A0 =A0 BUG_ON(!card);
>>>>
>>>> @@ -421,27 +422,31 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>>> =A0 =A0 =A0 /*
>>>> =A0 =A0 =A0 =A0* If the card status is in PRG-state, we can send t=
he HPI
>>>> command.
>>>> =A0 =A0 =A0 =A0*/
>>>> - =A0 =A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 do {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know when =
the HPI command will finish
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so we n=
eed to resend HPI until out
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, and k=
eep checking the card
>>>> status
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STATUS. =A0=
If a timeout error occurs
>>>> when
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HPI com=
mand, we are already out of
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_hpi_cmd=
(card, &status);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug=
("%s: abort HPI (%d error)\n",
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0mmc_hostname(card->host), err);
>>>> + =A0 =A0 if (R1_CURRENT_STATE(status) !=3D R1_STATE_PRG) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't send HPI: Card state=
=3D%d\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host)=
,
>>>> R1_CURRENT_STATE(status));
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 }
>>> You can't return error here, because the card status may be:
>>> 0 =3D Idle 1 =3D Ready 2 =3D Ident 3 =3D Stby 4 =3D Tran 5 =3D Data=
 6 =3D Rcv 7 =3D Prg
>>> 8
>>> =3D Dis 9 =3D Btst 10
>>> Not every value is error here: the card state may be Idle/Ready and=
 then
>>> you do not need to return error.
>>>
>> Depends. When the intent is to send HPI command, and the current sta=
te
>> is such that it can't be sent,
>> then a error has to be returned, right ?
>> OTOH, if the API was "mmc_get_to_transfer_state()", then it would ma=
ke
>> sense to not return an error.
>
> I'm working on HPI commmand that stops running BKOPS, when runtime su=
spend
> flow is triggered. Right now, the code is not correct and CMD5 (sleep=
)
> sent to the card without any check for running BKOPS.
> In this case card may be in any state. Do you think we need to wait/c=
heck
> state before calling mmc_interrupt_hpi() function?
>

It's a completely different issue that I had informed Saugata, who is
doing the rework on
power off notify and sleep command sequence.
Essentially, the card shouldn't be put to sleep once BKOPS_START has
been issued,
and we should need to interrupt with HPI only when a higher layer
request needs to be serviced.

I don't know whether you are interested in handling only urgent BKOPS
or periodic BKOPS,
but we can discuss the design on a separate thread.

>>
>>
>>>> +
>>>> + =A0 =A0 starttime =3D jiffies;
>>>> + =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
>>>> + =A0 =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s:HPI could not be sent.err=3D=
%d)\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host)=
, err);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 }
>>>> +
>>>> + =A0 =A0 do {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &status);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status) =3D=
=3D R1_STATE_TRAN)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - starttime=
) >
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.out_of_int=
_time)
> I think we need to add some margin time to the out_of_int_time here.
>
> Thanks,
> Kostya
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>
