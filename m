Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0F4570EB
	for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819446; cv=none; b=G+0CE84FZdZcVpanbn+Mi/3GqiM0IDalxS9U6TGhYj9Z9gvsQSRQ33xF1brHnxypi/PMhXALbLyUY+iSJjoDAUp+fyzBcvJXDsXjSxp0pE+Z+/H116WspbAFsdEAEdK8rM9OcK9/En4ANiby3eMMZ1QQI7cV4k/I1xa85UVIpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819446; c=relaxed/simple;
	bh=EVKYh0hJpbNTkxAN0Fy6wrmdeRWDWspj/uqgj2/jeVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvgtBSsm3zJvc5jRtVhPtb2Q+/uLTWtxSp7LzevVtu496RuVoKPnqLkhdzBvej1mZFffaLU6nKu3iozSetdmM1YFzC35D9SXOIaQwr04FK1lMc7fUdp6LO1x5A+OG3+AM1lWdM24SK6w8vmR1HDUQonkJQVJF+BuhAvDUC4+ScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9bvygYC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9bvygYC"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso525480f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2026 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784819428; x=1785424228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SKlsvS68nxwTrHyc02FS9ZWm7a5IuxUhAPHwjUHdRyc=;
        b=L9bvygYCfQAtTx+kf77n1AC4Q0Fcsp3GJx2coXKtAPFnJmZrBxVF0OJcpgDsc8Vu3h
         5Z/CO3R5TU4cLIhzxaLrEKLSaKYfeoAb+VlGjpBbOdHkXfMA0EWRW4OJMqk10hvZf1b3
         l8zr1hIwsebQg/3zhGVYyJDNBk70DwV5WCL8RgUIoxxL15u0L0CVU0obxDBpOJ5yrdtp
         ugXBAD1OLsF1C8J0TIWReo5+tJF6UTwzqxUMLjugy2EL1CjSJPEQOEGsKhQ9039f+qVh
         xk6v9bNaGdmMd20oYEFaDLrhS0KIUj1vxQvJJTFEIg9r+5un/ZmQvladdJcwMxq3eNmQ
         +M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784819428; x=1785424228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SKlsvS68nxwTrHyc02FS9ZWm7a5IuxUhAPHwjUHdRyc=;
        b=i5D6ulgVcmBTZfuzizfBSwO87FxxGlY1wQBVcnt2P4R+91Nt+OzgFCkyPIOsgvT9kI
         Uz8J+sdycLKza3hbxcsyI0zAZoLF0ZFFKEejQH7mHailCQxVa1JtgelHNOJd02Vw7sOf
         Fx1KrGq1Cp3uEsrSt6RyGyJJg6+I31DStFY98UAcudyArJlGi4UedIXL9cekIfhlXXe7
         k0DL14fPuf4lvoI4vB20Pt+5RlPTZmeVuSQbX2DGpiSD6noHbtESycQnzdYWg5oPXFGD
         nRRhudr3mGo0Bt/la9GWVofysyywQ5DpnHA379hP4IZ7wxq/wsHiVkAUxIFk7o+i+pab
         cWTw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Fjw7+YWptrsCiNFLcWNAw5X0+xojtJjUHYzewECeeYaUhkN9ZcCofywZQqnDaG4NuX7otWogdns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuzjcIrmUTkuTMeS9wCMLldwVws2aK96O9K6BBIwreBoJ3fS4o
	3gqEcfFTD2gdMHtSTYPxO5XXG8DBiRsoMoJcI08rq9hz4IDjsBM9ECvs
X-Gm-Gg: AR+sD11JaIDJUiTTovpP3Dmmj+8wOoa7HEY6QB0pgh39XAkGDG4CXZZIJ7e7f/MWAs5
	lEZ5629F1SceUEdIqFIt+RKPtepdfMvhImv5eNOWy+tQ8aeaEaYQWKJRqEpzH5eH+6zYmcKHIdU
	uHme6IamHPBPokqVLLHWhofjSL+kerKyQqUAIDtJWJzh3gqrHu03Asa/4cxsGqgdeVbBtaY+osf
	kiKhZpohEhZS00kMqSBwNdXmmE0hMuL3JkzkcrUbYzoq+oihfR+WXHwVXq1m8HKHEE/g/AR6a29
	7NtO11g5x0hght6hIZiqZEyDeEXkpt4KfCK1pftQ+FyGEofI5lfBKhcy+ie9rL4wxE9qyt56zEO
	9mN2oHPVldrhY6UgLkldRVYkEWVGcapiayhpjFBzz5yE+8KAaaHIceiqiofVMwVy7g4B3uzrE5r
	Yoo0i8Yc6+ZasRrgyCJrsGZt6L7mtX7908r98h3w==
