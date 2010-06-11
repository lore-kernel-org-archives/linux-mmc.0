From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: + sdhci-add-no-hi-speed-bit-quirk-support.patch added to -mm tree
Date: Fri, 11 Jun 2010 12:25:32 +0900
Message-ID: <AANLkTik5ANblTvTGh-4f9IL7VW8iPmQtRiN0BIDWjFGc@mail.gmail.com>
References: <201006102043.o5AKhJjl022731@imap1.linux-foundation.org>
	<20100611004229.GD3498@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61147 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754301Ab0FKDZd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2010 23:25:33 -0400
In-Reply-To: <20100611004229.GD3498@trinity.fluff.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-mmc@vger.kernel.org

On Fri, Jun 11, 2010 at 9:42 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Thu, Jun 10, 2010 at 01:43:19PM -0700, akpm@linux-foundation.org w=
rote:
>>
>> The patch titled
>> =A0 =A0 =A0SDHCI: add no hi-speed bit quirk support
>> has been added to the -mm tree. =A0Its filename is
>> =A0 =A0 =A0sdhci-add-no-hi-speed-bit-quirk-support.patch
>>
>> Before you just go and hit "reply", please:
>> =A0 =A0a) Consider who else should be cc'ed
>> =A0 =A0b) Prefer to cc a suitable mailing list as well
>> =A0 =A0c) Ideally: find the original patch on the mailing list and d=
o a
>> =A0 =A0 =A0 reply-to-all to that, adding suitable additional cc's
>>
>> *** Remember to use Documentation/SubmitChecklist when testing your =
code ***
>>
>> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
>> out what to do about this
>>
>> The current -mm tree may be found at http://userweb.kernel.org/~akpm=
/mmotm/
>>
>> ------------------------------------------------------
>> Subject: SDHCI: add no hi-speed bit quirk support
>> From: Kyungmin Park <kmpark@infradead.org>
>>
>> Some SDHCI controllers like s5pc110 don't have an HISPD bit in the H=
OSTCTL
>> register.
>
> It would be nice for someone at Samsung to (a) explain the difference=
s
> from the base SDHCI spec for all their hardware (the databooks are of=
ten
> vague in this area) and (b) for the information for the extra registe=
rs
> this IP block has to be explained in more detail (and the platform co=
de
> checked for this too).

I hope also.

Thank you,
Kyungmin Park

>
> The CTRL2/CTRL3 registers definitions in the datasheets leave out use=
ful
> information such as how the feedback and filtering bits should be set
> and how they depend on things such as the card type and bus speed.
>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: <linux-mmc@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>> =A0drivers/mmc/host/sdhci.c | =A0 =A03 ++-
>> =A0drivers/mmc/host/sdhci.h | =A0 =A02 ++
>> =A02 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff -puN drivers/mmc/host/sdhci.c~sdhci-add-no-hi-speed-bit-quirk-s=
upport drivers/mmc/host/sdhci.c
>> --- a/drivers/mmc/host/sdhci.c~sdhci-add-no-hi-speed-bit-quirk-suppo=
rt
>> +++ a/drivers/mmc/host/sdhci.c
>> @@ -1164,7 +1164,8 @@ static void sdhci_set_ios(struct mmc_hos
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBUS;
>>
>> - =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_SD_HS)
>> + =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_SD_HS &&
>> + =A0 =A0 =A0 =A0 !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_HISPD;
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_HISPD;
>> diff -puN drivers/mmc/host/sdhci.h~sdhci-add-no-hi-speed-bit-quirk-s=
upport drivers/mmc/host/sdhci.h
>> --- a/drivers/mmc/host/sdhci.h~sdhci-add-no-hi-speed-bit-quirk-suppo=
rt
>> +++ a/drivers/mmc/host/sdhci.h
>> @@ -240,6 +240,8 @@ struct sdhci_host {
>> =A0#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN =A0 =A0 =A0 =A0 =A0 =A0=
(1<<25)
>> =A0/* Controller cannot support End Attribute in NOP ADMA descriptor=
 */
>> =A0#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC =A0 =A0 =A0 =A0 =A0 =A0=
(1<<26)
>> +/* Controller doesn't have HISPD bit field in HI-SPEED SD card */
>> +#define SDHCI_QUIRK_NO_HISPD_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<27)
>>
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0 =A0=
 =A0 =A0 =A0 =A0/* Device IRQ */
>> =A0 =A0 =A0 void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0 =A0=
 /* Mapped address */
>> _
>>
>> Patches currently in -mm which might be from kmpark@infradead.org ar=
e
>>
>> mmc-recognize-csd-structure.patch
>> mmc-recognize-csd-structure-fix.patch
>> s5pc110-sdhci-s3c-can-override-host-capabilities.patch
>> s5pc110-sdhci-s3c-support-on-s5pc110.patch
>> sdhci-add-no-hi-speed-bit-quirk-support.patch
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> --
> Ben
>
> Q: =A0 =A0 =A0What's a light-year?
> A: =A0 =A0 =A0One-third less calories than a regular year.
>
>
