From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Thu, 19 Apr 2012 19:13:20 +0530
Message-ID: <CANfBPZ-PwhiDhTbD5Xc3c1K8pgG60zCx=_Gy7qWkaC0Bj35cQw@mail.gmail.com>
References: <1334760358-17568-1-git-send-email-svenkatr@ti.com>
 <1334810595-20316-1-git-send-email-svenkatr@ti.com> <87vckvkfp6.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:38720 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755285Ab2DSNno convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Apr 2012 09:43:44 -0400
Received: by bkcji17 with SMTP id ji17so9362213bkc.21
        for <linux-mmc@vger.kernel.org>; Thu, 19 Apr 2012 06:43:41 -0700 (PDT)
In-Reply-To: <87vckvkfp6.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Apr 19, 2012 at 7:05 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Apr 19 2012, Venkatraman S wrote:
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
>> =A0 =A0 =A0 v1->v2: Fix formatting inside debug prints
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 44 ++++++++++++++++++++++++-=
-------------------
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 -
>> =A02 files changed, 24 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e541efb..d57c8f3 100644
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s:HPI could not be sent. err=3D=
%d\n",
>
> You're still missing a space in "%s: HPI".
>
Err.. I thought you meant the space between "sent." and "err=3D".
Will fix.
