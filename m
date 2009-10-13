From: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 12 Oct 2009 19:39:52 -0700
Message-ID: <20091012193952.1482e322@fido2.homeip.net>
References: <1254160269.10634.15.camel@localhost>
	<4AC0FBF0.6090007@csr.com>
	<20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu>
	<f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
	<20090929233732.62f470e0@mjolnir.ossman.eu>
	<20090929231013.5d67b36a@fido2.homeip.net>
	<20091008203826.5e027347@mjolnir.ossman.eu>
	<20091010114215.5f9d8c94@fido2.homeip.net>
	<4AD32B01.5000600@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from usul.overt.org ([204.11.33.43]:35857 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755358AbZJMClD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Oct 2009 22:41:03 -0400
In-Reply-To: <4AD32B01.5000600@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Pierre Ossman <pierre@ossman.eu>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

On Mon, 12 Oct 2009 14:11:29 +0100
David Vrabel <david.vrabel@csr.com> wrote:

> 
> In the 3.00 spec, OCR bit 24 is S18R (Signalling 1.8V request).  This
> is outside of the VDD region (bits 0:23).  So I think we can support
> non standard DS/HS (Default Speed/High Speed) cards that report 1.8V
> operation (in the VDD region) and new UHS-I (Ultra High Speed phase I)
> cards without any confusion.
> 
> On a UHS-I capable controller, the software would send ACMD41 with
> S18R set and see if the card responses with it set.  If so, it tells
> the card to switch to 1.8V signalling (CMD11) and tells the
> controller to switch to 1.8V signalling and SDR12 mode.  The
> controller still supplies 3.3V to the card even after the switch.
> Later on the host software will query the card to find out what UHS-I
> modes are supported and switch card and controller to a faster mode
> (if possible).

Interesting. But that means that Ohad's patch doesn't make much sense;
his uses the MMC low voltage OCR bit in an SDIO context. So either, the
patch is wrong, or he's dealing with out-of-spec hardware.

Ohad?

--phil
