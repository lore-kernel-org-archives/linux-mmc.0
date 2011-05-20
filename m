From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] mmc_test: how use mmc_test on only eMMC board
Date: Fri, 20 May 2011 10:39:11 +0900
Message-ID: <4DD5C63F.6030405@samsung.com>
References: <4DD4A23F.10400@samsung.com> <m3vcx6d9ey.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54158 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934674Ab1ETBjP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 21:39:15 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLH002FM0L4EQ10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 May 2011 10:39:14 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLH003QU0LDP2@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 May 2011 10:39:13 +0900 (KST)
In-reply-to: <m3vcx6d9ey.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

Chris Ball wrote:
> Hi,
> 
> On Thu, May 19 2011, Jaehoon Chung wrote:
>> Hi mailing..
>>
>> I want to know how use mmc_test..
>>
>> In my case, i used only eMMC board.
>> So i didn't use unbind/bind for mmc_test.
>>
>> echo mmc0:0001 > /sys/bus/mmc/drivers/mmcblk/unbind
>> then rootfs of my board has be broken 
> 
> mmc_test destroys the data on the card being tested, so there is no way
> to use it on your active rootfs.
> 
> You would have to boot from external SD (or USB, or network, or
> something else) in order to run it on your internal eMMC.  If you do
> this, first make sure your eMMC doesn't contain any data needed to boot
> your system far enough to be able to boot a kernel from another device.
> 
Thanks for your comment. i know that i can use SD-boot in order to use mmc_test.
but if there is other method, i want to know them.
I try to boot with SD-card..

Thanks Chris. :)

Regards,
Jaehoon Chung

