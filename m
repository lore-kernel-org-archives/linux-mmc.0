From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: fixed regulator control
Date: Wed, 11 May 2011 12:00:33 +0900
Message-ID: <4DC9FBD1.2000803@samsung.com>
References: <4DBA90BD.8070804@samsung.com> <m3iptv2027.fsf@pullcord.laptop.org>
 <4DBE62FE.6020402@samsung.com> <m3boza6neb.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61546 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab1EKDA2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2011 23:00:28 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL0003U8GCQPOI0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 May 2011 12:00:26 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL000DX0GCP5R@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 May 2011 12:00:25 +0900 (KST)
In-reply-to: <m3boza6neb.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>

Chris Ball wrote:
> Hi Jaehoon,
> 
> On Mon, May 02 2011, Jaehoon Chung wrote:
>> Hi Chris..
>>
>> Thanks for comments...
>> I think that could confuse that message when didn't set CONFIG_REGULATOR.
> 
> The message *does not appear* when CONFIG_REGULATOR is unset, because
> NULL -- which the regulator subsystem returns via the regulator_get()
> stub -- is not an IS_ERR().  Do you agree?

Thanks, I agreed that.
I'm interesting mailing's discussion about "[PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR "
(in this case, i think similar case)

> 
>> And i wonder how do you think about regulator control in suspend (dw_mmc.c)?
> 
> Yes, that patch looks correct, although I can't test it myself.  Please
> send it separately.

Ok. i will send that separately patch.

Regards,
Jaehoon Chung
