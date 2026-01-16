Received: from mail-m49248.qiye.163.com (mail-m49248.qiye.163.com [45.254.49.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD6031985E;
	Fri, 16 Jan 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525881; cv=none; b=Ov0cyi/rRYTEYsrjadBnhzmrFdjr0VqLyEtdmnh4iBfOhaTzW7oNZdi1MvS7Tj3xeBSfTjJrMCxCX4AccONfAJ7Rs4ms3yg5TKNEuyjBvoda6eZDOHavjP+3lArgyMo3Fb7hFudpaX3X0cqOa1xwApluayVPliJODIe5JNPc0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525881; c=relaxed/simple;
	bh=wdhCYNerUT5x76FPQQYhTof1wRylgDxTq3K0Gs/qeQo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hf0rNyHBaupo55/6WPZCQ/6yO7sbS66rPizybLq5RhO+VxB1wrJd/VPM6qncWwzlKTJX+UbsBfmWUL45UsohwVNEVcFs/RIXcElJjGUL6/4WE346EkQqInui+4nREHVepS8mYTFdg05G15/7bTDmhSJ+FhdCzlKwaArF+GyfAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RpNt6cpl; arc=none smtp.client-ip=45.254.49.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RpNt6cpl"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30d5a768d;
	Fri, 16 Jan 2026 08:55:43 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	John Clark <inindev@gmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 0/5] Fix sd card support for RK3576 platform
Date: Fri, 16 Jan 2026 08:55:27 +0800
Message-Id: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9bc44d0ff109cckunm67a197c8691b6e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8ZTFZKSkhJT0tCT0NJGBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=RpNt6cpls4sQKPLRsFD5RNbnQn+fmwg8Nb3IyAn6sxjbGG4D9uRgDvmAssf1sf1x6hoxJa9Lhnob/1hylagLNoG2syzsVpbkSPkD47di6a/tR6rrO5GcpkCKz4RM4C6WRUR5V3rjXcu4gyqYF6qKfVQC68OPtlhzY+GdavQi92g=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uoK5EkOo3ZU7QkVzkaMiSPAUrQMKeBC87ZTj6FI/yvE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


Marco reported a problem[1] for his FriendlyElec NanoPi R76S board. The problem
is becuase after runtime suspend, the associated power domain is powered off, which
resets the registers including power control bit, card detection logic and internal
phase registers. This leads to three problems need to be solved.

1. hot-plug broken:

SD card hot-plug support for RK3576 boards is broken, because sd slot should try to
use slot-gpio(cd-gpios) instead of function IO for supporting runtime PM. In order
to support slot-gpio detection method, we should disable jtag switching for RK3576.

But the rockchip_grf_init fails to handle this because it couldn't handle
multiple grf nodes. In this case, iocgrf is in behind of sysgrf, so only
sysgrf is handled. We should scan all possible nodes.

Moreover, the offset is wrong as well. Per the TRM, the address of
TOP_IOC_IOC_MISC_CON is 0x260440F0, which means the offset if 0x40F0
instead of 0x040F.

2. cards lost power:

When powering off the power domain during runtime suspend, the controller fails to
maintain the power control status as all the registers is cleared. This results in
power lost for cards during runtime suspend and have to reset the card each time
exiting from runtime supended state. Should use gpio-based regulator for vmmc-suppy
for the boards.

3. controller lost internal phases/mem-clock settings

As the same reason mentioned above, should invent rockchip specific runtime PM
callbacks to save and restore internal phase related settings.

Note: An examination of the RK3576 related dts files suggests that several other boards
may also not function correctly, because I noticed signs of copy-pasting, but I don't have
the schematics to confirm it, I've cc'ed the users of these boards. I hope they can verify
their own boards and submit separate patches if fixes are needed.

Please help review and test.

[1] https://lore.kernel.org/all/20260110010715.1610159-1-mschirrmeister@gmail.com/T/#t


Changes in v4
- add fix patches for RK3576 EVB1 and NanoPi R76S

Changes in v3:
- remove of_node_put() (Heiko)

Changes in v2:
- use for_each_matching_node_and_match(Heiko)

Shawn Lin (5):
  soc: rockchip: grf: Fix wrong RK3576_IOCGRF_MISC_CON definition
  soc: rockchip: grf: Support multiple grf to be handled
  mmc: dw_mmc-rockchip: Fix runtime PM support for internal phase
    support
  arm64: dts: rockchip: Fix SD card support for RK3576 EVB1
  arm64: dts: rockchip: Fix SD card support for RK3576 Nanopi R76s

 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts   | 22 +++++++++
 .../arm64/boot/dts/rockchip/rk3576-nanopi-r76s.dts | 23 ++++++++-
 drivers/mmc/host/dw_mmc-rockchip.c                 | 38 ++++++++++++++-
 drivers/soc/rockchip/grf.c                         | 57 +++++++++++-----------
 4 files changed, 109 insertions(+), 31 deletions(-)

-- 
2.7.4

