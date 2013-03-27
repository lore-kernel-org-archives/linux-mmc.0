From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: RE: [PATCH v6 3/5] mmc: davinci_mmc: add DT support
Date: Wed, 27 Mar 2013 09:55:43 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA4A96A@DBDE01.ent.ti.com>
References: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
 <1363779852-24083-4-git-send-email-prakash.pm@ti.com>
 <201303201326.09265.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51435 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812Ab3C0J43 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Mar 2013 05:56:29 -0400
In-Reply-To: <201303201326.09265.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "Nori, Sekhar" <nsekhar@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "hs@denx.de" <hs@denx.de>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Porter, Matt" <mporter@ti.com>

Hi Arnd,

On Wed, Mar 20, 2013 at 18:56:09, Arnd Bergmann wrote:
> On Wednesday 20 March 2013, Manjunathappa, Prakash wrote:
> > Adds device tree support for davinci_mmc. Also add binding documentation.
> > As of now in non-dma PIO mode and without GPIO card_detect/write_protect
> > option because of dependencies on EDMA and GPIO module DT support.
> 
> Shouldn't the binding at least specify the names for the DMA channels?
> It's fine if the driver works without those, but I think there is no
> strict dependency here: If dma_request_slave_channel does not find
> a channel, the driver can just continue in PIO mode, and as soon
> as the EDMA driver is merged, it will work with DMA.
> 

In that case, don't I have to add support for it in driver also using
dma_request_slave_channel_compat? As we do not have edma support yet on
da850, I will not be able to test it.

Thanks,
Prakash
