From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 18 Apr 2012 11:50:51 +0530
Message-ID: <CANfBPZ9_+n7gTd1Ny1xGPpDX9DJ4=aXeX7K8eogGBWg7vG527w@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
 <CAKYAXd96A6yzaz-59y+79sgRaQuT3MpRBZKStJM4HQN3L-=h5A@mail.gmail.com>
 <4F8E1B98.1050803@samsung.com> <CAKYAXd9PNeEDZAC6JVfySRHH-yFhThOdCE92MiULWxw94-dZjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:34662 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101Ab2DRGVO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 02:21:14 -0400
Received: by bkcje9 with SMTP id je9so12027808bkc.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Apr 2012 23:21:11 -0700 (PDT)
In-Reply-To: <CAKYAXd9PNeEDZAC6JVfySRHH-yFhThOdCE92MiULWxw94-dZjw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Apr 18, 2012 at 10:15 AM, Namjae Jeon <linkinjeon@gmail.com> wr=
ote:
> 2012/4/18 Jaehoon Chung <jh80.chung@samsung.com>:
>> On 04/18/2012 09:20 AM, Namjae Jeon wrote:
>>
>>> 2012/4/17 Venkatraman S <svenkatr@ti.com>:
>>>> mmc_execute_hpi should send the HPI command only
>>>> once, only if the card is in PRG state.
>>>>
>>>> According to eMMC spec, the command's completion time is
>>>> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
>>>> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
>>>> defined to begin at the end of sending the command itself.
>>> Hi. Venkatraman.
>>> I can not find this words. " the command's completion time is not
>>> dependent on OUT_OF_INTERRUPT_TIME" .
>>> Would you inform me which page and which part you checked in specif=
ication ?
>>
>> Well, i know that timeout value is used the OUT_OF_INTERRUPT_TIME, w=
hen interrupted by HPI.
>> It's my misunderstanding?
> I agree, I also understand with you. But we should hear Venkatraman's
> opinion from next reply.
> see the spec.

That particular line was explicit, *emphasis* mine..
In Section 6.8.2 "OUT_OF_INTERRUPT_TIME defines the maximum time
between the *end* bit of CMD12/13, arg[0]=3D1 to the DAT0 release of th=
e
device."

Which essentially means the timer should start after the HPI command
has been exchanged, and should normally end when the DAT0 line is
released (in other words, move out of PRG state).
You can see the same definition in Section 7.4.33

The definition in 6.6.23, is partly confusing, for one it uses
OUT_OF_INTERRUPT_BUSY_TIME and not OUT_OF_INTERRUPT_TIME, and other,
it refers to the command being *interrupted by* HPI, not the HPI
command itself.

Let me know if this explains it a bit better.

Best regards,
Venkat.
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
--------------------------------------------------------
> HPI command is accepted as a legal command in prg-state. However, onl=
y
> some commands may be interrupted by HPI. If HPI is received during
> commands which are not interruptible, a response is sent but the HPI
> command has no effect and the original command is completed normally,
> possibly exceeding the OUT_OF_INTERRUPT_TIME timeout.
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
-------------------------------------------------------------
> we can know OUT_OF_INTERRUPT_TIME timeout can be exceeded when
> commands is not interrupted by HPI.
> Also I think that timeout should be operated by host driver as curren=
t code.
> But I have a question while checking spec.
> Currently, when sending HPI command, MMC_RSP_R1 is set to flags.
> When setting MMC_RSP_R1B, does host driver set timeout value from mmc=
 core =A0?
