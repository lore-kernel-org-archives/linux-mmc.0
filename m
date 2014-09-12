From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc:  eMMC BKOPS status handling lock for non urgent case
Date: Fri, 12 Sep 2014 11:45:28 +0900
Message-ID: <54125E48.7030603@samsung.com>
References: <5400AF04.2040708@tqsc.de> <5406731D.8000802@samsung.com>
 <540D65B5.3010206@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:40800 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaILCpa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Sep 2014 22:45:30 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBR00IRJOZSEBB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 12 Sep 2014 11:45:28 +0900 (KST)
In-reply-to: <540D65B5.3010206@tqsc.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markus Niebel <list-09_linux-mmc@tqsc.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On 09/08/2014 05:15 PM, Markus Niebel wrote:
> Hello Jaehoon Chung
> 
> Am 03.09.2014 03:47, wrote Jaehoon Chung:
>> Hi, Markus
>>
>> Sorry for replying too late.
>>
>> On 08/30/2014 01:49 AM, Markus Niebel wrote:
>>> Hello,
>>>
>>> experimenting with the current BKOPS code we found, that when triggering from BKOPS_LEVEL 1,
>>> the status stored with mmc_card_set_doing_bkops is never reset preventing BKOPS from working.
>> In now, bkops is working for upper case than LEVEL_2 (urgent case).
>> Patch of LEVEL_1's case has sent at mailing, maybe you can found it.
> 
> I will look for it.
> 
>>
>>>
>>> Since I'm not an expert in the mmc subsystem I ask for a hint where to look for completion
>>> and implement proper status reset.
>>
>> Could you explain to me more?
> 
> If starting BKOPS with BKOPS_LEVEL 1 a switch (CMD6) without wait for completion (status polling)
> is issued an a status variable is set. I did'nt find a place where this status is reset.

You means when BKOPS_LEVEL_1 is set, this status didn't reset anywhere, right?
I didn't know why this value needs to reset.
Before starting BKOPS, always read the bkops-status from card's ext_csd register.
Then it should be re-assigned to the new status value.

we didn't refer to bkops-status for starting bkops or not.

Best Regards,
Jaehoon Chung

> 
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>> Thanks in advance
>>>
>>> Markus Niebel
>>>
>  
> Best Regards,
> Markus Niebel
> 

