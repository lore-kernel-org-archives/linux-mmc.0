From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 4/4] mmc: core: Send HPI only till it is successful
Date: Sat, 14 Apr 2012 09:35:12 +0900
Message-ID: <CAKYAXd8uFC98RLtEp+52PC+=KLeXKQXk_QTBJ_Y2yG_S+8NYtw@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
	<1334319854-5989-5-git-send-email-svenkatr@ti.com>
	<CAKYAXd_R5RfyP_-hW6LRbdEaVHbJOS+RdQC6-t3tqCcBUS4HGw@mail.gmail.com>
	<CANfBPZ-b=0ykM5XapE9KVMHkojoD1v==ZV5eqnQqothTGb5j7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34723 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab2DNAfN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Apr 2012 20:35:13 -0400
Received: by wejx9 with SMTP id x9so2249578wej.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Apr 2012 17:35:12 -0700 (PDT)
In-Reply-To: <CANfBPZ-b=0ykM5XapE9KVMHkojoD1v==ZV5eqnQqothTGb5j7g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

2012/4/14 S, Venkatraman <svenkatr@ti.com>:
> On Fri, Apr 13, 2012 at 8:09 PM, Namjae Jeon <linkinjeon@gmail.com> w=
rote:
>> Hi. Venkatraman.
>>
>> You fixed 10 times. why is it 10 times ?
> There's no right number - I haven't seen it fail much in my tests but
> should allow a few retries.
Is there the reason should send HPI a few retries ?
>
>> and checking err from mmc_send_status is not needed ? is it =C2=A0al=
so
>> infinite case ?
> Check again - the loop will break if the send_status returns an error
> (even once), or if the card comes out of PRG state.
okay, but this patch print "abort HPI" although card_status is fail.
if print abort HPI fail, Can we know which error occurred in either
send hpi cmd error and send status error ?
Thanks.
>
>>
>> Thanks.
>>
>> 2012/4/13 Venkatraman S <svenkatr@ti.com>:
>>> Try to send HPI only a fixed number of times till it is
>>> successful. One successful transfer is enough - but wait
>>> till the card comes out of transfer state.
>>> Return an error if the card was not in programming state to
>>> begin with - so that the caller knows that HPI was not sent.
>>>
>>> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>>> ---
>>> =C2=A0drivers/mmc/core/core.c | =C2=A0 34 ++++++++++++++++++-------=
---------
>>> =C2=A01 file changed, 18 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index e541efb..ceabef5 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -401,7 +401,7 @@ EXPORT_SYMBOL(mmc_wait_for_req);
>>> =C2=A0*/
>>> =C2=A0int mmc_interrupt_hpi(struct mmc_card *card)
>>> =C2=A0{
>>> - =C2=A0 =C2=A0 =C2=A0 int err;
>>> + =C2=A0 =C2=A0 =C2=A0 int err, i;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 status;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(!card);
>>> @@ -421,27 +421,29 @@ int mmc_interrupt_hpi(struct mmc_card *card)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * If the card status is in PRG-state, w=
e can send the HPI command.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>> + =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (R1_CURRENT_STATE(status) =3D=3D R1_S=
TATE_PRG) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /*
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* We don't know when the HPI command will finish
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* processing, so we need to resend HPI until out
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* of prg-state, and keep checking the card status
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* with SEND_STATUS. =C2=A0If a timeout error occurs wh=
en
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* sending the HPI command, we are already out of
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* prg-state.
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* To prevent an=
 infinite lockout, try to send HPI
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a fixed =
number of times and bailout if it can't
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* succeed.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i =
< 10 && err !=3D 0 ; i++)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0err =3D mmc_send_hpi_cmd(card, &status);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (err)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Once HPI was =
sent successfully, the card is
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* supposed=
 to be back to transfer state.
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (err) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug("%s: abort HPI (%d e=
rror)\n",
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
mmc_hostname(card->host), err);
>>> -
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D mmc_send_status(card, &status);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (err)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D mmc_send_status(card, &status);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (R1_=
CURRENT_STATE(status) =3D=3D R1_STATE_PRG);
>>> - =C2=A0 =C2=A0 =C2=A0 } else
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: Le=
ft prg-state\n", mmc_hostname(card->host));
>>> + =C2=A0 =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("%s: Ca=
n't send HPI. State=3D%d\n",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mmc_hostname(card->host), R1_CURRENT_STATE(status));
>>> + =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> =C2=A0out:
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_release_host(card->host);
>>> --
>>> 1.7.10.rc2
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
