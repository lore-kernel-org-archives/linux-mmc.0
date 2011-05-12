From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] sdhci-s3c: fixed compiler error for renamed register
Date: Thu, 12 May 2011 11:26:17 +0900
Message-ID: <4DCB4549.7040108@samsung.com>
References: <4DCA3B54.3000607@samsung.com> <m3liyd2vl1.fsf@pullcord.laptop.org>
 <6C03668EAF45B747AF947A1603D1B300EBE0327C@SAUSEXMBP01.amd.com>
 <m3hb912tls.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53561 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1ELC0M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 22:26:12 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL2008189DR01D0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 11:26:10 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL200GTP9FMUY@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 12 May 2011 11:26:10 +0900 (KST)
In-reply-to: <m3hb912tls.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Nath, Arindam" <Arindam.Nath@amd.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kyungmin Park <kyungmin.park@samsung.com>

Thanks Chris..

Regards,
Jaehoon Chung

Chris Ball wrote:
> Hi,
> 
> On Wed, May 11 2011, Nath, Arindam wrote:
>> I am okay with your suggestion. I just changed the name as per the
>> SDHC3.0 spec.
> 
> Great, okay.  I've rebased "mmc: sd: add support for driver type
> selection" to remove that HOST_CONTROL->HOST_CONTROL1 change, and
> pushed it out to mmc-next now.
> 
> - Chris.