X-Received: by 2002:a05:6000:612:b0:47f:9461:7747 with SMTP id ffacd0b85a97d-47f946177aemr432689f8f.20.1784819427717;
        Thu, 23 Jul 2026 08:10:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:f073:32ed:a057:cd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb81dcsm15886823f8f.12.2026.07.23.08.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:10:27 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v22 00/13] Add Renesas RZ/G3L SD/eMMC support
Date: Thu, 23 Jul 2026 16:10:04 +0100
Message-ID: <20260723151024.318918-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

The Renesas RZ/G3L SoC has:

Channel 0 supports SD and eMMC (including HS400/HS400ES).
Channel 1 supports SD and eMMC (except for HS400).
Channel 2 supports SD.

The SoC supports a maximum frequency of 150 MHz. The SD0 interface does
not support IOVS and PWEN in the SDHI register (no internal regulator),
unlike SD1 and SD2. It has an internal divider for all modes except HS400.
It also has a 2048-bit divider compared to 512 on others. Moreover
RZ/G3L supports HS400 enhanced strobe mode.

This patch series support all modes. Please see the test logs for
smarc-rzg3l[1]

This patch series tested on smarc-rz{v2l,g2l,g2lc,g2ul,g3s,g3l,g3e},
rz{v2h,t2h}-evk and hihope-rz{g2h,g2m,g2n} boards

v21->v22:
 * Added HS400 ES mode after fixing inode corruption when eMMC is
   mounted as rootfs.
 * Updated commit descriptions for patches #4, #5, #6, #7, #9, #12,
   and #13.
 * Added clk_div_mask to of_default_cfg and of_rcar_gen2_compatible.
 * Added a renesas_sdhi_set_hw_adjustment_delay() call to
   renesas_sdhi_init_tuning().
 * Added renesas_sdhi_is_internal_divider_enabled() and
   renesas_sdhi_clk_get_rate() to simplify the clock rate logic.
 * Added `clock &= ~GENMASK(9, 8)` to clear the divider mask bits in
   the register value.
 * Added a renesas_sdhi_set_tmpport() helper to set delay values.
 * Added a check in renesas_sdhi_is_internal_divider_enabled() to
   return disabled status when in HS400 mode.
 * renesas_sdhi_reset() now restores data strobe register values
   after reset.
v20->v21:
 * Dropped HS400 ES support due to file system corruption, will add this
   mode later after investigation.
 * Added support for make clock divider mask configurable
 * Added clk_div_mask to RZ/G2L of_data.
 * Added clk_div_mask to RZ/G3L of_data.
 * Restored actual_clk calculation in renesas_sdhi_set_clock().
 * Updated renesas_sdhi_set_clock() for RZ/G3L HS400 clock handling as
   it supports only single clk divider value and other values are
   prohibited.
 * Updated commit description for patch#12.
v19->v20:
 * Replaced the check mmd->clk_mask with mmc_data->clk_mask and moved
   the code after assignment of variable mmd, this ensures assigning
   the default values for non-DT platforms and DT platforms with no
   device data.
 * Replaced the check mmd->max_divider with mmc_data->max_divider and
   moved the code after assignment of variable mmd, this ensures
   assigning the default values for non-DT platforms and DT platforms with
   no device data.
 * Fixed the ordering of resets in suspend/resume paths.
 * Added bitfield.h header file.
 * Reworked on renesas_sdhi_set_clock() to handle the 11-bit divider
   case and the 32-bit register write.
 * Updated resume() with scoped PM runtime call.
 * SD_CLK_CTRL clk enable turned off before updating SCC_CKSEL_DTSEL
   register.
v18->v19:
 * Updated commit description for patch#1,#2,#6,#8,#11 and #12
 * Updated clock and reset description with AXI master and AXI slave
 * Added else condition for reset and reset-names.
 * Renamed aclk->aclkm and reordered the axi clocks similar to resets.
 * Retained the tag got binding patch as the changes are trivial.
 * Fixed the clk_mask for non-DT platforms.
 * Fixed max-divider setting for non-DT platforms.
 * Replaced the magic number '9' with ilog2 function in
   renesas_sdhi_clk_enable().
 * Dropped divider variable from struct renesas_sdhi.
 * Updated renesas_sdhi_clk_update() to return rate for HS400 mode
   and non HS400 mode(uses 1/2 internal divider).
 * Updated handling for clk divider.
 * Renamed TMIO_MMC_HWADJ2->TMIO_MMC_HWADJ to make it generic for
   hardware tuning delays
 * Dropped duplicate SH_MOBILE_SDHI_SCC_TMPPORT2 macro
 * Updated suspend/resume with scoped runtime calls in suspend.
 * Fixed extra space in HS400MODE2 comment block.
 * Updated the comment HS400mode2->HS400MODE2.
 * Dropped the updation of clk handling as it is taken care in
   previous patches.
 * HS400ES support is enabled based on of_data.
 * Fixed the space in HS400ES comment block.

