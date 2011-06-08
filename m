From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Wed, 8 Jun 2011 14:36:35 +0100
Message-ID: <BANLkTini3Oz7P3ji9rrnh75bcwf=vdyWkg@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
	<BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
	<BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
	<BANLkTi=-ZRVLqrmriGOV7YGXHHvJHTmkzg@mail.gmail.com>
	<BANLkTikvdm=RLoY38xrvVAF5Zo9qCSa4hg@mail.gmail.com>
	<BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=bcaec5396bd4db8fb704a5336c37
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46956 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab1FHNgf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 09:36:35 -0400
Received: by pzk9 with SMTP id 9so244003pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 06:36:35 -0700 (PDT)
In-Reply-To: <BANLkTinbqoPOMuL30ksmDJEtM2RebAhksQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

--bcaec5396bd4db8fb704a5336c37
Content-Type: text/plain; charset=ISO-8859-1

On 8 June 2011 10:33, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Sounds like you didn't power the card off then in the driver after probe ?
>
> Can you show the diff with which you did this experiment ?

Attached. This is on top of your fix for correct driver deinit during suspend.

Test case is:
1. boot, load libertas driver
2. suspend in a way that libertas returns -ENOSYS to power down card
(this is the default)
3. resume
4. MMC layer powers up card to identify it, then powers it down, then
fails to power it up for libertas probe

If I add the reset (shown commented-out in the patch), it matches the
behaviour of other known-good codepaths and also solves the problem.

