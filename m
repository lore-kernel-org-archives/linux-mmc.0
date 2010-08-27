From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [PATCH] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Fri, 27 Aug 2010 16:14:49 +0900
Message-ID: <AANLkTikLq_04+KQzyKmOh2K7U4wME=bXTzfq0M1KH8V3@mail.gmail.com>
References: <4C775C8E.7040903@samsung.com>
	<20100827070955.GA2418@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43429 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab0H0HOx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Aug 2010 03:14:53 -0400
Received: by wyb35 with SMTP id 35so3195091wyb.19
        for <linux-mmc@vger.kernel.org>; Fri, 27 Aug 2010 00:14:49 -0700 (PDT)
In-Reply-To: <20100827070955.GA2418@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>

On Fri, Aug 27, 2010 at 4:09 PM, Matt Fleming <matt@console-pimps.org> =
wrote:
> On Fri, Aug 27, 2010 at 03:34:54PM +0900, Jaehoon Chung wrote:
>> If controller use SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk,
>> controller need always polling detect
>>
>> In this case, always generated interrupt.Because controller checked =
card status.
>> I think that is not efficiently.
>>
>> But if card is nonremovable, we need not always polling.
>> So i added the check-point which is nonremovable or not
>>
>> =A0Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 =A05 +++--
>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 401527d..4bc5d3c 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1826,8 +1826,9 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 if (caps & SDHCI_CAN_DO_HISPD)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
>>
>> - =A0 =A0 if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
>> - =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>> + =A0 =A0 if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_NEE=
DS_POLL;
>>
>> =A0 =A0 =A0 mmc->ocr_avail =3D 0;
>> =A0 =A0 =A0 if (caps & SDHCI_CAN_VDD_330)
>> --
>> 1.6.0.4
>> --
>
> I don't have any non-removable hardware so I can't test this patch bu=
t I
> think it makes sense. The indentation looks a bit weird, but Andrew m=
ay
> fix that up if he thinks it's a problem.
>
> I'm assuming that you're testing this change with the sdhci-s3c.c
> driver? Is it a good idea that the driver is using
> SDHCI_QUIRK_BROKEN_CARD_DETECTION when it has a nonremovable card?
> Currently we seem to be using SDHCI_QUIRK_BROKEN_CARD_DETECTION and
> MMC_CAP_NONREMOVABLE to mean that same thing in some places which is
> really confusing.

There are some reason to use both.
s5pc110/c210 has 3 or 4 mmc devices and basically our board don't
connect the card detection pin to sdhci.
That's reason to define BROKEN_CARD_DETECTION. but some devices such
as eMMC and WiFi has connected permanently.
it's reason to define CAP_NONREMOVABLE for these devices.

The main reason of this patch is that don't poll anymore when it's
non-removable.

Thank you,
Kyungmin Park

>
> Like in drivers/mmc/host/sdhci.c we can enable card detection irqs fo=
r
> cards that are nonremovable which is a bit pointless (though obviousl=
y
> not harmful).
>
> But your patch seems fine unless anyone else has an issue with it, I'=
m
> just trying to see if we could clean this up ontop of your patch.
>
> Adding Andrew Morton to the CC list.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
