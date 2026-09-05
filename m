Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6F320CD1
	for <linux-mmc@vger.kernel.org>; Sat,  5 Sep 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788622359; cv=none; b=G3VseqCY03EO0EtGNQ8sone+5iNJdBtq0pK249sfvuLPuLLj6kUSWgv9cNj/lY00PE/FEixlVRAMZ5PqH7OH76mRLpxQaqRjLNoU3mhLUztUlxBxtcY5rRnlsP2Ymc6hR2DdpDjQXUxvVSMNS867V0p9E/+zsv5w79eCx4Tec9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788622359; c=relaxed/simple;
	bh=8J1UiXJhzVvrBOSm0Tr/M27LUtZiz4TFzi/G029Oths=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWiu4ZqyS9s0eBPu9YB0AzTp09M4aCJrFPJLd2NrVGpu82xyUN2okhm65S9tasm0UypiR5E7pe02ajcI51vopTK0ImvjyFTOAe3CMsvuj0vmtqBf+P7wnOvdhIpZ7hdOpfGY7jwhCKxqflrlouzsrEuFM9y+A9w+tgLYpyNAqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482f9309813so1835809f8f.1
        for <linux-mmc@vger.kernel.org>; Sat, 05 Sep 2026 08:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788622356; x=1789227156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jSU4aZpbll1PpORySxMO+b6aF9erqEZX1yTwxUGQHwY=;
        b=ceyTrXcZh0xSeMqQ3DcKEii0E7AfdMGfJ2txQ0gyuikz8b/6CWgADaXY8Rv5zTjYIH
         t0CXh+bPlxO0zdBQ6wvOeGyUHJ4Xcwc6DuYfuyshkH8AXWaF9/wVkU47iwWnzFisQsLy
         LwXicf//5coi+/0T12umA/zloI2aiH/m+2aupxNQIjujqkY5sSZRQyNZwe3uG0Bg9kyK
         GHdgDs2Cu4MgFcmyhCX3DfUsPpD5lYWae9vPJYay/JIfmzyCCJ2CplkNUphYcUi72rKS
         I8wqP1zwBzpifB4E0PXraLGpKyHp6u/LHSaNeoWmcnAbvG1CqQRDND9qMHUxNSmRIhcq
         2zLg==
X-Forwarded-Encrypted: i=1; AKwUvBzLO9cPg6o8CW0Jc6BCK9Hk50OpDY4lrLA0ssGocltYRMw0xRsNTTyuQIyG8nHzJQvX4WMjznt+O2s=@vger.kernel.org
X-Gm-Message-State: AFuF++mLx8ia2HQ2YKUu2I/GaFGcvarDqTlOu1LiW7iLgj0YhZMASdub
	5Z7g3zff1zyKD+N/nzsZuulyxf0xVE1FP+qNbiXdztPoxkKTXPus19Q7
X-Gm-Gg: AYBFou0JN+0MQA/3+80bHSENBpNRqhvxlpMT+LjVib3Wv225Np8Vg/AWG0IpxRjajkw
	YjDMsyXlWquKgClX6hoxplw+tq4gmm7gfEOEEK8DLVrUwUIqi/bDUB+dPNZYxwnBgpb9TPpH8qX
	rkpl2pe/XvcWCKD1nJ4KXHC0Owf3wtOniVIM0+SUM0VWzpKwZ93rZbswZwV0cEvUYpg2JXWBTKy
	w/bvTTTvtdnzGz8M+rJd1qSxDdMNaQ607vTAe3bxwqpeBQKYgOdRCKKzboOIEK8WLp8it82S2Ys
	kJgEQh0CgFcZk5mNipRb3JgdSHpJz6NT9sCdBvl6GCZC1WYOeCcTU02sgcA62B4VF8YFGtDWuMx
	zFH3cHwBiXFThF1xi/qgNzdoA8qIIv0QXHJ7MunWm5PjgfPOo09WlByOGl9ikP63/KRAX9rb2NG
	7AUpczd1wndG3KJsVnDPOJkuyw8u1kzQKatF2rSQd5CQHQUVardELePR6M/MPX1q4fGyaL1Pv2z
	DHtjw+/qapBj+vWs2duvdV1PA==
X-Received: by 2002:a05:6000:2287:b0:485:8b5c:da39 with SMTP id ffacd0b85a97d-4858b5ce1bdmr10859250f8f.12.1788622355807;
        Sat, 05 Sep 2026 08:32:35 -0700 (PDT)
Received: from threads.localdomain ([84.68.179.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm16691913f8f.25.2026.09.05.08.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:32:35 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] amlogic: t7: give the MMC bus pipeline clock real consumers
Date: Sat,  5 Sep 2026 16:32:30 +0100
Message-ID: <20260905153234.133217-1-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous series for the intermittent boot hangs on the VIM4
marked sys_ampipe_nand as critical. But as Chuan Liu from Amlogic
explained, sys_ampipe_nand clocks a pipeline stage that the
hardware design inserts in the bus path between the SD/eMMC
controllers and the NIC_MATRIX fabric to help timing closure.

So the clock has real consumers: reference it from the three MMC
controller nodes and drop CLK_IS_CRITICAL instead.

The series crosses three trees; patch 4 (clk) must only land after
patches 1-3, otherwise the DMA hangs fixed by 43e1705ecab9 come back.

Changes since v1 [3]:
 - Dropped the Fixes: tag; this series is an improvement and should not
   be picked up by stable (Jerome Brunet)
 - Moved the patch 4 dependency note below the --- so it is not kept
   for posterity (Jerome Brunet)
 - Dropped the e-mail address from the Assisted-by trailer, see
   Documentation/process/coding-assistants.rst (Jerome Brunet)
 - Fixed the space-indented error path added to meson_mmc_probe() in
   patch 2, it did not pass checkpatch
 - Dropped the CLK_PIPELINE() macro from patch 2; has_pipeline_clk is a
   capability flag, not an SD_EMMC_CLOCK register field

Thanks,
Lucas

Lucas Tanure (4):
  dt-bindings: mmc: amlogic,meson-gx-mmc: document the T7 pipeline clock
  mmc: meson-gx: enable the bus pipeline clock on T7
  arm64: dts: amlogic: t7: add the pipeline clock to the MMC controllers
  clk: meson: t7: don't mark sys_ampipe_nand as critical

 .../bindings/mmc/amlogic,meson-gx-mmc.yaml    | 29 ++++++++++++++++++-
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 15 ++++++----
 drivers/clk/meson/t7-peripherals.c            | 10 +++----
 drivers/mmc/host/meson-gx-mmc.c               | 20 +++++++++++++
 4 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.55.0