Output logs are:
bash-4.1# insmod /media/4E11-1D7C/libertas_sdio.ko
[   53.847863] libertas_sdio: Libertas SDIO driver
[   53.853104] libertas_sdio: Copyright Pierre Ossman
[   53.858040] mmc_power_restore_host mmc1
[   54.809019] libertas_sdio mmc1:0001:1: (unregistered net_device):
00:17:c4:a7:50:57, fw 9.70.3p36, cap 0x000003a3
[   54.825485] libertas_sdio mmc1:0001:1: wlan0: Marvell WLAN 802.11 adapter
bash-4.1# [   54.920650] udev[992]: renamed network interface wlan0 to eth0
[   54.978168] ieee80211 phy0: assoc: bss   (null) not in scan results
[   56.295225] ieee80211 phy0: assoc: bss   (null) not in scan results
[   56.337101] cfg80211: Calling CRDA for country: EU
bash-4.1# echo mem > /sys/power/state
[   65.393797] PM: Syncing filesystems ...
[   65.672372] done.
[   65.803121] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   65.823048] Freezing remaining freezable tasks ... (elapsed 0.01
seconds) done.
[   65.884808] i8042 kbd 00:04: wake-up capability enabled by ACPI
[   65.891251] i8042 aux 00:03: wake-up capability disabled by ACPI
[   65.897820] ehci_hcd 0000:00:10.4: PCI INT D disabled
[   65.903294] uhci_hcd 0000:00:10.2: PCI INT C disabled
[   65.908900] uhci_hcd 0000:00:10.1: PCI INT B disabled
[   65.914431] libertas_sdio mmc1:0001:1: mmc1:0001:1: suspend: PM flags = 0x3
[   65.922077] uhci_hcd 0000:00:10.0: PCI INT A disabled
[   65.927578] viafb 0000:00:01.0: PCI INT A disabled
[   65.932646] libertas_sdio mmc1:0001:1: Suspend without wake params
-- powering down card
[   65.944166] cfg80211: Calling CRDA to update world regulatory domain
[   66.010534] mmc1: card 0001 removed
[   66.014310] sdhci-pci 0000:00:0c.0: PCI INT A disabled
[   66.030103] PM: suspend of devices complete after 186.534 msecs
[   66.110284] PM: late suspend of devices complete after 74.153 msecs
[   66.116751] ACPI: Preparing to enter system sleep state S3
[   66.122976] PM: Saving platform NVS memory
+r[   66.122976] ACPI: Low-level resume complete
[   66.122976] PM: Restoring platform NVS memory
[   66.122976] ACPI: Waking up from system sleep state S3
[   66.150047] uhci_hcd 0000:00:10.0: BAR 4: set to [io
0x8000-0x801f] (PCI address [0x8000-0x801f])
[   66.170036] uhci_hcd 0000:00:10.1: BAR 4: set to [io
0x8020-0x803f] (PCI address [0x8020-0x803f])
[   66.190035] uhci_hcd 0000:00:10.2: BAR 4: set to [io
0x8040-0x805f] (PCI address [0x8040-0x805f])
[   66.210034] ehci_hcd 0000:00:10.4: BAR 0: set to [mem
0x80003000-0x800030ff] (PCI address [0x80003000-0x800030ff])
[   66.220917] PM: early resume of devices complete after 87.797 msecs
[   66.227558] viafb 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   66.234561] sdhci-pci 0000:00:0c.0: PCI INT A -> GSI 22 (level,
low) -> IRQ 22
[   66.241931] uhci_hcd 0000:00:10.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[   66.249168] usb usb2: root hub lost power or was reset
[   66.260047] uhci_hcd 0000:00:10.1: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[   66.260077] usb usb3: root hub lost power or was reset
[   66.260116] uhci_hcd 0000:00:10.2: PCI INT C -> GSI 21 (level, low) -> IRQ 21
[   66.260145] usb usb4: root hub lost power or was reset
[   66.260179] ehci_hcd 0000:00:10.4: PCI INT D -> GSI 23 (level, low) -> IRQ 23
[   66.260761] i8042 kbd 00:04: wake-up capability disabled by ACPI
[   66.560225] PM: resume of devices complete after 332.791 msecs
[   66.580429] Restarting tasks ... done.
[   66.650427] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
bash-4.1# [   66.690461] cfg80211: World regulatory domain updated:
[   66.695701] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[   66.733049] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   66.751195] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   66.759333] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   66.795426] mmc0: mmc_rescan_try_freq: trying to init card at 300000 Hz
[   66.808884] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   66.830830] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   66.865778] cfg80211: Calling CRDA to update world regulatory domain
[   66.905733] cfg80211: World regulatory domain updated:
[   66.917952] mmc0: mmc_rescan_try_freq: trying to init card at 200000 Hz
[   66.968065] cfg80211:     (start_freq - end_freq @ bandwidth),
(max_antenna_gain, max_eirp)
[   66.985155] cfg80211:     (2402000 KHz - 2472000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   67.015441] cfg80211:     (2457000 KHz - 2482000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   67.045234] mmc0: mmc_rescan_try_freq: trying to init card at 187500 Hz
[   67.053616] cfg80211:     (2474000 KHz - 2494000 KHz @ 20000 KHz),
(300 mBi, 2000 mBm)
[   67.122604] cfg80211:     (5170000 KHz - 5250000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   67.151879] mmc1: mmc_rescan_try_freq: trying to init card at 400000 Hz
[   67.189830] cfg80211:     (5735000 KHz - 5835000 KHz @ 40000 KHz),
(300 mBi, 2000 mBm)
[   67.296211] mmc1: new SDIO card at address 0001
[   67.337105] mmc_power_save_host mmc1
[   67.356088] mmc_power_restore_host mmc1
[   67.471529] CMD5 reset returned -110
[   67.477144] libertas_sdio: probe of mmc1:0001:1 failed with error -16

