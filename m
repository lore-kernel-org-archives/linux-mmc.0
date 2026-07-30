Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A83415F2B
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411129; cv=none; b=GqsvQX48H1GS+Zz7SBjYqMMegcCTSi2QlmYNOpuugzw9xuMXOU+8uWGAd7Xpnk11EpLIlYkS+kutLCdhstSN+a+5fYCpWSO7H+4q8A4iOJ1KDN6y/H4XyH0QKK+BcUB6e6oc5jmz47Ld5JcSvoHbyp1SZCLQ39VgACQNPBL/CGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411129; c=relaxed/simple;
	bh=ztojtsJcgm/HN1h3twmpiuxbRjK1HrCwlx+0aoQ69AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QcFoXW8mMRi3lldbN5ZaPIxvGfS75flKjTwc4FFl98hGRrx7kOeF5iLVYuyHwZnScCPzDQaQuauccVAVZesJOlBRCpk0tMGY/4syzDCXKQ+DdM31NtI7975KhNr3m2bWdIe9iljaPRUcAgNAkwEII2mBmpLYEbDV1uoys3y9O0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLR6d+s4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLR6d+s4"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1379041f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411124; x=1786015924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yjmBegB3RiqLoHhBho8LH0LOARZI5UYSPYaZVtCSLIw=;
        b=DLR6d+s43YKKaNabVRU5SCi9C+j5j9Vi0OKbl66bbpw2A5Ah6idWAW/ssbXIWt/u7W
         O5VfwxhieaVMsVmV+KNgi0B6A9JaIrHnNijacMuDBzytbroo/rShRAp0YWcFIDL9r4sc
         AUmM3PkI9Cr5gIT3L25RAVv4RvGfm2PcT0DwcAY3O9GuoptlTsgdvC4ImGkaTsp8p6AD
         sx7qh1KLqqZDSjz1/YQTq1/KBuvrSsFSpceesYcSbAvBxQke3t3cPRxY9EJJT549okjV
         RaY9Xftg1XVwc8Nx04OZIKikqk8VKTIEiBkY+xWk5K+pQ6Ef7lSCNQKmlW9MaS/S4OT2
         BSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411124; x=1786015924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yjmBegB3RiqLoHhBho8LH0LOARZI5UYSPYaZVtCSLIw=;
        b=pgnbo6Xf0Q32c/MfpaqdLTJepxAQmcq3EgkXBIPBnQutp+b9oXLvtJ/CafVDwUe5Xo
         gPJbvwQ+M5ptTc25T92E4tjAt4HWrcSeyVMT+5OIyk8B8JaakTBCWKrIoDyLAvxV3dWK
         a85LbzPlepA+Rjx84cRpJtBc5GFD+a+AO9ftw81qdv3MYwcJna1lZTqc95Ve+MYN2Tiq
         cHFFk8kLDhwSi0qu+0a38u6FNSRcL2ddLK7C4Ij2Ja980qzsOvtDzPwdWeK7KzyfzSw7
         MLfz+FGMEEmmxDlqZp37ClBWtc6xQ+uN0u8h4IoA2zcma+aUDoiHl2fsjs39BVAeAk5u
         FZmw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1jU/XcVqzNtpon7/HxESNtrXdiryQVaDr4mqTsVt98xhvJ5ZzypJrYhZ58qBRpq8QQIQ4slW1Cz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyImMctOYlpfqt2qQwIYBFvITlXSYHIM8WQFZdwH00lKa80cge
	u5vZP2nRzm/rDfoVNXNsM4SHKYTZTwyZA3OxlHf0Bqq5LyN9qdwndXU2PTKxbQ==
X-Gm-Gg: AR+sD12q6lCfMcZzubxkPruHcFDQweHYlB8+9CZCMnZCxoGYoRhW19rvFyLCnMsgyZy
	Pl8+wO2R5BG2LML5BCbv1FvCnp+OOVdUF6h26YkgGys/L4uJ245gyKz+h4znC34IdNftOtk/l0r
	tLKbaIaIX/zAR35JPLOw5+chnHVT7oc/Zuwws6du0SdMk+/ElK8h+tfKDN2kdXTOcjw08iwg9QT
	F2wgUTvMWs5KDOMX5BiUkBQrSlNH+tAbLgSOf/XdcVp01cdEGSqNoL/qCODdlVWn+KsJaArqtJW
	EZgdEwClzdM35mZGDDCa556p/X7hOzbacp4lwMRbCPBNzTDoCnCWaWzHuGVd7pGfaJzUmujR5R7
	O+yC07qsxOkUK4baV+z1XGst0Zld0+0I5Enq4AxrHqGDvTvLwdFTNMqh5bSkntgl1+DerrcZy8g
	r8Y0yFjQejwEXy8DC9VlHVBerburiCyXjrgmkmA+2oXk3qPqPwTdbup43dnDCbjAlPz4jObGQiI
	eZKrHOYeuzhPg==
X-Received: by 2002:a05:6000:250d:b0:47f:9464:86c3 with SMTP id ffacd0b85a97d-47fc8215decmr3145913f8f.57.1785411124315;
        Thu, 30 Jul 2026 04:32:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:03 -0700 (PDT)
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
Subject: [PATCH v23 00/14] Add Renesas RZ/G3L SD/eMMC support
Date: Thu, 30 Jul 2026 12:31:38 +0100
Message-ID: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
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

v22->v23:
 * Added write32hook function for hardware idle synchronization for
   CTL_SD_CARD_CLK_CTL writes.
 * Changed the data type of max_divider from unsigned int to signed int.
 * Assigned of_data->clk_div_mask in renesas_sdhi_probe().
 * Updated commit description for patch#7.
 * Updated tmio_mmc_reset() to handle 32 bit divider register in RZ/G3L.
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

Biju Das (14):
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
  mmc: renesas_sdhi: Add write32_hook for CTL_SD_CARD_CLK_CTL register
    writes
  mmc: renesas_sdhi: Add RZ/G3L SDHI support
  mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
  mmc: renesas_sdhi: Make HS400 OSEL bit configurable per SoC
  mmc: renesas_sdhi: Add RZ/G3L HS400 support
  mmc: renesas_sdhi: Add HS400 enhanced strobe support for RZ/G3L

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 ++++--
 drivers/mmc/host/renesas_sdhi.h               |  12 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 337 +++++++++++++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  78 +++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  16 +-
 drivers/mmc/host/tmio_mmc.h                   |   7 +
 drivers/mmc/host/tmio_mmc_core.c              |  13 +-
 include/linux/platform_data/tmio.h            |  19 +
 8 files changed, 499 insertions(+), 91 deletions(-)

-- 
2.43.0

