From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH V3] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Fri, 2 Nov 2012 05:32:35 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EABDCB7@DBDE01.ent.ti.com>
References: <1351684656-30275-1-git-send-email-gururaja.hebbar@ti.com>
 <20121031122639.GA10998@arwen.pp.htv.fi>
 <CAOyx1LrKBE+xzSRN4F=+e1DuMJL+5SAv-YkJWJdDw8p=kDojmw@mail.gmail.com>
 <20121031201626.GA28784@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20121031201626.GA28784@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, "S, Venkatraman" <svenkatr@ti.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rob@landley.net" <rob@landley.net>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 01, 2012 at 01:46:26, Balbi, Felipe wrote:
> Hi,
> 
> On Thu, Nov 01, 2012 at 01:21:36AM +0530, Venkatraman S wrote:
> > On Wed, Oct 31, 2012 at 5:56 PM, Felipe Balbi <balbi@ti.com> wrote:
> > > Hi,
> > >
> > > On Wed, Oct 31, 2012 at 05:27:36PM +0530, Hebbar, Gururaja wrote:
> > >> HSMMC IP on AM33xx need a special setting to handle High-speed cards.
> > >> Other platforms like TI81xx, OMAP4 may need this as-well. This depends
> > >> on the HSMMC IP timing closure done for the high speed cards.
> > >>
> > >> From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
> > >>
> > >> The MMC/SD/SDIO output signals can be driven on either falling edge or
> > >> rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
> > >> to reach better timing performance, and thus to increase data transfer
> > >> frequency.
> > >>
> > >> There are few pre-requisites for enabling the HSPE bit
> > >> - Controller should support High-Speed-Enable Bit and
> > >> - Controller should not be using DDR Mode and
> > >> - Controller should advertise that it supports High Speed in
> > >>   capabilities register and
> > >> - MMC/SD clock coming out of controller > 25MHz
> > >>
> > >> Note:
> > >> The implementation reuses the output of calc_divisor() so as to reduce
> > >> code addition.
> > >>
> > >> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
> > >
> > > this looks good to my eyes, hopefully I haven't missed anything:
> > >
> > > Reviewed-by: Felipe Balbi <balbi@ti.com>
> > >
> > 
> > Except for the excessively verbose comments which are just duplicating the code,
> > <Quote>
> > >> +      * Enable High-Speed Support
> > >> +      * Pre-Requisites
> > >> +      *      - Controller should support High-Speed-Enable Bit
> > >> +      *      - Controller should not be using DDR Mode
> > >> +      *      - Controller should advertise that it supports High Speed
> > >> +      *        in capabilities register
> > >> +      *      - MMC/SD clock coming out of controller > 25MHz
> > >> +      */
> > </Quote>
> > 
> > I'm ok with this patch as well. I'm putting a few patches under test
> > including this one,
> > and will send it to Chris as part of that series.
> > I'll strip out the above mentioned comments, unless there are any
> > objections.
> 
> please don't. Detailing the pre-requisites for getting HSP mode working
> isn't bad at all. Should someone decide to change the behavior and ends
> up breaking it, the comment will help putting things back together.
> 
> my 2 cents, you've got the final decision though.

Same here. Description is required in commit message since it will help
in during git bisect.

> 
> -- 
> balbi
> 


Regards, 
Gururaja
