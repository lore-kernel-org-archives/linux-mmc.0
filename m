From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Sun, 8 Aug 2010 23:50:24 -0600
Message-ID: <AANLkTimOtWeDNewWfoCteJW7UN2cCrY-SPv7h6qsTL_-@mail.gmail.com>
References: <AANLkTinJKO3-iXOXuL7CMWCj5qMMHyMrtnadwPpqTeBu@mail.gmail.com>
	<3850A844E6A3854C827AC5C0BEC7B60AEA19@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55955 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab0HIFup convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2010 01:50:45 -0400
Received: by gwb20 with SMTP id 20so3262081gwb.19
        for <linux-mmc@vger.kernel.org>; Sun, 08 Aug 2010 22:50:44 -0700 (PDT)
In-Reply-To: <3850A844E6A3854C827AC5C0BEC7B60AEA19@zch01exm23.fsl.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

On Wed, Aug 4, 2010 at 8:14 PM, Zang Roy-R61911 <r61911@freescale.com> =
wrote:
>> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> > index c6d1bd8..a92566e 100644
>> > --- a/drivers/mmc/host/sdhci.c
>> > +++ b/drivers/mmc/host/sdhci.c
>> > @@ -817,8 +817,12 @@ static void
>> sdhci_set_transfer_mode(struct sdhci_host *host,
>> > =A0 =A0 =A0 =A0WARN_ON(!host->data);
>> >
>> > =A0 =A0 =A0 =A0mode =3D SDHCI_TRNS_BLK_CNT_EN;
>> > - =A0 =A0 =A0 if (data->blocks > 1)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
>> > + =A0 =A0 =A0 if (data->blocks > 1) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks &
>> SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS=
_MULTI |
>> SDHCI_TRNS_ACMD12;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS=
_MULTI;
>>
>> nit:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_MULTI;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_MULTIBL=
OCK_READ_ACMD12)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mode |=3D SDHCI_TRNS_A=
CMD12;
>>
>> Clearer, no?
> why?

Shorter lines, fewer lines, and the SDHCI_TRNS_MULTI is more obviously
unconditional.  But as I said, it is a nitpick.

g.
