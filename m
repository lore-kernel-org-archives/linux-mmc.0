Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com [101.71.155.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62B449B2D
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111283; cv=none; b=HIS+NEfG/8NpB7vT8Hx16Z42xkAoqQD76F+1NhciKRRIrXMbFMxDCjE85g6vyFeM4dBmLkOfgTgBLIHpeBER9N704JEeSEFwhmx6Gz+HN3MmOuspvwrzp8TRpNpZ9FfSpXxeGQtREwd1gcDlXmd7zSfrQT81TNwzZuzQd+4kyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111283; c=relaxed/simple;
	bh=EyMbagwZAMrqPyXh2Odo7NMiz5JZU5Ke1yXp6tPdaBE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Oy5m1veJOCca4HOl+6mOikBTVy+Ffv38p78eDjB+ReJgut+dwrjwLI9P6G9dLMw4YIVnpGtVSxZy/sD6mhOeT+f712W7U7O4NDbZpr/j+jP/4xP8WclvQPbie5b//dpygqVhPMK9Ks2R1T/td9AMiOnvF5HvR+dHksIBH3H8mm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BeB+ZyFO; arc=none smtp.client-ip=101.71.155.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BeB+ZyFO"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d64b9645;
	Fri, 11 Sep 2026 14:45:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [RFC PATCH 0/4] Add SDIO userspace passthrough support (kernel cdev + mmc-utils)
Date: Fri, 11 Sep 2026 14:44:52 +0800
Message-Id: <1789109096-196082-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa08f36ee5103a4kunma7c49b4e5df1aa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGR9LVkgeGksZSR4aSk9NSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BeB+ZyFOpEzRobcJGu6zat/O176IOmima2wE2kjhffRsa6XNvWOBiRNgpZlRux3mtzitIallMe66S1P2K8Fassb5qt+VHz2/xcFoj7RZ7ftXBehN5vHX2RRELqwEyt3e4WIVGU6YRKFEY+hVTWu8zxjvBLua5xwabz9pnAT28ek=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=IBsK0D/ReBzPbJQbNDeG0eds+EAmpQjPAwfqpDy3wxs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Hi Ulf

This RFC series adds raw userspace access to the SDIO register space,
spanning two projects and therefore threaded into a single series:

  - Patch 1 (kernel tree): a passthrough character device exposing
    CMD52/CMD53 to userspace for every SDIO function.

  - Patches 2-4 (mmc-utils tree): SDIO enumeration in 'mmc list'
    plus 'mmc sdio' commands using the new interface, i.e. the first
    userspace consumer of the kernel patch.

They are sent together so the kernel UAPI and its user can be reviewed
as a whole. If you prefer, I am happy to split them into independent
threads per project.

=== Motivation ===

SDIO cards are normally driven by function drivers (brcmfmac,
mwifiex, rtw88_8723bs, ...), but bring-up, debugging and factory
test frequently need to poke the SDIO register space directly:
CCCR/FBR in function 0, or vendor registers before any function
driver is bound, and some deployments, notably lightweight IoT
boards, want to handle the SDIO function entirely from userspace.
Today the only way is to write a tiny kernel driver per device.

eMMC and SD already have userspace tooling in mmc-utils; SDIO is
conspicuously absent from it.

=== Why not lssdio? ===

Standalone SDIO enumeration tooling already exists: the lssdio script
of the sdioutils project [1], and the sdio.ids database proposed here
comes from that very project. Still, I would rather grow mmc-utils
than use lssdio, for two reasons:

  - Userspace tooling of a subsystem is conventionally unified:
    USB has lsusb, PCI has lspci, and MMC/SD cards are already
    enumerated by 'mmc' from mmc-utils. SDIO devices live on the
    same subsystem, so extending 'mmc list' is their natural home:
    one tool, one consistent output format, one place to maintain.

  - lssdio is a standalone perl script, and SDIO devices are mass
    deployed in lightweight IoT/embedded systems where a perl
    runtime costs 10-20MB of storage - a non-starter there. mmc-utils
    is a tiny C binary already present on most boards shipping eMMC
    or SD, so SDIO support comes essentially for free, and the
    sdio.ids database it needs is a few KB.

=== The patches ===

Patch 1 (kernel tree) adds the passthrough interface, patches 2-4
(mmc-utils tree) are its userspace side:

  - 1/4: Behind CONFIG_MMC_SDIO_CDEV, every SDIO function gets a
    /dev/mmcX:YYYY:FN node with two ioctls: SDIO_IOC_RW issues CMD52
    for single byte read/write - function 0 addresses the card
    common area (CCCR/FBR), a raw flag reads the register back
    after write - and SDIO_IOC_RW_EXT issues CMD53 in byte mode for
    1..512 bytes. The ioctls require CAP_SYS_ADMIN and take the
    host claim for the duration of each command, since raw access
    can disturb the state a bound function driver maintains.

  - 2-4: mmc-utils learns about SDIO end to end. 'mmc list' now
    enumerates SDIO cards one row per function, decoding vendor/
    device/class ids through a new sdio.ids database imported from
    the sdioutils project (see "Why not lssdio?" above for why this
    lives in mmc-utils). New 'mmc sdio read/write' commands issue
    CMD52 (single byte, function 0 included), and 'mmc sdio
    xread/xwrite' issue CMD53 for multi-byte access - hex bytes on
    the command line, or a binary payload via the @file form.
    Example session on the RTL8723BS board:

      # mmc list
      DEVICE         DEV                 TYPE  MANUFACTURER                PRODUCT                                  REV   CLASS  SERIAL  DATE
      mmc0:0001:1    /dev/mmc0:0001:1    SDIO  Realtek Semiconductor Corp. RTL8723BS [Rockchip] (WiFi 802.11b/g/n)  FF    WLAN   -       -
      mmc0:0001:2    /dev/mmc0:0001:2    SDIO  Realtek Semiconductor Corp. Unlisted(0xc822)                         FF    00     -       -

      # mmc sdio read /dev/mmc0:0001:1 0 0x0
      fn 0 addr 0x00000: 0x43 (67)

      # mmc sdio xwrite /dev/mmc0:0001:1 1 0x1000 0xaa 0x55 0x5a 0xa5
      fn 1 addr 0x01000 wrote 4 bytes

=== Testing ===

Tested the full stack (cdev + all mmc commands) on a board with a
Realtek RTL8723BS wireless module (one listed and one yet unlisted
function);

=== Open questions ===

  - Device node naming: /dev/mmcX:YYYY:FN reuses dev_name() of the
    SDIO function device, consistent with mmcblk naming. Any
    objections from a udev/systemd point of view?
  - UAPI: SDIO_IOC_RW_EXT embeds a 512-byte buffer in the ioctl
    struct to keep the API dead simple; a user-pointer variant would
    avoid the copy for larger transfers but CMD53 byte mode tops out
    at 512 bytes anyway. Reasonable?
  - The ioctls require CAP_SYS_ADMIN since raw access can disturb a
    bound function driver. Is that the right knob, or should this
    additionally/alternatively refuse access when a function driver
    is bound?
  - 2/4 adds a CLASS column to the existing 'mmc list' table (shown
    as "-" for MMC/SD). Is changing the existing output acceptable?

[1] lssdio announcement on linux-mmc:
    https://lore.kernel.org/linux-mmc/20230214195702.ungo5roxliq7pjas@pali/

Shawn Lin (4):
  mmc: core: Add SDIO userspace passthrough character device
  mmc-utils: lsmmc: Add SDIO device support to the list command
  mmc-utils: Add sdio read/write commands for CMD52 access
  mmc-utils: Add sdio xread/xwrite commands for CMD53 access

Patch 1, against the mmc tree:

 drivers/mmc/Kconfig                 |  11 +++
 drivers/mmc/core/Makefile           |   1 +
 drivers/mmc/core/sdio_bus.c         |  12 ++-
 drivers/mmc/core/sdio_cdev.c        | 189 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio_cdev.h        |  21 ++++
 include/linux/mmc/sdio_func.h       |   4 +
 include/uapi/linux/mmc/sdio_ioctl.h |  48 +++++++++
 7 files changed, 284 insertions(+), 2 deletions(-)

Patches 2-4, against mmc-utils:

 Makefile       |   4 +-
 docs/HOWTO.rst |  29 +++++-
 lsmmc.c        | 286 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 man/mmc.1      |  20 ++++
 mmc.c          |  25 +++++
 mmc.h          |  26 ++++++
 mmc_cmds.c     | 234 ++++++++++++++++++++++++++++++++++++++++++++++
 mmc_cmds.h     |   4 +
 sdio.ids       | 206 +++++++++++++++++++++++++++++++++++++++++
 9 files changed, 817 insertions(+), 17 deletions(-)

-- 
2.25.1
