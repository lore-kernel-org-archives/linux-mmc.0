From: Stephen Warren <swarren@nvidia.com>
Subject: Resume issue with brcmfmac *not* loaded
Date: Mon, 13 Jun 2011 14:18:38 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04992C026B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:15121 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab1FMVSu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2011 17:18:50 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "cjb@laptop.org" <cjb@laptop.org>, "Greg KH (gregkh@suse.de)" <gregkh@suse.de>, "vrao@broadcom.com" <vrao@broadcom.com>, "grundler@chromium.org" <grundler@chromium.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I'm having resume problems on a system (NVIDIA Tegra Seaboard) that would
use the brcmfmac staging driver.

When the driver is loaded, suspend and resume (echo mem > /sys/state/power)
work fine.

However, without the driver loaded, resume works, but 10 seconds later,
the kernel hangs a little, and spits out the errors quoted at the end of
this email. The hangs interfere with other devices on the system; e.g.
audio DMA gets starved and causes audible artifacts.

I tracked this down to brcmfmac's suspend function wl_cfg80211_suspend()
calling sdioh_sdio_set_host_pm_flags(MMC_PM_KEEP_POWER).

I note that the MMC controller suspend/resume path are influenced by
MMC_PM_KEEP_POWER, but only when the driver for the attached SDIO device
specify that flag, hence it's in host->pm_flags and not just in
host->pm_caps.

If I hack all the MMC core code to look for (host->pm_caps &
MMC_PM_KEEP_POWER) instead of (host->pm_flags & MMC_PM_KEEP_POWER), then
suspend/resume works fine even without the brcmfmac driver loaded.

I imagine such a change isn't blanket appropriate for the MMC core. Can
anyone clue me in on:

* Is the call to sdioh_sdio_set_host_pm_flags() just something that masks
a somewhat unrelated problem that should be investigated, or a direct fix
for this issue?

* Is suspend/resume expected to work without the driver in a case like
this, or is it a known troublesome area?

Note that the call to sdioh_sdio_set_host_pm_flags() was introduced to
staging-2.6.git in commit 6b5a5a3eb77ea69382da9d2a64d74107e49cedaa
"STAGING: brcm80211 v2 keep power on in suspend state".

Thanks!

The error spew:

