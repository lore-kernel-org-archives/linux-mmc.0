From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: duplicated trial with same freq when
 mmc_rescan_try_freq()
Date: Fri, 13 May 2011 11:16:04 +0900
Message-ID: <4DCC9464.3020806@samsung.com>
References: <4DCB97F3.9060704@samsung.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1154C484@039-SN1MPN1-005.039d.mgd.msft.net>
 <m3fwokypzv.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36842 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab1EMCQE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 22:16:04 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL40038G3MB8A80@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 13 May 2011 11:15:55 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL4007CY3MKXB@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 13 May 2011 11:15:56 +0900 (KST)
In-reply-to: <m3fwokypzv.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Huang Changming-R66093 <R66093@freescale.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "andy.ross@windriver.com" <andy.ross@windriver.com>

Hi Chris..

My question is others..I agreed the using frequency table..

But my questions is this...
For example, if f_min is 300KHz, you can the below message.

mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
mmc1: mmc_rescan_try_freq: trying to init card at 300000 Hz
mmc1: mmc_rescan_try_freq: trying to init card at 300000 Hz

In other words, first init card with 400KHZ, 
but second/third to init with 300KHz. 
i think not necessary that try to initialize the two times with 300KHz.

I want to know your opinion..

Regards,
Jaehoon Chung

Chris Ball wrote:
> Hi,
> 
> On Thu, May 12 2011, Huang Changming-R66093 wrote:
>> The required min frequency (f_min) is 400KHz during identify stage, is
>> it necessary to use the frequency table (freqs[], including 300KHz,
>> 200KHz and 100KHz)?
> 
> Yes.  Some hardware is buggy/out of compliance with the spec.
> 
> - Chris.

