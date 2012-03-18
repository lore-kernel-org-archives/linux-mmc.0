From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Sun, 18 Mar 2012 18:47:49 +0000
Message-ID: <20120318184749.BB15D3E07BF@localhost>
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
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6982082980030362048=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120316030134.GA5161-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Guo Shawn-R65073 <r65073-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============6982082980030362048==
Content-Type: text/plain

On Fri, 16 Mar 2012 11:01:35 +0800, Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> On Thu, Mar 15, 2012 at 07:22:04PM +0800, Lothar Waßmann wrote:
> > Hi,
> > 
> > Dong Aisheng writes:
> > > On Thu, Mar 15, 2012 at 02:53:29PM +0800, Lothar Waßmann wrote:
> > > > Hi,
> > > > 
> > > > Dong Aisheng writes:
> > > > > On Wed, Mar 14, 2012 at 10:16:43PM +0800, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
> > > > > > On Wed, Mar 14, 2012 at 08:45:23PM +0800, Dong Aisheng wrote:
> > > > > > > On Wed, Mar 14, 2012 at 01:23:51AM +0800, Grant Likely wrote:
> > > > [...]
> > > > > > > But it seems this needs pass mac address to fec driver via platforom data which is
> > > > > > > not friendly to dt.
> > > > > > > 
> > > > > > > Another way may be changing fec driver to get the fixed part of mac address(first
> > > > > > > two bytes) from device tree and read the left dynamical part from otp which i'm not
> > > > > > > sure is better enough.
> > > > > > > 
> > > > > > > BTW, filling with zeros seems not work since it's invalid mac address.
> > > > > > 
> > > > > > Yes, that's the idea of using this value...
> > > > > > 
> > > > > But comparing to use an invalid value, why not just do not define that
> > > > > local-mac-address property?
> > > > > 
> > > > Because a MAC address is by definition a GLOBALLY UNIQUE IDENTIFIER
> > > > which is contrary to coding a "valid" default value for it somewhere!
> > > > The owner of a certain MAC address range (OUI) is responsible for
> > > > ensuring the uniqueness. Thus only they may assign a specific MAC
> > > > address to a specific device.
> > > > 
> > > Yes, you're correct.
> > > So i propose to read the MAC address from MX28 OTP in fec driver instead of
> > > define it in device tree in my last mail.
> > > http://www.spinics.net/lists/arm-kernel/msg165040.html
> > > Do you have any comment on that way?
> > > 
> > That patch sets the OUI to the Freescale owned MAC range. Thus only
> > Freescale products may be able to use the driver.
> > 
> No.
> My proposal is only set the fixed part(first two octets) in board dts file,
> each board knows it's value, and read the left 4 octets from OCOTP dynamically.
> Obviously the freeescale board dts file is only for FSL platforms.
> Other platforms can define their fix part of MAC address in their dts file.
> 
> > Anyway there is no definite spec how the MAC address(es) are stored
> > in the fuse map. Thus reading the MAC from there is more or less
> > platform specific.
> > 
> It's just provide one more option since there are customers storing the MAC
> in the fuse map.

That should be straight forward to support; have a property that
specifies the method used for fetching/calculating the MAC.

> > Currently I'm setting up the MAC address for our TX28 from the fuses
> > in the platform code passed via platform_data, but that will obviously
> > not work with DT.
> > 
> Non-dt can also use my proposal, then you only need to pass the fixed part of
> MAC via platfrom data, the left will be read by fec driver.
> 
> > The correct way would probably be to pass the MAC from the bootloader
> > via a DT blob. But that would require all bootloaders to be updated
> > first to support DTS. :(
> > 
> But uboot will face the same problem that can not define a valid MAC
> in dts, did i undertand correctly?
> 
> > An intermediate solution could be using OF_DEV_AUXDATA to pass a
> > platform_data struct that may contain a MAC address set up by the
> > platform code.
> > 
> Yes, it's a way but i'm afraid will not get accepted by dt people.

The problem remains; where does the platform code get the MAC address
from?  The kernel has to devise it from *somewhere* and the best place
for that should be in the MAC driver itself.

I've got no problem with the idea of only specifying the OUI in the DT
and the driver extracting the remaining 3 bytes from the hardware.

In principle, that's the design intent for DT systems anyway; it
describes things which cannot be probed from the hardware, or tells
the OS how the data is encoded in the hardware.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

--===============6982082980030362048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6982082980030362048==--
