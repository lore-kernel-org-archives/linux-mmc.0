From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] dw_mmc: didn't support multiple blocks of weird length?
Date: Mon, 28 Feb 2011 11:44:33 +0900
Message-ID: <4D6B0C11.8080503@samsung.com>
References: <4D675BA4.4040006@samsung.com>
 <AANLkTi=a+4e-DnVNoYjrLzBBzkFMu2yJutpO8kkNnuPm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62730 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1B1Coj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Feb 2011 21:44:39 -0500
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHB000DX3ME9B80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Feb 2011 11:44:38 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHB00H7C3MEBW@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Feb 2011 11:44:38 +0900 (KST)
In-reply-to: <AANLkTi=a+4e-DnVNoYjrLzBBzkFMu2yJutpO8kkNnuPm@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>

Right...maybe not problem merging those two functions.
But think not use list_add_tail(&slot->queue_node, &host->queue)..

I want to know when use list_add_tail functions..in this code.

Regards,
Jaehoon Chung


Will Newton wrote:
> On Fri, Feb 25, 2011 at 7:35 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi..
>>
>> I didn't understand this point..
>> Plz let me explain this code..
>> why need this function (dw_mci_queue_request(host, slot, mrq)?
> 
> I don't think there would be any problem merging those two functions.
> Also I would be happy to see the comment deleted, it doesn't really
> make sense.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

