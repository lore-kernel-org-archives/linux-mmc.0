From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC/RFT] MMC: CORE: eMMC in Sleep mode before suspend
Date: Thu, 21 Jul 2011 23:12:26 +0300
Message-ID: <4E28882A.2020405@intel.com>
References: <1310567787-14697-1-git-send-email-balajitk@ti.com>	<CANfBPZ-dwv1e1JweRR5jFu2rLRxQCWd+ibuaN2RHv+gCZcQeOw@mail.gmail.com> <m21uxm9pym.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49807 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab1GUUM3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jul 2011 16:12:29 -0400
In-Reply-To: <m21uxm9pym.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

On 19/07/2011 7:48 p.m., Chris Ball wrote:
> Hi,
>
> On Tue, Jul 19 2011, S, Venkatraman wrote:
>> On Wed, Jul 13, 2011 at 8:06 PM, Balaji T K<balajitk@ti.com>  wrote:
>>> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
>>> in the mmc suspend to minimize power consumption.
>>>
>>> Signed-off-by: Balaji T K<balajitk@ti.com>
>> Balaji,
>>    Would you mind reposting the patch without the RFC and s/CORE/core
>> in subject line ?
>> You can add my
>> Acked-by: Venkatraman S<svenkatr@ti.com>
> No need to resend, thanks -- pushed to mmc-next with these changes and
> the ACK.
>
> Anyone object to letting this soak in mmc-next for a release and merging
> it in 3.2?  I'm worried that we'll find card or host quirks around this,
> and the 3.0 release is probably happening today.

eMMC often have VccQ (logic) always on (or sharing the same power as 
SDRAM which comes to the same thing), but can switch off Vcc (NAND 
core).  However, turning off Vcc without first putting the card to sleep 
can result in errors i.e. you are not allowed to do it.

This patch seems to be covering the "VccQ always on" case but relies on 
CMD0 to wake up the card.

If that is what is going on, then some comments to that effect are 
needed, including within mmc_init_card to note that mmc_go_idle is 
needed for cards that are asleep - if that is, in fact, correct.

Also, wouldn't it be nice to wake up the card with CMD5 which should be 
much faster than re-initialising?

> - Chris.

