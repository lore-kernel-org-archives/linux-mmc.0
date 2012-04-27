From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Fri, 27 Apr 2012 09:26:13 +0100
Message-ID: <WC20120427082613.2202AB@terrafix.co.uk>
References: <CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com> <CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com> <CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com> <CAK=WgbaKFhknaDVEbPjmcWGL-F_DiYG0t1t-cB-sGWHPCOBErA@mail.gmail.com> <CAGDS+n=bYK4_RZMd9TeKTGafi6k9JQmu1u2ELuUQecTKxJ_gfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:38276 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1759980Ab2D0Jhu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Apr 2012 05:37:50 -0400
In-Reply-To: <CAGDS+n=bYK4_RZMd9TeKTGafi6k9JQmu1u2ELuUQecTKxJ_gfg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Neil Brown <neilb@suse.de>, Bing Zhao <bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>

-----Original Message-----
=46rom: Steve Sakoman <sakoman@gmail.com>
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, Joe Woodward <jw@terrafix.co.uk>, linu=
x-mmc@vger.kernel.org, Neil Brown <neilb@suse.de>, Bing Zhao=20
<bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>
Date: Thu, 26 Apr 2012 16:51:10 -0700
Subject: Re: mmc: sdio: runtime PM and 8686 problems

> On Mon, Dec 19, 2011 at 1:10 AM, Ohad Ben-Cohen <ohad@wizery.com>
> wrote:
>=20
> > We're slowly progressing towards understanding the issues we have
> with
> > the 8686 (it seems there are a few different hw revisions of it, so=
me
> > of which do require toggling the reset pin before sending another
> init
> > sequence), but it might take some more time until a solution fully
> > materializes.
> >
> > Since 3.2 is just around the corner, I suggest we should now procee=
d
> > with the revert (see patch below), and later revisit this once we
> have
> > a complete solution in hand.
>=20
> Has any progress been made on this issue?
>=20
> I too have been trying to power down/up the wifi module on the Overo.
> I'm seeing the same issue described in this thread.
>=20
> Some additional data:
>=20
> I rebuilt my kernel (3.2) with a CD GPIO enabled for the mmc port the
> module
> is connected to and in turn connected that GPIO to another one that I
> can toggle from user space.
>=20
> Toggling the CD GPIO after powering back up the module does indeed
> work properly -- the module is detected, the driver loaded, and prope=
r
> function
> restored.
>=20
> So basically the procedure I've used is:
>=20
> - decide wifi can be powered down
> - unload the libertas modules
> - put the wifi hw in reset with gpio16
> - wait till wifi is needed again
> - take the chip out of reset
> - toggle the CD gpio
> - libertas modules are autoloaded, as is the firmware
> - wifi is up and functioning
>=20
> So the next step is to get rid of the silly two GPIO external hardwar=
e
> hack.  Is it possible to trigger a card insertion/removal event via
> some standard API?
>=20
> Or does the above information provide a clue as to why normal code
> paths don't work?
>=20
> Any other ideas?
>=20
> Steve
>=20

Since the patch has been reverted (i.e. no runtime PM) I haven't seen a=
 problem.

I've not put any more work in to getting it to work with runtime PM i'm=
 afriad.

