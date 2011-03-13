From: "Richard A. Smith" <richard@laptop.org>
Subject: Re: Memory replacement
Date: Sun, 13 Mar 2011 17:31:46 -0400
Message-ID: <4D7D37C2.2030102@laptop.org>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com>	<201103122351.07697.arnd@arndb.de>	<AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com> <201103131821.00762.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57245 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab1CMVbu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2011 17:31:50 -0400
Received: by vxi39 with SMTP id 39so3866178vxi.19
        for <linux-mmc@vger.kernel.org>; Sun, 13 Mar 2011 14:31:50 -0700 (PDT)
In-Reply-To: <201103131821.00762.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "C. Scott Ananian" <cscott@laptop.org>, Kevin Gordon <kgordon420@gmail.com>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On 03/13/2011 01:21 PM, Arnd Bergmann wrote:

>>> Do you have test results somewhere publically available? We are currently
>>> discussing adding some tweaks to the linux mmc drivers to detect cards
>>> with certain features, and to do some optimizations in the block layer
>>> for common ones.
>>
>> http://wiki.laptop.org/go/NAND_Testing
>
> Ok, so the "testing" essentially means you create an ext2/3/4 file system
> and run tests on the file system until the card wears out, right?

The qualifying test is that the card must pass 3TB of writes with no 
errors.  We run that on samples from the various mfg's.

There's a 2nd round of test(s) that runs during the manufacturing and 
burn-in phases. One is a simple firmware test to see if you can talk the 
card at all and then one runs at burn in.  It doesn't have a minimum 
write size criteria but during the run there must not be any bit errors.

> It does seem a bit crude, because many cards are not really suitable
> for this kind of file system when their wear leveling is purely optimized
> to the accesses defined in the sd card file system specification.
>
> If you did this on e.g. a typical Kingston card, it can have a write
> amplification 100 times higher than normal (FAT32, nilfs2, ...), so
> it gets painfully slow and wears out very quickly.

Crude as they are they have been useful tests for us.  Our top criteria 
is reliability.  We want to ship the machines with a SD card thats going 
to last for the 5 year design life using the filesystem we ship.  We 
tried to create an access pattern was the worst possible and the highest 
stress on the wear leveling system.

If a card pases the 3TB abuse test then we are pretty certain its going 
to meet that goal.  There were many cards that died very quickly.

The tests have also helped expose other issues with things like sudden 
power off.  In one case a SPO during a write would corrupt the card so 
badly it became useless.  You could only recover them via a super secret 
tool from the manufacturer.

> I had hoped that someone already correlated the GC algorithms with
> the requirements of specific file systems to allow a more systematic
> approach.

At the time we started doing this testing none of the log structure 
filesystems were deemed to be mature enough for us to ship. So we didn't 
bother to try and torture test using them.

If more precision tests were created that still allowed us to make a 
reasonable estimate of data write lifetime we would be happy to start 
using them.

-- 
Richard A. Smith  <richard@laptop.org>
One Laptop per Child
