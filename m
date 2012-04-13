From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 4/4] mmc: core: Send HPI only till it is successful
Date: Fri, 13 Apr 2012 21:28:26 +0530
Message-ID: <CANfBPZ-b=0ykM5XapE9KVMHkojoD1v==ZV5eqnQqothTGb5j7g@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
 <1334319854-5989-5-git-send-email-svenkatr@ti.com> <CAKYAXd_R5RfyP_-hW6LRbdEaVHbJOS+RdQC6-t3tqCcBUS4HGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:58990 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754129Ab2DMP6t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Apr 2012 11:58:49 -0400
Received: by bkcjg15 with SMTP id jg15so3675124bkc.34
        for <linux-mmc@vger.kernel.org>; Fri, 13 Apr 2012 08:58:46 -0700 (PDT)
In-Reply-To: <CAKYAXd_R5RfyP_-hW6LRbdEaVHbJOS+RdQC6-t3tqCcBUS4HGw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Fri, Apr 13, 2012 at 8:09 PM, Namjae Jeon <linkinjeon@gmail.com> wro=
te:
> Hi. Venkatraman.
>
> You fixed 10 times. why is it 10 times ?
There's no right number - I haven't seen it fail much in my tests but
should allow a few retries.

> and checking err from mmc_send_status is not needed ? is it =A0also
> infinite case ?
Check again - the loop will break if the send_status returns an error
(even once), or if the card comes out of PRG state.

>
> Thanks.
>
> 2012/4/13 Venkatraman S <svenkatr@ti.com>:
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
>> =A0*/
>> =A0int mmc_interrupt_hpi(struct mmc_card *card)
>> =A0{
>> - =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 int err, i;
>> =A0 =A0 =A0 =A0u32 status;
>>
>> =A0 =A0 =A0 =A0BUG_ON(!card);
>> @@ -421,27 +421,29 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * If the card status is in PRG-state, we can send th=
e HPI command.
>> =A0 =A0 =A0 =A0 */
>> + =A0 =A0 =A0 err =3D -EINVAL;
>> =A0 =A0 =A0 =A0if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know whe=
n the HPI command will finish
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so we=
 need to resend HPI until out
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, and=
 keep checking the card status
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STATUS.=
 =A0If a timeout error occurs when
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HPI c=
ommand, we are already out of
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* To prevent an infinite lockout, try=
 to send HPI
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a fixed number of times and bailo=
ut if it can't
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* succeed.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 10 && err !=3D 0 ; i=
++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_hpi_=
cmd(card, &status);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Once HPI was sent successfully, the=
 card is
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* supposed to be back to transfer s=
tate.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_de=
bug("%s: abort HPI (%d error)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 mmc_hostname(card->host), err);
>> -
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_statu=
s(card, &status);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_statu=
s(card, &status);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while (R1_CURRENT_STATE(status) =3D=
=3D R1_STATE_PRG);
>> - =A0 =A0 =A0 } else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Left prg-state\n", mmc_h=
ostname(card->host));
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't send HPI. State=3D=
%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->hos=
t), R1_CURRENT_STATE(status));
>> + =A0 =A0 =A0 }
>>
>> =A0out:
>> =A0 =A0 =A0 =A0mmc_release_host(card->host);
>> --
>> 1.7.10.rc2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
