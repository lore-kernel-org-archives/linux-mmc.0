From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Mon, 19 Mar 2012 15:06:01 +0000
Message-ID: <20120319150601.B783A3E05A5@localhost>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-2-git-send-email-b29396@freescale.com>
 <20120313172351.97C5E3E053B@localhost>
 <20120314124512.GG1180@shlinux2.ap.freescale.net>
 <20120314141643.GP3852@pengutronix.de>
 <20120315030206.GB13022@shlinux2.ap.freescale.net>
 <20321.37353.63115.664975@ipc1.ka-ro>
 <20120315105927.GE13022@shlinux2.ap.freescale.net>
 <20321.53468.310199.875966@ipc1.ka-ro>
 <20120316030134.GA5161@shlinux2.ap.freescale.net>
 <20120318184749.BB15D3E07BF@localhost> <20326.55337.249575.289067@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7836861438887505566=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20326.55337.249575.289067-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Guo Shawn-R65073 <r65073-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============7836861438887505566==
Content-Type: text/plain

On Mon, 19 Mar 2012 07:54:33 +0100, Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org> wrote:
> Grant Likely writes:
> > On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Waßmann wrote:
> > > > Dong Aisheng writes:
> > > > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Waßmann wrote:
> > > > Anyway there is no definite spec how the MAC address(es) are stored
> > > > in the fuse map. Thus reading the MAC from there is more or less
> > > > platform specific.
> > > > 
> > > It's just provide one more option since there are customers storing the MAC
> > > in the fuse map.
> > 
> > That should be straight forward to support; have a property that
> > specifies the method used for fetching/calculating the MAC.
> > 
> Executable code stored inside a DT blob? ;)

I know you're joking here, but I'm going to answer seriously
anyway... Absolutely not.  What I'm suggesting is a property that
specifies the method used to determine the mac address.  Something
like (off the top of my head):

	local-mac-address = [01 02 03 00 00 00];
	local-mac-mask = [0xff 0xff 0xff 0 0 0];
	mac-encoding = "append-serial-number";

> 
> > > > Currently I'm setting up the MAC address for our TX28 from the fuses
> > > > in the platform code passed via platform_data, but that will obviously
> > > > not work with DT.
> > > > 
> > > Non-dt can also use my proposal, then you only need to pass the fixed part of
> > > MAC via platfrom data, the left will be read by fec driver.
> > > 
> > > > The correct way would probably be to pass the MAC from the bootloader
> > > > via a DT blob. But that would require all bootloaders to be updated
> > > > first to support DTS. :(
> > > > 
> > > But uboot will face the same problem that can not define a valid MAC
> > > in dts, did i undertand correctly?
> > > 
> > > > An intermediate solution could be using OF_DEV_AUXDATA to pass a
> > > > platform_data struct that may contain a MAC address set up by the
> > > > platform code.
> > > > 
> > > Yes, it's a way but i'm afraid will not get accepted by dt people.
> > 
> > The problem remains; where does the platform code get the MAC address
> > from?  The kernel has to devise it from *somewhere* and the best place
> > for that should be in the MAC driver itself.
> > 
> The platform code knows how and where the MAC is stored on a specific
> platform. The driver has no business in knowing platform details like
> this. Thus only platform code (or the bootloader) can provide the MAC
> to the driver.

Okay, if so then it would be wise to have a reliable function for the
MAC driver to call to lookup it's address as determined by platform
code.  Alternately, the platform code can write the correct mac
address into the device tree node at init time (see
prom_update_property() and prom_add_property()).

BTW, prom_update_property() currently fails if the property doesn't
actually exist yet which isn't what we want I think.  Also, there are
only two users so it would be easy to change to make it add-or-update
instead of update-only.

> > I've got no problem with the idea of only specifying the OUI in the DT
> > and the driver extracting the remaining 3 bytes from the hardware.
> > 
> > In principle, that's the design intent for DT systems anyway; it
> > describes things which cannot be probed from the hardware, or tells
> > the OS how the data is encoded in the hardware.
> > 
> If all bootloaders were aware of DT this wouldn't be a problem,
> because they could place the correct MAC inside the DT blob right
> away.
> But in the mean time (AKA forever) we need some other solution.

You'll notice I haven't disputed that.

g.


--===============7836861438887505566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7836861438887505566==--
