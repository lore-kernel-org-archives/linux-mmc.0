From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] Kernel NULL pointer dereference for mmc
Date: Wed, 13 Jul 2011 11:13:53 +0900
Message-ID: <4E1CFF61.7070701@samsung.com>
References: <4E1BCC49.6050708@samsung.com>
 <CAJ0pr18-UvxHwfWuVFy=TfLvWSbfRwAY1CL0EBh+fPOi6KPGRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:59215 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842Ab1GMCNi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2011 22:13:38 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LO900ANR26ON9J0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jul 2011 11:13:36 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LO900KRL26OCV@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 13 Jul 2011 11:13:36 +0900 (KST)
In-reply-to: <CAJ0pr18-UvxHwfWuVFy=TfLvWSbfRwAY1CL0EBh+fPOi6KPGRw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Per.

#iozone -az -i 0 -i 1 -i 2 -s 200m -U /mnt/mmc -f /mnt/mmc/test -e

/mnt/mmc is mounted /dev/mmcblk0p6 for EXT4 filesystem.

It's my command..i tested with both SDHCI and DW_MMC controller.
DW_MMC controller didn't find that error message.
But SDHCI controller always occurred that error.
I'm debugging for this issue..

If you have any doubts, plz let me know..

Regards,
Jaehoon Chung

Per Forlin wrote:
> On 12 July 2011 06:23, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi
>>
>> When I tested MMC card with IOzone, i found this message..
>> I tried to find what problem..but i didn't find yet..
>>
>> So i want to get mailing's help..Have ever seen the below message?
>> (using SDHCI controller, eMMC 4.41 card, 8-bit buswidth)
>>
>> I didn't applied about post_req/pre_req in sdhci.c.
>> (using latest kernel in mmc-tree)
>>
> It's fine to set post_req and pre_req to NULL (default value is NULL)
> Can you post the IOzone command line?
> I want to run the same IOzone command on Snowball and Pandaboard.
> 
> Thanks,
> Per
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

