From: "Torne (Richard Coles)" <torne@google.com>
Subject: Re: [PATCH V2] MMC: core: cap MMC card timeouts at 2 seconds.
Date: Fri, 1 Jun 2012 10:32:40 +0100
Message-ID: <CAEV-rjfkcoEc-4VmMS-wQburo5tZZVDemzHk8LyKGhuLfFnSng@mail.gmail.com>
References: <1338226278-13336-1-git-send-email-torne@google.com>
	<1338258732.20487.171.camel@deadeye>
	<4FC87EEA.5010707@intel.com>
	<CAEV-rjcFx_+Zs+1K5rxapx7ngDkArEKSV8tDubbVL+BfYLDU5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53624 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759300Ab2FAJcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jun 2012 05:32:41 -0400
Received: by yhmm54 with SMTP id m54so1436649yhm.19
        for <linux-mmc@vger.kernel.org>; Fri, 01 Jun 2012 02:32:40 -0700 (PDT)
In-Reply-To: <CAEV-rjcFx_+Zs+1K5rxapx7ngDkArEKSV8tDubbVL+BfYLDU5Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, cjb@laptop.org, linus.walleij@linaro.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 1 June 2012 10:31, Torne (Richard Coles) <torne@google.com> wrote:
> On 1 June 2012 09:35, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 29/05/12 05:32, Ben Hutchings wrote:
>>> On Mon, 2012-05-28 at 18:31 +0100, Torne (Richard Coles) wrote:
>>>> From: "Torne (Richard Coles)" <torne@google.com>
>>>>
>>>> MMC CSD info can specify very large, ridiculous timeouts, big enou=
gh to
>>>> overflow timeout_ns on 32-bit machines. This can result in the car=
d
>>>> timing out on every operation because the wrapped timeout value is=
 far
>>>> too small.
>>>>
>>>> Fix the overflow by capping the result at 2 seconds. =A0Cards spec=
ifying
>>>> longer timeouts are almost certainly insane, and host controllers
>>>> generally cannot support timeouts that long in any case.
>>>>
>>>> 2 seconds should be plenty of time for any card to actually functi=
on;
>>>> the timeout calculation code is already using 1 second as a "worst=
 case"
>>>> timeout for cards running in SPI mode.
>>>
>>> Needs a 'Signed-off-by'.
>>>
>>>> ---
>>>> =A0drivers/mmc/core/core.c | =A0 11 ++++++++++-
>>>> =A01 files changed, 10 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 0b6141d..3b4a9fc 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -512,7 +512,16 @@ void mmc_set_data_timeout(struct mmc_data *da=
ta, const struct mmc_card *card)
>>>> =A0 =A0 =A0if (data->flags & MMC_DATA_WRITE)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0mult <<=3D card->csd.r2w_factor;
>>>>
>>>> - =A0 =A0data->timeout_ns =3D card->csd.tacc_ns * mult;
>>>> + =A0 =A0/*
>>>> + =A0 =A0 * The timeout in nanoseconds may overflow with some card=
s. Cap it at
>>>> + =A0 =A0 * two seconds both to avoid the overflow and also becaus=
e host
>>>> + =A0 =A0 * controllers cannot generally generate timeouts that lo=
ng anyway.
>>>> + =A0 =A0 */
>>>> + =A0 =A0if (card->csd.tacc_ns <=3D (2 * NSEC_PER_SEC) / mult)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0data->timeout_ns =3D card->csd.tacc_ns * =
mult;
>>>> + =A0 =A0else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0data->timeout_ns =3D 2 * NSEC_PER_SEC;
>>>
>>> We clearly need to guard against overflow here, and this is the cor=
rect
>>> way to clamp the multiplication. =A0I can't speak as to whether 2 s=
econds
>>> is the right limit.
>>
>> The host controllers I have looked at have a limit of around 2.5 sec=
onds.
>>
>> But why not just use the size of the type as the limit? e.g.
>>
>> =A0 =A0 =A0 =A0if (card->csd.tacc_ns <=3D UINT_MAX / mult)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->timeout_ns =3D card->csd.tacc_n=
s * mult;
>> =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->timeout_ns =3D UINT_MAX;
>
> The host controller drivers don't seem to all do a very good job of
> preventing further overflows or handling large values correctly
> (though some do). sdhci takes the especially annoying additional step
> of printk'ing a warning for *every single MMC command* where
> data->timeout_ns is larger than the controller can accommodate.
> Capping it to a value with a sensible order of magnitude seems to mak=
e
> it more likely that cards with obviously bogus CSD parameters will
> actually work. I don't object to using a larger number for the limit,
> but UINT_MAX on a 64-bit system obviously doesn't limit this at all
> and will leave you with timeouts up to 17 minutes, which seems
> ridiculous :)

Er, not 17 minutes; 102.4 seconds as I used later in my mail. SD cards
have their timeouts capped already, so their larger 100x multiplier is
not a problem; 102.4 seconds is the longest for an MMC card.

> My original motivation for this patch is that I have a device with an
> eMMC that specifies a 25.5 second timeout, attached to a sdhci host
> whose maximum timeout is 2.8 seconds. Originally I proposed a patch t=
o
> just remove the warning in sdhci, but nobody replied, and when I
> realised there was actually an overflow happening I opted to fix that
> instead.
>
> So, yeah, we could use UINT_MAX, but then at minimum I also need to
> kill the warning in sdhci to make my device work, and probably all th=
e
> host controller drivers need to be checked to make sure they don't us=
e
> timeout_ns in a way that can overflow.
>
> I've also just noticed that struct mmc_data's comment for timeout_ns
> says /* data timeout (in ns, max 80ms) */ which is not true (the max
> is 102.4 seconds if my math is correct), which may have contributed t=
o
> the host drivers not being too careful :)
>
> What do you think?
>
>>>
>>> Ben.
>>>
>>>> =A0 =A0 =A0data->timeout_clks =3D card->csd.tacc_clks * mult;
>>>>
>>>> =A0 =A0 =A0/*
>>>
>>
>
>
>
> --
> Torne (Richard Coles)
> torne@google.com



--=20
Torne (Richard Coles)
torne@google.com
