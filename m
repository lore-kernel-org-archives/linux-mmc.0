From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Mon, 19 Mar 2012 22:02:24 +0000
Message-ID: <20120319220224.ABF5A3E0A04@localhost>
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
 <20120319150601.B783A3E05A5@localhost> <20327.25470.723875.916422@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1677333256993087441=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20327.25470.723875.916422-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
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

--===============1677333256993087441==
Content-Type: text/plain

On Mon, 19 Mar 2012 17:49:02 +0100, Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org> wrote:
> Hi,
> 
> Grant Likely writes:
> > On Mon, 19 Mar 2012 07:54:33 +0100, Lothar Waßmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org> wrote:
> > > Grant Likely writes:
> > > > On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> > > > > On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Waßmann wrote:
> > > > > > Dong Aisheng writes:
> > > > > > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Waßmann wrote:
> > > > > > Anyway there is no definite spec how the MAC address(es) are stored
> > > > > > in the fuse map. Thus reading the MAC from there is more or less
> > > > > > platform specific.
> > > > > > 
> > > > > It's just provide one more option since there are customers storing the MAC
> > > > > in the fuse map.
> > > > 
> > > > That should be straight forward to support; have a property that
> > > > specifies the method used for fetching/calculating the MAC.
> > > > 
> > > Executable code stored inside a DT blob? ;)
> > 
> > I know you're joking here, but I'm going to answer seriously
> > anyway... Absolutely not.  What I'm suggesting is a property that
> > specifies the method used to determine the mac address.  Something
> > like (off the top of my head):
> > 
> > 	local-mac-address = [01 02 03 00 00 00];
> > 	local-mac-mask = [0xff 0xff 0xff 0 0 0];
> > 	mac-encoding = "append-serial-number";
> > 
> That still does not specify where the remaining part of the MAC is
> stored and how it should be retrieved.

I'm suggesting that you define a string that means something specific;
that hopefully can be shared by multiple platforms.  For example,
"append-serial-number" might mean start with the values selected by
AND of local-mac-address and local-mac-mask, and OR in the board's
serial number.  You would need to define something that worked if this
was the solution you used.

> > Okay, if so then it would be wise to have a reliable function for the
> > MAC driver to call to lookup it's address as determined by platform
> > code.  Alternately, the platform code can write the correct mac
> > address into the device tree node at init time (see
> > prom_update_property() and prom_add_property()).
> > 
> That sounds good. Didn't know about those functions. That could be
> used to mimic the current behaviour of supplying the MAC via
> platform_data.

I'm okay with doing this; but make sure you remove the bogus
local-mac-address from the .dts file.

g.


--===============1677333256993087441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1677333256993087441==--
