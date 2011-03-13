From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Memory replacement
Date: Sun, 13 Mar 2011 07:57:30 -0500
Message-ID: <AANLkTime9LvwzPTyCXVV-ghcB5tm8VMdAiztF_BunOx6@mail.gmail.com>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com>
	<201103111135.01394.arnd@arndb.de>
	<320717C0-7117-462E-9227-7966EE6941D7@laptop.org>
	<201103122351.07697.arnd@arndb.de>
	<AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:55301 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261Ab1CMM5d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 08:57:33 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2DCu95t016318
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 08:56:09 -0400 (EDT)
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com [209.85.214.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2DCu9If016312
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 08:56:09 -0400 (EDT)
Received: by iwn3 with SMTP id 3so5242296iwn.15
        for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 05:57:31 -0700 (PDT)
In-Reply-To: <AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "C. Scott Ananian" <cscott@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Watlington <wad@laptop.org>, Kevin Gordon <kgordon420@gmail.com>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On Sat, Mar 12, 2011 at 7:01 PM, C. Scott Ananian <cscott@laptop.org> w=
rote:
> On Sat, Mar 12, 2011 at 5:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> I've had four cards with a Sandisk label that had unusual characteri=
stics
>> and manufacturer/OEM IDs that refer to other companies, three Samsun=
g ("SM")
>> and one unknown ("BE", possibly lexar). In all cases, the Sandisk su=
pport
>> has confirmed from photos that the cards are definitely fake. They a=
lso
>
> Please see the blog post I cited in the email immediately prior to
> yours, which discusses this situation precisely. =A0Often the cards a=
re
> not actually "fake" -- they may even be produced on the exact same
> equipment as the usual cards, but "off the books" during hours when
> the factory is officially closed. =A0This sort of thing is very very
> widespread, and fakes can come even via official distribution
> channels. =A0(Discussed in bunnie's post.)
>
>> However, they have apparently managed to make them work well
>> for random access by using some erase blocks as SLC (writing only
>> the pages that carry the most significant bit in each cell) and
>> by doing log structured writes in there, something that apparently
>> others have not figured out yet. Also, as I mentioned, they
>> consistenly use a relatively large number of open erase blocks.
>> I've measured both effects on SD cards and USB sticks.
>
> You've been lucky.
>
>> I believe you can get this level of sophistication only from
>> companies that make the nand flash, the controller and the card:
>> Sandisk, Samsung and Toshiba.
>> Other brands that just get the controllers and the flash chips
>> from whoever sells them cheaply (kingston, adata, panasonic,
>> transcend, ...) apparently don't get the really good stuff.
>
> You're giving the OEMs too much credit. =A0As John says, unless you
> arrange for a special SKU, even the "first source" companies will giv=
e
> you whatever they've got cheap that day.
>
>>> How we deal with this is constant testing and getting notification =
from
>>> the manufacturer that they are changing the internals (unfortunatel=
y,
>>> we aren't willing to pay the premium to have a special SKU).
>>
>> Do you have test results somewhere publically available? We are curr=
ently
>> discussing adding some tweaks to the linux mmc drivers to detect car=
ds
>> with certain features, and to do some optimizations in the block lay=
er
>> for common ones.
>
> http://wiki.laptop.org/go/NAND_Testing
>
> But the testing wad is talking about is really *on the factory floor*=
:
> =A0Regular sampling of chips as they come into the factory to ensure
> that the chips *you are actually about to put into the XOs* are
> consistent. =A0Relying on manufacturing data reported by the chips is
> not reliable.
> =A0--scott


Sorry to butt in, I think I'm missing most of the context
here....nevertheless... I'm curious, ignoring outer packaging and
product names, if you look at cards with the "same" CID (i.e. same
manfid/oemid/date/firmware and hw rev), do you get same performance
characteristics?

Anyway, if you're curious about optimizing performance for certain
cards, I'm curious to see your results, your tests and (if any) vendor
recommendations. I'm collecting data and trying to re-validate some of
the vendor suggestions for Toshiba eMMCs... in particular - splitting
unaligned writes into an unaligned and aligned part. The only thing I
can say now is that the more data I collect the less it makes sense
:-).

I'm resubmitting a change to MMC layer that allows creating block MMC
quirks... Skipping the actual quirks as I'm trying to revalidate data
taken by others and provide data I'm confident about, but you might be
interested in the overall quirks support if you're thinking about
adding your own.

A
