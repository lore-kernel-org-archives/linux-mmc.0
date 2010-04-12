From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: How to make kernel block layer generate bigger request in the request queue?
Date: Mon, 12 Apr 2010 14:26:41 -0400
Message-ID: <yq1d3y4msri.fsf@sermon.lab.mkp.net>
References: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
	<4BBFBE3E.5070605@gmail.com> <yq1y6gwt62p.fsf@sermon.lab.mkp.net>
	<1270911503.2806.194.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:63757 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0DLS2o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2010 14:28:44 -0400
In-Reply-To: <1270911503.2806.194.camel@mulgrave.site> (James Bottomley's
	message of "Sat, 10 Apr 2010 09:58:23 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Robert Hancock <hancockrwd@gmail.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>>>>> "James" == James Bottomley <James.Bottomley@suse.de> writes:

>> Correct.  It's quite unlikely for pages to be contiguous so this is
>> the best we can do.

James> Actually, average servers do about 50% contiguous on average
James> since we changed the mm layer to allocate in ascending physical
James> page order ...  this figure is highly sensitive to mm changes
James> though, and can vary from release to release.

Interesting.  When did this happen?

Last time I gathered data on segment merge efficiency (1 year+ ago) I
found that adjacent pages were quite rare for a normal fs type workload.
Certainly not in the 50% ballpark.  I'll take another look when I have a
moment...

-- 
Martin K. Petersen	Oracle Linux Engineering
