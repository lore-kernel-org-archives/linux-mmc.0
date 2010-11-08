From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 8 Nov 2010 11:40:21 +0100
Message-ID: <4CD7D395.8040804@stericsson.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com> <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com> <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com> <AANLkTimWg_EE+hg__b0NW792szvY+4Rc_4XsjbHN_tJv@mail.gmail.com> <4CD7C4DB.7070105@stericsson.com> <C771C677-E21B-41FC-ABEE-DBEFEFA8569D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:34732 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754179Ab0KHKki (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 05:40:38 -0500
In-Reply-To: <C771C677-E21B-41FC-ABEE-DBEFEFA8569D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>

Philip Rakity wrote:
> On Nov 8, 2010, at 1:37 AM, Linus Walleij wrote:
>> - Card (including SDIO device) whitelisting.
> 
> do not understand the term whitelisting ..  please explain.

The idea would be to have a database with ID:s for cards
that may be gated. Any SDIO card not it this list would
not be gated.

>> - Host whitelisting - for the case where as gateable SDIO
>>  device is soldered to the bus.
>>
>> The first looks like big-ish so would be a separate patch, but a
>> host flag for the latter like MMC_CAP_GATE_SDIO can easily be
>> folded into a v10 of this patch.
> 
> Nico was not in favor of this.  He thought it best to have
> the core/ layer handle this.

My patch is indeed to the core?

This was to be a flag for explicitly letting the core
gate some specific hosts on the MMC bus, in the case
where you (when defining platform data) already know that
a gateable SDIO card was soldered hardly onto a certain
host.

Anyway, if we have such needs they can be fixed later.

Yours,
Linus Walleij
