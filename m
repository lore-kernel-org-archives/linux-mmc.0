From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH V2 0/4] Add MMC erase and secure erase
Date: Mon, 14 Jun 2010 14:10:06 +0300
Message-ID: <4C160E0E.4010802@nokia.com>
References: <4C14AC7E.6030308@nokia.com> <20100614080921.GA28316@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34600 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756044Ab0FNLKh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jun 2010 07:10:37 -0400
In-Reply-To: <20100614080921.GA28316@lst.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: "jens.axboe@oracle.com" <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Kyungmin Park <kmpark@infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

Christoph Hellwig wrote:
> On Sun, Jun 13, 2010 at 01:01:34PM +0300, Adrian Hunter wrote:
>> Hi
>>
>> Add ability to do MMC erase and secure erase operations from userspace,
>> using the BLKDISCARD ioctl and a newly created BLKSECDISCARD ioctl.
> 
> Have you done any measurement if the use of the block layer changes
> performance of the discard requests for you?

No.  For my purposes there will be only 1 discard request for the entire
device which will take several minutes to process, so block layer
performance is not a factor.

> I'd really prefer to
> send down the secure erase that way, too.  This could easily be done
> by having a DISCARD_SECURE rw flag, which just ORs another flag into
> the request type field.

Needs a bio flag, a request flag, setup the request flag based on the
bio flag, prevent merging secure and non-secure discards, prevent drivers
doing non-secure discards for secure discards.

Seems like a lot of little changes for something that no one wants.
Shouldn't it wait for someone to need it first?
