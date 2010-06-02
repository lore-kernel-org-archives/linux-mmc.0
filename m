From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [MMC] omap: Remove BUG_ON for disabled interrupts
Date: Wed, 2 Jun 2010 15:26:52 -0700
Message-ID: <AANLkTimERVDHWjTgWfyqjUu-I1aU2kqU99T9yRcJMRgG@mail.gmail.com>
References: <1275186443-8242-1-git-send-email-darkstar6262@gmail.com>
	<20100602140542.8c1073f1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54385 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758777Ab0FBW1M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Jun 2010 18:27:12 -0400
In-Reply-To: <20100602140542.8c1073f1.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jun 2, 2010 at 2:05 PM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> On Sat, 29 May 2010 19:27:23 -0700
> Cory Maccarrone <darkstar6262@gmail.com> wrote:
>
>> This change removes a BUG_ON for when interrupts are disabled
>> during an MMC request. =C2=A0During boot, interrupts can be disabled
>> when a request is made, causing this bug to be triggered. =C2=A0In r=
eality,
>> there's no reason this should halt the kernel, as the driver has pro=
ved
>> reliable in spite of disabled interrupts, and additionally, there's
>> nothing in this code that would require interrupts to be enabled.
>>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> ---
>> =C2=A0drivers/mmc/host/omap.c | =C2=A0 =C2=A01 -
>> =C2=A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
>> index 2b28168..d98ddcf 100644
>> --- a/drivers/mmc/host/omap.c
>> +++ b/drivers/mmc/host/omap.c
>> @@ -1157,7 +1157,6 @@ static void mmc_omap_start_request(struct mmc_=
omap_host *host,
>> =C2=A0 =C2=A0 =C2=A0 mmc_omap_start_command(host, req->cmd);
>> =C2=A0 =C2=A0 =C2=A0 if (host->dma_in_use)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_start_dma(host=
->dma_ch);
>> - =C2=A0 =C2=A0 BUG_ON(irqs_disabled());
>> =C2=A0}
>>
>> =C2=A0static void mmc_omap_request(struct mmc_host *mmc, struct mmc_=
request *req)
>
> So we need to decide whether this should be backported into 2.6.34.x
> and perhaps earlier.
>
> For that decision we'll need to know the things you didn't tell us:
> Which drivers are affected? =C2=A0Under which setups is it triggering=
? =C2=A0Why
> aren't lots of people reporting "hey my kernel went BUG"?
>
>

The only setup I've managed to make it trigger on is on the HTC Herald
during bootup when the driver is built into the kernel (mostly because
that's all I have).  I believe it's related to the fact that on bootup
I get many timeout errors on "CMD5" while initializing the card.  Each
CMD5 timeout triggers that bug (I changed it to a WARN_ON to get it to
boot in) due to the fact that part of the timeout code involves
sending the request again.  With interrupts turned off, that BUG would
be triggered.

I can't answer the question of why other people aren't reporting this
-- I know the CMD timeouts are fairly common with this driver, and
it's only within the last few kernel releases that their triggering
the BUG started happening.  (I had only been able to test it because I
was carrying forward the MMC 16-bit patch I submitted a while ago
which only recently made it in.  I'm not sure if that's related or
not, but I need that to use the MMC-OMAP on herald.)

I imagine a better solution to this would be to fix the timeout issues
so the repeated requests aren't a problem.  But any hardware bugs that
cause a timeout during boot would cause this bug to be triggered,
which is why I'm proposing removing the BUG_ON entirely (since
everything seems to work fine anyway).

I don't know why interrupts are disabled at this point, but my limited
googling around leads me to believe the recent LOCKDEP work may be the
cause.  I couldn't find enough information on that to know for sure
though.  I do know that the bug no longer triggers after the card
initializes successfully (and presumably interrupts re-enable).

My guess is that since other people aren't reporting this problem,
it's not hugely important to backport.  A better question in that case
would be why am I seeing it?  I don't understand why interrupts would
be disabled at this point in bootup.

- Cory
