Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B78259CAE
	for <linux-mmc@vger.kernel.org>; Wed,  5 Mar 2025 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210890; cv=none; b=qE0D/3RBjaGTFoX3TS5KoiPCcm+8i6nL8LMBvTjcARx1px7QKKjFUGXNB+m3HENoAkUkjunKzqsfhv1dYJxPTkg4bIHcghEmvV4uNomkTMvtbMc3hRhE+vHDObwCviN1Ut0PJ7xmJ7hbQGER838kgGhJQvXyaiWTsMRA6tvT70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210890; c=relaxed/simple;
	bh=WWTRVJuyzpdI59DPD8jMGqY0GuaQoshgyrwbY2RUU1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BMHfT3DFms6qON1r+C8YCt9NaLx5PGX7H2tMkvJzLtXWRvUk8j9SY4nL8VefORvwEiWyQgJQsnDiEapDn91ksyN6zfU+T52z3iMaOwRvJwBcKMirytlovm6rvFpOHEIodJWnWHYuMwpKYrC2CLNRJmuQLn+RUlCx+YQfvZrbCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=C/3NoK1C; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="C/3NoK1C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1741210881;
 bh=innxyVjkg+mq6x4IGX11r7TVyyqnex8mH7N+cCGoDio=;
 b=C/3NoK1CkHNOiiCGT1hqMCnoNv6iZVK/+bJN/tbN8kVpSm2o+kNWiRsFJlU6whXO1Rl8hr7/u
 MmMpNt742FKHF3OCvLmm7Vi1rQJH9n7+dFx4XPKsah09R1pDBkSr9/+TCvAALYZ3fD41e5Zt6fD
 P/x6349yaDWHtCTgmd94JBo2PG4Jpzg6ofltbvuUDuYCZDtEnEcWUD19+X6WT5PUSoycJdPvDtC
 XPYoBawzWGhjRQzjKX3itsKYF8gFFOZbWmvxjI6UtUqBBKDIBfmGOoK8eNtTFoX2XY0rYh28T64
 U03sra4HNxb8nmqu7fU0OHFSRpsQf5Ng3gfaAnRUrAKw==
X-Forward-Email-ID: 67c8c4f988fb7bbab4530f30
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] rockchip: Add support for onboard eMMC on Radxa E20C
Date: Wed,  5 Mar 2025 21:41:01 +0000
Message-ID: <20250305214108.1327208-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Radxa E20C may come with an onboard eMMC (8GB / 16GB / 32GB / 64GB).

This series add dt-binding and SoC DT node for the SDHCI controller
and enable use of the SDCHI controller on the Radxa E20C.

This series add support for the onboard eMMC on Radxa E20C.

Driver changes to use different delay and tap num is needed to be able
to support HS400 modes, something for a future series. With this HS200
mode should work:

  mmc0: SDHCI controller on ffbf0000.mmc [ffbf0000.mmc] using ADMA
  mmc0: new HS200 MMC card at address 0001
  mmcblk0: mmc0:0001 TLi16G 14.7 GiB
   mmcblk0: p1 p2 p3
  mmcblk0boot0: mmc0:0001 TLi16G 4.00 MiB
  mmcblk0boot1: mmc0:0001 TLi16G 4.00 MiB
  mmcblk0rpmb: mmc0:0001 TLi16G 4.00 MiB, chardev (499:0)

  ~ # cat /sys/kernel/debug/mmc0/ios
  clock:          200000000 Hz
  actual clock:   198000000 Hz
  vdd:            21 (3.3 ~ 3.4V)
  bus mode:       2 (push-pull)
  chip select:    0 (don't care)
  power mode:     2 (on)
  bus width:      3 (8bits)
  timing spec:    9 (mmc HS200)
  signal voltage: 1 (1.80 V)
  driver type:    0 (driver type B)

  ~ # hdparm -t /dev/mmcblk0p1
  /dev/mmcblk0p1:
  Timing buffered disk reads:   64 MB in 0.37 seconds = 173154 kB/s

This series depends on v2 of the "Support SD/SDIO controllers on RK3528"
series for a clean apply.

Jonas Karlman (3):
  dt-bindings: mmc: sdhci-of-dwcmhsc: Add compatible string for RK3528
  arm64: dts: rockchip: Add SDHCI controller for RK3528
  arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  4 +++-
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 12 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 24 +++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.48.1

