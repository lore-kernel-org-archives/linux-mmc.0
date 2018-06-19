From: Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 0/1] eMMC controller issue on Intel Baytrail SoC
Date: Tue, 19 Jun 2018 08:31:18 +0200
Message-ID: <20180619063119.3955-1-kurt@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, kurt@linutronix.de
List-Id: linux-mmc@vger.kernel.org

Hi,

I've encountered a problem on an Intel Atom E3825. When performing lots of
reboots (10, 50, 100, ...) the eMMC controller stops working. The reset commands
won't work anymore and you get error messages such as:

|mmc1: Reset 0x1 never completed.
|sdhci: =========== REGISTER DUMP (mmc1)===========
|sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
|sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
|sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
|sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
|sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
|sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
|sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
|sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
|sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
|sdhci: Caps:     0xffffffff | Caps_1:   0xffffffff
|sdhci: Cmd:      0x0000ffff | Max curr: 0xffffffff
|sdhci: Host ctl2: 0x0000ffff
|sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffff

After using ftrace, I've discovered that this issue happens when runtime power
management is utilized. So after searching a bit, I've found the errata list for
the E3825:

https://www.intel.ca/content/dam/www/public/us/en/documents/specification-updates/atom-e3800-family-spec-update.pdf

Erratum VLI10 basically states, that suspend/resume shouldn't be used. Otherwise
wrong data between memory the device may be transferred. Therefore, I've
disabled runtime power management and the issue disappeared. That's what the
following patch does.

This patch is tested against v4.17 and v4.9.

Any suggestions?

Kurt Kanzenbach (1):
  mmc: sdhci-pci: fix eMMC controller issue on Intel Baytrail SoCs

 drivers/mmc/host/sdhci-pci-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--
2.11.0
