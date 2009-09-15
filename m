From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: EXT_CSD  Register : CSD_STRUCTURE vs CSD_CSD_REV
Date: Tue, 15 Sep 2009 08:16:34 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B02F64543C4@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B02F6454333@dbde02.ent.ti.com>
 <20090914215140.7efe4671@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48553 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758028AbZIOCqx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2009 22:46:53 -0400
In-Reply-To: <20090914215140.7efe4671@mjolnir.ossman.eu>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Benjamin.Telya@sandisk.com" <Benjamin.Telya@sandisk.com>, "drzeus-list@drzeus.cx" <drzeus-list@drzeus.cx>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Joshi, Rhishi" <rhishi@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Raju, Veeramanikandan" <veera@ti.com>

Pierre,

Thanks for the information.

And what I understood from MMCA specification is that - 
EXT_CSD_REV: Defines the fixed parameters. related to the EXT_CSD, according to its revision. Nothing to do with MMCA specification version or > 4GB card.

SO, I need just one more help from you to browse the MMCA specification where it's mentioned that if Card is >4GB then EXT_CSD_REV Revision should be > 2 (Rev 1.2)?

And again the fact I mentioned in my previous email that below fact is from Symbian OS too.

So please reply sometime to helping me understand better.

Thanks & regards,
Ghorai 

-----Original Message-----
From: Pierre Ossman [mailto:pierre@ossman.eu] 
Sent: 2009-09-15 01:22
To: Ghorai, Sukumar
Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Chikkature Rajashekar, Madhusudhan; Benjamin.Telya@sandisk.com; drzeus-list@drzeus.cx; Pandita, Vikram; Joshi, Rhishi; Sawant, Anand; Raju, Veeramanikandan
Subject: Re: EXT_CSD Register : CSD_STRUCTURE vs CSD_CSD_REV

On Mon, 14 Sep 2009 20:34:35 +0530
"Ghorai, Sukumar" <s-ghorai@ti.com> wrote:

> Hello,
> 
> I am working in Linux MMC driver.
> Recently I came across one 16GB MMC card where EXT_CSD Register having EXT_CSD_REV[192] field as ZERO, which is valid according to Specification. But card is not working due to following reason -
> 
>  1.  As we know there are two fields in Extended CSD Register -  CSD_STRUCTURE Version[194] & EXT_CSD_REV Revision [192].
> 
> 
>  1.  In mmc.c/ mmc_read_ext_csd ()
>     *   Implementation expecting EXT_CSD_REV non zero (e.g. >3 in current code)
>     *   I think it could be checking for CSD_STRUCTURE version.
>     *   Because EXT_CSD_REV having Zero is the valid Field.
>     *   This is the way it's done in other OS too.

The opposite, it expects the version to be below 3 as those are the
only ones it knows about. Checking the CSD version for the EXT_CSD
would just be silly.

> 
> 
>  1.  To check the high capacity card.
>     *   We could check in access mode from OCR.  This is not in Linux exactly and steps to check the EXT_CSD_REV.
>     *   This is done in some other OS too.
> 

Checking the OCR is insufficient if I remember the spec correctly, so
we ignore it completely. The EXT_CSD needs to be correct for high
capacity to work anyway.

> So do you think we can update the code to check the CSD_STRUCTURE Version? Please let us know your opinion.

No, as that would violate the spec and possibly misinterpret some cards
as high-capacity.

To handle your card you would have to build some kind of quirks system
so that the kernel can identify that this card is buggy and compensate
for it.

Rgds
-- 
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
