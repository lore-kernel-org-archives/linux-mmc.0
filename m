From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Thu, 19 May 2011 11:37:39 +0900
Message-ID: <4DD48273.4060402@samsung.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-2-git-send-email-andreiw@motorola.com>
 <1303870235-29041-3-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26047 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab1ESCho (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 22:37:44 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLF00C6R8MOHGE0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 May 2011 11:37:42 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLF0079Y8MULO@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 19 May 2011 11:37:42 +0900 (KST)
In-reply-to: <1303870235-29041-3-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>

Hi Andrei

Andrei Warkentin wrote:
> CMD23-prefixed instead of open-ended multiblock transfers
> have a performance advantage on some MMC cards.
> 
you mentioned about "some MMC cards". 
Conversely, that means the some card didn't have a performance advantage?

Did you find the performance advantage? 
if you found the advantage and you can tell me, 
i want to know what do you have the some MMC cards..

Regards,
Jaehoon Chung
