From: Markus Niebel <list-09_linux-mmc@tqsc.de>
Subject: Re: mmc:  eMMC BKOPS status handling lock for non urgent case
Date: Mon, 15 Sep 2014 15:13:39 +0200
Message-ID: <5416E603.7050406@tqsc.de>
References: <5400AF04.2040708@tqsc.de> <5406731D.8000802@samsung.com> <540D65B5.3010206@tqsc.de> <54125E48.7030603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:47832 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbaIONG4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Sep 2014 09:06:56 -0400
In-Reply-To: <54125E48.7030603@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hello,
Am 12.09.2014 um 04:45 schrieb Jaehoon Chung:
> Hi,
> 
> On 09/08/2014 05:15 PM, Markus Niebel wrote:
>> Hello Jaehoon Chung
>>
>>>> Hello,
>>>>
>>>> experimenting with the current BKOPS code we found, that when triggering from BKOPS_LEVEL 1,
>>>> the status stored with mmc_card_set_doing_bkops is never reset preventing BKOPS from working.
>>> In now, bkops is working for upper case than LEVEL_2 (urgent case).
>>> Patch of LEVEL_1's case has sent at mailing, maybe you can found it.
>>
>> I will look for it.
>>
>>>
>>>>
>>>> Since I'm not an expert in the mmc subsystem I ask for a hint where to look for completion
>>>> and implement proper status reset.
>>>
>>> Could you explain to me more?
>>
>> If starting BKOPS with BKOPS_LEVEL 1 a switch (CMD6) without wait for completion (status polling)
>> is issued an a status variable is set. I did'nt find a place where this status is reset.
> 
> You means when BKOPS_LEVEL_1 is set, this status didn't reset anywhere, right?
> I didn't know why this value needs to reset.
> Before starting BKOPS, always read the bkops-status from card's ext_csd register.
> Then it should be re-assigned to the new status value.
> 
> we didn't refer to bkops-status for starting bkops or not.
> 

in drivers/mmc/core/core.c:

void mmc_start_bkops(struct mmc_card *card, bool from_exception)

a driver internal status is checked with mmc_card_doing_bkops(card)
and in case the state is set nothing will be done

At the end of the function the state is set with mmc_card_set_doing_bkops(card)
for the non urgent case

The state is only reset from mmc_stop_bkops which is only called from _mmc_suspend

> Best Regards,
> Jaehoon Chung


Best Regards,
Markus Niebel

