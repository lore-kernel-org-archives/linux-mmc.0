From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Sun, 13 Mar 2011 15:54:37 +0100
Message-ID: <201103131554.38028.arnd@arndb.de>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com> <201103111123.21063.arnd@arndb.de> <AANLkTinYmXrn=UmJDcr-2aAN5jChfTTX9EebCu9xbibc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64793 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1CMOym (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 10:54:42 -0400
In-Reply-To: <AANLkTinYmXrn=UmJDcr-2aAN5jChfTTX9EebCu9xbibc@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Sunday 13 March 2011 14:00:04 Andrei Warkentin wrote:
> > If the latter two are not much different on the toshiba card, that
> > would be a simpler implementation, and more likely to be useful on
> > other cards.
> >
> 
> Revalidating the data now, along with some more tests, to get a better
> picture. It seems the more data I get, the less it makes sense :(.

I was already fearing that the change would only benefit low-level
benchmarks. It certainly helps writing small chunks to the buffer
that is meant for FAT32 directories, but at some point, the card
will have to write back the entire logical erase block, so you
might not be able to gain much in real-world workloads.

Of course, I also have only a very limited understanding of the
algorithm used in the Toshiba chip.

	Arnd
