From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: SD-card endurance, wear and crappiness
Date: Wed, 10 Sep 2014 09:18:51 +0200
Message-ID: <CA+20K0DFuk-3pBJoQhLci-EbFSO-8y3u=kP1zba1a70zgF9CRg@mail.gmail.com>
References: <CA+20K0DpX_zts4DgLstU4UUM1WZQWxPQWXBOjwreD6RZeUwfsQ@mail.gmail.com>
	<CA+20K0DfrGWOSQDgDNPzBYw8W=yq3s9EohEwiTxtUMnPp_sJEA@mail.gmail.com>
	<3904705.sVTpylx3OE@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:60465 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaIJHSw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Sep 2014 03:18:52 -0400
Received: by mail-qc0-f182.google.com with SMTP id x13so5503426qcv.41
        for <linux-mmc@vger.kernel.org>; Wed, 10 Sep 2014 00:18:51 -0700 (PDT)
In-Reply-To: <3904705.sVTpylx3OE@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2014-09-09 11:11 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 09 September 2014 10:54:51 Johan Rudholm wrote:
>> 2014-09-03 16:24 GMT+02:00 Johan Rudholm <jrudholm@gmail.com>:
>> > Hi all,
>> >
>> > as you know, NAND flash can be programmed a limited number of times
>> > before it reaches end of life, the number of times varies with the
>> > NAND technology used, among other things.
>> >
>> > As far as I can tell from the simplified SD-spec, there is no way of
>> > asking the card about how many program/erase cycles it can handle, or
>> > how many p/e cycles are left before reaching EOL. Right?
>
> I think that is correct.
>
>> > So, if one should want to give the user some kind of early warning
>> > that it's time to change SD-cards, is there a way? Also, when a card
>> > has reached EOL, is there a way of telling this condition apart from
>> > all other error conditions that may arise? As you know, depending on
>> > the quality of the card and controller, read timeouts, write timeouts,
>> > lockups etc may occur but can usually be fixed with a power cycle.
>> >
>> > I'm thinking of collecting simple statistics from for instance
>> > card/block.c and exposing it via an ioctl or sysfs. The statistics can
>> > be gathered and processed by some user space process which can
>> > determine if the user needs to be alerted. The statistics can be, for
>> > instance:
>> >
>> > * Writes/reads that timeout, but succeed after a retry
>> > * Writes/reads that timeout and never succeeds
>> > * Different kinds of errors in the card status
>> > * Anything else?
>> >
>> > Perhaps it's not possible to detect worn out cards this way, but at
>> > least it could point out and warn about crappy cards?
>> >
>> > Any thoughts about this?
>
> Have you tried if this works? In my experience, the worn-out cards
> I have either just fail completely, or they return incorrect data,
> but I have not looked at this side of the problem much.
>
> Do you have cards that sometimes time out but always still return
> correct data on retry?

I have noticed that some cards time out on a multi block read, but
then succeeds when single block reads are attempted. I've also
experimented with retrying the multi block read instead of falling
back to single block reads, and some cards succeed after a number (>
10) of retries. However, these cards have not been close to being worn
out.

I have almost never seen an SD-card that's died because of wear, at
least not under controlled circumstances. So, thanks for sharing your
experiences! Maybe the bottom line will be that there is no guaranteed
way of detecting that a card is nearing EOL.

//Johan
