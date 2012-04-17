From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 4/4] mmc: core: Send HPI only till it is successful
Date: Tue, 17 Apr 2012 17:36:31 +0530
Message-ID: <CANfBPZ8JUWCgMrnkWq5pbGMG3pUBx9=_b1H4uUPhT5DuuzDEfg@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
 <1334319854-5989-5-git-send-email-svenkatr@ti.com> <CAKYAXd_R5RfyP_-hW6LRbdEaVHbJOS+RdQC6-t3tqCcBUS4HGw@mail.gmail.com>
 <CANfBPZ-b=0ykM5XapE9KVMHkojoD1v==ZV5eqnQqothTGb5j7g@mail.gmail.com>
 <CAKYAXd8uFC98RLtEp+52PC+=KLeXKQXk_QTBJ_Y2yG_S+8NYtw@mail.gmail.com> <CAELcNGQXMks6gOzbmAhcEQtrA7hVCXUGOR8RRCp5sPapOjpG8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:60579 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755823Ab2DQMGz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Apr 2012 08:06:55 -0400
Received: by bkcji17 with SMTP id ji17so6648835bkc.21
        for <linux-mmc@vger.kernel.org>; Tue, 17 Apr 2012 05:06:52 -0700 (PDT)
In-Reply-To: <CAELcNGQXMks6gOzbmAhcEQtrA7hVCXUGOR8RRCp5sPapOjpG8Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

On Sun, Apr 15, 2012 at 8:40 PM, Jae hoon Chung <jh80.chung@gmail.com> =
wrote:
> Hi Venkatraman
>
> 2012/4/14 Namjae Jeon <linkinjeon@gmail.com>:
>> 2012/4/14 S, Venkatraman <svenkatr@ti.com>:
>>> On Fri, Apr 13, 2012 at 8:09 PM, Namjae Jeon <linkinjeon@gmail.com>=
 wrote:
>>>> Hi. Venkatraman.
>>>>
>>>> You fixed 10 times. why is it 10 times ?
>>> There's no right number - I haven't seen it fail much in my tests b=
ut
>>> should allow a few retries.
>> Is there the reason should send HPI a few retries ?
>>>
>>>> and checking err from mmc_send_status is not needed ? is it =A0als=
o
>>>> infinite case ?
>>> Check again - the loop will break if the send_status returns an err=
or
>>> (even once), or if the card comes out of PRG state.
> Well, if hpi command is successful, that loop should be break.
> Already out-of prg-state.
But that would happen anyway if the card is out of prg state.

> But if hpi command is failed, just waiting for out-of prg-state?
> why wait for out-of prg-state?...if state is prg-state, hpi-cmd is
> already failed..?
> then...i think that need not to wait for out-of prg-state..just retur=
n failed...
It's already happening with the current patch.

But from what I understand from NJ and you, it doesn't make sense to
retry sending HPI command multiple times. I'll update the patch to send
it only once.


>
> Best Regards,
> Jaehoon Chung
>> okay, but this patch print "abort HPI" although card_status is fail.
>> if print abort HPI fail, Can we know which error occurred in either
>> send hpi cmd error and send status error ?
>> Thanks.
>>>
>>>>
>>>> Thanks.
>>>>
>>>> 2012/4/13 Venkatraman S <svenkatr@ti.com>:
>>>>> Try to send HPI only a fixed number of times till it is
>>>>> successful. One successful transfer is enough - but wait
>>>>> till the card comes out of transfer state.
>>>>> Return an error if the card was not in programming state to
>>>>> begin with - so that the caller knows that HPI was not sent.
>>>>>
>>>>> Reported-by: Alex Lemberg <Alex.Lemberg@sandisk.com>
>>>>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>>>>> ---
>>>>> =A0drivers/mmc/core/core.c | =A0 34 ++++++++++++++++++-----------=
-----
>>>>> =A01 file changed, 18 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index e541efb..ceabef5 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -401,7 +401,7 @@ EXPORT_SYMBOL(mmc_wait_for_req);
>>>>> =A0*/
>>>>> =A0int mmc_interrupt_hpi(struct mmc_card *card)
>>>>> =A0{
>>>>> - =A0 =A0 =A0 int err;
>>>>> + =A0 =A0 =A0 int err, i;
>>>>> =A0 =A0 =A0 =A0u32 status;
>>>>>
>>>>> =A0 =A0 =A0 =A0BUG_ON(!card);
>>>>> @@ -421,27 +421,29 @@ int mmc_interrupt_hpi(struct mmc_card *card=
)
>>>>> =A0 =A0 =A0 =A0/*
>>>>> =A0 =A0 =A0 =A0 * If the card status is in PRG-state, we can send=
 the HPI command.
>>>>> =A0 =A0 =A0 =A0 */
>>>>> + =A0 =A0 =A0 err =3D -EINVAL;
>>>>> =A0 =A0 =A0 =A0if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) =
{
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We don't know =
when the HPI command will finish
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* processing, so=
 we need to resend HPI until out
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of prg-state, =
and keep checking the card status
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with SEND_STAT=
US. =A0If a timeout error occurs when
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* sending the HP=
I command, we are already out of
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prg-state.
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* To prevent an infinite lockout, =
try to send HPI
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a fixed number of times and ba=
ilout if it can't
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* succeed.
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < 10 && err !=3D 0 =
; i++)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_h=
pi_cmd(card, &status);
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Once HPI was sent successfully, =
the card is
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* supposed to be back to transfe=
r state.
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr=
_debug("%s: abort HPI (%d error)\n",
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc_hostname(card->host), err);
>>>>> -
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_st=
atus(card, &status);
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0br=
eak;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_st=
atus(card, &status);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} while (R1_CURRENT_STATE(status) =
=3D=3D R1_STATE_PRG);
>>>>> - =A0 =A0 =A0 } else
>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Left prg-state\n", mm=
c_hostname(card->host));
>>>>> + =A0 =A0 =A0 } else {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: Can't send HPI. State=
=3D%d\n",
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->=
host), R1_CURRENT_STATE(status));
>>>>> + =A0 =A0 =A0 }
>>>>>
>>>>> =A0out:
>>>>> =A0 =A0 =A0 =A0mmc_release_host(card->host);
>>>>> --
>>>>> 1.7.10.rc2
>>>>>
