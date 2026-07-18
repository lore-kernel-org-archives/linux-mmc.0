Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC838B7D1
	for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784381927; cv=none; b=KTLgSQQZFP3RJyy81/cZQ53P4a42j1EwX64YQ4Jm2uWSxNZfxGrKkfyi6SsuzhV9Gy4/kqf/a34HEsevjzz83A8RAY52rR0yiT3wJY8FOdXAQicxZF0RYmzy33kINICFrA6v31Az+XXoAx1oi0QSGxY3LcqG86bORyxUDlqu1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784381927; c=relaxed/simple;
	bh=L6q8CQ0N7zqDWuVPfSeUOvk4ghMeoh/UjYCRZrdkbwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZ5RqQ6ZVR6ZYCNp7SwA/AzBrFe4jRZ9fCCeinns6FgpjDmJoLM6s2icYaSQkzP9oN1DT3fBZWJiOxwOuq2IWUDoldlrisqXiNd4Wbe/JtyoPiVIlYmMJejj51eG0UmppC+u6XbDZJuczHHDEuNMDJpspaPA1+Co3fsc3hyAj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWVPr3ue; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWVPr3ue"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954d29264cso5716695e9.2
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jul 2026 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784381922; x=1784986722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L3OSWa75h1bTFuUYBpoS/TnaG1jA1To2p5t3DPZP7FA=;
        b=WWVPr3ue8zqZfwB3A+3vfR+DXVC3hQC0M9vpiqzr8YgV2KFyK9UOK33uQDOsL2DoGb
         MOzKikcKibPC1C/5yngHBcBsAlTwo97c92XRN528dFRXb4vZwqu8fLprb3xf/NLo1j1u
         86n4eELdIKFHQoH7TD523EoWFCDIgPcFCUn2BMhU8ZpOxYh1nmVdTuLl4Zn5POaDVjB4
         bYA3VMna0y/34B/8BQcDCR7UTq9CsJMI5PtqhHtWyh+QGnrwR3ILmQL5pKKHIxLFCfls
         8JQzJ/SMHfxO3G3kSbK48taO1q3dm/cjqICv7/ssj4JOVgin+ITaDQZTGL96WUp8OQ5Y
         Itjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784381922; x=1784986722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L3OSWa75h1bTFuUYBpoS/TnaG1jA1To2p5t3DPZP7FA=;
        b=OyHZk3a6uonpdEWy9e3rJ1sDhAuvpkQ+SD6Wa/6jMaCXXRibgR+aXUi4xNuqiaozvq
         Fb918jOY/Jwls+KmzHaUcBuilEZ5xM6MXrkfTcx37RPy4ND+PWftoaAyD6rybspbTUQX
         eNWWnIIF13x36U1NCCPDClJ93xwz9yLYWooOQl8Ezfr/lFNPIhmYbcvH/RbZKHm+UIfw
         AKlplt6MNZKyE4OOGQ3Pv0G0ywgnKhtSyHiM9mv4T/HgXm4LnyelS6B913XYkEsqJh+2
         mWP7yr3IKhn+I+mX/pO6RNA8A9xIQRyKleXcQdFiStzcL6lSJ9e3p+cZcxmKB2X+ai6w
         cxXA==
X-Forwarded-Encrypted: i=1; AHgh+RqtGubSS2FZg7MH9heNq1pEz29K/OhgexFn7klXRrYPVCFhR4SpuwaK5syI3k2r9F/VqMGbSjSuYx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytldESl0HTHaMWNy2T2JdqzLVgaXsPsjKoOKUDCr4ft28irkjk
	jpWkqg2vxTQ6xllR9dttQTPUmDRzuFGgrg7v92MLItRVO4ckfM4Xjy8E
X-Gm-Gg: AfdE7ckj179d1wLwBqGYuTxv7zVQ4NPhEvTmPBen/7vCyhb19bKcrd6mSwjOZTxRkNI
	Lt3cmM+XAOXep7vfKtzns+OloEb+iZ9y4hXbXr7/ie6sswHxLKLoEDbF+2SYef0W/0eRvAIEKy9
	xKNBQVi3F76yOzkHkicudXEQNEcDCo6qKPm92TydJlrbxetDehHenOwzSGxswNCrUKWZRkxLvwS
	dps1NiuETh7etB+O0kjUW6R2mziC5d5DxZ/9/svSzV033sDVeAQchwfWFHlBrKo/wuoEAiQrL56
	zu/dqPctiK9EHjfmZdgxyVveCoXRWt/VMnDO1Rz2lX3TnrF7hUzkuOnSLBVz3dQltj0OtWu/Ja+
	faOUgsnXp1FWoU5jg8lK9uHhJ+Bs1oznq2xv4cEQBCFq99ImWAPhZQACgS9U5h7h5UK6iuFaA6d
	6xPmpVpC2agRVRPzTD1b5CBFN4018=
