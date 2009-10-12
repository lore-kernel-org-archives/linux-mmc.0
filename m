From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 12 Oct 2009 14:11:29 +0100
Message-ID: <4AD32B01.5000600@csr.com>
References: <1254160269.10634.15.camel@localhost>	<4AC0FBF0.6090007@csr.com>	<20090928192548.11da5c3c@fido2.homeip.net>	<20090929202833.179fb521@mjolnir.ossman.eu>	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>	<20090929233732.62f470e0@mjolnir.ossman.eu>	<20090929231013.5d67b36a@fido2.homeip.net>	<20091008203826.5e027347@mjolnir.ossman.eu> <20091010114215.5f9d8c94@fido2.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:43422 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755716AbZJLNN0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2009 09:13:26 -0400
Received: from rly12g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly12g.srv.mailcontrol.com (MailControl) with ESMTP id n9CDCM92015315
	for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2009 14:12:42 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly12g.srv.mailcontrol.com (MailControl) id n9CDBgE3012478
	for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2009 14:11:42 +0100
In-Reply-To: <20091010114215.5f9d8c94@fido2.homeip.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: Pierre Ossman <pierre@ossman.eu>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

Philip Langdale wrote:
> On Thu, 8 Oct 2009 20:38:26 +0200
> Pierre Ossman <pierre@ossman.eu> wrote:
> 
>>> In practice, I expect that the timings are close enough that this
>>> will work anyway, but I think the situation is analogous to HS-MMC
>>> vs HS-SD. There the timings are slightly different and you felt it
>>> was enough to justify a separate host cap for each one.
>>>
>> It's difficult to say without seeing the spec. But if things are not
>> backwards compatible, then we should probably add either a new timing
>> mode, or a new bus mode (where we have open drain and push pull
>> today).
>>
>>> In fact, thinking about it in those terms, it suggests we need to
>>> retroactively introduce a reduced-voltage MMC host flag too, just in
>>> case SDHCI 3.0 controllers barf on those cards...
>>>
>> Maybe. Again, it's difficult to say without seeing the specifics of
>> the new specification.
> 
> Make sense. So, I guess the question is do we assume the best case (in
> which case there is no additional work to do - the code that is now
> in allows low voltage SDIO cards to try and run) or the worst case and
> add pre-emptive mode flags?
> 
> David, you've actually seen the new spec right? What's your opinion?

In the 3.00 spec, OCR bit 24 is S18R (Signalling 1.8V request).  This is
outside of the VDD region (bits 0:23).  So I think we can support non
standard DS/HS (Default Speed/High Speed) cards that report 1.8V
operation (in the VDD region) and new UHS-I (Ultra High Speed phase I)
cards without any confusion.

On a UHS-I capable controller, the software would send ACMD41 with S18R
set and see if the card responses with it set.  If so, it tells the card
 to switch to 1.8V signalling (CMD11) and tells the controller to switch
to 1.8V signalling and SDR12 mode.  The controller still supplies 3.3V
to the card even after the switch.  Later on the host software will
query the card to find out what UHS-I modes are supported and switch
card and controller to a faster mode (if possible).

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
