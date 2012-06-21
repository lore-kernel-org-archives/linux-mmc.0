From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v3] mmc: core: Fix the HPI execution sequence
Date: Thu, 21 Jun 2012 12:54:48 +0530
Message-ID: <CANfBPZ89btqCBin8Wyg87w0cEz213oNiC=FJcoxtw1Hb+1n9pw@mail.gmail.com>
References: <1340184834-12700-1-git-send-email-svenkatr@ti.com> <002301cd4f0e$7b380de0$71a829a0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:36514 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753428Ab2FUHZM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jun 2012 03:25:12 -0400
Received: by bkcjm19 with SMTP id jm19so293715bkc.14
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jun 2012 00:25:09 -0700 (PDT)
In-Reply-To: <002301cd4f0e$7b380de0$71a829a0$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linkinjeon@gmail.com, jh80.chung@samsung.com, alex.lemberg@sandisk.com, Kostya <kdorfman@codeaurora.org>

On Wed, Jun 20, 2012 at 11:29 PM, Subhash Jadavani
<subhashj@codeaurora.org> wrote:
> Hi Venkatraman,
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Venkatraman S
>> Sent: Wednesday, June 20, 2012 3:04 PM
>> To: cjb@laptop.org
>> Cc: linux-mmc@vger.kernel.org; linkinjeon@gmail.com;
>> jh80.chung@samsung.com; alex.lemberg@sandisk.com; Venkatraman S; Kos=
tya
>> Subject: [PATCH v3] mmc: core: Fix the HPI execution sequence
>>
>> mmc_execute_hpi should send the HPI command only once, and only if t=
he
>> card is in PRG state.
>>
>> According to eMMC spec, the command's completion time is not depende=
nt on
>> OUT_OF_INTERRUPT_TIME. Only the transition out of PRG STATE is guard=
ed by
>> OUT_OF_INTERRUPT_TIME - which is defined to begin at the end of send=
ing
>> the command itself.
>>
>> Specify the default timeout for the actual sending of HPI command, a=
nd
> then
>> use OUT_OF_INTERRUPT_TIME to wait for the transition out of PRG stat=
e.
>
> I guess this is not the correct interpretation. cmd.cmd_timeout_ms sh=
ould
> specify for how much time host driver should wait for command + busy =
line
> deassertion. So why are you keeping the timeout calculation after the
> command is completed?
>
If what you stay is correct, the card should be in PRG state after
mmc_send_hpi_cmd()
returns.

I understood and observed it as opposite. HPI cmd returns immediately,
and the device takes
OUT_OF_INTERRUPT_TIME time to come out of PRG state.

My experiments / tests confirm that behavior. It takes a few ms (and se=
veral
SEND_STATUS messages later), after HPI, for the card to be out of PRG s=
tate.

> mmc_send_hpi_cmd() returns means the host controller driver have ensu=
red
> that BUSY indication is removed so after mmc_send_hpi_cmd(), if you w=
ant to
> check if the card is still in PROGRAMMING state, it should be uncondi=
tional
> check in loop (rather than timeout based) until card is out of progra=
mming
> state.
>
> To me, mmc_send_hpi_cmd() implementation should not be anything diffe=
rent
> than mmc_switch(). In mmc_switch() also, after mmc_wait_for_cmd() ret=
urns it
> continuously keeps checking if card is programming or not.
>
> Regards,
> Subhash
>
>>
>> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>> CC: Kostya <kdorfman@codeaurora.org>
>> ---
>> v2 discussions: http://marc.info/?l=3Dlinux-mmc&m=3D133657255616390&=
w=3D2
>>
>> v2->v3:
>> =A0 =A0 =A0 Return gracefully for card idle states (suggested by kdo=
rfman)
>>
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 57
> ++++++++++++++++++++++++++-----------------
>> -
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 -
>> =A02 files changed, 34 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> 80ec427..08ed144 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -404,6 +404,7 @@ int mmc_interrupt_hpi(struct mmc_card *card) =A0=
{
>> =A0 =A0 =A0 int err;
>> =A0 =A0 =A0 u32 status;
>> + =A0 =A0 unsigned long starttime;
>>
>> =A0 =A0 =A0 BUG_ON(!card);
>>
>> @@ -419,30 +420,40 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* If the card status is in PRG-state, we can send the H=
PI command.
>> - =A0 =A0 =A0*/
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
>> + =A0 =A0 switch (R1_CURRENT_STATE(status)) {
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
>> + =A0 =A0 case R1_STATE_IDLE:
>> + =A0 =A0 case R1_STATE_READY:
>> + =A0 =A0 case R1_STATE_STBY: /* intentional fall through */
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* In idle states, HPI is not needed and t=
he caller
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0can issue the next intended command imm=
ediately */
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case R1_STATE_PRG:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* In all other states, it's illegal to is=
sue HPI */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: HPI cannot be sent. Card sta=
te=3D%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host),
>> R1_CURRENT_STATE(status));
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 starttime =3D jiffies;
>> + =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
>> + =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
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
>> @@ -569,7 +569,6 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32
>> *status)
>>
>> =A0 =A0 =A0 cmd.opcode =3D opcode;
>> =A0 =A0 =A0 cmd.arg =3D card->rca << 16 | 1;
>> - =A0 =A0 cmd.cmd_timeout_ms =3D card->ext_csd.out_of_int_time;
>>
>> =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>> =A0 =A0 =A0 if (err) {
>> --
>> 1.7.10.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
> the body
>> of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
