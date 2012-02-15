From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Wed, 15 Feb 2012 19:55:22 +0900
Message-ID: <4F3B8F1A.4050601@samsung.com>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F39F785.9070206@samsung.com>
 <E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
 <4F3A1BD4.3010601@samsung.com> <m2mx8lihzs.fsf@bob.laptop.org>
 <E2E6AC6BFAD06343BA2D97432459C1B60723E982CA@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45699 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab2BOKzZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 05:55:25 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZF00BQYKZQYQC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Feb 2012 19:55:24 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZF00M7HL0BE650@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Feb 2012 19:55:23 +0900 (KST)
In-reply-to: <E2E6AC6BFAD06343BA2D97432459C1B60723E982CA@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan RUDHOLM <johan.rudholm@stericsson.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Kyungmin Park <kyungmin.park@samsung.com>

On 02/15/2012 12:31 AM, Johan RUDHOLM wrote:

> Hi Chris, Jaehoon,
> 
> Chris Ball wrote:
> 
>>
>> Hi,
>>
>> On Tue, Feb 14 2012, Jaehoon Chung wrote:
>>> What kernel version is supported? up to linux-3.3? did you know?
>>
>> I think the only requirement is the command submission ioctl, so it
>> should work in every kernel from 3.0 onwards.
> 
> Actually, to be able to write to the ext csd via the ioctl, "mmc: core: check for zero length ioctl data" is also required. I think this went into 3.3-rc1.

Hi..Chris, Johan.

I think that mmc extcsd read/write <device> is something wrong..
If mmc extcsd write /dev/mmcblk0, then boot area1/2 is power-on-write-protect. right?
And i ran mmc extcsd read /dev/mmcblk0, and i printed the ext_csd[174](BOOT_WP_STATUS)
That's always 0x0.

That means Boot-area1/2 is not protected.
In do_write_extcsd(), i think that check with BOOT_WP_STATUS[174] whether protected or not.
not BOOT_WP[173].

How think about?

I will send the patch for this.

Best Regards,
Jaehoon Chung

> 
> Kind regards, Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


