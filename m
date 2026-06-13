Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9A25776
	for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781343588; cv=none; b=c9Yl0pVz0AY/MUPsZDjiz5PTGEyc0+Fp8bUzZFk2iRcslHTQO2zXOCILnNz3+Gtsp1sGEW92063eA+PXW8dtgIR3n5L5xAUlKRFDQ9pUQFBldI9LlnOTJbsTWh3q9tzI38f5i1y5RMT8UOhg6B/JC6b+vpIqBQOlFDuhQCKpQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781343588; c=relaxed/simple;
	bh=0S6TK3LPErCSFayvbXziaRw3zak6S+hHC3Py82gYe5k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y9BbomREaIn5pI6DTxomOx3KdBQCUtqtPBV95bnEZsLNf/Ckoecpurbq/d639dyiz1GN2sBMelYu4V5dD4Fi/c07Fu19ZIrHsrnqInackuNbVu4b09qi+IJyUBMS7QgkuhjiMEWKonfhjmEnTx1wSQiPJhDSqNYXcZ/U5vCGITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrVZpZmo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrVZpZmo"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c86214eead7so789885a12.0
        for <linux-mmc@vger.kernel.org>; Sat, 13 Jun 2026 02:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781343587; x=1781948387; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8ETabvgyXaefxG7MMag31gPiFKWJAnshBNUt1PyL3o=;
        b=LrVZpZmoWjD31ixI2eUdC+jqUiDzxzaWu9vywdpfEdASU3i+sqYP7WfIEID0TvVPvA
         +YBUBe1wudYGqhtauyx9v5S/oh1dE5M6xVc/zzvWhTcQUnjatb7UNUNg0UtUWIX+82UD
         X7Vu5PgztI922u1/P38BHOKOdRr0BreUstMCES2fg0Ikk0cL8WHZX0wUQzijsn2lRoqg
         tW1NcAhhE9aSjdktyv3wOg7bD5lKeeXAhaH03RkTAqx7eSwW3jRINRnU2xACXYuSaRRo
         TOph6JqTl24C24yMgbKf5C3lJMw5cItrABlMftY86L+4IY3PIR9EDRrLcQJrf+4HucGg
         Potg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781343587; x=1781948387;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8ETabvgyXaefxG7MMag31gPiFKWJAnshBNUt1PyL3o=;
        b=kAUwDv+s2v+ePNGfcBYtwySKQFjXBOtog7zSMX+IYXlHAPuZIeNPCEnUmkxRbwaM7R
         rdUh7QyQ31JnqG9jCP86vv8q6+HU5d8Ii5TvDpbZ6QECiSo5jm+ZTe+vzEJoQerZpn0n
         xilahnfUGu/brWRe6+iOHcCUqAoAjz2ZsVTCfSwjBhauRyxIhLlt7Rghp4aKO65JWcz5
         MkzyZ/HbX0Lp4uCzXaQDWzkM4P9aw9jAjxqJ63wdvSQxAI29WXjrNTbjG8B7C6Ihosbh
         x5oiLWVIbA8NoN8Q4CTOm0QD9p4sgtCePgbFK+3J1lwjrEbi52ulKpk30BT4Pl2yheUH
         uyXg==
X-Gm-Message-State: AOJu0Yy8TkDewVs9vGDB4mBhtfSd0no67qqljLEQstK9hWx1bw9foBXH
	ZrNRJT+08GO7YWHTP3BtxWPjEAWkjmc5rDcpwKLw060Xmlp9wIP2lf+R
