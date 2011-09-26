From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4] mmc: support HPI send command
Date: Mon, 26 Sep 2011 13:13:13 +0900
Message-ID: <4E7FFBD9.9030400@samsung.com>
References: <4E532DB1.4070301@samsung.com> <4E7ADE2D.4010007@samsung.com>
 <m21uv8232q.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63729 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab1IZENt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2011 00:13:49 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LS400C653QX1KN0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 13:13:47 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LS400GG63QZ6V40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Sep 2011 13:13:47 +0900 (KST)
In-reply-to: <m21uv8232q.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

Hi Chris.

This feature can use in eMMC4.41 device.
So if you have eMMC4.41 device, you can also test this feature.
(using my RFC-patch about BKOPS, maybe can simply test the HPI command)

Thanks,
Jaehoon Chung

Chris Ball wrote:

> Hi Jaehoon,
> 
> On Thu, Sep 22 2011, Jaehoon Chung wrote:
>> This feature is also used in eMMC4.41. So i want to know your opinion.
>> (In eMMC4.5, i known this feature is important)
>> If need more modification, i will do. if not, i want to merge this feature.
> 
> I don't have any eMMC 4.5 devices -- the patch looks plausible, but it
> would be nice to get a Tested-by from someone else who's tested it on
> different devices to you and wants to see it merged.
> 
> Thanks,
> 
> - Chris.


