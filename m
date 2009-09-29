From: Philip Langdale <philipl@overt.org>
Subject: Re: [PATCH] sdio: add =?UTF-8?Q?MMC=5FCAP=5FVDD=5F=31=36=35=5F=31=39=35?=
 =?UTF-8?Q?=20host=20capability?=
Date: Tue, 29 Sep 2009 16:20:38 -0400
Message-ID: <f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
References: <1254160269.10634.15.camel@localhost> <4AC0FBF0.6090007@csr.com> <20090928192548.11da5c3c@fido2.homeip.net> <20090929202833.179fb521@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from usul.overt.org ([204.11.33.43]:40549 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788AbZI2U3t (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Sep 2009 16:29:49 -0400
In-Reply-To: <20090929202833.179fb521@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: David Vrabel <david.vrabel@csr.com>, Ohad Ben-Cohen <ohad@bencohen.org>, akpm@linux-foundation.org, p <hilipl@overt.org>, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org


On Tue, 29 Sep 2009 20:28:33 +0200, Pierre Ossman <pierre@ossman.eu> wrote:
> On Mon, 28 Sep 2009 19:25:48 -0700
> Philip Langdale <philipl@overt.org> wrote:
> 
>> 
>> Hi David,
>> 
>> Ok, that sounds reasonable, but my concern is a controller that
>> publishes support for MMC_VDD_165_195 for mmc cards but doesn't
>> claim support for SDIO cards - particularly considering the
>> signalling implications you mentioned. Now, maybe you don't see
>> this happening in the wild, but it seems to me that it has to
>> be possible. It seems that to guard against this, you'd need a
>> host cap that says "165_195 for SD" and if it's not present,
>> mask it out of the OCR when dealing with SD/IO cards.
>> 
>> Am I being too paranoid?
>> 
> 
> There is no way the vendor of the SD controller can know what this bit
> means to the vendor of the SD/SDIO card as it is undefined. I'm afraid
> I see no safe way of supporting this bit. The only thing we can do is
> interpret it as being the same as the MMC bit, but then only with an
> opt-in configuration as we might be killing hardware with this.

My understanding from the previous discussion was that SD 3.0 (and
presumably
a matching SDHCI 3.0) fully define the low voltage range. As such, a
controller
that is documented to conform to this spec, or is otherwise documented to
implement the functionality, can be safely allowed to run SD cards that
also
claim to support the bit.

Yes, there is a danger of pre 3.0 cards claiming to suport the low voltage
range,
but I think there's a credible chance that no such cards actually exist,
and if
they do, I think they're obscure enough to ignore - if they were a problem,
the
SD association would have had to abandon using the same bit as MMC uses.

If you're really paranoid, you could also cross-check the SD card version
but
that would have to happen after establishing basic communication so you'd
have
to go back and re-negotiate the voltage after starting at 3.3V.

It seems a reasonable compromise to me to assume that a card which claims
low
voltage support knows what its talking about, and then have host support be
opt
in, either by explicitly reporting SDHCI 3.0 compliance or because the
controller
docs state that it supports SD 3.0 cards.

--phil
