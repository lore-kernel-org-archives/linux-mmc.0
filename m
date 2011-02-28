From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] dw_mmc: didn't support multiple blocks of weird length?
Date: Mon, 28 Feb 2011 19:55:54 +0900
Message-ID: <4D6B7F3A.9040905@samsung.com>
References: <4D675BA4.4040006@samsung.com>
 <AANLkTi=a+4e-DnVNoYjrLzBBzkFMu2yJutpO8kkNnuPm@mail.gmail.com>
 <4D6B0C11.8080503@samsung.com>
 <AANLkTi=cjeHKnHX0pbEnuaEo4EDj_vECRBDdUtWP9Z9D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49891 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740Ab1B1K4f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 05:56:35 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHB00CPYQDBW6B0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Feb 2011 19:55:59 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHB009O8QDBSU@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Feb 2011 19:55:59 +0900 (KST)
In-reply-to: <AANLkTi=cjeHKnHX0pbEnuaEo4EDj_vECRBDdUtWP9Z9D@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>

Will Newton wrote:
> On Mon, Feb 28, 2011 at 2:44 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Right...maybe not problem merging those two functions.
>> But think not use list_add_tail(&slot->queue_node, &host->queue)..
>>
>> I want to know when use list_add_tail functions..in this code.
> 
> I think that code is from the original NXP driver and appears to be
> used to support multiple slots attached to the same block (so you can
> be asked to process a request for slot A while the block is busy
> processing an earlier request for slot B). I don't have any hardware
> setup like this, everything I have has only a single slot so I don't
> believe I have ever seen that branch of the conditional execute.

Oh..i also used only single slot..i want to remove spinlock_bh()..
because if we used a only single slot, i think that spinlock_bh() not need..
how think about this?

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

