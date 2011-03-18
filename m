From: "Luis R. Rodriguez" <lrodriguez@atheros.com>
Subject: Re: [RFC 1/4] sdhci: allow for multiple delays when sending commands
Date: Fri, 18 Mar 2011 16:52:08 -0700
Message-ID: <AANLkTik=G-FzcUy+x0yK0DY1YKoRA58qhCN95hxOnizO@mail.gmail.com>
References: <1300486320-23607-1-git-send-email-lrodriguez@atheros.com>
 <1300486320-23607-2-git-send-email-lrodriguez@atheros.com> <m3y64ct47j.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55074 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab1CRXwa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Mar 2011 19:52:30 -0400
In-Reply-To: <m3y64ct47j.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, vmehta@atheros.com, naveen.singh@atheros.com, kvalo@adurom.com, j@w1.fi, Naveen Singh <nsingh@atheros.com>, Vipin Mehta <Vipin.Mehta@atheros.com>

On Fri, Mar 18, 2011 at 4:10 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Luis,
>
> On Fri, Mar 18 2011, Luis R. Rodriguez wrote:
>> This is at least known to be required for the ENE 714.
>>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: Kalle Valo <kvalo@adurom.com>
>> Cc: Naveen Singh <nsingh@atheros.com>
>> Cc: Vipin Mehta <Vipin.Mehta@atheros.com>
>> Signed-off-by: Luis R. Rodriguez <lrodriguez@atheros.com>
>
> I think this wins cjb's "I've never been so confused about what a pat=
ch
> author thought they were doing before" award.

I warned you :)

>> ---
>> =C2=A0drivers/mmc/host/sdhci.c | =C2=A0 =C2=A07 ++++---
>> =C2=A01 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 9e15f41..c95dfc2 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -891,8 +891,8 @@ static void sdhci_send_command(struct sdhci_host=
 *host, struct mmc_command *cmd)
>>
>> =C2=A0 =C2=A0 =C2=A0 WARN_ON(host->cmd);
>>
>> - =C2=A0 =C2=A0 /* Wait max 10 ms */
>> - =C2=A0 =C2=A0 timeout =3D 10;
>> + =C2=A0 =C2=A0 /* Wait max this amount of ms */
>> + =C2=A0 =C2=A0 timeout =3D (10*256) + 255;
>>
>> =C2=A0 =C2=A0 =C2=A0 mask =3D SDHCI_CMD_INHIBIT;
>> =C2=A0 =C2=A0 =C2=A0 if ((cmd->data !=3D NULL) || (cmd->flags & MMC_=
RSP_BUSY))
>
> Okay, so our original plan is to go through the while loop ten times,
> which equals ten mdelay(1)s =3D=3D 10ms, waiting for the inhibit bit =
to
> become unset.
>
> After this hunk of your patch, we're set to go through the loop 2815
> times, which would make for 2.8 seconds. =C2=A0That seems excessive.
>
>> @@ -913,7 +913,8 @@ static void sdhci_send_command(struct sdhci_host=
 *host, struct mmc_command *cmd)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout--;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(timeout & 0xFF))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mdelay(1);
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 mod_timer(&host->timer, jiffies + 10 * HZ);
>
> But wait, here you decide *not* to call mdelay(1) every time through =
the
> loop, and instead call it only on iterations where the bottom eight b=
its
> are unset. =C2=A0This disqualifies most of the 2815 values that timeo=
ut will
> be set to, and leaves the following values triggering the mdelay(1):
>
> 0x100 0x200 0x300 0x400 0x500 0x600 0x700 0x800 0x900 0xa00
> =C2=A0256 =C2=A0 512 =C2=A0 768 =C2=A01024 =C2=A01280 =C2=A01536 =C2=A0=
1792 =C2=A02048 =C2=A02304 =C2=A02560
>
> The astute observer will notice that there are ten such values.
> So you're calling mdelay(1) ten times. =C2=A0But that's what we were
> doing before! =C2=A0The only difference is that now we spin through
> the while loop 2815 times instead of 10, and don't perform any
> explicit delay on 2805 of them. =C2=A0Or am I missing something?
>
> I think you should try:
>
> (a) Reverting the patch and checking that it's actually needed
> (b) Leaving the while loop body alone, but increasing the max
> =C2=A0 =C2=A0timeout until you bisect to the amount of ms that your c=
ontroller
> =C2=A0 =C2=A0actually takes to release the inhibit bit.
> (c) Yelling loudly in the direction that this code came from. =C2=A0:=
)

Heh thanks for the review, once I even get ath6kl to even load
properly on x86_64 I'll try reverting this POS hunk and see if it
still works without it. Who knows where the hell this patch came from,
as I noted I was given the entire blob as a huge patch and if you look
at it, the original patch even removes some quirk for tegra.

 Luis
