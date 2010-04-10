From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: How to make kernel block layer generate bigger request in the request queue?
Date: Fri, 09 Apr 2010 22:05:50 -0400
Message-ID: <yq1y6gwt62p.fsf@sermon.lab.mkp.net>
References: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
	<4BBFBE3E.5070605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:51075 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab0DJCGO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Apr 2010 22:06:14 -0400
In-Reply-To: <4BBFBE3E.5070605@gmail.com> (Robert Hancock's message of "Fri,
	09 Apr 2010 17:54:38 -0600")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: "Gao, Yunpeng" <yunpeng.gao@intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>>>>> "Robert" == Robert Hancock <hancockrwd@gmail.com> writes:

>> Did I miss something to make the block layer generate bigger size
>> data for every request in the request queue?  Below is part of my
>> source code. Any comments are highly appreciated. Thank you in
>> advance.

Robert> 8 sectors is 4KB, that's the size of a page. If the pages that
Robert> are being written are not physically contiguous that may be the
Robert> best the block layer can do with the constraints you've given it
Robert> (not supporting any more than 1 DMA segment). 

Correct.  It's quite unlikely for pages to be contiguous so this is the
best we can do.

Having recently done a cleanup of our segment handling I became aware
that there are many MMC devices that are single-element only.  This was
probably a sufficient approach for 32MB devices but it's time to get
with the program and implement proper scatter-gather.

-- 
Martin K. Petersen	Oracle Linux Engineering
