From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Tue, 14 Feb 2012 11:16:40 +0900
Message-ID: <4F39C408.6020501@samsung.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
 <m2mx8y6ls1.fsf@bob.laptop.org>
 <CAKLKtzeRHVeMemTytmaon0GsZ2GqXwz_M_CX6aTj+xDDgN7HVg@mail.gmail.com>
 <4F2F649E.2010106@samsung.com>
 <CAKLKtzcAqJVDTZFYpijicWStr7m76Quv2ic8hRZp+X_Wmd-bFQ@mail.gmail.com>
 <m2vcndks0m.fsf@bob.laptop.org>
 <CAKLKtzdr68J7wF6m9wpCaXh3_XnL6y9tid2g4yzwxVVPgLndGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28796 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2BNCQm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2012 21:16:42 -0500
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZD00L7H2B84WC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 11:16:41 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZD009WX2BS2H50@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 11:16:40 +0900 (KST)
In-reply-to: <CAKLKtzdr68J7wF6m9wpCaXh3_XnL6y9tid2g4yzwxVVPgLndGA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 02/14/2012 05:37 AM, Saugata Das wrote:

> On 12 February 2012 02:27, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Mon, Feb 06 2012, Saugata Das wrote:
>>> Thanks for the info. Perhaps the initial MMC-4.5 device samples do not
>>> implement this command well. Yes, this feature is good to have in the
>>> kernel. I shall wait for some more comments on the proposed
>>> implementation before submitting the patch.
>>
>> I'm not very excited about merging features that offer no concrete
>> benefit, because it just grows the kernel (and list of places where bugs
>> can occur) for no benefit.  So, it would be great if we could find a
>> device that actually implements these contexts in a way that provides
>> a performance benefit, to prove that adding the code is worthwhile.
>>
> 
> Completely agree with you. The purpose of proposing this
> implementation under [RFC] was to trigger some discussion on how this
> feature should be implemented.

I agreed, too. i think Saugata's patch isn't completely
we need the discussion to use this feature
I will also check what need for this..

Thanks,
Jaehoon Chung

> 
>> Thanks,
>>
>> - Chris.
>> --
>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