v17->v18:
 * Collected tag
 * Merged patch #4 and #5 and updated commit description
 * Annotated the empty sentinel entries in the OF match tables with a
   "Sentinel." comment for clarity.
 * Retained the tag as it is a trivial cleanup.
 * New patches drop struct renesas_sdhi_hw_info, instead using
   renesas_sdhi_of_data and tmio_mmc_data.
 * Dropped clk, pinctrl, SoC, and board dtsi from this patch series;
   will send later.
v1->v17:
 * Collected tag for binding patch.
 * Resending the series as there is an issue with patch threading from
   patch #14.

[1]
Logs:
HS200:(With internal divider)
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios
clock:          150000000 Hz
actual clock:   150000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    1 (driver type A)

SDR104:(With internal divider)
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc1/ios
clock:          150000000 Hz
actual clock:   150000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

HS400: (Without internal divider)
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios
clock:          150000000 Hz
actual clock:   150000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400)
signal voltage: 1 (1.80 V)
driver type:    1 (driver type A)

HS400 ES: (Without internal divider)
root@smarc-rzg3l:~# cat /proc/cmdline
rw rootwait earlycon root=/dev/mmcblk0p2 net.ifnames=0
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios
clock:          150000000 Hz
actual clock:   150000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400 enhanced strobe)
signal voltage: 1 (1.80 V)
driver type:    1 (driver type A)

s2ram:
root@smarc-rzg3l:~# echo mem > /sys/power/state
[   72.838238] PM: suspend entry (deep)
[   72.864225] Filesystems sync: 0.021 seconds
[   72.875166] Freezing user space processes
[   72.883030] Freezing user space processes completed (elapsed 0.003 seconds)
[   72.890237] OOM killer disabled.
[   72.893612] Freezing remaining freezable tasks
[   72.900038] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   72.907677] printk: Suspending console(s) (use no_console_suspend to debug)
NOTICE:  BL2: v2.10.5(release):2.10.5/rzg3l_1.0.1_rc2
NOTICE:  BL2: Built : 11:18:41, Jul 15 2026
INFO:    BL2: Doing platform setup
INFO:    Configuring TrustZone Controller
INFO:    Total 3 regions set.
INFO:    Configuring TrustZone Controller
INFO:    Total 1 regions set.
INFO:    Configuring TrustZone Controller
INFO:    Total 1 regions set.
INFO:    eMMC boot from partition 1
INFO:    Loading image id=39 at address 0x44428
INFO:    emmcdrv_block_len: len: 0x00001000
INFO:    Load dst=0x44428 src=(p:1)0x260000(4864) len=0x1000(8)
INFO:    Image id=39 loaded: 0x44428 - 0x45428
INFO:    DDR: Retention Exit (Rev. 02.05)
NOTICE:  BL2: SYS_LSI_MODE: 0x12051
NOTICE:  BL2: SYS_LSI_DEVID: 0x87d9447
INFO:    BL2: Skip loading image id 3
INFO:    BL2: Skip loading image id 5
NOTICE:  BL2: Booting BL31
INFO:    Entry point address = 0x44000000
INFO:    SPSR = 0x3cd
[   72.951851] renesas-gbeth 11c30000.ethernet eth0: Link is Down
[   72.955613] Disabling non-boot CPUs ...
[   72.957320] psci: CPU3 killed (polled 4 ms)
[   72.961085] psci: CPU2 killed (polled 0 ms)
[   72.964897] psci: CPU1 killed (polled 0 ms)
[   72.966874] Enabling non-boot CPUs ...
[   72.967144] Detected VIPT I-cache on CPU1
[   72.967202] GICv3: CPU1: found redistributor 100 region 0:0x0000000012460000
[   72.967250] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   72.968284] CPU1 is up
[   72.968428] Detected VIPT I-cache on CPU2
[   72.968462] GICv3: CPU2: found redistributor 200 region 0:0x0000000012480000
[   72.968493] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   72.969465] CPU2 is up
[   72.969633] Detected VIPT I-cache on CPU3
[   72.969673] GICv3: CPU3: found redistributor 300 region 0:0x00000000124a0000
[   72.969714] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   72.970760] CPU3 is up
[   72.989187] dwmac4: Master AXI performs fixed burst length
[   72.989231] renesas-gbeth 11c30000.ethernet eth0: No Safety Features support found
[   72.989275] renesas-gbeth 11c30000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[   72.990364] renesas-gbeth 11c30000.ethernet eth0: configuring for phy/rgmii-id link mode
[   73.005175] dwmac4: Master AXI performs fixed burst length
[   73.005205] renesas-gbeth 11c40000.ethernet eth1: No Safety Features support found
[   73.005236] renesas-gbeth 11c40000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[   73.006314] renesas-gbeth 11c40000.ethernet eth1: configuring for phy/rgmii-id link mode
[   73.177702] OOM killer enabled.
[   73.180837] Restarting tasks: Starting
[   73.186007] Restarting tasks: Done
[   73.189570] random: crng reseeded on system resumption
[   73.195001] PM: suspend exit
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios[   75.705532] renesas-gbeth 11c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

