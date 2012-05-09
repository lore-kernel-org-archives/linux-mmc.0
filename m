From: kdorfman@codeaurora.org
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 9 May 2012 07:06:53 -0700 (PDT)
Message-ID: <143f1a4dd9fcd3b243bfc484242481b6.squirrel@www.codeaurora.org>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
    <edaffb8a034e4ed87b2f7c63d759c1d2.squirrel@www.codeaurora.org>
    <CANfBPZ_+K0y8zKJcyqzThrc=w+ea54C0m9voqHoaoCUfpA8QAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:35105 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309Ab2EIOGx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 10:06:53 -0400
In-Reply-To: <CANfBPZ_+K0y8zKJcyqzThrc=w+ea54C0m9voqHoaoCUfpA8QAA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: kdorfman@codeaurora.org, linux-mmc@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>, Jae hoon Chung <jh80.chung@gmail.com>, Chris Ball <cjb@laptop.org>

> On Wed, May 9, 2012 at 6:47 PM,  <kdorfman@codeaurora.org> wrote:

>>> @@ -403,6 +403,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>> =A0{
>>> =A0 =A0 =A0 int err;
>>> =A0 =A0 =A0 u32 status;
>>> + =A0 =A0 unsigned long starttime;
>>>
>>> =A0 =A0 =A0 BUG_ON(!card);
>>>
>>> @@ -421,27 +422,31 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>> =A0 =A0 =A0 /*
>>> =A0 =A0 =A0 =A0* If the card status is in PRG-state, we can send th=
e HPI
>>> command.
>>> =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 do {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know when t=
he HPI command will finish
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so we ne=
ed to resend HPI until out
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, and ke=
ep checking the card
>>> status
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STATUS. =A0=
If a timeout error occurs
>>> when
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HPI comm=
and, we are already out of
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_hpi_cmd(=
card, &status);
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug(=
"%s: abort HPI (%d error)\n",
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0mmc_hostname(card->host), err);
>>> + =A0 =A0 if (R1_CURRENT_STATE(status) !=3D R1_STATE_PRG) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't send HPI: Card state=3D=
%d\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host),
>>> R1_CURRENT_STATE(status));
>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 }
>> You can't return error here, because the card status may be:
>> 0 =3D Idle 1 =3D Ready 2 =3D Ident 3 =3D Stby 4 =3D Tran 5 =3D Data =
6 =3D Rcv 7 =3D Prg
>> 8
>> =3D Dis 9 =3D Btst 10
>> Not every value is error here: the card state may be Idle/Ready and =
then
>> you do not need to return error.
>>
> Depends. When the intent is to send HPI command, and the current stat=
e
> is such that it can't be sent,
> then a error has to be returned, right ?
> OTOH, if the API was "mmc_get_to_transfer_state()", then it would mak=
e
> sense to not return an error.

I'm working on HPI commmand that stops running BKOPS, when runtime susp=
end
flow is triggered. Right now, the code is not correct and CMD5 (sleep)
sent to the card without any check for running BKOPS.
In this case card may be in any state. Do you think we need to wait/che=
ck
state before calling mmc_interrupt_hpi() function?

>
>
>>> +
>>> + =A0 =A0 starttime =3D jiffies;
>>> + =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
>>> + =A0 =A0 if (err) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s:HPI could not be sent.err=3D=
%d)\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host),=
 err);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 }
>>> +
>>> + =A0 =A0 do {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &status);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status) =3D=3D=
 R1_STATE_TRAN)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - starttime)=
 >
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.out_of_int_=
time)
I think we need to add some margin time to the out_of_int_time here.

Thanks,
Kostya
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum


