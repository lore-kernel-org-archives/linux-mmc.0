From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
Date: Thu, 05 Sep 2013 22:03:38 +0900
Message-ID: <5228812A.2040301@samsung.com>
References: <loom.20130830T140917-496@post.gmane.org>
 <52242F31.4030103@samsung.com> <loom.20130903T105514-341@post.gmane.org>
 <CAOprVPLx1NR37YJOYzXSkQ7w70o5kWp0dbKdn0OzCr_0B7TkUQ@mail.gmail.com>
 <52269C2A.2030105@samsung.com> <loom.20130905T110125-516@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46525 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab3IENDT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2013 09:03:19 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSN0038ILLG9020@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Sep 2013 22:03:17 +0900 (KST)
In-reply-to: <loom.20130905T110125-516@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 09/05/2013 06:12 PM, Prasanna NAVARATNA wrote:
> Hello,
>  
>> http://permalink.gmane.org/gmane.linux.kernel.mmc/15430
> This link mentions that BKOPS_EN 163bit in EXT_CSD is one-time programmable
> flag but from JEDEC Standard No. 84-A441 spec, it is R/W bit. Please
> re-confirm about the statement.
R/W bit is one-time programmable and readable. what do you mean?
> 
> 
>>> MMC-Utils open source utility for enabling and disabling features.
>>> It use ioctl defined in block/card to send commands to host.
>>> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
> 
> I am not able to find this git in my platform repo. 
> Is this mmc-utils git mandatory to have? 
> What if, somebody don't have it and need to enabled BKOPS for eMMMC4.41?
> Is mmc-utils the only way to enable BKOPS?
If you want to enable the bkops, then you can use your patch at your local repo, not mainline.

Best Regards,
Jaehoon Chung
> 
> Regards,
> Prasanna NAVARATNA
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

