From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/4] Add MMC erase and secure erase
Date: Mon, 14 Jun 2010 10:09:21 +0200
Message-ID: <20100614080921.GA28316@lst.de>
References: <4C14AC7E.6030308@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:51311 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753861Ab0FNIKY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jun 2010 04:10:24 -0400
Content-Disposition: inline
In-Reply-To: <4C14AC7E.6030308@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: jens.axboe@oracle.com, hch@lst.de, Andrew Morton <akpm@linux-foundation.org>, Kyungmin Park <kmpark@infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

On Sun, Jun 13, 2010 at 01:01:34PM +0300, Adrian Hunter wrote:
> Hi
> 
> Add ability to do MMC erase and secure erase operations from userspace,
> using the BLKDISCARD ioctl and a newly created BLKSECDISCARD ioctl.

Have you done any measurement if the use of the block layer changes
performance of the discard requests for you?  I'd really prefer to
send down the secure erase that way, too.  This could easily be done
by having a DISCARD_SECURE rw flag, which just ORs another flag into
the request type field.

