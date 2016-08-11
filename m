From: Christoph Hellwig <hch@lst.de>
Subject: Re: [REGRESSION] Secure discard is broken
Date: Thu, 11 Aug 2016 16:05:33 +0200
Message-ID: <20160811140533.GA16543@lst.de>
References: <d0e18115-0b63-207f-4350-29d6a5085e52@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41623 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcHKOFf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Aug 2016 10:05:35 -0400
Content-Disposition: inline
In-Reply-To: <d0e18115-0b63-207f-4350-29d6a5085e52@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>, Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

> I made a few hacks that seemed to make it go but I expect there are more
> places to change:

That should be about it, and I did indeed forget about these places.
For the place where we hceck for multiple op types it would be nice
to use switch statements, though.
