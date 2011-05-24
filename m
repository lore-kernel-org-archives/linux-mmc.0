From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: why would an SD card, after 12 hours, start to fail recording
 video?
Date: Tue, 24 May 2011 16:03:39 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105241557390.12131@localhost6.localdomain6>
References: <alpine.DEB.2.00.1105241307400.3975@localhost6.localdomain6> <201105242124.13856.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:52132 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933307Ab1EXUDn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 16:03:43 -0400
In-Reply-To: <201105242124.13856.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org

On Tue, 24 May 2011, Arnd Bergmann wrote:

> On Tuesday 24 May 2011 19:11:48 Robert P. J. Day wrote:
> >   a maddeningly vague question -- i'm currently after more information
> > -- but i've been told about an issue where someone is recording video
> > to an SD card and, after 12 hours, the units begin to "fail."  that's
> > all the info i have at the moment, i hope to get more so i don't even
> > know what the definition of "fail" is here, or the brands or models or
> > vendors involved, only what you read above.
> >
> >   has anyone run across something like this before?  again, i realize
> > this is annoyingly vague but if i had a hint as to what might be
> > going on, i might be able to offer some advice.  what could possibly
> > cause properly recording SD cards to start misbehaving after several
> > hours?  thanks for any wildly speculative guesses.
>
> There are many reasons why this could happen:
>
> * You used a Kingston (or other cheap) SD card with a file system other
>   than FAT32
>
> * The partition is not aligned to 4 MB
>
> * The cluster size is less than 16 KB
>
> * You have multiple partitions on the card
>
> If any of these are true, you have destroyed the card by writing a
> lot of data to it.

  i'm not right this minute in a position to verify any of that but
here's a few more sentences i've received:

"What happens when the unit fails is that it stops recording suddenly.
There's no discernable pattern involved and no way to predict it."

and

"The error we see basically exhibits the following pattern:
- SD driver does not respond as expected to VFS
- FAT FS detects the error (FAT Panic) and remounts the device in read-only mode

"We also see numerous mildly corrupt FAT FSes during recording."

  once i get the detailed setup, i'll be able to verify any of the
above.  thanks muchly.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

