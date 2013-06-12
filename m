From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 08/10] ARM: dts: omap3: split omap3_pmx_core
Date: Wed, 12 Jun 2013 10:54:44 -0700
Message-ID: <20130612175444.GS8164@atomide.com>
References: <20130523184045.GD13507@atomide.com>
 <1370546059-24181-1-git-send-email-balajitk@ti.com>
 <1370546059-24181-9-git-send-email-balajitk@ti.com>
 <20130612143459.GY8164@atomide.com>
 <51B8AB0F.9060701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51B8AB0F.9060701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [130612 10:14]:
> On Wednesday 12 June 2013 08:05 PM, Tony Lindgren wrote:
> >* Balaji T K <balajitk@ti.com> [130606 12:20]:
> >>omap3_pmx_core: padconf register are in two banks 0x48003000 to 0x48002268
> >>and 0x480025c0 to 0x480025f8.
> >>
> >>split omap3_pmx_core into 2 banks as register between 0x48002270 and 0x48002564
> >>belongs to type pinctrl-single,bit-per-mux with access to certain bit
> >>fields with bit field mask.
> >
> >Is this the right patch for the description? THe patch seems to deal with
> >USB pins.
> >
> >Also, let's not hog any pins under the pinmux controllers, those make
> >unloading pinctrl-single impossible which is not nice for distros and
> >development.
> 
> omap3_pmx_core is not continuous, so had to split into two and
> updated the only user in second bank (omap3_pmx_core2) which happened to be usb,
> CC Roger for USB dynamic pin mux selection.

I see. OK yes we can split it as that saves memory too for the unused
registers. While at it, please move remove the hogs from the pmx
entries and move the pins to the drivers claiming them.

Regards,

TOny
