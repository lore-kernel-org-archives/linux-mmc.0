From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 1/4] block: Allow drivers to implement BLKDISCARD and add
	BLKSECDISCARD
Date: Fri, 11 Jun 2010 16:52:11 +0900
Message-ID: <AANLkTilwsxBuqqQm8BTOXjP5AKpw4NSU8bWNCDxMqh6F@mail.gmail.com>
References: <4C081AEC.7010302@nokia.com>
	<20100610081950.GA15888@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35935 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868Ab0FKHwM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jun 2010 03:52:12 -0400
In-Reply-To: <20100610081950.GA15888@infradead.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jun 10, 2010 at 5:19 PM, Christoph Hellwig <hch@infradead.org> =
wrote:
> On Fri, Jun 04, 2010 at 12:13:16AM +0300, Adrian Hunter wrote:
>> SD/MMC cards provide an erase operation that is too inefficient to
>> allow file systems to use it, however it is still useful for
>> userspace tools because it is still 10 - 100 times faster than
>> writing zeroes. =A0Allow the MMC block driver to provide its own
>> BLKDISCARD implementation for this purpose.

I heard if we give trim command without proper align, it writes some
data to align its data.
then user data can be corrupt.
The main problem is we don't know exact used block at filesystem. so
user can corrupt their data easily.

And as you know each manufacturers use their own superpage and align.

>
> That's no good reason. =A0Almost all current SSD TRIM implementations
> have the same issue, that's why filesustems require the -o discard
> option to enabled it. =A0In addition I've not actually seen any numbe=
rs
> from you on a current kernel.

I hope to see the performance results. In my test, no improvement.

Thank you,
Kyungmin Park

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
