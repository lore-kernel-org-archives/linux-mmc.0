From: Markus Niebel <list-09_linux-mmc@tqsc.de>
Subject: Re: mmc:  eMMC BKOPS status handling lock for non urgent case
Date: Mon, 08 Sep 2014 10:15:49 +0200
Message-ID: <540D65B5.3010206@tqsc.de>
References: <5400AF04.2040708@tqsc.de> <5406731D.8000802@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:48704 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbaIHIDA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Sep 2014 04:03:00 -0400
In-Reply-To: <5406731D.8000802@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hello Jaehoon Chung

Am 03.09.2014 03:47, wrote Jaehoon Chung:
> Hi, Markus
> 
> Sorry for replying too late.
> 
> On 08/30/2014 01:49 AM, Markus Niebel wrote:
>> Hello,
>>
>> experimenting with the current BKOPS code we found, that when triggering from BKOPS_LEVEL 1,
>> the status stored with mmc_card_set_doing_bkops is never reset preventing BKOPS from working.
> In now, bkops is working for upper case than LEVEL_2 (urgent case).
> Patch of LEVEL_1's case has sent at mailing, maybe you can found it.

I will look for it.

> 
>>
>> Since I'm not an expert in the mmc subsystem I ask for a hint where to look for completion
>> and implement proper status reset.
> 
> Could you explain to me more?

If starting BKOPS with BKOPS_LEVEL 1 a switch (CMD6) without wait for completion (status polling)
is issued an a status variable is set. I did'nt find a place where this status is reset. 

> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Thanks in advance
>>
>> Markus Niebel
>>
 
Best Regards,
Markus Niebel
