From: Grant Grundler <grundler@chromium.org>
Subject: Re: Resume issue with brcmfmac *not* loaded
Date: Mon, 13 Jun 2011 17:26:38 -0700
Message-ID: <BANLkTimJXtFB5Qi9sjVOWhrKVfuE5O1p-uhGMq_WmnJPJcugpg@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04992C026B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:30336 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab1FNA0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2011 20:26:45 -0400
Received: from kpbe19.cbf.corp.google.com (kpbe19.cbf.corp.google.com [172.25.105.83])
	by smtp-out.google.com with ESMTP id p5E0Qfvh022450
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 17:26:41 -0700
Received: from yxe1 (yxe1.prod.google.com [10.190.2.1])
	by kpbe19.cbf.corp.google.com with ESMTP id p5E0Q5rU010330
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 17:26:39 -0700
Received: by yxe1 with SMTP id 1so1724797yxe.34
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2011 17:26:39 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04992C026B@HQMAIL01.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "Greg KH (gregkh@suse.de)" <gregkh@suse.de>, "vrao@broadcom.com" <vrao@broadcom.com>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Sukesh Srikakula <sukeshs@broadcom.com>

+olofj (chromium.org), sukeshs (Broadcom)

On Mon, Jun 13, 2011 at 2:18 PM, Stephen Warren <swarren@nvidia.com> wr=
ote:
> I'm having resume problems on a system (NVIDIA Tegra Seaboard) that w=
ould
> use the brcmfmac staging driver.

Stephen,
Are you using the chromium.org tree...and using 2.6.38 based kernel?
Or directly using gregkh's staging-next:staging-2.6 tree/branch?

> When the driver is loaded, suspend and resume (echo mem > /sys/state/=
power)
> work fine.
>
> However, without the driver loaded, resume works, but 10 seconds late=
r,
> the kernel hangs a little, and spits out the errors quoted at the end=
 of
> this email. The hangs interfere with other devices on the system; e.g=
=2E
> audio DMA gets starved and causes audible artifacts.
>
> I tracked this down to brcmfmac's suspend function wl_cfg80211_suspen=
d()
> calling sdioh_sdio_set_host_pm_flags(MMC_PM_KEEP_POWER).

Broadcom and/or Olofj might have insight in this. It's not clear to me
why loading the driver on resume would break this.  Loading the driver
at boot time works fine for me and should essentially be exercising
the same code path from the driver PoV.


> I note that the MMC controller suspend/resume path are influenced by
> MMC_PM_KEEP_POWER, but only when the driver for the attached SDIO dev=
ice
> specify that flag, hence it's in host->pm_flags and not just in
> host->pm_caps.

Sorry, I don't know the difference and assume Olof does.


> If I hack all the MMC core code to look for (host->pm_caps &
> MMC_PM_KEEP_POWER) instead of (host->pm_flags & MMC_PM_KEEP_POWER), t=
hen
> suspend/resume works fine even without the brcmfmac driver loaded.

Olof (just walked by) suspects pm_caps means it's supported and
pm_flags indicates state (enabled).


> I imagine such a change isn't blanket appropriate for the MMC core. C=
an
> anyone clue me in on:
>
> * Is the call to sdioh_sdio_set_host_pm_flags() just something that m=
asks
> a somewhat unrelated problem that should be investigated, or a direct=
 fix
> for this issue?

Based on Olof's comments (and he wasn't 100% sure either), setting the
pm_flags field sets the state.

> * Is suspend/resume expected to work without the driver in a case lik=
e
> this, or is it a known troublesome area?

I think it should work without the driver loaded but I don't know
where the dragons are in this subsystem (yet).

>
> Note that the call to sdioh_sdio_set_host_pm_flags() was introduced t=
o
> staging-2.6.git in commit 6b5a5a3eb77ea69382da9d2a64d74107e49cedaa
> "STAGING: brcm80211 v2 keep power on in suspend state".
>
> Thanks!

hth,
grant

>
> The error spew:
>
> [ =C2=A0 45.739276] PM: resume of devices complete after 338.419 msec=
s
> [ =C2=A0 46.642802] Restarting tasks ... done.
> [ =C2=A0 56.697061] mmc2: Timeout waiting for hardware interrupt.
> [ =C2=A0 56.742333] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER=
 DUMP (mmc2)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ =C2=A0 56.791248] sdhci: Sys addr: 0x00000000 | Version: =C2=A00x00=
