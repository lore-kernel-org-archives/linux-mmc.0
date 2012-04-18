From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 18 Apr 2012 17:23:53 +0900
Message-ID: <CAKYAXd_osDoHtCLq0k2JmrwmOzZhLqnAu7QkzYkyLGn4Px_inw@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
	<CAKYAXd96A6yzaz-59y+79sgRaQuT3MpRBZKStJM4HQN3L-=h5A@mail.gmail.com>
	<4F8E1B98.1050803@samsung.com>
	<CAKYAXd9PNeEDZAC6JVfySRHH-yFhThOdCE92MiULWxw94-dZjw@mail.gmail.com>
	<CANfBPZ9_+n7gTd1Ny1xGPpDX9DJ4=aXeX7K8eogGBWg7vG527w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38208 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab2DRIXy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 04:23:54 -0400
Received: by wgbdr13 with SMTP id dr13so7259743wgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 01:23:53 -0700 (PDT)
In-Reply-To: <CANfBPZ9_+n7gTd1Ny1xGPpDX9DJ4=aXeX7K8eogGBWg7vG527w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

2012/4/18 S, Venkatraman <svenkatr@ti.com>:
> On Wed, Apr 18, 2012 at 10:15 AM, Namjae Jeon <linkinjeon@gmail.com> =
wrote:
>> 2012/4/18 Jaehoon Chung <jh80.chung@samsung.com>:
>>> On 04/18/2012 09:20 AM, Namjae Jeon wrote:
>>>
>>>> 2012/4/17 Venkatraman S <svenkatr@ti.com>:
>>>>> mmc_execute_hpi should send the HPI command only
>>>>> once, only if the card is in PRG state.
>>>>>
>>>>> According to eMMC spec, the command's completion time is
>>>>> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
>>>>> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
>>>>> defined to begin at the end of sending the command itself.
>>>> Hi. Venkatraman.
>>>> I can not find this words. " the command's completion time is not
>>>> dependent on OUT_OF_INTERRUPT_TIME" .
>>>> Would you inform me which page and which part you checked in speci=
fication ?
>>>
>>> Well, i know that timeout value is used the OUT_OF_INTERRUPT_TIME, =
when interrupted by HPI.
>>> It's my misunderstanding?
>> I agree, I also understand with you. But we should hear Venkatraman'=
s
>> opinion from next reply.
>> see the spec.
>
> That particular line was explicit, *emphasis* mine..
> In Section 6.8.2 "OUT_OF_INTERRUPT_TIME defines the maximum time
> between the *end* bit of CMD12/13, arg[0]=3D1 to the DAT0 release of =
the
> device."
>
> Which essentially means the timer should start after the HPI command
> has been exchanged, and should normally end when the DAT0 line is
> released (in other words, move out of PRG state).
> You can see the same definition in Section 7.4.33
>
> The definition in 6.6.23, is partly confusing, for one it uses
> OUT_OF_INTERRUPT_BUSY_TIME and not OUT_OF_INTERRUPT_TIME, and other,
> it refers to the command being *interrupted by* HPI, not the HPI
> command itself.
>
> Let me know if this explains it a bit better.
>
> Best regards,
> Venkat.
Hi. Venkat.
You're right. OUT_OF_INTERRUPT_TIME is range between Busy line(Data0)
released by device and end bit of CMD 12,13.
and I would like you change some code in this patch.
I think that break is better than goto. because it is not duplicated lo=
op.
+               if (!err && R1_CURRENT_STATE(status) =3D=3D R1_STATE_TR=
AN)
+                       goto out;

you don't need to initialize cmd_timeout_ms value. because you can see
struct mmc_command cmd =3D {0}; code.
+       cmd.cmd_timeout_ms =3D 0;

Thanks.

