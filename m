From: John Watlington <wad@laptop.org>
Subject: Re: Memory replacement
Date: Mon, 14 Mar 2011 14:50:27 -0400
Message-ID: <CB98789C-76FD-4C0E-B7CA-FB41A3F32757@laptop.org>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com>	<201103122351.07697.arnd@arndb.de>	<AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>	<201103131821.00762.arnd@arndb.de>
	<4D7D37C2.2030102@laptop.org> <4D7D4670.1050009@bga.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@lists.laptop.org>
In-Reply-To: <4D7D4670.1050009@bga.com>
List-Unsubscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=unsubscribe>
List-Archive: <http://lists.laptop.org/pipermail/devel>
List-Post: <mailto:devel@lists.laptop.org>
List-Help: <mailto:devel-request@lists.laptop.org?subject=help>
List-Subscribe: <http://lists.laptop.org/listinfo/devel>,
	<mailto:devel-request@lists.laptop.org?subject=subscribe>
Sender: devel-bounces@lists.laptop.org
Errors-To: devel-bounces@lists.laptop.org
To: mikus@bga.com
Cc: "Richard A. Smith" <richard@laptop.org>, devel@lists.laptop.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On Mar 13, 2011, at 6:34 PM, Mikus Grinbergs wrote:

>> The tests have also helped expose other issues with things like sudden 
>> power off.  In one case a SPO during a write would corrupt the card so 
>> badly it became useless.  You could only recover them via a super secret 
>> tool from the manufacturer.
> 
> Is there any "sledgehammer" process available to users without a super
> secret tool ?

No.   Such software does exist for every controller, but it doesn't
necessarily use the SD interface as SD.

> I've encountered SD cards which will be recognized as a device when
> plugged in to a running XO-1 (though 'ls' of a filesystem on that SD
> card is corrupt) -- but 'fdisk' is ineffective when I want to write a
> new partition table (and 'fsck' appears to loop).  Since otherwise I'd
> just have to throw the card away, I'd be willing to apply EXTREME
> measures to get such a card into a reusable ("blank slate") condition.


Cards that are in the state you describe are most likely dead due to
running out of spare blocks.   There is nothing that can be done to
rehabilitate them, even using the manufacturer's secret code.
In a disturbing trend, most of the cards I've returned for failure analysis
in the past year have been worn out (and not just trashed meta-data
due to a firmware error).

Bummer,
wad