000001
> [ =C2=A0 56.840178] sdhci: Blk size: 0x00000000 | Blk cnt: =C2=A00x00=
000000
> [ =C2=A0 56.840216] sdhci: Argument: 0x00010000 | Trn mode: 0x0000000=
0
> [ =C2=A0 56.840253] sdhci: Present: =C2=A00x1fff0001 | Host ctl: 0x00=
000001
> [ =C2=A0 56.840288] sdhci: Power: =C2=A0 =C2=A00x00000000 | Blk gap: =
=C2=A00x00000000
> [ =C2=A0 56.840322] sdhci: Wake-up: =C2=A00x00000000 | Clock: =C2=A0 =
=C2=A00x00000000
> [ =C2=A0 56.840356] sdhci: Timeout: =C2=A00x00000000 | Int stat: 0x00=
000000
> [ =C2=A0 56.840391] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c=
3
> [ =C2=A0 56.840425] sdhci: AC12 err: 0x00000000 | Slot int: 0x0000000=
0
> [ =C2=A0 56.840460] sdhci: Caps: =C2=A0 =C2=A0 0x61ff30b0 | Caps_1: =C2=
=A0 0x00000000
> [ =C2=A0 56.840495] sdhci: Cmd: =C2=A0 =C2=A0 =C2=A00x0000071a | Max =
curr: 0x00000001
> [ =C2=A0 56.840528] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000=
0
> [ =C2=A0 56.840557] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [ =C2=A0 56.850714] mmc2: Controller never released inhibit bit(s).
> [ =C2=A0 56.850751] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER=
 DUMP (mmc2)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ =C2=A0 56.850787] sdhci: Sys addr: 0x00000000 | Version: =C2=A00x00=
000001
> [ =C2=A0 56.850822] sdhci: Blk size: 0x00000000 | Blk cnt: =C2=A00x00=
000000
> [ =C2=A0 56.850858] sdhci: Argument: 0x00010000 | Trn mode: 0x0000000=
0
> [ =C2=A0 56.850894] sdhci: Present: =C2=A00x1fff0001 | Host ctl: 0x00=
000001
> [ =C2=A0 56.850928] sdhci: Power: =C2=A0 =C2=A00x00000000 | Blk gap: =
=C2=A00x00000000
> [ =C2=A0 56.850961] sdhci: Wake-up: =C2=A00x00000000 | Clock: =C2=A0 =
=C2=A00x00000000
> [ =C2=A0 56.850995] sdhci: Timeout: =C2=A00x00000000 | Int stat: 0x00=
000000
> [ =C2=A0 56.851030] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c=
3
> [ =C2=A0 56.851064] sdhci: AC12 err: 0x00000000 | Slot int: 0x0000000=
0
> [ =C2=A0 56.851099] sdhci: Caps: =C2=A0 =C2=A0 0x61ff30b0 | Caps_1: =C2=
=A0 0x00000000
> [ =C2=A0 56.851134] sdhci: Cmd: =C2=A0 =C2=A0 =C2=A00x0000071a | Max =
curr: 0x00000001
> [ =C2=A0 56.851167] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000=
0
> [ =C2=A0 56.851196] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [ =C2=A0 56.861317] mmc2: Controller never released inhibit bit(s).
> [ =C2=A0 56.861352] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER=
 DUMP (mmc2)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ =C2=A0 56.861387] sdhci: Sys addr: 0x00000000 | Version: =C2=A00x00=
000001
> [ =C2=A0 56.861422] sdhci: Blk size: 0x00000000 | Blk cnt: =C2=A00x00=
000000
> [ =C2=A0 56.861456] sdhci: Argument: 0x00010000 | Trn mode: 0x0000000=
0
> [ =C2=A0 56.861491] sdhci: Present: =C2=A00x1fff0001 | Host ctl: 0x00=
000001
> [ =C2=A0 56.861524] sdhci: Power: =C2=A0 =C2=A00x00000000 | Blk gap: =
=C2=A00x00000000
> [ =C2=A0 56.861558] sdhci: Wake-up: =C2=A00x00000000 | Clock: =C2=A0 =
=C2=A00x00000000
> [ =C2=A0 56.861591] sdhci: Timeout: =C2=A00x00000000 | Int stat: 0x00=
000000
> [ =C2=A0 56.8n1626] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c=
3
> [ =C2=A0 56.861659] sdhci: AC12 err: 0x00000000 | Slot int: 0x0000000=
0
> [ =C2=A0 56.861694] sdhci: Caps: =C2=A0 =C2=A0 0x61ff30b0 | Caps_1: =C2=
=A0 0x00000000
> [ =C2=A0 56.861728] sdhci: Cmd: =C2=A0 =C2=A0 =C2=A00x0000071a | Max =
curr: 0x00000001
> [ =C2=A0 56.861761] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000=
0
> [ =C2=A0 56.861790] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [ =C2=A0 56.871906] mmc2: Controller never released inhibit bit(s).
> [ =C2=A0 56.871940] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER=
 DUMP (mmc2)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ =C2=A0 56.871976] sdhci: Sys addr: 0x00000000 | Version: =C2=A00x00=