>> --------------------------------------------------------------------=
-----------------------------------------------------------------------=
---------------------------------------------------------
>> HPI command is accepted as a legal command in prg-state. However, on=
ly
>> some commands may be interrupted by HPI. If HPI is received during
>> commands which are not interruptible, a response is sent but the HPI
>> command has no effect and the original command is completed normally=
,
>> possibly exceeding the OUT_OF_INTERRUPT_TIME timeout.
>> --------------------------------------------------------------------=
-----------------------------------------------------------------------=
--------------------------------------------------------------
>> we can know OUT_OF_INTERRUPT_TIME timeout can be exceeded when
>> commands is not interrupted by HPI.
>> Also I think that timeout should be operated by host driver as curre=
nt code.
>> But I have a question while checking spec.
>> Currently, when sending HPI command, MMC_RSP_R1 is set to flags.
>> When setting MMC_RSP_R1B, does host driver set timeout value from mm=
c core =C2=A0?
>>
>> when I check stop transmission in spec, R1B response should be set i=
n
>> write cases.
>> So MMC_RSP_R1B should be set to flags in HPI stop transmission inste=
ad
>> of MMC_RSP_R1 ?
>> --------------------------------------------------------------------=
-----------------------------------------------------------------------=
----------------------------------------------
>> Abbreviation : STOP_ TRANSMISSION
>> response : R1/ R1b4
>> NOTE 4 R1 for read cases and R1b for write cases.
>> --------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------------------------------------
>> Thanks.
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>
>>>>
>>>> Thanks.
>>>>>
>>>>> Specify the default timeout for the actual sending of HPI
>>>>> command, and then use OUT_OF_INTERRUPT_TIME to wait for
>>>>> the transition out of PRG state.
>>>>>
>>>>> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>>>>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>>>>> CC: Namjae Jeon <linkinjeon@gmail.com>
>>>>> CC: Jae hoon Chung <jh80.chung@gmail.com>
>>>>> CC: Chris Ball <cjb@laptop.org>
>>>>> ---
>>>>> Changes since v1:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Skip looping over send_status indefini=
tely
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Correct the interpretation of OUT_OF_I=
NTERRUPT_TIME
>>>>>
>>>>> =C2=A0drivers/mmc/core/core.c =C2=A0 =C2=A0| =C2=A0 45 ++++++++++=
++++++++++++++--------------------
>>>>> =C2=A0drivers/mmc/core/mmc_ops.c | =C2=A0 =C2=A02 +-
>>>>> =C2=A02 files changed, 26 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index e541efb..027c579 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -403,6 +403,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>>>> =C2=A0{
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int err;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 status;
>>>>> + =C2=A0 =C2=A0 =C2=A0 unsigned long starttime;
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(!card);
>>>>>
>>>>> @@ -421,27 +422,31 @@ int mmc_interrupt_hpi(struct mmc_card *card=
)
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If the card status is in PRG-state,=
 we can send the HPI command.
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>>>> - =C2=A0 =C2=A0 =C2=A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STA=
TE_PRG) {
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /*
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* We don't know when the HPI command will finish
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* processing, so we need to resend HPI until out
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* of prg-state, and keep checking the card status
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* with SEND_STATUS. =C2=A0If a timeout error occurs=
 when
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* sending the HPI command, we are already out of
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* prg-state.
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0*/
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D mmc_send_hpi_cmd(card, &status);
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (err)
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: abort HPI (%d e=
rror)\n",
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mmc_hostname(card->host), err);
>>>>> + =C2=A0 =C2=A0 =C2=A0 if (R1_CURRENT_STATE(status) !=3D R1_STATE=
_PRG) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: =
Can't send HPI: Card state=3D%d\n",
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 mmc_hostname(card->host), R1_CURRENT_STATE(status));
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVA=
L;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>>>>> + =C2=A0 =C2=A0 =C2=A0 }
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 starttime =3D jiffies;
>>>>> + =C2=A0 =C2=A0 =C2=A0 err =3D mmc_send_hpi_cmd(card, &status);
>>>>> + =C2=A0 =C2=A0 =C2=A0 if (err) {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("%s:H=
PI could not be sent.err=3D%d)\n",
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 mmc_hostname(card->host), err);
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;
>>>>> + =C2=A0 =C2=A0 =C2=A0 }
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 do {
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D mmc_se=
nd_status(card, &status);
>>>>> +
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!err && R1=
_CURRENT_STATE(status) =3D=3D R1_STATE_TRAN)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 goto out;
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (jiffies_to=
_msecs(jiffies - starttime) >
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 card->ext_csd.out_of_int_time)
>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D -ETIMEDOUT;
>>>>> + =C2=A0 =C2=A0 =C2=A0 } while (!err);
>>>>>
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 err =3D mmc_send_status(card, &status);
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (err)
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (R1_CU=
RRENT_STATE(status) =3D=3D R1_STATE_PRG);
>>>>> - =C2=A0 =C2=A0 =C2=A0 } else
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: =
Left prg-state\n", mmc_hostname(card->host));
>>>>>
>>>>> =C2=A0out:
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_release_host(card->host);
>>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_op=
s.c
>>>>> index 69370f4..f2235d6 100644
>>>>> --- a/drivers/mmc/core/mmc_ops.c
>>>>> +++ b/drivers/mmc/core/mmc_ops.c
>>>>> @@ -569,7 +569,7 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u=
32 *status)
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.opcode =3D opcode;
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd.arg =3D card->rca << 16 | 1;
>>>>> - =C2=A0 =C2=A0 =C2=A0 cmd.cmd_timeout_ms =3D card->ext_csd.out_o=
f_int_time;
>>>>> + =C2=A0 =C2=A0 =C2=A0 cmd.cmd_timeout_ms =3D 0;
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D mmc_wait_for_cmd(card->host, &=
cmd, 0);
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (err) {
>>>>> --
>>>>> 1.7.10.rc2
>>>>>
>>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
