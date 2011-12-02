From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc0: Too large timeout requested for CMD38!
Date: Fri, 02 Dec 2011 10:32:28 +0900
Message-ID: <4ED82AAC.4030402@samsung.com>
References: <CAC=G6szdK=6wR4xiZk9mhBofEf7DHeuAcpeeTiVCdiK1aUyeOw@mail.gmail.com>
 <CAC=G6swWj3=eUYUczCqcNJq7Nj177nis4817+bg-qS0dUic=Xg@mail.gmail.com>
 <878vmwmarg.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62915 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab1LBBcc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 20:32:32 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVJ009XQYVDT790@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Dec 2011 10:32:31 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVJ00J0PYY6RJ00@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Dec 2011 10:32:31 +0900 (KST)
In-reply-to: <878vmwmarg.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Schilling <paul.s.schilling@gmail.com>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

Hi Chris.

i didn't know this error is related with s3c.

When swapon is performing, i know the card is run the discard.
(mm/swapfile.c about line 2050? run discard_swap())

At that time, This SD card's erase_time_out should be too big,so this message may be produced.

If i can get the more information, very helpful to me for debugging whether this problem is s3c or not.
(What is SD-card's vendor?)

Thanks

Best Regards,
Jaehoon Chung

On 12/02/2011 03:01 AM, Chris Ball wrote:

> Hi Jaehoon, Kyungmin, Kukjin,
> 
> On Fri, Nov 18 2011, Paul Schilling wrote:
>> I am getting the following error when trying to use a swap file on a
>> large 32GB SD card formated with EXT4.
>>
>> Thanks,
>> Paul Schilling
>>
>> Swap file /external_flash_a/swap_file being enabled.
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> mmc0: Too large timeout requested for CMD38!
>> Adding 131068k swap on /external_flash_a/swap_file.  Priority:-1
>> extents:3 across:135104k SS
>>
>> Linux version 3.2.0-rc2+ (#######) (gcc version 4.3.3 (GCC) ) #77
>> PREEMPT Fri Nov 18 13:37:37 CST 2011
>> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
>> CPU: VIVT data cache, VIVT instruction cache
>> Machine: CONDOR2416
>> [..]
> 
> Any thoughts on this s3c error?
> 
> Thanks,
> 
> - Chris.


