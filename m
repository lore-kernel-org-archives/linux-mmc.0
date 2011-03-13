From: "C. Scott Ananian" <cscott@laptop.org>
Subject: Re: Memory replacement
Date: Sun, 13 Mar 2011 13:06:13 -0400
Message-ID: <AANLkTikVfiD7yaQbyR8xsiZDCmhp1eGhKM+PnHFSHjvW@mail.gmail.com>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com>
	<201103111135.01394.arnd@arndb.de>
	<320717C0-7117-462E-9227-7966EE6941D7@laptop.org>
	<201103122351.07697.arnd@arndb.de>
	<AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>
	<AANLkTime9LvwzPTyCXVV-ghcB5tm8VMdAiztF_BunOx6@mail.gmail.com>
	<AANLkTike97v8KTayEnMUADyQsF2yvDpAuQC5VCsS1a8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39332 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab1CMRGO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 13:06:14 -0400
Received: by iwn34 with SMTP id 34so4215802iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 10:06:14 -0700 (PDT)
In-Reply-To: <AANLkTike97v8KTayEnMUADyQsF2yvDpAuQC5VCsS1a8b@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, John Watlington <wad@laptop.org>, Kevin Gordon <kgordon420@gmail.com>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On Sun, Mar 13, 2011 at 1:00 PM, C. Scott Ananian <cscott@laptop.org> w=
rote:
> On Sun, Mar 13, 2011 at 8:57 AM, Andrei Warkentin <andreiw@motorola.c=
om> wrote:
>> Sorry to butt in, I think I'm missing most of the context
>> here....nevertheless... I'm curious, ignoring outer packaging and
>> product names, if you look at cards with the "same" CID (i.e. same
>> manfid/oemid/date/firmware and hw rev), do you get same performance
>> characteristics?
>
> No.

To elaborate: see bunnie's blog post (cited above) on how the CID is
often forged or wrong.  I've also personally witnessed a
manufacturer's rep come to the factory floor to reprogram a compact
flash card's internal microcontroller with new firmware.  This did not
update any externally visible information reported by the chip.  I had
to convince the manufacturer to leave their proprietary hardware on
the factory floor in order to be able to verify that future units
would have the correct firmware.  (Granted, this was not an MMC unit,
but I would be surprised if MMC vendors were significantly different
in this regard.)

If you've spent any time working with Chinese/Taiwanese OEMs, you will
notice that version control methodologies are (in general)
disappointingly lax.
 --scott

--=20
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 ( http://cscott.net/=
 )
