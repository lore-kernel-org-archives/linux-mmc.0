From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: How to make kernel block layer generate bigger request in the
 request queue?
Date: Tue, 13 Apr 2010 16:20:34 +0100
Message-ID: <20100413162034.445a388b@lxorguk.ukuu.org.uk>
References: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
	<4BBFBE3E.5070605@gmail.com>
	<yq1y6gwt62p.fsf@sermon.lab.mkp.net>
	<1270911503.2806.194.camel@mulgrave.site>
	<yq1d3y4msri.fsf@sermon.lab.mkp.net>
	<1271102309.4428.85.camel@mulgrave.site>
	<CE761E84DADF2947A4AF22FB8D97A4731CB7230B@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731CB7230B@shsmsx501.ccr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
To: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Cc: James Bottomley <James.Bottomley@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>, Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

> And I just curious why the block layer does not merge these contiguous sectors into one single request? For example, if > the block layer generate 'start_sect: 48776, nsect: 64, rw: r' instead of below requests, I think the performance will 
> be better.

You said earlier "My hardware doesn't support scatter/gather"

> start_sect: 48776, nsect: 8, rw: r
> start_sect: 48784, nsect: 8, rw: r
> start_sect: 48792, nsect: 8, rw: r
> start_sect: 48800, nsect: 8, rw: r
> start_sect: 48808, nsect: 8, rw: r
> start_sect: 48816, nsect: 8, rw: r
> start_sect: 48824, nsect: 8, rw: r
> start_sect: 48832, nsect: 8, rw: r

Print the bus address of each request and you will probably find they are
not contiguous so they have not been merged because your hardware could
not do that transfer and you have no IOMMU.

If the overhead per command is really really huge you can preallocate an
internal buffer of say 32K or 64K in your driver and tell the block layer
you do scatter gather, then copy the buffers into a linear chunk. I'd be
very surprised if that was a win overall on any vaguely sane hardware but
flash with erase block overhead and the like might be one of the less
sane cases.

Alan
