From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: enable BKOPS for supported eMMC(4.41)
Date: Wed, 04 Sep 2013 11:34:18 +0900
Message-ID: <52269C2A.2030105@samsung.com>
References: <loom.20130830T140917-496@post.gmane.org>
 <52242F31.4030103@samsung.com> <loom.20130903T105514-341@post.gmane.org>
 <CAOprVPLx1NR37YJOYzXSkQ7w70o5kWp0dbKdn0OzCr_0B7TkUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62138 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756378Ab3IDCeC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 22:34:02 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSK007LHXSIT4F0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 04 Sep 2013 11:34:00 +0900 (KST)
In-reply-to: <CAOprVPLx1NR37YJOYzXSkQ7w70o5kWp0dbKdn0OzCr_0B7TkUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nitin Singla <nitin.akshainie@gmail.com>
Cc: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>, linux-mmc@vger.kernel.org

Hi Prasanna,

You can refer to

http://permalink.gmane.org/gmane.linux.kernel.mmc/15430

Best Regards,
Jaehoon Chung

On 09/03/2013 06:34 PM, Nitin Singla wrote:
> Hi Prasanna,
> 
> MMC-Utils open source utility for enabling and disabling features.
> It use ioctl defined in block/card to send commands to host.
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc-utils.git
> 
> Thanks,
> Nitin
> 
> On Tue, Sep 3, 2013 at 2:28 PM, Prasanna NAVARATNA
> <prasanna.navaratna@gmail.com> wrote:
>> Hello Jaehoon,
>>
>>> Why do you use MMC_CAP2_BKOPS_EN?
>> Because BKOPS on eMMC4.41 is optional. So the capability is provided for the
>> platform to either enable/disable this feature (its not mandatory to always
>> enable BKOPS on 4.41)
>>
>>> Maybe we had discussed about this point. i know that we can enable the
>> BKOPS with the mmc-util.
>>> (Actually, This code had included into my first patch. but it's removed.)
>> I'm not aware of this discussion and currently I'm running on eMMC4.41 and
>> bkops is supported but not enabled. So i suggested this patch.
>> Do you mean to say, right now, i can enable it using mmc-utils?
>> Will you please elaborate?
>>
>> Thanks,
>> Prasanna
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

