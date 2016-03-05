From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/2] mmc, block: override default max_dev_sectors
Date: Sat, 05 Mar 2016 16:58:57 -0500
Message-ID: <yq1fuw44me6.fsf@sermon.lab.mkp.net>
References: <cover.1456847028.git.pawelx.wodkowski@intel.com>
	<20160302171227.GA5229@infradead.org>
	<07856956733C274AB06C493240019A2D76CDEC35@IRSMSX101.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:49534 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcCEV7Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2016 16:59:25 -0500
In-Reply-To: <07856956733C274AB06C493240019A2D76CDEC35@IRSMSX101.ger.corp.intel.com>
	(Mateusz Nowak's message of "Fri, 4 Mar 2016 10:49:29 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nowak, Mateusz" <mateusz.nowak@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Wodkowski, PawelX" <pawelx.wodkowski@intel.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>>>>> "Mateusz" == Nowak, Mateusz <mateusz.nowak@intel.com> writes:

>> Past commit 5f009d ("block: Initialize max_dev_sectors to 0"), this
>> should not be needed.

Mateusz> I missed the fix you mention while rebasing from rc3. Thus
Mateusz> apologies for providing incorrectly described and not
Mateusz> necessarily needed patch set.

Mateusz> However, since some drivers may still want to override
Mateusz> max_dev_sectors, would the patches be good to be redone and
Mateusz> resubmitted as improvement?

Nothing prevents you from setting max_dev_sectors in the driver. That's
why it's there. The default being set in my original patch just had the
unfortunate side-effect of clamping the controller limit.

-- 
Martin K. Petersen	Oracle Linux Engineering
