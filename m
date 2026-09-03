Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77236A37F
	for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2026 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788476368; cv=none; b=h83Z9Dx3lbSYfHwaD296VEF/a3JJwCuY045cCxv0WvjDG2d6uKrF6qsnKfkPUJqIAFmFgogu+mqJwxL1gupk8R7U6MuhfijEASCCFK71HzhOm9QHA3mOSD751Ur7GhWLEn67mwghe4JUYGavqLbezN9UBbm36zvDrGapCJU5oqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788476368; c=relaxed/simple;
	bh=q0PEkNH4X+PaMAyot1IOtz3LQ1vAi3SlCfuAqTtRk8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+SGBO26PEVK8IIg2KHvDP2uOq0BWLyiIbyJ/6sjzFN9NrDrzvXiEZMkeQXFiRkEnlpB0YgW4y23iB2q2Js4rjzr2iXcQCe7J6yoRgNwxqSau4rTeCdOmQ9BEOOo0COm/3pukUX1jKw2QfbcwY7rjFlD4QyRVLRgHWGfGpn/W3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48584dc164fso374005f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2026 15:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788476364; x=1789081164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUDONbWsQf4g8On4R7HSZLyPEP705AHSMo8bYRBit5E=;
        b=bhjZBWO/rLdkLhI4F7wPjWPA5nj07hVOuiI0/okTAbZDFfd88ClL4J80dg92c9WH69
         HTrKt1l3FAmBxE+xeRDKkb9mZN0V0jhEzvuvT1Rec7owmB78Klqg/8oGpYSAVxY1dzUO
         XxE2yMgJW/VPo/79s9jygCrQBz/Xdkyt3IkLgwtXkFLojxgiPE9VJpjoeIuDYoOZ6K3H
         Sg2e3rJBr9FvZjV7E5BVnXq/p95gICl7DhmxF2LxillmysWHMLqjxDH5gmZ/F5dcVu94
         Ebabs+QdZNH922UBoQde2va/HsJUOPZTmnzckOyPgEViRXOBsqAOwCMl5JbCTs5tRMsH
         dQDA==
X-Forwarded-Encrypted: i=1; AKwUvBwHqVmKKY1e3YUb9ljimb1a9FLOqRf1pnr85tPQz+ynLG3S+wMPQcGPD1r/wFoCilvTgT0SiMO2kcw=@vger.kernel.org
X-Gm-Message-State: AFuF++kX42oxVACuVWcVc8Qy9JU3hcbs1auBvtj/BUqH7bXJ5bjw0Khn
	NK4VRDEHyor6eDK8aQDYWjokncBDje26FVhSMpwRROvn7VDAw2rPI6hB
X-Gm-Gg: AYBFou0w/wx+yfEt3Sj0keqppzHcAOo5uJt/Pnfwx+mBzAXB21Whmg7CgvaDKqd4Rvx
	1JFv7WImoqa1RVvl3JOWMLGX9JSd9mBsQ6mKzahYKCwrvCpUhmhaZD07WU/5E7Co/u3A7Pqnh17
	7T5XlfVj5q/cLTw4bh+BP31VxykhZKKFOe4ee3U/N6FLehhw1DHCR/SS7UkSNkNR6oOMjmaGW9Y
	2CNXcG/GD7fDjbuBUkksLf2NPp999dnIf984GKkXqZ0WkMpJt9lgleRJXJTaXq72VXVECk41sg9
	XFnqkhoC1MFsMJJsqNYTip1Zx0B+o7noN/oRbsE37j8oIha74SGM34DtUTgH3179j0ppa09uLUo
	dTWNUEbp9lSv0fPRt316ogy6F4sJYI/5FemW6+3cHPQ4K/fhmMLANHB9QGG4RP9y//T+LpLUZr0
	nJwDbsT31J4cYZ0hHEtMgBfLW3W+6WJwhvwbhiWRT2HVE4MIa4i//naauJ28MfWoYdj/epZjoAA
	b+J7YbXCzc96gmL844Jqfkg1A==
X-Received: by 2002:a5d:5f50:0:b0:485:8a46:7059 with SMTP id ffacd0b85a97d-4858a4672acmr372086f8f.43.1788476364181;
        Thu, 03 Sep 2026 15:59:24 -0700 (PDT)
Received: from threads.localdomain ([84.68.179.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885c5bbdsm1686142f8f.36.2026.09.03.15.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:59:23 -0700 (PDT)
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
Subject: [PATCH 0/4] amlogic: t7: give the MMC bus pipeline clock real consumers
Date: Thu,  3 Sep 2026 23:59:17 +0100
Message-ID: <20260903225921.2290441-1-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous series [2] for the intermittent boot hangs on the VIM4
marked sys_ampipe_nand as critical. But as Chuan Liu from Amlogic
explained [1], sys_ampipe_nand clocks a pipeline stage that the
hardware design inserts in the bus path between the SD/eMMC
controllers and the NIC_MATRIX fabric to help timing closure.

So the clock has real consumers: reference it from the three MMC
controller nodes and drop CLK_IS_CRITICAL instead.

The series crosses three trees; patch 4 (clk) must only land after
patches 1-3, otherwise the DMA hangs fixed by 43e1705ecab9 come back.

[1] https://lore.kernel.org/linux-amlogic/ (RFC: clk: meson: t7:
    Intermittent boot instability and memory corruption on VIM4)
[2] https://lore.kernel.org/linux-amlogic/ (arm64: amlogic: t7:
    describe the VIM4 supplies and keep the fabric clocks running)

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
 drivers/mmc/host/meson-gx-mmc.c               | 21 ++++++++++++++
 4 files changed, 63 insertions(+), 12 deletions(-)

-- 
2.55.0