X-Gm-Gg: Acq92OGDS6scZPJBBanM4u8Ful0DrEBSNC1sIVGVxFgfE/ktMBiL2d9Tttgj/P6bkTZ
	iW9kJhZrXEYIm/agGPjjIquOUXbIdeprPkQq7v0eg6F+WXoFD33gnZDOieQ+KBQ/E122Ro9xTiv
	iiqyAbYs5O5FrUkQnCFywMt+AfLVlCHzvDKg0LRVJox+6mFeN3dqP7kpsvDhUGT83bfOtLA/maS
	hjdZHSKgqO+PQpTUb6wKoje7tf4DG72DTbm1y5rGlCYyTdBorCXkuuOPIJOvuG4a5o97b6M6FzO
	eEjOJH32KNKggl2ZMG6CTiP+IEyXGMJ1IAGqZVoiswCqF+qDBtZ300ubRi+REKiJUDurFZfE+a8
	BIk1MsWzvLhKasqd5SWDjkN3LNHz3sTjwtcSb4vheKFRRCVRfEGkwBaBdzc0z+297fM+3NTI8RZ
	IPdNr00T/NpEr8ZahyDGO3A3gG90cWYrJtEC87grRuU1As
X-Received: by 2002:a05:6300:6690:b0:3b4:640e:f6c7 with SMTP id adf61e73a8af0-3b7857debcdmr5756051637.14.1781343586541;
        Sat, 13 Jun 2026 02:39:46 -0700 (PDT)
Received: from Black-Pearl.localdomain ([49.207.61.84])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c8661a67603sm4155826a12.0.2026.06.13.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 02:39:45 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v4 0/2] dt-bindings: mmc: st,sdhci: convert
 STMicroelectronics SDHCI-ST MMC/SD Controller controller binding to YAML
Date: Sat, 13 Jun 2026 09:39:38 +0000
Message-Id: <20260613-st-mmc-v4-0-b3c385617c16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFolLWoC/13N0Q6CIBTG8VdxXHcaHMSgq96jdeHwqGyhDZyrO
 d89tGWuy++M35+JRQqOIjtnEws0uuj6Lo38kDHbll1D4Kq0GXIsuMQTxAG8t2ANL8rKqLrWkqX
 Hj0C1e66h6y3t1sWhD6+1O4rl+knk3HwTowABuVW5RGGlkurS+NLdj7b3bEmM+GOKy40hcBCip
 MSKCi39M7lnemMyMZ0+QkMVatJ7Ns/zG5md3FcKAQAA
X-Change-ID: 20260327-st-mmc-c906ad95ff83
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.15.2

This patch series converts the legacy text-based Device Tree binding for
STMicroelectronics SDHCI-ST MMC/SD controller to DT schema (YAML) format.

Note:
The patch "dt-bindings: mmc: st,sdhci: convert to DT schema"
depends on the patch "arm: dts: st: align node patterns with established
convention". If the DT schema patch is applied before the DTS
cleanup patch, `dtbs_check` will fail due to the presence of the removed
properties in the existing DTS.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v4:
- st,sdhci: Add minItems: 1 to clock-names and reg-names to allow single-entry
  configurations, fixing dtbs_check failures on nodes that omit the
  optional 'icn' clock or 'top-mmc-delay' register region.
- st,sdhci: Modify the commit message to explain the changes.
- Link to v3: https://patch.msgid.link/20260508-st-mmc-v3-0-81c329ed28e8@gmail.com

Changes in v3:
- st,sdhci: Edit description of reg property. Modify reg-names. Add
  "minItems" for clocks and clock-names properties.
- Modify the commit message to match with the updated changes.
- Link to v2: https://patch.msgid.link/20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com

Changes in v2:
- Fix node name in DTS for the MMC to match with the estableshed convention.
- st,sdhci: drop unnecessary properties, modify "reg", "reg-names" and
  "clock-names" properties, include an allOf with $ref to mmc-controller.
- Link to v1: https://patch.msgid.link/20260409-st-mmc-v1-1-4c54321c3535@gmail.com

---
Charan Pedumuru (2):
      arm: dts: st: align node patterns with established convention
      dt-bindings: mmc: st,sdhci: Convert to DT schema

 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------------
 .../devicetree/bindings/mmc/st,sdhci.yaml          |  92 +++++++++++++++++
 arch/arm/boot/dts/st/stih407-family.dtsi           |   4 +-
 3 files changed, 94 insertions(+), 112 deletions(-)
---
base-commit: cf2cd8efd046c561191b8541d32a8bfe845bf06b
change-id: 20260327-st-mmc-c906ad95ff83

Best regards,
--  
Charan Pedumuru <charan.pedumuru@gmail.com>

