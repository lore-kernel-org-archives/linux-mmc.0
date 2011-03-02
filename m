From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] dw_mmc: didn't support multiple blocks of weird length?
Date: Wed, 02 Mar 2011 12:01:12 +0900
Message-ID: <4D6DB2F8.5090801@samsung.com>
References: <4D675BA4.4040006@samsung.com>
 <AANLkTi=a+4e-DnVNoYjrLzBBzkFMu2yJutpO8kkNnuPm@mail.gmail.com>
 <4D6B0C11.8080503@samsung.com>
 <AANLkTi=cjeHKnHX0pbEnuaEo4EDj_vECRBDdUtWP9Z9D@mail.gmail.com>
 <4D6B7F3A.9040905@samsung.com>
 <AANLkTin32J=VAZXQfxYL4wME4Z4uBO=fKHRgHWBnZ=n+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60681 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757201Ab1CBDBl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 22:01:41 -0500
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHE00DZLTQ1W840@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 02 Mar 2011 12:01:13 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHE002TITQ2KX@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 02 Mar 2011 12:01:14 +0900 (KST)
In-reply-to: <AANLkTin32J=VAZXQfxYL4wME4Z4uBO=fKHRgHWBnZ=n+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>

Will Newton wrote:
> On Mon, Feb 28, 2011 at 10:55 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Will Newton wrote:
>>> On Mon, Feb 28, 2011 at 2:44 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Right...maybe not problem merging those two functions.
>>>> But think not use list_add_tail(&slot->queue_node, &host->queue)..
>>>>
>>>> I want to know when use list_add_tail functions..in this code.
>>> I think that code is from the original NXP driver and appears to be
>>> used to support multiple slots attached to the same block (so you can
>>> be asked to process a request for slot A while the block is busy
>>> processing an earlier request for slot B). I don't have any hardware
>>> setup like this, everything I have has only a single slot so I don't
>>> believe I have ever seen that branch of the conditional execute.
>> Oh..i also used only single slot..i want to remove spinlock_bh()..
>> because if we used a only single slot, i think that spinlock_bh() not need..
>> how think about this?
> 
> I'm not convinced that removing the multiple slot functionality will
> allow you to remove the spin_lock_bh, it looks like the lock may be
> protecting more than just the queue. Why do you want to remove the
> spinlock?

I should not remove the spin_lock_bh in using multiple slot.
If i use only one slot, i asked that need spin_lock_bh()?
I think if we assume using one slot,need not them..(using quirks instead of removing them)

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