On a side note, I'm doing something very similar to you with my Overo, =
except with one difference. Where you have routed a GPIO externally whi=
ch you can toggle=20
from userspace, I've hacked the MMC driver (omap_hsmmc.c) to add a sysf=
s entry to force a re-scan. This also allows me to safely remove/insert=
 SD cards (as the=20
Overo SDCard slot doesn't have a card-detect pin) when the device is ru=
nning (I run from a ramfs).

I've thought for a while that a userspace hook to kick the MMC driver w=
here this is no physical GPIO would be useful in mainline, but haven't =
done any more about=20
it.

Also, I've appled the first pass of patches to enable Libertas async fi=
rmware loading (as required by newer UDEVs).

I have two scripts pasted below to turn on/off the WiFi (the delays jus=
t work for me, I know they are not optimal).

Hope this helps.

Cheers,
Joe


> cat #wifi-down.sh
#!/bin/sh

echo "Turning off WiFi..."

echo "...stopping wlan0 interface"
ifdown wlan0

echo "...unloading WiFi kernel module"
modprobe -r libertas_sdio

echo "...disabling power to WiFi chip"
if [ -e /sys/class/gpio/gpio16/value ] ; then
  echo "...already exported GPIO reset control"
else
  echo "...exporting GPIO reset control"
  echo 16 > /sys/class/gpio/export
  echo out > /sys/class/gpio/gpio16/direction
fi
echo 0 > /sys/class/gpio/gpio16/value

echo "...removing wpa configuration file"
rm /tmp/wpa_supplicant.conf

echo "..rescanning the MMC/SDIO as we have powered down the WiFi chip"
echo 1 > /sys/bus/platform/drivers/omap_hsmmc/omap_hsmmc.1/mmc_host/mmc=
1/rescan
sleep 2

echo "...done"



#> cat wifi-up.sh
#!/bin/sh

# Get the network parameters.
SSID=3D$1
PSK=3D$2

echo "Turning on WiFi..."

echo "...enabling power to WiFi chip"
if [ -e /sys/class/gpio/gpio16/value ] ; then
  echo "...already exported GPIO reset control"
else
  echo "...exporting GPIO reset control"
  echo 16 > /sys/class/gpio/export
  echo out > /sys/class/gpio/gpio16/direction
fi
echo 0 > /sys/class/gpio/gpio16/value
usleep 10
echo 1 > /sys/class/gpio/gpio16/value
usleep 10

echo "..rescanning the MMC/SDIO as we have powered up the WiFi chip"
echo 1 > /sys/bus/platform/drivers/omap_hsmmc/omap_hsmmc.1/mmc_host/mmc=
1/rescan

### Wait for the device to be found.
sleep 2

### Set up the AP and password.
echo "...adding wpa configuration file"
rm /tmp/wpa_supplicant.conf
echo "ctrl_interface=3D/var/run/wpa_supplicant
ctrl_interface_group=3D0
eapol_version=3D1
ap_scan=3D1
fast_reauth=3D1

network=3D{
      ssid=3D\"${SSID}\"
      proto=3DWPA2                 # try WPA RSN if you WPA2 fails
      key_mgmt=3DWPA-PSK
      pairwise=3DCCMP TKIP
      group=3DCCMP TKIP
      scan_ssid=3D1
      psk=3D\"${PSK}\"
      priority=3D10
}" > /tmp/wpa_supplicant.conf

echo "...loading WiFi kernel module"
modprobe libertas_sdio

### We must wait for the asynchronous firmware loading to complete.
sleep 2

echo "...starting wlan0 interface"
ifup wlan0

echo "...done"


=3D=3D=3D=3D=3D=3D=3D=3D=3D
On 3.2 the rescan looks a bit like:

static ssize_t
omap_hsmmc_store_rescan(struct device *dev,
		struct device_attribute *attr, const char *buf, size_t size)
{
	struct mmc_host *mmc =3D container_of(dev, struct mmc_host, class_dev)=
;
	struct omap_hsmmc_host *host =3D mmc_priv(mmc);

printk (KERN_ERR "MMC: rescanning...\n");

	if (!host->suspended)
		schedule_work(&host->mmc_carddetect_work);

	return size;
}

static DEVICE_ATTR(rescan, S_IWUGO, NULL, omap_hsmmc_store_rescan);


And I add in to omap_hsmmc_probe:

	ret =3D device_create_file(&mmc->class_dev, &dev_attr_rescan);
	if (ret < 0)
		goto err_slot_name;


>=20
> >> When SDIO runtime PM was originally introduced, we immediately fac=
ed
> >> two regressions with two different chipsets, and in response decid=
ed
> >> not to enable it by default.
> >>
> >> With your work on the 8686 we hoped we found all the gotchas, so
> >> 08da834 did make sense (at least experimentally).
> >>
> >> Unfortunately we now see that some setups out there still refuse t=
o
> >> work when SDIO runtime PM is enabled by default, and obviously we
> >> can't live with these kind of regressions.
> >>
> >> commit fd9fec7a00f58a16803e37a99a014ef82543ef6f
> >> Author: Ohad Ben-Cohen <ohad@wizery.com>
> >> Date: =A0 Wed Nov 30 16:22:13 2011 +0200
> >>
> >> =A0 =A0Revert "mmc: enable runtime PM by default"
> >>
> >> =A0 =A0When SDIO runtime PM was originally introduced, we immediat=
ely
> faced
> >> =A0 =A0two regressions with two different chipsets, and in respons=
e
> decided
> >> =A0 =A0not to enable it by default.
> >>
> >> =A0 =A0With the recent work on the 8686 we hoped we found all the
> gotchas,
> >> =A0 =A0so 08da834 did make sense (at least experimentally).
> >>
> >> =A0 =A0Unfortunately we now see that some setups out there still
> refuse to work
> >> =A0 =A0when SDIO runtime PM is enabled by default (see
> >> =A0 =A0http://www.spinics.net/lists/linux-mmc/msg11161.html), and
> obviously we
> >> =A0 =A0can't live with these kind of regressions.
> >>
> >> =A0 =A0This reverts commit 08da834a24312157f512224691ad1fddd11c107=
3.
> >>
> >> =A0 =A0Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> >> =A0 =A0Cc: Daniel Drake <dsd@laptop.org>
> >>
> >> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> >> index e8a5eb3..d31c78b 100644
> >> --- a/drivers/mmc/core/host.c
> >> +++ b/drivers/mmc/core/host.c
> >> @@ -302,17 +302,6 @@ struct mmc_host *mmc_alloc_host(int extra,
> struct
> >> device *dev)
> >> =A0 =A0 =A0 =A0host->max_blk_size =3D 512;
> >> =A0 =A0 =A0 =A0host->max_blk_count =3D PAGE_CACHE_SIZE / 512;
> >>
> >> - =A0 =A0 =A0 /*
> >> - =A0 =A0 =A0 =A0* Enable runtime power management by default. Thi=
s flag
> was added due
> >> - =A0 =A0 =A0 =A0* to runtime power management causing disruption =
for
> some users, but
> >> - =A0 =A0 =A0 =A0* the power on/off code has been improved since t=
hen.
> >> - =A0 =A0 =A0 =A0*
> >> - =A0 =A0 =A0 =A0* We'll enable this flag by default as an experim=
ent,
> and if no
> >> - =A0 =A0 =A0 =A0* problems are reported, we will follow up later =
and
> remove the flag
> >> - =A0 =A0 =A0 =A0* altogether.
> >> - =A0 =A0 =A0 =A0*/
> >> - =A0 =A0 =A0 host->caps =3D MMC_CAP_POWER_OFF_CARD;
> >> -
> >> =A0 =A0 =A0 =A0return host;
> >>
> >> =A0free:
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l


