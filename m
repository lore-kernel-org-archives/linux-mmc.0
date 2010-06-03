From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC] [PATCH 1/2] mmc: split mmc_sd_init_card()
Date: Thu, 03 Jun 2010 13:21:23 -0400
Message-ID: <m3hblk8224.fsf@pullcord.laptop.org>
References: <1-1000-12432-1274803827-7569@rere.qmqm.pl>
	<20100528144027.3c868841.akpm@linux-foundation.org>
	<20100531155846.GA9493@rere.qmqm.pl> <4C0774A8.2030704@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43960 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289Ab0FCRUZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jun 2010 13:20:25 -0400
In-Reply-To: <4C0774A8.2030704@nokia.com> (Adrian Hunter's message of "Thu, 03
	Jun 2010 12:23:52 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

   > That is a bit vague.  An SD card is a memory.  An SDIO "card" is
   > an I/O connection made using the same physical interface as an SD
   > card and a very similar protocal to SD cards (at least with
   > respect to reading and writing).  I do not understand how a card
   > can be SD and SDIO.  Are you sure you are not talking about a
   > controller that supports SD and SDIO?  A lot of controllers do
   > that.

Adrian, I presume we're talking about something like:

http://www.arasan.com/products/sd/SD-Combo-Flyer.pdf

Micha=C5=82, could you let us know which SD-combo device(s) in particul=
ar
you've been working with?

- Chris.
--=20
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
