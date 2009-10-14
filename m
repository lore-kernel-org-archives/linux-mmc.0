From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Wed, 14 Oct 2009 09:56:28 +0200
Message-ID: <da15981b0910140056j9a62fccvdb256b851455c686@mail.gmail.com>
References: <1254160269.10634.15.camel@localhost> <20090928192548.11da5c3c@fido2.homeip.net>
	<20090929202833.179fb521@mjolnir.ossman.eu> <f6ee8ef9d3da123c11433b52ec8d6a60@localhost>
	<20090929233732.62f470e0@mjolnir.ossman.eu> <20090929231013.5d67b36a@fido2.homeip.net>
	<20091008203826.5e027347@mjolnir.ossman.eu> <20091010114215.5f9d8c94@fido2.homeip.net>
	<4AD32B01.5000600@csr.com> <20091012193952.1482e322@fido2.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:64396 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755402AbZJNH5Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Oct 2009 03:57:25 -0400
Received: by fxm27 with SMTP id 27so11214224fxm.17
        for <linux-mmc@vger.kernel.org>; Wed, 14 Oct 2009 00:56:48 -0700 (PDT)
In-Reply-To: <20091012193952.1482e322@fido2.homeip.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Langdale <philipl@overt.org>, David Vrabel <david.vrabel@csr.com>, Pierre Ossman <pierre@ossman.eu>
Cc: akpm@linux-foundation.org, ian@mnementh.co.uk, matt@console-pimps.org, roberto.foglietta@gmail.com, linux-mmc@vger.kernel.org

On Tue, Oct 13, 2009 at 4:39 AM, Philip Langdale <philipl@overt.org> wrote:
> Interesting. But that means that Ohad's patch doesn't make much sense;
> his uses the MMC low voltage OCR bit in an SDIO context. So either, the
> patch is wrong, or he's dealing with out-of-spec hardware.

Yes, the hardware is out-of-spec. It uses the undefined low voltage
OCR bit to achieve 1.8V SDIO voltage. By removing the MMC_VDD_165_195
restriction, commit 27cce39f555def6f5ebe7f03d69ccc44ab25f0b2 makes it
possible for the hardware to work with unpatched kernels.

Philip, David, Pierre - would you like to remove the MMC_VDD_165_195
restriction differently ? maybe to revive the MMC_CAP_VDD_165_195 host
capability patch in some way (see
http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00386.html) ?

Thank you for the comments and help,
Ohad.
