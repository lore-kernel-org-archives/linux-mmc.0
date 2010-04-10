From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: How to make kernel block layer generate bigger request in the
 request queue?
Date: Sat, 10 Apr 2010 09:58:23 -0500
Message-ID: <1270911503.2806.194.camel@mulgrave.site>
References: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
	 <4BBFBE3E.5070605@gmail.com>  <yq1y6gwt62p.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <yq1y6gwt62p.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 2010-04-09 at 22:05 -0400, Martin K. Petersen wrote:
> >>>>> "Robert" == Robert Hancock <hancockrwd@gmail.com> writes:
> 
> >> Did I miss something to make the block layer generate bigger size
> >> data for every request in the request queue?  Below is part of my
> >> source code. Any comments are highly appreciated. Thank you in
> >> advance.
> 
> Robert> 8 sectors is 4KB, that's the size of a page. If the pages that
> Robert> are being written are not physically contiguous that may be the
> Robert> best the block layer can do with the constraints you've given it
> Robert> (not supporting any more than 1 DMA segment). 
> 
> Correct.  It's quite unlikely for pages to be contiguous so this is the
> best we can do.

Actually, average servers do about 50% contiguous on average since we
changed the mm layer to allocate in ascending physical page order ...
this figure is highly sensitive to mm changes though, and can vary from
release to release.

Just in case anyone is thinking of it, there's no way we'd alter the
block layer to copy into physically contiguous since the overhead would
be pretty horrific.  However, if the platform has an iommu, you can use
it to map physically discontinuous to bus contiguous and fit everything
into a single sg element.

> Having recently done a cleanup of our segment handling I became aware
> that there are many MMC devices that are single-element only.  This was
> probably a sufficient approach for 32MB devices but it's time to get
> with the program and implement proper scatter-gather.

James