clock:          150000000 Hz
actual clock:   150000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400 enhanced strobe)
signal voltage: 1 (1.80 V)
driver type:    1 (driver type A)
root@smarc-rzg3l:~#

s2idle:
root@smarc-rzg3l:~# echo freeze > /sys/power/state
[   97.634564] PM: suspend entry (s2idle)
[   97.655343] Filesystems sync: 0.016 seconds
[   97.662352] Freezing user space processes
[   97.666531] Freezing user space processes completed (elapsed 0.004 seconds)
[   97.676132] OOM killer disabled.
[   97.679743] Freezing remaining freezable tasks
[   97.687107] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
[   97.695071] printk: Suspending console(s) (use no_console_suspend to debug)
[   97.744129] renesas-gbeth 11c30000.ethernet eth0: Link is Down
[  100.135760] dwmac4: Master AXI performs fixed burst length
[  100.135805] renesas-gbeth 11c30000.ethernet eth0: No Safety Features support found
[  100.135848] renesas-gbeth 11c30000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[  100.137950] renesas-gbeth 11c30000.ethernet eth0: configuring for phy/rgmii-id link mode
[  100.154860] dwmac4: Master AXI performs fixed burst length
[  100.154890] renesas-gbeth 11c40000.ethernet eth1: No Safety Features support found
[  100.154919] renesas-gbeth 11c40000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[  100.154984] renesas-gbeth 11c40000.ethernet eth1: configuring for phy/rgmii-id link mode
[  100.246688] OOM killer enabled.
[  100.249851] Restarting tasks: Starting
[  100.254395] Restarting tasks: Done
[  100.258012] random: crng reseeded on system resumption
[  100.263468] PM: suspend exit
root@smarc-rzg3l:~#
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc0/ios[  102.690106] renesas-gbeth 11c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

clock:          150000000 Hz
actual clock:   150000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400 enhanced strobe)
signal voltage: 1 (1.80 V)
driver type:    1 (driver type A)
root@smarc-rzg3l:~#

SDIO testing:
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc1/ios
clock:          100000000 Hz
actual clock:   100000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    5 (sd uhs SDR50)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
root@smarc-rzg3l:~#
root@smarc-rzg3l:~# ping google.com
PING google.com (142.250.151.139): 56 data bytes
64 bytes from 142.250.151.139: seq=0 ttl=112 time=7.679 ms
64 bytes from 142.250.151.139: seq=1 ttl=112 time=12.283 ms
^C
google.com ping statistic
packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 7.679/9.981/12.283 ms

Biju Das (13):
  dt-bindings: mmc: renesas,sdhi: Document RZ/G3L (r9a08g046) SoC
  mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
  mmc: renesas_sdhi: Add clk_mask field to support flexible clock
    divider widths
  mmc: renesas_sdhi: Add max_divider field to support SoC-specific clock
    ranges
  mmc: renesas_sdhi: Make clock divider mask configurable
  mmc: renesas_sdhi: Add tuning delay support for RZ/G2L
  mmc: renesas_sdhi: Add TMIO_MMC_INTERNAL_DIVIDER flag
  mmc: renesas_sdhi: Add optional axis/axim reset controls
  mmc: renesas_sdhi: Add RZ/G3L SDHI support
  mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
  mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
  mmc: renesas_sdhi: Add RZ/G3L HS400 support
  mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 ++++--
 drivers/mmc/host/renesas_sdhi.h               |  12 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 327 +++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  78 ++++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  16 +-
 include/linux/platform_data/tmio.h            |  19 +
 6 files changed, 471 insertions(+), 89 deletions(-)

-- 
2.43.0

