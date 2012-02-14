From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Tue, 14 Feb 2012 17:31:16 +0900
Message-ID: <4F3A1BD4.3010601@samsung.com>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F39F785.9070206@samsung.com>
 <E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22826 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab2BNIbU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2012 03:31:20 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZD0075TJO4HXU0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 17:31:18 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZD00AKXJO5FYG1@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 17:31:17 +0900 (KST)
In-reply-to: <E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan RUDHOLM <johan.rudholm@stericsson.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

On 02/14/2012 05:07 PM, Johan RUDHOLM wrote:

> Jaehoon Chung wrote:
> 
>> On 02/13/2012 02:03 AM, Chris Ball wrote:
>>
>>> Hi,
>>>
>>> I've created a repository for userspace mmc tools now:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
>>>
>>> At the moment the only commands supported are Johan Rudholm's extcsd
>>> write-protect commands, exposed as:
>>>
>>>    ./mmc extcsd read /dev/mmcblkX
>>>    ./mmc extcsd write /dev/mmcblkX
>>>
>>> Johan, when I try running these I'm seeing:
>>>
>>> octavius:cjb~/git/mmc-utils % sudo ./mmc extcsd read /dev/mmcblk0
>>> sdhci-pci 0000:0d:00.0: mmc_blk_ioctl_cmd: cmd error -110
>>> ioctl: Connection timed out
>>> Could not read EXT_CSD from /dev/mmcblk0
>>
>> I tested with SD and eMMC.
>> In eMMC case..
>>
>> /opt/home/root # mmc extcsd read /dev/mmcblk0
>> Power ro locking: possible
>> Permanent ro locking: possible
>> ro lock status: not locked
>>
>> But In SD card,
>> s3c-sdhci s3c-sdhci.2: mmc_blk_ioctl_cmd: cmd error -110
>> ioctl: Connection timed out
>> Could not read EXT_CSD from /dev/mmcblk1
>>
>> What differ? Anyway..It's great about mmc-utils.
> 
> Yes, this is expected -- SD cards don't have the ext csd register.

What kernel version is supported? up to linux-3.3? did you know?
Best Regards,
Jaehoon Chung

> 
> Kind regards, Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


