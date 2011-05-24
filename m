From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: why would an SD card, after 12 hours, start to fail recording video?
Date: Tue, 24 May 2011 21:24:13 +0200
Message-ID: <201105242124.13856.arnd@arndb.de>
References: <alpine.DEB.2.00.1105241307400.3975@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab1EXTYT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 15:24:19 -0400
In-Reply-To: <alpine.DEB.2.00.1105241307400.3975@localhost6.localdomain6>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-mmc@vger.kernel.org

On Tuesday 24 May 2011 19:11:48 Robert P. J. Day wrote:
>   a maddeningly vague question -- i'm currently after more information
> -- but i've been told about an issue where someone is recording video
> to an SD card and, after 12 hours, the units begin to "fail."  that's
> all the info i have at the moment, i hope to get more so i don't even
> know what the definition of "fail" is here, or the brands or models or
> vendors involved, only what you read above.
> 
>   has anyone run across something like this before?  again, i realize
> this is annoyingly vague but if i had a hint as to what might be
> going on, i might be able to offer some advice.  what could possibly
> cause properly recording SD cards to start misbehaving after several
> hours?  thanks for any wildly speculative guesses.

There are many reasons why this could happen:

* You used a Kingston (or other cheap) SD card with a file system other
  than FAT32

* The partition is not aligned to 4 MB

* The cluster size is less than 16 KB

* You have multiple partitions on the card

If any of these are true, you have destroyed the card by writing a
lot of data to it.

	Arnd
