From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC} sdhci.c set_ios -- disable global interrupts and Question
 on Power Management
Date: Mon, 14 Feb 2011 12:44:49 -0800
Message-ID: <70D5B8A0-2EC9-4CA1-8350-B44E5A07D779@marvell.com>
References: <7953F5A4-7BFA-4E40-8202-C682C0314F49@marvell.com>
 <AANLkTimh2cZbtnoSLQ7ddq9hFxx7ddfM-NJmaS1f=pXh@mail.gmail.com>
 <447896B1-8836-4DFE-A00D-D41C395C79FC@marvell.com>
 <B040EC60-E156-4863-A735-15876F835FA1@marvell.com>
 <AANLkTikYYo4bJxQEa3+p=gE8iKNHxxbv7JPjB6vnywrs@mail.gmail.com>
 <E5D06E6B-BE70-4446-9F56-32982C119FC0@marvell.com>
 <8250E4885F9967469CAC3FB5CBA2CE69935205E445@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47403 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751506Ab1BNUrO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 15:47:14 -0500
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69935205E445@irsmsx501.ger.corp.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Pierre,

The spin_lock may not be needed if the same thread cannot be re-entered.

That was the reason for the assumptions.  Sorry about not being clear.

Philip

On Feb 14, 2011, at 10:41 AM, Tardy, Pierre wrote:

> Philip,
>>> And, more important, you will do cond_resched while holding you
>>> spinlock, which is *bad*.
>>> What if the mmc stack will call you again from another thread? deadlock...
> 
>> Assumptions -- Please Confirm
>> -------------------------------------------
> No need to do assumptions, schedule while holding spinlocks is bad, your kernel will oops with something like:
> BUG: scheduling while in atomic.
> 
> 
>>>> @@ -1108,7 +1108,7 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
>>>>        * can apply clock after applying power
>>>>        */
>>>>       if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
>>>> -               mdelay(10);
>>>> +               mmc_delay(10);
>>> Do you need this quirk in your platform?
>> 
>> No
> Then, you dont have any mdelay in your set_ios, and you are trying to optimize something that never happen.
> 
> Pierre
> 
> ---------------------------------------------------------------------
> Intel Corporation SAS (French simplified joint stock company)
> Registered headquarters: "Les Montalets"- 2, rue de Paris, 
> 92196 Meudon Cedex, France
> Registration Number:  302 456 199 R.C.S. NANTERRE
> Capital: 4,572,000 Euros
> 
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
> 

