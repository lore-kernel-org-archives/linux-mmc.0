From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 9 May 2012 19:23:20 +0530
Message-ID: <CANfBPZ_+K0y8zKJcyqzThrc=w+ea54C0m9voqHoaoCUfpA8QAA@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com> <edaffb8a034e4ed87b2f7c63d759c1d2.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:40575 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754262Ab2EINxx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 09:53:53 -0400
Received: by bkcji2 with SMTP id ji2so385765bkc.33
        for <linux-mmc@vger.kernel.org>; Wed, 09 May 2012 06:53:40 -0700 (PDT)
In-Reply-To: <edaffb8a034e4ed87b2f7c63d759c1d2.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kdorfman@codeaurora.org
Cc: linux-mmc@vger.kernel.org, Namjae Jeon <linkinjeon@gmail.com>, Jae hoon Chung <jh80.chung@gmail.com>, Chris Ball <cjb@laptop.org>

On Wed, May 9, 2012 at 6:47 PM,  <kdorfman@codeaurora.org> wrote:
>> mmc_execute_hpi should send the HPI command only
>> once, only if the card is in PRG state.
>>
>> According to eMMC spec, the command's completion time is
>> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
>> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
>> defined to begin at the end of sending the command itself.
>>
>> Specify the default timeout for the actual sending of HPI
>> command, and then use OUT_OF_INTERRUPT_TIME to wait for
>> the transition out of PRG state.
>>
>> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> CC: Namjae Jeon <linkinjeon@gmail.com>
>> CC: Jae hoon Chung <jh80.chung@gmail.com>
>> CC: Chris Ball <cjb@laptop.org>
>> ---
>> Changes since v1:
>> =A0 =A0 =A0 Skip looping over send_status indefinitely
>> =A0 =A0 =A0 Correct the interpretation of OUT_OF_INTERRUPT_TIME
>>
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 45
>> ++++++++++++++++++++++++--------------------
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A02 +-
>> =A02 files changed, 26 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e541efb..027c579 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -403,6 +403,7 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>> =A0{
>> =A0 =A0 =A0 int err;
>> =A0 =A0 =A0 u32 status;
>> + =A0 =A0 unsigned long starttime;
>>
>> =A0 =A0 =A0 BUG_ON(!card);
>>
>> @@ -421,27 +422,31 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* If the card status is in PRG-state, we can send the=
 HPI command.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know when th=
e HPI command will finish
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so we nee=
d to resend HPI until out
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, and kee=
p checking the card status
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STATUS. =A0=
If a timeout error occurs when
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HPI comma=
nd, we are already out of
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_hpi_cmd(c=
ard, &status);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("=
%s: abort HPI (%d error)\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0mmc_hostname(card->host), err);
>> + =A0 =A0 if (R1_CURRENT_STATE(status) !=3D R1_STATE_PRG) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't send HPI: Card state=3D=
%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host), =
R1_CURRENT_STATE(status));
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
> You can't return error here, because the card status may be:
> 0 =3D Idle 1 =3D Ready 2 =3D Ident 3 =3D Stby 4 =3D Tran 5 =3D Data 6=
 =3D Rcv 7 =3D Prg 8
> =3D Dis 9 =3D Btst 10
> Not every value is error here: the card state may be Idle/Ready and t=
hen
> you do not need to return error.
>
Depends. When the intent is to send HPI command, and the current state
is such that it can't be sent,
then a error has to be returned, right ?
OTOH, if the API was "mmc_get_to_transfer_state()", then it would make
sense to not return an error.


>> +
>> + =A0 =A0 starttime =3D jiffies;
>> + =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s:HPI could not be sent.err=3D%=
d)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host), =
err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &status);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status) =3D=3D=
 R1_STATE_TRAN)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - starttime) =
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.out_of_int_t=
ime)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ETIMEDOUT;
>> + =A0 =A0 } while (!err);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(ca=
rd, &status);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=3D R=
1_STATE_PRG);
>> - =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Left prg-state\n", mmc_hostn=
ame(card->host));
>>
>> =A0out:
>> =A0 =A0 =A0 mmc_release_host(card->host);
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 69370f4..f2235d6 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -569,7 +569,7 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32
>> *status)
>>
>> =A0 =A0 =A0 cmd.opcode =3D opcode;
>> =A0 =A0 =A0 cmd.arg =3D card->rca << 16 | 1;
>> - =A0 =A0 cmd.cmd_timeout_ms =3D card->ext_csd.out_of_int_time;
>> + =A0 =A0 cmd.cmd_timeout_ms =3D 0;
>>
>> =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>> =A0 =A0 =A0 if (err) {
>> --
>> 1.7.10.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> Thanks,
> Kostya
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
>
>
>
>
