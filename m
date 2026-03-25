Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D938E5DE
	for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774479311; cv=none; b=E4eUebySWj3NFwqh8LFEGziEQYhyD1u/Ib8sNo6rACSxHfHX5in66SR14PoCMSaRFWyaJnoDvX/VSWLu0XxbQetOaFJjan7/L4rfRwdkSMtnRrGOWoYyPZpC330uU/zQmrjYh9Sc5HlT0OroCHJ2kIVJ0P/S7EueV88J+AgMfj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774479311; c=relaxed/simple;
	bh=cfmt8Fb6+/mGsuMLAVq8l84JoLhdl8W28ndt3in8j8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbPPJEjjIBWutoU4gU41QVIZ5K5G6uZRsvYd7rtT+BMHUeBma3BgRiPtn3zCYK+sJTpS+LlgzxtIWoPY5h3ZlKj20Cvf4FVvvPbeIL5OEcZ0D6hDf9ACMko8a7Ha12K6wHAoqAmDSlQwBV28xFwbrRqNYwVZ7wPvjaShfGBrAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrnHq+OU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrnHq+OU"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso224112a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 15:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774479309; x=1775084109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jg+jxIxiDHnN00TgvSu+pP6M1fm2u7hbNztuwkGyUXY=;
        b=qrnHq+OUC5ADeKpEqWbAZLqfeOkD4ZzRcmrzD7r9S4QwpU7UbqPtZIz5bLww66sS50
         MY2ajnA3YFNi0l74nfa9d2G0Tr2UdBt8xLFaqLRusPoa6p1zypUmHZO5LszttxaVsEQZ
         KcSwrrjFyesX1WBdgg73X90PD4Q+zHb3MPbaXgdrae/iX+dNQjDdynQNwLQRlXbBod4T
         4KbyiFJXo1MeDnQIpM9yoqkeQNntokWE+UvK87kTsC3RLvbpxZ0MRyPGC6XQn1CBAUfb
         sXLyq/SGXbbhZzI9q7cMB9DAo1nE4Od3cZPWzHhriFPOnftnuBRntXKvTH0Gf4gUD/1z
         QXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774479309; x=1775084109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg+jxIxiDHnN00TgvSu+pP6M1fm2u7hbNztuwkGyUXY=;
        b=Dls+EEX6/CWyjo3jX7u4eepyM9TrDOTNdilZNYL18qEXM62rqXuBLXjNQ7sjoKHJuP
         0cWl/5d7MM/+DCfKBOAO6veVgxhudO4M45ItH8WXNCwO0AYwobbwIgBpXjGxl+eeIjcw
         cpDuo5RqQeEe0NSSn6nXEPyyIgNi0ymYwa2QgPqxABGop3OpWqAxqAaqbePR5pTQmTFM
         NIsQPJEPmQyQWxYJfUIMi22leYfzb7qyBjOYtBbZi/ZKmvWF4lxHubXONQgZYsn3DqIE
         2lWrKQdXPz/nVpsIhZZLOk3By36aTIwOmDo2IVvumQ3aKLWN+c1s3ztbwVE2BkyYcdoR
         25lw==
X-Forwarded-Encrypted: i=1; AJvYcCXFVY1QLXO1hGx1/ten2LrWd2pbpNC4YxJFLXi31nhSUpwEE9UgHdlZopiYQbXXs3/ofgQFwtEMmoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+acDGiElUeJstadMTjSyn8CxPV/nm/wSIq7AA6Ey01MBD7Bf
	UCOgswPu+hiEXYYjOS36q7S0O4w/tVVjYFOz4XrWotD7MbtA1qRsg4p/
X-Gm-Gg: ATEYQzxU1cdSzz2pqYdN6y+/o9z1PEge1Pev7Gm6s0rVkoEE8z6PA7wmzmEhidc/w0z
	izPkJG1oqTT4sIMs3yzVslbIxTuKGvTu7fd/j1IJb4VBFC9qdqKQBiZZG1ftRh94UDPWeYuJQlr
	JnW7zLLEj2Fk4aA0yKRNuJ2yUUqDx3qyj+MDEoaBJYZ/dPFW8A3ND4TkeczqCgzBukmeMndtI3E
	87Dp/+P5Mi3aFU7/6ogHuRlFVxbJin5Kn4ulbGtpC0kDCrv7PXRHJldADoD4alHicmL7EEfenB+
	SayNkTpY31hsoqBe472bkrslSFjpWy9GT+z4eH++cSjA04OLMCafnwieeXxEzu8A10kTZ5Bpm6H
	Sat84rMkoi7JA4+gcUxNstwgmxJCpjlL0XpA8rc/hsHt6xS8UUB2bN1/vFwGub81hwM3mkMJ0/o
	dIKYDc6U28mINx7/ptXsbhYq/t
X-Received: by 2002:a17:90b:3f47:b0:356:7b41:d348 with SMTP id 98e67ed59e1d1-35c0dd95083mr4052323a91.20.1774479309361;
        Wed, 25 Mar 2026 15:55:09 -0700 (PDT)
Received: from arch ([2409:40c2:5018:3ab3:ebcf:9aee:dece:80da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c1e1a64absm84066a91.2.2026.03.25.15.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 15:55:09 -0700 (PDT)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	xuwei5@hisilicon.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	zhangfei.gao@linaro.org,
	linux-mmc@vger.kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	rougueprince47@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] mmc: hisilicon: Convert dw-mshc bindings and fix dtbs
Date: Thu, 26 Mar 2026 04:24:37 +0530
Message-ID: <20260325225439.68161-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Hisilicon dw-mshc text bindings to DT schema
format and cleans up legacy node names in Hisilicon board files.

While testing the new YAML schema, dtbs_check flagged the hi3660, 
hi3670, and hi6220 SoC files for using the non-standard 'dwmmc' node 
name prefix. resulting in warnings.

Patch 1 Convert to DT schema
Patch 2 updates the Hisilicon dtsi files to use standard 'mmc' 
node name.

Changes in v2:
 - Patch 1: 
    - Grouped compatible strings into an enum.
    - Replaced raw numbers with proper flags.
    - Fixed property order and removed invalid hex values.
    - Added explanation for clock order change in commit message.
    - Collected Acked-by tag.
 - Patch 2: 
    - No code changes.
    - Collected Acked-by and Reviewed-by tags.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
Note: this patch is part of the process for applying to GSoC device
tree bindings conversion project #
https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

- The file is enabled by arm64 defconfig (CONFIG_MMC_DW_K3=y)
- It is used in following
    /arch/arm64/boot/dts/hisilicon/hi3660.dtsi
    -included by /arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
    /arch/arm64/boot/dts/hisilicon/hi3670.dtsi
    -included by /arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts

Bhargav Joshi (2):
  dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert to DT schema
  arm64: dts: hisilicon: Rename dwmmc nodes to mmc

 .../mmc/hisilicon,hi3660-dw-mshc.yaml         | 117 ++++++++++++++++++
 .../devicetree/bindings/mmc/k3-dw-mshc.txt    |  73 -----------
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   4 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |   6 +-
 5 files changed, 124 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt

-- 
2.53.0