[   45.739276] PM: resume of devices complete after 338.419 msecs
[   46.642802] Restarting tasks ... done.
[   56.697061] mmc2: Timeout waiting for hardware interrupt.
[   56.742333] sdhci: =========== REGISTER DUMP (mmc2)===========
[   56.791248] sdhci: Sys addr: 0x00000000 | Version:  0x00000001
[   56.840178] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   56.840216] sdhci: Argument: 0x00010000 | Trn mode: 0x00000000
[   56.840253] sdhci: Present:  0x1fff0001 | Host ctl: 0x00000001
[   56.840288] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[   56.840322] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[   56.840356] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   56.840391] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c3
[   56.840425] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   56.840460] sdhci: Caps:     0x61ff30b0 | Caps_1:   0x00000000
[   56.840495] sdhci: Cmd:      0x0000071a | Max curr: 0x00000001
[   56.840528] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[   56.840557] sdhci: ===========================================
[   56.850714] mmc2: Controller never released inhibit bit(s).
[   56.850751] sdhci: =========== REGISTER DUMP (mmc2)===========
[   56.850787] sdhci: Sys addr: 0x00000000 | Version:  0x00000001
[   56.850822] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   56.850858] sdhci: Argument: 0x00010000 | Trn mode: 0x00000000
[   56.850894] sdhci: Present:  0x1fff0001 | Host ctl: 0x00000001
[   56.850928] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[   56.850961] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[   56.850995] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   56.851030] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c3
[   56.851064] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   56.851099] sdhci: Caps:     0x61ff30b0 | Caps_1:   0x00000000
[   56.851134] sdhci: Cmd:      0x0000071a | Max curr: 0x00000001
[   56.851167] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[   56.851196] sdhci: ===========================================
[   56.861317] mmc2: Controller never released inhibit bit(s).
[   56.861352] sdhci: =========== REGISTER DUMP (mmc2)===========
[   56.861387] sdhci: Sys addr: 0x00000000 | Version:  0x00000001
[   56.861422] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   56.861456] sdhci: Argument: 0x00010000 | Trn mode: 0x00000000
[   56.861491] sdhci: Present:  0x1fff0001 | Host ctl: 0x00000001
[   56.861524] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[   56.861558] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[   56.861591] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   56.8n1626] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c3
[   56.861659] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   56.861694] sdhci: Caps:     0x61ff30b0 | Caps_1:   0x00000000
[   56.861728] sdhci: Cmd:      0x0000071a | Max curr: 0x00000001
[   56.861761] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[   56.861790] sdhci: ===========================================
[   56.871906] mmc2: Controller never released inhibit bit(s).
[   56.871940] sdhci: =========== REGISTER DUMP (mmc2)===========
[   56.871976] sdhci: Sys addr: 0x00000000 | Version:  0x00000001
[   56.872010] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[   56.872045] sdhci: Argument: 0x00010000 | Trn mode: 0x00000000
[   56.872080] sdhci: Present:  0x1fff0001 | Host ctl: 0x00000001
[   56.872112] sdhci: Power:    0x00000000 | Blk gap:  0x00000000
[   56.872146] sdhci: Wake-up:  0x00000000 | Clock:    0x00000000
[   56.872179] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
[   56.872214] sdhci: Int enab: 0x00ff00c3 | Sig enab: 0x00fc00c3
[   56.872247] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[   56.872282] sdhci: Caps:     0x61ff30b0 | Caps_1:   0x00000000
[   56.872315] sdhci: Cmd:      0x0000071a | Max curr: 0x00000001
[   56.872348] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
[   56.872377] sdhci: ===========================================
[   56.876637] mmc2: card 0001 removed

Then, the kernel appears to enumerate the card again, auto-loads the
driver (which doesn't happen at boot; I haven't fully investigated why),
and from that point on, IIRC, suspend/resume work OK:

[   59.679982] mmc2: queuing unknown CIS tuple 0x80 (50 bytes)
[   59.687842] mmc2: queuing unknown CIS tuple 0x80 (7 bytes)
[   59.690668] mmc2: queuing unknown CIS tuple 0x80 (7 bytes)
[   59.697879] mmc2: queuing unknown CIS tuple 0x80 (19 bytes)
[   59.716700] mmc2: queuing unknown CIS tuple 0x02 (1 bytes)
[   59.719648] mmc2: new SDIO card at address 0001
[   60.012255] brcmutil: module is from the staging directory, the quality is unknown, you have been warned.
[   60.012270] brcmutil: module is from the staging directory, the quality is unknown, you have been warned.
[   60.029470] brcmutil: module is from the staging directory, the quality is unknown, you have been warned.
[   60.383075] cfg80211: Calling CRDA to update world regulatory domain
[   60.466156] brcmfmac: module is from the staging directory, the quality is unknown, you have been warned.
[   60.469614] brcmfmac: module is from the staging directory, the quality is unknown, you have been warned.
[   60.479732] brcmfmac: module is from the staging directory, the quality is unknown, you have been warned.
[   60.709134] No SDIO Drive strength initdone for chip 4329 rev 3 pmurev 6
[   60.766006] DHD: dongle ram size is set to 294912(orig 294912)
[   60.854818] ERROR @wl_cfg80211_request_fw : Could not download fw (-2)
[   60.909985] _dhdsdio_download_firmware: dongle image file download failed
[   61.137195] dhd_bus_start: dhdsdio_probe_download failed. firmware = brcm/bcm4329-fullmac-4.bin nvram = brcm/bcm4329-fullmac-4.txt

-- 
nvpublic

