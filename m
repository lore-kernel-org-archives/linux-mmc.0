From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: mmci: Improve runtime PM support
Date: Mon, 24 Oct 2011 13:48:06 +0200
Message-ID: <4EA55076.2010701@stericsson.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com> <20111021173637.GG21648@n2100.arm.linux.org.uk> <CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com> <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com> <4EA51C4A.7040802@stericsson.com> <20111024090432.GA9893@n2100.arm.linux.org.uk> <4EA53181.2050700@stericsson.com> <20111024094203.GI9893@n2100.arm.linux.org.uk> <4EA538A3.9070501@stericsson.com> <20111024101416.GK9893@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:44734 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932109Ab1JXLsb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 07:48:31 -0400
In-Reply-To: <20111024101416.GK9893@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Rasmussen <sebras@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

>> Could you maybe elaborate a bit of how the power is controlled in the  
>> ARM dev boards? Would it be possible to control such a switch in "GPIO"  
>> manner instead? For example via the vdd_handler or similar?
>>
>> I will also think if and see if is feasible to re-design and see if this  
>> hole feature can be controlled by the variant struct instead. My feeling  
>> is although it can be kind of messy. But let's see...
> 
> The MCIPWR register contains two bits to control _the_ _power_ _state_.
> See Table A-4: the MCIPWR signal.  See section 2.2.2.  See section 3.3.1.
> 
> The MCIPWR signal controls the external power switch.  This is the only
> signal for it.  This is the only connection for it.  There is no other
> control form for this power switch.
> 

Then we are only left to use the variant struct I believe. In principle, 
a flag in the variant struct, could indicate whether it is OK to disable 
the vcore regulator and thus clear the MCIPWR when doing runtime_suspend.

How do you feel about this kind of approach to find a solution?

BR
Ulf Hansson
