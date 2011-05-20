From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Fri, 20 May 2011 13:38:29 +0900
Message-ID: <4DD5F045.90001@samsung.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-1-git-send-email-andreiw@motorola.com>
 <1303870235-29041-2-git-send-email-andreiw@motorola.com>
 <1303870235-29041-3-git-send-email-andreiw@motorola.com>
 <4DD48273.4060402@samsung.com>
 <BANLkTi=yJuEtN-SSokhp5CE_mCz9D9D5SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17594 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935208Ab1ETEie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 00:38:34 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLH00A7G8TF01M0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 May 2011 13:38:32 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLH00EJX8W8SJ@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 May 2011 13:38:32 +0900 (KST)
In-reply-to: <BANLkTi=yJuEtN-SSokhp5CE_mCz9D9D5SA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de, Kyungmin Park <kyungmin.park@samsung.com>

Hi Andrei,

Andrei Warkentin wrote:
> On Wed, May 18, 2011 at 9:37 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Andrei
>>
>> Andrei Warkentin wrote:
>>> CMD23-prefixed instead of open-ended multiblock transfers
>>> have a performance advantage on some MMC cards.
>>>
>> you mentioned about "some MMC cards".
>> Conversely, that means the some card didn't have a performance advantage?
>>
>> Did you find the performance advantage?
>> if you found the advantage and you can tell me,
>> i want to know what do you have the some MMC cards..
>>
> 
> I've tested this on a Sandisk eMMC where I saw as good as
> a 50% improvement on writes (30% real-life use cases). This was a
> SEM32G 4.3+ part.

Can you tell me your environment? buswidth, AP information, benchmark etc..
And if you have the performance result's data, can you share them?

Regards,
Jaehoon Chung
