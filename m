From: Mikus Grinbergs <mikus@bga.com>
Subject: Re: Memory replacement
Date: Sun, 13 Mar 2011 17:34:24 -0500
Message-ID: <4D7D4670.1050009@bga.com>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com>	<201103122351.07697.arnd@arndb.de>	<AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>	<201103131821.00762.arnd@arndb.de> <4D7D37C2.2030102@laptop.org>
Reply-To: mikus@bga.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail4.comsite.net ([205.238.176.238]:60566 "EHLO
	mail4.comsite.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab1CMWaW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 18:30:22 -0400
In-Reply-To: <4D7D37C2.2030102@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Richard A. Smith" <richard@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

> The tests have also helped expose other issues with things like sudden 
> power off.  In one case a SPO during a write would corrupt the card so 
> badly it became useless.  You could only recover them via a super secret 
> tool from the manufacturer.

Is there any "sledgehammer" process available to users without a super
secret tool ?

I've encountered SD cards which will be recognized as a device when
plugged in to a running XO-1 (though 'ls' of a filesystem on that SD
card is corrupt) -- but 'fdisk' is ineffective when I want to write a
new partition table (and 'fsck' appears to loop).  Since otherwise I'd
just have to throw the card away, I'd be willing to apply EXTREME
measures to get such a card into a reusable ("blank slate") condition.

mikus

