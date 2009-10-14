From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Wed, 14 Oct 2009 11:34:42 +0100
Message-ID: <4AD5A942.3000207@csr.com>
References: <1254160269.10634.15.camel@localhost>	<20090928192548.11da5c3c@fido2.homeip.net>	<20090929202833.179fb521@mjolnir.ossman.eu>	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>	<20090929233732.62f470e0@mjolnir.ossman.eu>	<20090929231013.5d67b36a@fido2.homeip.net>	<20091008203826.5e027347@mjolnir.ossman.eu>	<20091010114215.5f9d8c94@fido2.homeip.net>	<4AD32B01.5000600@csr.com>	<20091012193952.1482e322@fido2.homeip.net>	<da15981b0910140056j9a62fccvdb256b851455c686@mail.gmail.com> <20091014104849.3c441249@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:48271 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430AbZJNKhc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Oct 2009 06:37:32 -0400
Received: from rly06d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly06d.srv.mailcontrol.com (MailControl) with ESMTP id n9EAZl25025245
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2009 11:36:38 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly06d.srv.mailcontrol.com (MailControl) id n9EAZ30C023260
	for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2009 11:35:03 +0100
In-Reply-To: <20091014104849.3c441249@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Philip Langdale <philipl@overt.org>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

Pierre Ossman wrote:
> On Wed, 14 Oct 2009 09:56:28 +0200
> Ohad Ben-Cohen <ohad@wizery.com> wrote:
> 
>> On Tue, Oct 13, 2009 at 4:39 AM, Philip Langdale <philipl@overt.org> wrote:
>>> Interesting. But that means that Ohad's patch doesn't make much sense;
>>> his uses the MMC low voltage OCR bit in an SDIO context. So either, the
>>> patch is wrong, or he's dealing with out-of-spec hardware.
>> Yes, the hardware is out-of-spec. It uses the undefined low voltage
>> OCR bit to achieve 1.8V SDIO voltage. By removing the MMC_VDD_165_195
>> restriction, commit 27cce39f555def6f5ebe7f03d69ccc44ab25f0b2 makes it
>> possible for the hardware to work with unpatched kernels.
>>
>> Philip, David, Pierre - would you like to remove the MMC_VDD_165_195
>> restriction differently ? maybe to revive the MMC_CAP_VDD_165_195 host
>> capability patch in some way (see
>> http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00386.html) ?
>>
> 
> Since this is out-of-spec and therefore possibly dangerous behaviour,
> I'd like it to be opt-in for the user. And since it's so early in the
> init process, we can't automate it based on card id.

It can be done per-card, the switch to the lower voltage just needs to
be deferred.  Initially set the voltage to a standard one that's
supported by the card and host.  After the card is fully initialized and
enumerated, have a hook for per-card fixups.  For the particular
non-standard card in question, this would then reduce the voltage to 1.8V.

Alternatively, if this is for a chip hardwired to the controller then
some board-specific data for the SD controller can be used to always set
the voltage correctly. e.g., always run at 1.8V regardless of what the
stack says.  Obviously, this strategy won't work with removable cards.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