000001
> [ =C2=A0 56.872010] sdhci: Blk size: 0x00000000 | Blk cnt: =C2=A00x00=
000000
> [ =C2=A0 56.872045] sdhci: Argument: 0x00010000 | Trn mode: 0x0000000=
0
> [ =C2=A0 56.872080] sdhci: Present: =C2=A00x1fff0001 | Host ctl: 0x00=
000001
> [ =C2=A0 56.872112] sdhci: Power: =C2=A0 =C2=A00x00000000 | Blk gap: =
=C2=A00x00000000
> [ =C2=A0 56.872146] sdhci: Wake-up: =C2=A00x00000000 | Clock: =C2=A0 =
=C2=A00x00000000
> [ =C2=A0 56.872179] sdhci: Timeout: =C2=A00x00000000 | Int stat: 0x00=
000000
> [ =C2=A0 56.872214] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c=
3
> [ =C2=A0 56.872247] sdhci: AC12 err: 0x00000000 | Slot int: 0x0000000=
0
> [ =C2=A0 56.872282] sdhci: Caps: =C2=A0 =C2=A0 0x61ff30b0 | Caps_1: =C2=
=A0 0x00000000
> [ =C2=A0 56.872315] sdhci: Cmd: =C2=A0 =C2=A0 =C2=A00x0000071a | Max =
curr: 0x00000001
> [ =C2=A0 56.872348] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x0000000=
0
> [ =C2=A0 56.872377] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [ =C2=A0 56.876637] mmc2: card 0001 removed
>
> Then, the kernel appears to enumerate the card again, auto-loads the
> driver (which doesn't happen at boot; I haven't fully investigated wh=
y),
> and from that point on, IIRC, suspend/resume work OK:
>
> [ =C2=A0 59.679982] mmc2: queuing unknown CIS tuple 0x80 (50 bytes)
> [ =C2=A0 59.687842] mmc2: queuing unknown CIS tuple 0x80 (7 bytes)
> [ =C2=A0 59.690668] mmc2: queuing unknown CIS tuple 0x80 (7 bytes)
> [ =C2=A0 59.697879] mmc2: queuing unknown CIS tuple 0x80 (19 bytes)
> [ =C2=A0 59.716700] mmc2: queuing unknown CIS tuple 0x02 (1 bytes)
> [ =C2=A0 59.719648] mmc2: new SDIO card at address 0001
> [ =C2=A0 60.012255] brcmutil: module is from the staging directory, t=
he quality is unknown, you have been warned.
> [ =C2=A0 60.012270] brcmutil: module is from the staging directory, t=
he quality is unknown, you have been warned.
> [ =C2=A0 60.029470] brcmutil: module is from the staging directory, t=
he quality is unknown, you have been warned.
> [ =C2=A0 60.383075] cfg80211: Calling CRDA to update world regulatory=
 domain
> [ =C2=A0 60.466156] brcmfmac: module is from the staging directory, t=
he quality is unknown, you have been warned.
> [ =C2=A0 60.469614] brcmfmac: module is from the staging directory, t=
he quality is unknown, you have been warned.
> [ =C2=A0 60.479732] brcmfmac: module is from the staging directory, t=
he quality is unknown, you have been warned.
> [ =C2=A0 60.709134] No SDIO Drive strength initdone for chip 4329 rev=
 3 pmurev 6
> [ =C2=A0 60.766006] DHD: dongle ram size is set to 294912(orig 294912=
)
> [ =C2=A0 60.854818] ERROR @wl_cfg80211_request_fw : Could not downloa=
d fw (-2)
> [ =C2=A0 60.909985] _dhdsdio_download_firmware: dongle image file dow=
nload failed
> [ =C2=A0 61.137195] dhd_bus_start: dhdsdio_probe_download failed. fir=
mware =3D brcm/bcm4329-fullmac-4.bin nvram =3D brcm/bcm4329-fullmac-4.t=
xt
>
> --
> nvpublic
>
>
