From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH V4 1/5] mmc: Add erase, secure erase, trim and secure trim
	operations
Date: Wed, 7 Jul 2010 16:41:14 -0400
Message-ID: <AANLkTikWNzuAOQlQkixgX4ARcjVSxaKDN77LTeE0isC-@mail.gmail.com>
References: <20100707111716.24979.68940.sendpatchset@ahunter-work.research.nokia.com>
	<20100707111723.24979.32020.sendpatchset@ahunter-work.research.nokia.com>
	<AANLkTinfDOlL7iKP4Qmb0J4xq_I_nNEnSbokCOkYmCSn@mail.gmail.com>
	<4C34CFDD.5030900@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59984 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab0GGUlQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2010 16:41:16 -0400
In-Reply-To: <4C34CFDD.5030900@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel Mailing List <linux-kernel@vger.kernel.org>, Kyungmin Park <kmpark@infradead.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>

On Wed, Jul 7, 2010 at 3:05 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> Ben Gardiner wrote:
>>
>> On Wed, Jul 7, 2010 at 7:17 AM, Adrian Hunter <adrian.hunter@nokia.c=
om>
>> wrote:
>>>
>>> From 7f01ad3c4be6ec09318176db12db66f353b526e0 Mon Sep 17 00:00:00 2=
001
>>
>>> SD/MMC cards tend to support an erase operation. =A0In addition,
>>> eMMC v4.4 cards can support secure erase, trim and secure trim
>>> operations that are all variants of the basic erase command.
>>
>> This is great. I am interested primarily in SD media.
>>
>> Please forgive my naive perspective: it seems that with the features
>> enabled by this patchset and a filesystem that is capable of issuing
>> erase block commands, the wear-leveling on SD media will be improved
>> -- much like with CF TRIM commands. Do you also think that is the
>> case? I would be very interested in hearing your expert opinion on
>> this.
>
> I am sorry but I don't know. =A0Wear-levelling in cards tends to be k=
ept
> secret by the manufacturers. =A0However, it is not clear to me that c=
ards
> bother to record whether or not anything has been erased. =A0 For exa=
mple,
> erase a card twice - it takes the same amount of time the second time
> as the first time, whereas if the card knew it was already erased, wh=
y
> wasn't the second time much quicker?

No worries. I'm happy to hear your opinion anyways.

Interesting observation re: erase time of cards, I assume that is
"erase" as in the SD erase operations as proposed in this patch as
opposed to erase as in 'mkfs'.

>>
>> I have a couple comments regarding mostly the SD support introduced =
in
>> this patch. Patches 2..5 of 5 seem fine to me but I'm not sure I'm
>> qualified to add acks or reviewed-by's.
>>
>>> +int mmc_erase(struct mmc_card *card, unsigned int from, unsigned i=
nt nr,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int arg)
>>> +{
>>> + =A0 =A0 =A0 unsigned int rem, to =3D from + nr;
>>> +
>>> + =A0 =A0 =A0 if (!(card->host->caps & MMC_CAP_ERASE) ||
>>> + =A0 =A0 =A0 =A0 =A0 !(card->csd.cmdclass & CCC_ERASE))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>> +
>>> + =A0 =A0 =A0 if (!card->erase_size)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>> +
>>> + =A0 =A0 =A0 if (mmc_card_sd(card) && arg !=3D MMC_ERASE_ARG)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>> +
>>> + =A0 =A0 =A0 if ((arg & MMC_SECURE_ARGS) &&
>>> + =A0 =A0 =A0 =A0 =A0 !(card->ext_csd.sec_feature_support & EXT_CSD=
_SEC_ER_EN))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>> +
>>> + =A0 =A0 =A0 if ((arg & MMC_TRIM_ARGS) &&
>>> + =A0 =A0 =A0 =A0 =A0 !(card->ext_csd.sec_feature_support & EXT_CSD=
_SEC_GB_CL_EN))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EOPNOTSUPP;
>>> +
>>
>>> +int mmc_can_trim(struct mmc_card *card)
>>> +{
>>> + =A0 =A0 =A0 if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_G=
B_CL_EN)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +EXPORT_SYMBOL(mmc_can_trim);
>>
>> It looks like mmc_can_trim(card) would return true when
>> mmc_card_sd(card) is true;
>
> It will return false for SD. =A0card->ext_csd.sec_feature_support
> is only used by MMC.

Makes sense now, thanks.

>>> /*
>>> + * Fetch and process SD Status register.
>>> + */
>>> +static int mmc_read_ssr(struct mmc_card *card)
>>> +{
>>
>> It looks like the conventional function prefix for SD-specific
>> functions in the rest of this file is mmc_sd_ ; 'mmc_read_ssr' ->
>> 'mmc_sd_read_ssr' =A0or -> 'mmc_read_sd_sr' perhaps?
>
> Well there is also mmc_decode_*, and mmc_read_switch so the other
> functions that do smilar things also do not follow that convention.

Good point.

>>
>>> + =A0 =A0 =A0 ssr =3D kmalloc(64, GFP_KERNEL);
>>
>> Why '64' instead of 'sizeof(*ssr)' ?
>
> sizeof(*ssr) is 4

Right -- my mistake :)

I guess I was _thinking_ 16*sizeof(*ssr)  or SSR_SIZE*sizeof(*ssr)
instead of a magic number '64'. I see now that this wouldn't be the
only kmalloc of a magic number in sd.c -- so I'll stop being so picky.

Reviewed-by: Ben Gardiner <bengardiner@nanometrics.ca>

---
Ben Gardiner
Nanometrics Inc.
http://www.nanometrics.ca
