From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH] mmc: omap_hsmmc: Pass on the suspend failure to the PM
 core
Date: Wed, 12 Sep 2012 07:48:29 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA7F8B7@DBDE01.ent.ti.com>
References: <1346764109-21174-1-git-send-email-gururaja.hebbar@ti.com>
 <CANfBPZ93ONzeYj=kD_7pbq=VBQLd98YM9BE9S+sPb3rrrXNFzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58060 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754308Ab2ILHsg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Sep 2012 03:48:36 -0400
In-Reply-To: <CANfBPZ93ONzeYj=kD_7pbq=VBQLd98YM9BE9S+sPb3rrrXNFzQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "cjb@laptop.org" <cjb@laptop.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>

On Tue, Sep 11, 2012 at 11:13:26, S, Venkatraman wrote:
> On Tue, Sep 4, 2012 at 6:38 PM, Hebbar, Gururaja <gururaja.hebbar@ti.com> wrote:
> > From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> >
> > In some cases mmc_suspend_host() is not able to claim the
> > host and proceed with the suspend process. The core returns
> > -EBUSY to the host controller driver. Unfortunately, the
> > host controller driver does not pass on this information
> > to the PM core and hence the system suspend process continues.
> >
> > In these cases the MMC core gets to an unexpected state
> > during resume and multiple issues related to MMC crop up.
> > 1. Host controller driver starts accessing the device registers
> > before the clocks are enabled which leads to a prefetch abort.
> > 2. A file copy thread which was launched before suspend gets
> > stuck due to the host not being reclaimed during resume.
> >
> > To avoid such problems pass on the -EBUSY status to the PM core
> > from the host controller driver. With this change, MMC core
> > suspend might still fail but it does not end up making the
> > system unusable. Suspend gets aborted and the user can try
> > suspending the system again.
> >
> 
> The last time we discussed this, didn't we plan to fix this differently ?
> Holding the return code of mmc_suspend_host in a separate variable and
> passing it to the caller
> of omap_hsmmc_suspend looks more sane to me.

Correct. I missed it. I will reformat the patch and resend it.

> 


Regards, 
Gururaja
