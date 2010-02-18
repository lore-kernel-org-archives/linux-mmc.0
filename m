From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Thu, 18 Feb 2010 18:45:18 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002181841400.1946@xanadu.home>
References: <cover.1265801967.git.david.vrabel@csr.com>
 <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com>
 <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
 <004901cab001$6b19f6c0$544ff780@am.dhcp.ti.com> <4B7C4608.5010008@csr.com>
 <alpine.DEB.2.00.1002171254040.24812@utopia.booyaka.com>
 <4B7D3EAE.1010908@csr.com>
 <alpine.DEB.2.00.1002180951330.24812@utopia.booyaka.com>
 <004001cab0c9$b208b2b0$544ff780@am.dhcp.ti.com>
 <alpine.DEB.2.00.1002181231520.24812@utopia.booyaka.com>
 <5e088bd91002181416l33dc2fe4u8d2a09d12ea0344e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_7P4RKl45WtjhNS5Je5FVKg)"
Return-path: <linux-omap-owner@vger.kernel.org>
In-reply-to: <5e088bd91002181416l33dc2fe4u8d2a09d12ea0344e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>, Madhusudhan <madhu.cr@ti.com>, David Vrabel <david.vrabel@csr.com>, r-woodruff2@ti.com, sawant@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_7P4RKl45WtjhNS5Je5FVKg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 18 Feb 2010, Steve Sakoman wrote:

> On Thu, Feb 18, 2010 at 12:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> > (cc'ing Steve, Richard, Anand)
> 
> > There appear to be least seven SDIO card drivers in 2.6.34-rc7. At least
> > one of these is for a TI chip - the wl1251.  I think some of the
> > Gumstix Overo OMAP3 boards are using an SDIO-connected Marvell Libertas:
> >
> > http://www.gumstix.com/store/catalog/product_info.php?products_id=252
> 
> That is correct, a Wi2Wi wifi module is connected via mmc2 on the
> Overo Air and Fire products.
> 
> Data rates are pretty low with the existing OMAP SDIO driver.   Any
> chance this patch would improve that situation?

Without proper SDIO interrupt support at the controller level, the core 
SDIO code does poll for pending SDIO interrupts periodically.  So yes, 
this patch is certainly going to help throughput.


Nicolas

--Boundary_(ID_7P4RKl45WtjhNS5Je5FVKg)--
