From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 4/4] mmc: core: Send HPI only till it is successful
Date: Thu, 19 Apr 2012 10:03:04 +0530
Message-ID: <CANfBPZ9AxVQXrtyHJw27Hp7WPZk8vkWbaBLMYEzhamt3FRDbng@mail.gmail.com>
References: <1334319854-5989-1-git-send-email-svenkatr@ti.com>
 <1334319854-5989-5-git-send-email-svenkatr@ti.com> <877gxcl4z7.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:53145 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750765Ab2DSEd1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Apr 2012 00:33:27 -0400
Received: by bkcjc3 with SMTP id jc3so8240636bkc.13
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 21:33:24 -0700 (PDT)
In-Reply-To: <877gxcl4z7.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, Apr 19, 2012 at 9:59 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Apr 13 2012, Venkatraman S wrote:
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
>
> Minor nit: for consistency, please always use:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Kernel-style comment blocks.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>
> .. even though they waste the first line. =A0:)
>
Thanks - I'll be more careful - but that comment is not present on the
last version I posted.
