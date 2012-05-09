From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 4/4] mmc: core: Send HPI only till it is successful
Date: Wed, 9 May 2012 19:13:25 +0530
Message-ID: <CANfBPZ_v5aVfTiRvRqhqP83sUsFHesoJeOkRfi7qBBUDT7rSDQ@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
 <1334319854-5989-5-git-send-email-svenkatr@ti.com> <5d18897df577fa24297975f3421088c8.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:47918 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752350Ab2EINns convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 May 2012 09:43:48 -0400
Received: by bkcjm2 with SMTP id jm2so357870bkc.34
        for <linux-mmc@vger.kernel.org>; Wed, 09 May 2012 06:43:45 -0700 (PDT)
In-Reply-To: <5d18897df577fa24297975f3421088c8.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kdorfman@codeaurora.org
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Wed, May 9, 2012 at 6:52 PM,  <kdorfman@codeaurora.org> wrote:
> Hi,
> I see 2 fixes for existing mmc_interrupt_hpi() function:
> - =A0[PATCH 4/4] mmc: core: Send HPI only till it is successful"
> - =A0[PATCH v2] mmc: core: Fix the HPI execution sequence
>
> They are exclusive. Can you explain how final solution will look like=
?
This one is old. After some review, I did fix the subject to reflect
the changes.
IOW, the latest one is the "mmc: core: Fix the HPI execution sequence" =
patch.

Regards,
Venkat.

> Thanks,
> Kostya
>
>> Try to send HPI only a fixed number of times till it is
>> successful. One successful transfer is enough - but wait
>> till the card comes out of transfer state.
>> Return an error if the card was not in programming state to
>> begin with - so that the caller knows that HPI was not sent.
>>
>> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>> =A0drivers/mmc/core/core.c | =A0 34 ++++++++++++++++++--------------=
--
>> =A01 file changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e541efb..ceabef5 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -401,7 +401,7 @@ EXPORT_SYMBOL(mmc_wait_for_req);
>> =A0 */
>> =A0int mmc_interrupt_hpi(struct mmc_card *card)
>> =A0{
>> - =A0 =A0 int err;
>> + =A0 =A0 int err, i;
>> =A0 =A0 =A0 u32 status;
>>
>> =A0 =A0 =A0 BUG_ON(!card);
>> @@ -421,27 +421,29 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* If the card status is in PRG-state, we can send the=
 HPI command.
>> =A0 =A0 =A0 =A0*/
>> + =A0 =A0 err =3D -EINVAL;
>> =A0 =A0 =A0 if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* To prevent an infinite lockout, try to =
send HPI
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* a fixed number of times and bailout i=
f it can't
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* succeed.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 10 && err !=3D 0 ; i++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_hpi_cmd=
(card, &status);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Once HPI was sent successfully, the car=
d is
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* supposed to be back to transfer state=
=2E
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug=
("%s: abort HPI (%d error)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0mmc_hostname(card->host), err);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(ca=
rd, &status);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(ca=
rd, &status);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=3D=
 R1_STATE_PRG);
>> - =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Left prg-state\n", mmc_hostn=
ame(card->host));
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't send HPI. State=3D%d\n=
",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host), =
R1_CURRENT_STATE(status));
>> + =A0 =A0 }
>>
>> =A0out:
>> =A0 =A0 =A0 mmc_release_host(card->host);
>> --
>> 1.7.10.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
>
>
