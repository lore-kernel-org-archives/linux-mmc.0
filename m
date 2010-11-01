From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] MMC Agressive clocking framework v6
Date: Mon, 01 Nov 2010 15:27:43 +0000
Message-ID: <4CCEDC6F.1020701@csr.com>
References: <1288383487-29860-1-git-send-email-linus.walleij@stericsson.com>	<4CCEA435.9030402@csr.com> <AANLkTiki-PGJHMcrRCwA46W+-xmj+AdpxLMFdd2mfdhM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:57001 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026Ab0KAP2H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2010 11:28:07 -0400
Received: from rly21d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly21d.srv.mailcontrol.com (MailControl) with ESMTP id oA1FS39Q016187
	for <linux-mmc@vger.kernel.org>; Mon, 1 Nov 2010 15:28:05 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly21d.srv.mailcontrol.com (MailControl) id oA1FRit2013242
	for <linux-mmc@vger.kernel.org>; Mon, 1 Nov 2010 15:27:44 GMT
In-Reply-To: <AANLkTiki-PGJHMcrRCwA46W+-xmj+AdpxLMFdd2mfdhM@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>

Linus Walleij wrote:
> 2010/11/1 David Vrabel <david.vrabel@csr.com>:
>> On 29/10/2010 21:18, Linus Walleij wrote:
>>> This patch modifies the MMC core code to optionally call the
>>> set_ios() operation on the driver with the clock frequency set
>>> to 0 (gate) after a grace period of at least 8 MCLK cycles, then
>>> restore it (ungate) before any new request. This gives
>>> the driver the option to shut down the MCI clock to the MMC/SD
>>> card when the clock frequency is 0, i.e. the core has stated
>>> that the MCI clock does not need to be generated.
>> With SDIO cards, 1 bit mode needs to be set on the controller otherwise
>> many controllers cannot detect card interrupts.
> 
> Do you mean generally, or just when disabling the clock?
> I don't quite get this part...

Just when disabling the clock.

>> Also some v2.00 SDIO cards in 4-bit mode will not generate card
>> interrupts unless they are clocked (the spec v2.00 doesn't require them
>> to be able to but v3.00 does).
> 
> OK I think it is better to disable clocking off SDIO cards altogether
> for now.

Ok.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