X-Received: by 2002:a05:600c:4685:b0:495:3f99:849c with SMTP id 5b1f17b1804b1-4954a3f48ebmr86693165e9.15.1784381922032;
        Sat, 18 Jul 2026 06:38:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c53f:e1cf:6009:4c03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96ff7sm121717845e9.10.2026.07.18.06.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 06:38:41 -0700 (PDT)
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
Subject: [PATCH v21 00/12] Add Renesas RZ/G3L SD/eMMC support
Date: Sat, 18 Jul 2026 14:38:20 +0100
Message-ID: <20260718133838.152905-1-biju.das.jz@bp.renesas.com>
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

RZ/G3L SoC has:

Channel 0 supports SD and eMMC (including HS400/HS400ES).
Channel 1 supports SD and eMMC (except for HS400).
Channel 2 supports SD.

The SoC supports a maximum frequency of 150 MHz. The SD0 interface does
not support IOVS and PWEN in the SDHI register (no internal regulator),
unlike SD1 and SD2. It has an internal divider for all modes except HS400.
It also has a 2048-bit divider compared to 512 on others. Moreover
RZ/G3L supports HS400 enhanced strobe mode.

This patch series support all Modes except HS400 ES mode.
Please see the test logs[1]

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

[1]:
Logs:
root@smarc-rzg3l:~# dmesg | grep mmc
[    0.000000] Kernel command line: rw rootwait earlycon root=/dev/mmcblk0p2 net.ifnames=0
[    1.954120] renesas_sdhi_internal_dmac 11c10000.mmc: mmc1 base at 0x0000000011c10000, max clock rate 150 MHz
[    1.967729] renesas_sdhi_internal_dmac 11c00000.mmc: mmc0 base at 0x0000000011c00000, max clock rate 150 MHz
[    1.978997] Waiting for root device /dev/mmcblk0p2...
[    2.066736] mmc0: new HS400 MMC card at address 0001
[    2.077061] mmcblk0: mmc0:0001 0IM20F 59.3 GiB
[    2.095408]  mmcblk0: p1 p2
[    2.098917] mmcblk0boot0: mmc0:0001 0IM20F 31.5 MiB
[    2.106696] mmcblk0boot1: mmc0:0001 0IM20F 31.5 MiB
[    2.113966] mmcblk0rpmb: mmc0:0001 0IM20F 4.00 MiB, chardev (510:0)
[    2.228334] EXT4-fs (mmcblk0p2): mounted filesystem d267a6b0-3e0c-48b1-865c-8801ab27f2c2 r/w with ordered data mode. Quota mode: none.
[    2.483088] mmc1: new UHS-I speed SDR104 SDXC card at address 5048
[    2.496361] mmcblk1: mmc1:5048 SN64G 59.5 GiB
[    2.504683]  mmcblk1: p1 p2
[    4.455604] EXT4-fs (mmcblk0p2): re-mounted d267a6b0-3e0c-48b1-865c-8801ab27f2c2.

root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc*/ios
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

root@smarc-rzg3l:~# echo "test" > /1.txt
root@smarc-rzg3l:~# mount -t auto /dev/mmcblk1p1 /media/
[  287.682702] EXT4-fs (mmcblk1p1): mounted filesystem 6fb3211d-4e8e-4ab0-b0ab-e0d2451b9b98 r/w with ordered data mode. Quota mode: none.
root@smarc-rzg3l:~# echo "media" > /media/1.text
root@smarc-rzg3l:~# cat /media/1.text
media

