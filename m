From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Wed, 12 Sep 2012 12:02:54 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA804A8@DBDE01.ent.ti.com>
References: <1346764151-21323-1-git-send-email-gururaja.hebbar@ti.com>
 <CANfBPZ-Wb7HE45DTmwsMt-hpJRUevjbjm9-aCR61B4JFULb8Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52767 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756296Ab2ILMDD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Sep 2012 08:03:03 -0400
In-Reply-To: <CANfBPZ-Wb7HE45DTmwsMt-hpJRUevjbjm9-aCR61B4JFULb8Mw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "cjb@laptop.org" <cjb@laptop.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>

On Wed, Sep 12, 2012 at 14:19:51, S, Venkatraman wrote:
> On Tue, Sep 4, 2012 at 6:39 PM, Hebbar, Gururaja <gururaja.hebbar@ti.com> wrote:
> > HSMMC IP on AM33xx need a special setting to handle High-speed cards.
> > Other platforms like TI81xx, OMAP4 may need this as-well. This depends
> > on the HSMMC IP timing closure done for the high speed cards.
> >
> > From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
> >
> > The MMC/SD/SDIO output signals can be driven on either falling edge or
> > rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
> > to reach better timing performance, and thus to increase data transfer
> > frequency.
> >
> > There are few pre-requisites for enabling the HSPE bit
> > - Controller should support High-Speed-Enable Bit and
> > - Controller should not be using DDR Mode and
> > - Controller should advertise that it supports High Speed in
> >   capabilities register and
> > - MMC/SD clock coming out of controller > 25MHz
> >
> 
> The patch is well written. But then, I don't see a need for a DT
> binding for this feature.

My reasons for DT Binding
1. Not all platforms using this driver has this bit (OMAP2)
2. Not all platforms using this driver needs this bit to be enabled (OMAP4)
3. Platforms which require this bit this to be set needs a method to inform 
driver.

In order to not disturb old/unsupported platforms, I chose this DT method.

> By definition, HS implies 25MHz or above, so that check seems to be
> redundant as well.

There are chances that the platform Max Clock output from HSMMC IP is < than 
25 MHz even if the card is High Speed. In such cases it would be better to
Confirm that the Clock output is actually > 25 MHz

Kindly correct me if I am wrong.

> Meanwhile, I'll check with HSPE enabled on OMAP.
> 
> Regards,
> Venkat.
> 


Regards, 
Gururaja
