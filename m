From: Christoph Hellwig <hch@lst.de>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Tue, 8 Sep 2009 21:06:14 +0200
Message-ID: <20090908190614.GA18545@lst.de>
References: <c4e36d110908310451t7c238e09u5af112fa3321cc23@mail.gmail.com> <200908312119.12121.rjw@sisk.pl> <c4e36d110909010234i5f1b9357l805132137725a4f8@mail.gmail.com> <c4e36d110909031529q77b53122kdb85785ba293c478@mail.gmail.com> <20090903232317.GA6760@lst.de> <87ljkvmt71.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:55448 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbZIHTGv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Sep 2009 15:06:51 -0400
Content-Disposition: inline
In-Reply-To: <87ljkvmt71.fsf@devron.myhome.or.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Zdenek Kabelac <zdenek.kabelac@gmail.com>, Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

On Fri, Sep 04, 2009 at 09:47:46AM +0900, OGAWA Hirofumi wrote:
> Well, that commit seems a bit strange. It calls fat_clusters_flush()
> unconditionally without checking sb->s_dirt. However, if my guess is
> right, "sync after removed event" itself sounds like the issue in
> suspend process.

The idea of ->sync_fs is that we always perform the sync activity,
and not just the usual background superblock writeback trigerred by
s_dirt.  If FAT doesn't need that and never has races around s_dirt
you can add the check back, but I would recommend against it.

Also when you hack around this in FAt MMC will still fail with every
other filesystem.