>
> when I check stop transmission in spec, R1B response should be set in
> write cases.
> So MMC_RSP_R1B should be set to flags in HPI stop transmission instea=
d
> of MMC_RSP_R1 ?
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
---------------------------------------------
> Abbreviation : STOP_ TRANSMISSION
> response : R1/ R1b4
> NOTE 4 R1 for read cases and R1b for write cases.
> ---------------------------------------------------------------------=
-----------------------------------------------------------------------=
----------------------------------------
> Thanks.
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> Thanks.
>>>>
>>>> Specify the default timeout for the actual sending of HPI
>>>> command, and then use OUT_OF_INTERRUPT_TIME to wait for
>>>> the transition out of PRG state.
>>>>
>>>> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>>>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>>>> CC: Namjae Jeon <linkinjeon@gmail.com>
>>>> CC: Jae hoon Chung <jh80.chung@gmail.com>
>>>> CC: Chris Ball <cjb@laptop.org>
>>>> ---
>>>> Changes since v1:
>>>> =A0 =A0 =A0 =A0Skip looping over send_status indefinitely
>>>> =A0 =A0 =A0 =A0Correct the interpretation of OUT_OF_INTERRUPT_TIME
>>>>
>>>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 45 +++++++++++++++++++++++=
+--------------------
>>>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A02 +-
>>>> =A02 files changed, 26 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index e541efb..027c579 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -403,6 +403,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>>> =A0{
>>>> =A0 =A0 =A0 =A0int err;
>>>> =A0 =A0 =A0 =A0u32 status;
>>>> + =A0 =A0 =A0 unsigned long starttime;
>>>>
>>>> =A0 =A0 =A0 =A0BUG_ON(!card);
>>>>
>>>> @@ -421,27 +422,31 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>>> =A0 =A0 =A0 =A0/*
>>>> =A0 =A0 =A0 =A0 * If the card status is in PRG-state, we can send =
the HPI command.
>>>> =A0 =A0 =A0 =A0 */
>>>> - =A0 =A0 =A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know w=
hen the HPI command will finish
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so =
we need to resend HPI until out
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, a=
nd keep checking the card status
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STATU=
S. =A0If a timeout error occurs when
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HPI=
 command, we are already out of
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_hpi=
_cmd(card, &status);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_d=
ebug("%s: abort HPI (%d error)\n",
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0mmc_hostname(card->host), err);
>>>> + =A0 =A0 =A0 if (R1_CURRENT_STATE(status) !=3D R1_STATE_PRG) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't send HPI: Card s=
tate=3D%d\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->h=
ost), R1_CURRENT_STATE(status));
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 starttime =3D jiffies;
>>>> + =A0 =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
>>>> + =A0 =A0 =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s:HPI could not be sent.e=
rr=3D%d)\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->h=
ost), err);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> +
>>>> + =A0 =A0 =A0 do {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &statu=
s);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status)=
 =3D=3D R1_STATE_TRAN)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - start=
time) >
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.out_of=
_int_time)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ETIMEDOUT;
>>>> + =A0 =A0 =A0 } while (!err);
>>>>
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_sta=
tus(card, &status);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brea=
k;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=
=3D R1_STATE_PRG);
>>>> - =A0 =A0 =A0 } else
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Left prg-state\n", mmc=
_hostname(card->host));
>>>>
>>>> =A0out:
>>>> =A0 =A0 =A0 =A0mmc_release_host(card->host);
>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops=
=2Ec
>>>> index 69370f4..f2235d6 100644
>>>> --- a/drivers/mmc/core/mmc_ops.c
>>>> +++ b/drivers/mmc/core/mmc_ops.c
>>>> @@ -569,7 +569,7 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u3=
2 *status)
>>>>
>>>> =A0 =A0 =A0 =A0cmd.opcode =3D opcode;
>>>> =A0 =A0 =A0 =A0cmd.arg =3D card->rca << 16 | 1;
>>>> - =A0 =A0 =A0 cmd.cmd_timeout_ms =3D card->ext_csd.out_of_int_time=
;
>>>> + =A0 =A0 =A0 cmd.cmd_timeout_ms =3D 0;
>>>>
>>>> =A0 =A0 =A0 =A0err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>>>> =A0 =A0 =A0 =A0if (err) {
>>>> --
>>>> 1.7.10.rc2
>>>>
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
