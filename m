From: Stephen Warren <swarren@nvidia.com>
Subject: RE: Resume issue with brcmfmac *not* loaded
Date: Tue, 14 Jun 2011 08:58:15 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04992C034F@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04992C026B@HQMAIL01.nvidia.com>
	<BANLkTimJXtFB5Qi9sjVOWhrKVfuE5O1p-uhGMq_WmnJPJcugpg@mail.gmail.com>
 <BANLkTinAXsHYBZ0uSY4ZtTd=f=7LNQM+_9o_FcLLYs1iPfL=YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:9209 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1FNP6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2011 11:58:38 -0400
In-Reply-To: <BANLkTinAXsHYBZ0uSY4ZtTd=f=7LNQM+_9o_FcLLYs1iPfL=YQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Grant Grundler <grundler@chromium.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "Greg KH (gregkh@suse.de)" <gregkh@suse.de>, "vrao@broadcom.com" <vrao@broadcom.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Sukesh Srikakula <sukeshs@broadcom.com>

Olof Johansson wrote at Monday, June 13, 2011 7:13 PM:
> Hi,
>=20
> First, the below were pure guesses on my behalf, but browsing around
> the sources for a few minutes seems to confirm that caps are... well,
> caps. flags are currently active flags.
>=20
> On Mon, Jun 13, 2011 at 5:26 PM, Grant Grundler <grundler@chromium.or=
g> wrote:
> >On Mon, Jun 13, 2011 at 2:18 PM, Stephen Warren <swarren@nvidia.com>=
 wrote:
> >> I'm having resume problems on a system (NVIDIA Tegra Seaboard) tha=
t would
> >> use the brcmfmac staging driver.
> >
> > Stephen,
> > Are you using the chromium.org tree...and using 2.6.38 based kernel=
?
> > Or directly using gregkh's staging-next:staging-2.6 tree/branch?

I'm using the chromeos-2.6.38 tree from kernel.git.

> >> When the driver is loaded, suspend and resume (echo mem > /sys/sta=
te/power)
> >> work fine.
> >>
> >> However, without the driver loaded, resume works, but 10 seconds l=
ater,
> >> the kernel hangs a little, and spits out the errors quoted at the =
end of
> >> this email. The hangs interfere with other devices on the system; =
e.g.
> >> audio DMA gets starved and causes audible artifacts.
> >>
> >> I tracked this down to brcmfmac's suspend function wl_cfg80211_sus=
pend()
> >> calling sdioh_sdio_set_host_pm_flags(MMC_PM_KEEP_POWER).
> >
> > Broadcom and/or Olofj might have insight in this. It's not clear to=
 me
> > why loading the driver on resume would break this. =A0Loading the d=
river
> > at boot time works fine for me and should essentially be exercising
> > the same code path from the driver PoV.
>=20
> Sounds to me like loading the driver isn't what is breaking things,
> it's the suspend/resume without a driver at all.

Yes, that's correct.

> That slot lacks a CD GPIO, which means that the MMC code will poll fo=
r
> cards present. It seems like one of those polls are what's causing
> problem in this case.
>=20
> The wifi adapter will stay powered across the suspend/resume (externa=
l
> power feed, not part of MMC). So the MMC interface will go down but
> the card will remain powered.
>
> >> I note that the MMC controller suspend/resume path are influenced =
by
> >> MMC_PM_KEEP_POWER, but only when the driver for the attached SDIO =
device
> >> specify that flag, hence it's in host->pm_flags and not just in
> >> host->pm_caps.
> >
> > Sorry, I don't know the difference and assume Olof does.
> >
> >> If I hack all the MMC core code to look for (host->pm_caps &
> >> MMC_PM_KEEP_POWER) instead of (host->pm_flags & MMC_PM_KEEP_POWER)=
, then
> >> suspend/resume works fine even without the brcmfmac driver loaded.
> >
> > Olof (just walked by) suspects pm_caps means it's supported and
> > pm_flags indicates state (enabled).

> Right -- it sounds to me like checking caps at resume time is the
> wrong way to go about it -- caps are just caps, and flags are the
> current actual setting.

Yes, checking caps doesn't seem correct; it was just a quick hack to
validate that keeping the power on was what made things work after the
driver was loaded.

> >> I imagine such a change isn't blanket appropriate for the MMC core=
=2E Can
> >> anyone clue me in on:
> >>
> >> * Is the call to sdioh_sdio_set_host_pm_flags() just something tha=
t masks
> >> a somewhat unrelated problem that should be investigated, or a dir=
ect fix
> >> for this issue?
>=20
> Sounds to me like there's another problem going on here. I wonder if
> the card gets confused if the host goes away and comes back without i=
t
> having been power cycled as well.

Ah. That sounds plausible.

> This should be simple for Broadcom to reproduce, and they are the one=
s
> with the knowledge of how their adapter behaves. So I'd like to hear
> from them about this.
>=20
> >> Note that the call to sdioh_sdio_set_host_pm_flags() was introduce=
d to
> >> staging-2.6.git in commit 6b5a5a3eb77ea69382da9d2a64d74107e49cedaa
> >> "STAGING: brcm80211 v2 keep power on in suspend state".
>=20
> Reverting that change won't make a difference in this case, will it?

No. I didn't try it, but I'm pretty sure that would just make resume
fail *with* the driver loaded too.

> Sounds like the solution here might instead be:
>=20
> * Specify the power_gpio properly for the slot in question (it does
> have one wired up if I'm reading the right schematics, it's just not
> specified in the board file)

I assume you mean WF_RST_L_PWDN_L?

> * Add a suspend/resume function to the sdhci-tegra driver currently
> not in use, that disables power to the slot during suspend if the
> pm_flags don't have MMC_KEEP_POWER set.

I'll give that a try and see...

> That should take care of this issue, but it would also be good to hea=
r
> from Broadcom above as to why the current behavior causes problems.

Thanks.

--=20
nvpublic

