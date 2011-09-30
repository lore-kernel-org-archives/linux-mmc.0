From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add write/read function for DATA register
Date: Fri, 30 Sep 2011 19:01:09 +0900
Message-ID: <4E859365.8060601@samsung.com>
References: <4E857FE6.5020208@samsung.com> <4E8584EA.5000900@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:64166 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab1I3KBN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2011 06:01:13 -0400
Received: from epcpsbgm2.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSB007G5YHZ7FW0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Sep 2011 19:01:12 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSB00N9WYHZ1RA1@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 30 Sep 2011 19:01:11 +0900 (KST)
In-reply-to: <4E8584EA.5000900@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin.park@samsung.com, Will Newton <will.newton@imgtec.com>

Hi James.

> Can I suggest that instead of having 6 new macros with offset parameters
> from the reg parameter (after all, the caller can just add the offset to
> the reg argument just as easily), you simply store the data register
> offset (what is currently DATA+host->data_offset) instead of
> host->data_offset, and use that instead of DATA. That would be simpler
> and more readable.


Sure..i understood your suggestion. But i think that need check the
version-id. i will also consider more..:)

> 
> DATA should probably be defined as the most up to date value, and define
> another one for pre-240A versions.


Right. i wonder why changed the DATA register :(

Best Regards,
Jaehoon Chung
