From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Memory replacement
Date: Sun, 13 Mar 2011 18:21:00 +0100
Message-ID: <201103131821.00762.arnd@arndb.de>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com> <201103122351.07697.arnd@arndb.de> <AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61614 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab1CMRVF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 13:21:05 -0400
In-Reply-To: <AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "C. Scott Ananian" <cscott@laptop.org>
Cc: John Watlington <wad@laptop.org>, Kevin Gordon <kgordon420@gmail.com>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On Sunday 13 March 2011 02:01:22 C. Scott Ananian wrote:
> On Sat, Mar 12, 2011 at 5:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I've had four cards with a Sandisk label that had unusual characteristics
> > and manufacturer/OEM IDs that refer to other companies, three Samsung ("SM")
> > and one unknown ("BE", possibly lexar). In all cases, the Sandisk support
> > has confirmed from photos that the cards are definitely fake. They also
> 
> Please see the blog post I cited in the email immediately prior to
> yours, which discusses this situation precisely.  Often the cards are
> not actually "fake" -- they may even be produced on the exact same
> equipment as the usual cards, but "off the books" during hours when
> the factory is officially closed.  This sort of thing is very very
> widespread, and fakes can come even via official distribution
> channels.  (Discussed in bunnie's post.)

I am very familiar with bunnie's research, and have referenced
it from my own page on the linaro wiki. I have also found Kingston
cards with the exact same symptoms that triggered his original
interest (very slow, manfid 0x41, oemid "42", low serial number).

Another interesting case of a fake card I found had a Sandisk
label and "LEXAR" in its MMC name field. Moreover, it actually
contained copyrighted software that Lexar ships in their real
cards. So what I'd assume is happening here is that the factory
that produces the cards or Lexar had a graveyard shift where they
were just printing Sandisk labels on the cards.

> You're giving the OEMs too much credit.  As John says, unless you
> arrange for a special SKU, even the "first source" companies will give
> you whatever they've got cheap that day.

It's pretty clear that they are moving to cheaper NAND chips when
possible, and I also mentioned that. For the controller chips, I don't
understand how they would save money by buying them on the spot market.
On the contrary, using the smart controllers that Sandisk themselves
make allows them to use even slower NAND chips and still qualify for
a better nominal speed grade, while companies that don't have acess
to decent controllers need to either use chips that are fast enough
to make up for the bad GC algorithm or lie in their speed grades.

> >> How we deal with this is constant testing and getting notification from
> >> the manufacturer that they are changing the internals (unfortunately,
> >> we aren't willing to pay the premium to have a special SKU).
> >
> > Do you have test results somewhere publically available? We are currently
> > discussing adding some tweaks to the linux mmc drivers to detect cards
> > with certain features, and to do some optimizations in the block layer
> > for common ones.
> 
> http://wiki.laptop.org/go/NAND_Testing

Ok, so the "testing" essentially means you create an ext2/3/4 file system
and run tests on the file system until the card wears out, right?

It does seem a bit crude, because many cards are not really suitable
for this kind of file system when their wear leveling is purely optimized
to the accesses defined in the sd card file system specification.

If you did this on e.g. a typical Kingston card, it can have a write
amplification 100 times higher than normal (FAT32, nilfs2, ...), so
it gets painfully slow and wears out very quickly.

I had hoped that someone already correlated the GC algorithms with
the requirements of specific file systems to allow a more systematic
approach.

	Arnd
