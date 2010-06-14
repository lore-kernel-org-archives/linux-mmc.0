From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/4] Add MMC erase and secure erase
Date: Mon, 14 Jun 2010 13:21:50 +0200
Message-ID: <20100614112150.GA5364@lst.de>
References: <4C14AC7E.6030308@nokia.com> <20100614080921.GA28316@lst.de> <4C160E0E.4010802@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:34908 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874Ab0FNLWK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Jun 2010 07:22:10 -0400
Content-Disposition: inline
In-Reply-To: <4C160E0E.4010802@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Christoph Hellwig <hch@lst.de>, "jens.axboe@oracle.com" <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Kyungmin Park <kmpark@infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

On Mon, Jun 14, 2010 at 02:10:06PM +0300, Adrian Hunter wrote:
> Needs a bio flag, a request flag, setup the request flag based on the
> bio flag, prevent merging secure and non-secure discards, prevent drivers
> doing non-secure discards for secure discards.
> 
> Seems like a lot of little changes for something that no one wants.
> Shouldn't it wait for someone to need it first?

I know that some people have asked for this.  But if you want to keep
it in the driver for now that's fine to me.  But in that case please:

 (a) make it entirely driver private and leave no traces of it in the
     block layer
 (b) split it into a separate patch from the discard support