--bcaec5396bd4db8fb704a5336c37
Content-Type: text/plain; charset=US-ASCII; name="sdio-rpm-cant-power-up.txt"
Content-Disposition: attachment; filename="sdio-rpm-cant-power-up.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goobkqta0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jIGIvZHJpdmVycy9tbWMvY29yZS9j
b3JlLmMKaW5kZXggNjgwOTFkZC4uOTI0MDVlMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29y
ZS9jb3JlLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMKQEAgLTE2NjIsNyArMTY2Miw3
IEBAIHZvaWQgbW1jX3N0b3BfaG9zdChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCiBpbnQgbW1jX3Bv
d2VyX3NhdmVfaG9zdChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCiB7CiAJaW50IHJldCA9IDA7Ci0K
K3ByaW50aygibW1jX3Bvd2VyX3NhdmVfaG9zdCAlc1xuIiwgbW1jX2hvc3RuYW1lKGhvc3QpKTsK
IAltbWNfYnVzX2dldChob3N0KTsKIAogCWlmICghaG9zdC0+YnVzX29wcyB8fCBob3N0LT5idXNf
ZGVhZCB8fCAhaG9zdC0+YnVzX29wcy0+cG93ZXJfcmVzdG9yZSkgewpAQCAtMTY4NSw2ICsxNjg1
LDcgQEAgaW50IG1tY19wb3dlcl9yZXN0b3JlX2hvc3Qoc3RydWN0IG1tY19ob3N0ICpob3N0KQog
ewogCWludCByZXQ7CiAKK3ByaW50aygibW1jX3Bvd2VyX3Jlc3RvcmVfaG9zdCAlc1xuIiwgbW1j
X2hvc3RuYW1lKGhvc3QpKTsKIAltbWNfYnVzX2dldChob3N0KTsKIAogCWlmICghaG9zdC0+YnVz
X29wcyB8fCBob3N0LT5idXNfZGVhZCB8fCAhaG9zdC0+YnVzX29wcy0+cG93ZXJfcmVzdG9yZSkg
ewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgYi9kcml2ZXJzL21tYy9jb3Jl
L3NkaW8uYwppbmRleCA4YWYzMzMwLi42MWVlNTNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9j
b3JlL3NkaW8uYworKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYwpAQCAtNzA2LDEwICs3MDYs
MjcgQEAgc3RhdGljIGludCBtbWNfc2Rpb19wb3dlcl9yZXN0b3JlKHN0cnVjdCBtbWNfaG9zdCAq
aG9zdCkKIAlCVUdfT04oIWhvc3QtPmNhcmQpOwogCiAJbW1jX2NsYWltX2hvc3QoaG9zdCk7CisK
KwkvKgorCSAqIFJlc2V0IHRoZSBjYXJkIGJ5IHBlcmZvcm1pbmcgdGhlIHNhbWUgc3RlcHMgdGhh
dCBhcmUgdGFrZW4gYnkKKwkgKiBtbWNfcmVzY2FuX3RyeV9mcmVxKCkgYW5kIG1tY19hdHRhY2hf
c2RpbygpIGR1cmluZyBhICJub3JtYWwiIHByb2JlCisJICovCisJLy9zZGlvX3Jlc2V0KGhvc3Qp
OworCS8vbW1jX2dvX2lkbGUoaG9zdCk7CisJLy9tbWNfc2VuZF9pZl9jb25kKGhvc3QsIGhvc3Qt
Pm9jcl9hdmFpbCk7CisKKwlyZXQgPSBtbWNfc2VuZF9pb19vcF9jb25kKGhvc3QsIDAsIE5VTEwp
OworCWlmIChyZXQpIHsKKwkJcHJpbnRrKCJDTUQ1IHJlc2V0IHJldHVybmVkICVkXG4iLCByZXQp
OworCQkvL2dvdG8gb3V0OworCX0KKwogCXJldCA9IG1tY19zZGlvX2luaXRfY2FyZChob3N0LCBo
b3N0LT5vY3IsIGhvc3QtPmNhcmQsCiAJCQkJbW1jX2NhcmRfa2VlcF9wb3dlcihob3N0KSk7CiAJ
aWYgKCFyZXQgJiYgaG9zdC0+c2Rpb19pcnFzKQogCQltbWNfc2lnbmFsX3NkaW9faXJxKGhvc3Qp
OworCitvdXQ6CiAJbW1jX3JlbGVhc2VfaG9zdChob3N0KTsKIAogCXJldHVybiByZXQ7CmRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LmMKaW5kZXggNThkNTQzNi4uY2UzZTJlMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtMjQ4OCw3ICsyNDg4LDcg
QEAgaW50IHNkaGNpX2FkZF9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQogCX0gZWxzZQog
CQltbWMtPmZfbWluID0gaG9zdC0+bWF4X2NsayAvIFNESENJX01BWF9ESVZfU1BFQ18yMDA7CiAK
LQltbWMtPmNhcHMgfD0gTU1DX0NBUF9TRElPX0lSUSB8IE1NQ19DQVBfRVJBU0UgfCBNTUNfQ0FQ
X0NNRDIzOworCW1tYy0+Y2FwcyB8PSBNTUNfQ0FQX1NESU9fSVJRIHwgTU1DX0NBUF9FUkFTRSB8
IE1NQ19DQVBfQ01EMjMgfCBNTUNfQ0FQX1BPV0VSX09GRl9DQVJEOwogCiAJaWYgKGhvc3QtPnF1
aXJrcyAmIFNESENJX1FVSVJLX01VTFRJQkxPQ0tfUkVBRF9BQ01EMTIpCiAJCWhvc3QtPmZsYWdz
IHw9IFNESENJX0FVVE9fQ01EMTI7Cg==
--bcaec5396bd4db8fb704a5336c37--
