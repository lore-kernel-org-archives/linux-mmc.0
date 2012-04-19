From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: core: Fix the HPI execution sequence
Date: Thu, 19 Apr 2012 09:52:47 +0530
Message-ID: <CANfBPZ8zJYwthk4yOTHyJzpwzt1-xru=fofNSHp5U-q_TBTPsg@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
 <1334760358-17568-1-git-send-email-svenkatr@ti.com> <4F8F6FE4.5010303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34956 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834Ab2DSEXL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Apr 2012 00:23:11 -0400
Received: by bkwj5 with SMTP id j5so13458003bkw.16
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 21:23:08 -0700 (PDT)
In-Reply-To: <4F8F6FE4.5010303@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linkinjeon@gmail.com

On Thu, Apr 19, 2012 at 7:22 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
Thanks Jaehoon Chung.
BTW, would you consider looking into the foreground HPI series ?

Chris,
  Can you please take this too for 3.5 ?


> On 04/18/2012 11:45 PM, Venkatraman S wrote:
>
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
>> ---
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 44 ++++++++++++++++++++++++-=
-------------------
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 -
>> =A02 files changed, 24 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e541efb..4e696e6 100644
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
>> @@ -421,27 +422,30 @@ int mmc_interrupt_hpi(struct mmc_card *card)
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (jiffies_to_msecs(jiffies - starttime) =
>=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.out_of_int_t=
ime)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ETIMEDOUT;
>> + =A0 =A0 } while (!err);
>>
>> =A0out:
>> =A0 =A0 =A0 mmc_release_host(card->host);
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 69370f4..0ed2cc5 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 =
*status)
>>
>> =A0 =A0 =A0 cmd.opcode =3D opcode;
>> =A0 =A0 =A0 cmd.arg =3D card->rca << 16 | 1;
>> - =A0 =A0 cmd.cmd_timeout_ms =3D card->ext_csd.out_of_int_time;
>>
>> =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>> =A0 =A0 =A0 if (err) {
>
>