s2ram:
root@smarc-rzg3l:~# echo mem > /sys/power/state
[  333.723778] PM: suspend entry (deep)
[  333.743368] Filesystems sync: 0.015 seconds
[  333.754880] Freezing user space processes
[  333.762770] Freezing user space processes completed (elapsed 0.003 seconds)
[  333.769795] OOM killer disabled.
[  333.773021] Freezing remaining freezable tasks
[  333.778915] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  333.786358] printk: Suspending console(s) (use no_console_suspend to debug)
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
[  333.827014] renesas-gbeth 11c30000.ethernet eth0: Link is Down
[  333.830869] Disabling non-boot CPUs ...
[  333.833195] psci: CPU3 killed (polled 0 ms)
[  333.837072] psci: CPU2 killed (polled 0 ms)
[  333.840622] psci: CPU1 killed (polled 0 ms)
[  333.842113] Enabling non-boot CPUs ...
[  333.842381] Detected VIPT I-cache on CPU1
[  333.842438] GICv3: CPU1: found redistributor 100 region 0:0x0000000012460000
[  333.842484] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[  333.843494] CPU1 is up
[  333.843644] Detected VIPT I-cache on CPU2
[  333.843678] GICv3: CPU2: found redistributor 200 region 0:0x0000000012480000
[  333.843708] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[  333.844560] CPU2 is up
[  333.844714] Detected VIPT I-cache on CPU3
[  333.844750] GICv3: CPU3: found redistributor 300 region 0:0x00000000124a0000
[  333.844781] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[  333.845804] CPU3 is up
[  333.873259] dwmac4: Master AXI performs fixed burst length
[  333.873305] renesas-gbeth 11c30000.ethernet eth0: No Safety Features support found
[  333.873349] renesas-gbeth 11c30000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[  333.875449] renesas-gbeth 11c30000.ethernet eth0: configuring for phy/rgmii-id link mode
[  333.892271] dwmac4: Master AXI performs fixed burst length
[  333.892300] renesas-gbeth 11c40000.ethernet eth1: No Safety Features support found
[  333.892329] renesas-gbeth 11c40000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[  333.894274] renesas-gbeth 11c40000.ethernet eth1: configuring for phy/rgmii-id link mode
[  334.066618] OOM killer enabled.
[  334.069768] Restarting tasks: Starting
[  334.075337] Restarting tasks: Done
[  334.079175] random: crng reseeded on system resumption
[  334.084885] PM: suspend exit
root@smarc-rzg3l:~# [  336.680010] renesas-gbeth 11c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

root@smarc-rzg3l:~# cat /1.txt
test
root@smarc-rzg3l:~# cat /media/1.text
media
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc*/ios
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
root@smarc-rzg3l:~#

s2idle:
root@smarc-rzg3l:~# echo freeze > /sys/power/state
[  450.999169] PM: suspend entry (s2idle)
[  451.017350] Filesystems sync: 0.013 seconds
[  451.024258] Freezing user space processes
[  451.028222] Freezing user space processes completed (elapsed 0.003 seconds)
[  451.037188] OOM killer disabled.
[  451.040460] Freezing remaining freezable tasks
[  451.046419] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  451.053881] printk: Suspending console(s) (use no_console_suspend to debug)
[  451.095285] renesas-gbeth 11c30000.ethernet eth0: Link is Down
[  453.419781] dwmac4: Master AXI performs fixed burst length
[  453.419827] renesas-gbeth 11c30000.ethernet eth0: No Safety Features support found
[  453.419869] renesas-gbeth 11c30000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[  453.420959] renesas-gbeth 11c30000.ethernet eth0: configuring for phy/rgmii-id link mode
[  453.437889] dwmac4: Master AXI performs fixed burst length
[  453.437921] renesas-gbeth 11c40000.ethernet eth1: No Safety Features support found
[  453.437952] renesas-gbeth 11c40000.ethernet eth1: IEEE 1588-2008 Advanced Timestamp supported
[  453.439032] renesas-gbeth 11c40000.ethernet eth1: configuring for phy/rgmii-id link mode
[  453.531484] OOM killer enabled.
[  453.534640] Restarting tasks: Starting
[  453.539474] Restarting tasks: Done
[  453.543086] random: crng reseeded on system resumption
[  453.548410] PM: suspend exit
root@smarc-rzg3l:~# [  455.991868] renesas-gbeth 11c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

root@smarc-rzg3l:~# cat /1.txt
test
root@smarc-rzg3l:~# cat /media/1.text
media
root@smarc-rzg3l:~# cat /sys/kernel/debug/mmc*/ios
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
root@smarc-rzg3l:~#

SDIO Testing:
root@smarc-rzg3l:~# dmesg | grep mmc1
[    1.750548] renesas_sdhi_internal_dmac 11c10000.mmc: mmc1 base at 0x0000000011c10000, max clock rate 150 MHz
[    1.949973] mmc1: new UHS-I speed SDR50 SDIO card at address 0001
root@smarc-rzg3l:~# ping google.com
PING google.com (142.250.117.101): 56 data bytes
64 bytes from 142.250.117.101: seq=0 ttl=113 time=9.466 ms
64 bytes from 142.250.117.101: seq=1 ttl=113 time=13.376 ms
64 bytes from 142.250.117.101: seq=2 ttl=113 time=13.486 ms

3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/

Biju Das (12):
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

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 108 ++++++--
 drivers/mmc/host/renesas_sdhi.h               |  12 +-
 drivers/mmc/host/renesas_sdhi_core.c          | 232 ++++++++++++++----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  78 +++++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  14 +-
 include/linux/platform_data/tmio.h            |  16 ++
 6 files changed, 375 insertions(+), 85 deletions(-)

-- 
2.43.0

