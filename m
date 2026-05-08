Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160E337B81
	for <linux-mmc@vger.kernel.org>; Fri,  8 May 2026 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260997; cv=none; b=YjlslojV4tkrM/hpRTxDOgSKbq/pvCjoyQkeURZ+s96ROMGVkM9vOCiHguAzj8Y9lAs+XOHAL3x/Spdh7i123NENvqZ8V+TfqK2a0B0/f0tJ+IUYRkNhTJsvAygx0Hew9/Uvy4ZgxcndLb4S9PwDW615XEAlIhxE7Y7Btq3Rq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260997; c=relaxed/simple;
	bh=NN6N7TQCE5GHBwFcGQIJrNm6PvYKJPI2VA57CmSdpUs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mEYV9V3o+vlEU8KfjEBQSHS/FEq/oqFsCZO/aqH1TKIR0nkHqdmYoTvgKir7lZEzyF8qOLmkhiORqyK7DfJcrFafuKnbxsjroRCh74hXL1/kZiQiJzNSkaq5DO0PJODhro0NM1rZx1qrvbaTnx2W93AXlJBlJ9A+LaSmtzDrdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpKtVLvJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpKtVLvJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b9ea536877so15743215ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2026 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778260995; x=1778865795; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YXUQyFk3/gkaOHXxMJL4LSnKxu/TPQvEZNmcErPubxM=;
        b=KpKtVLvJXmH1dafpVUtGFfa6x6wwMG2maQOTW2/2vfJsDzdTVZV5M09rckTlaJURiX
         WXnvs1mzyBaKo1ZmCoBE1OAd2fYkCvBTfs9zz+0DvNWklaB3LrLLli+SCA8f2vjApeyj
         Z29YNq2NkuxRrwnqe/9N681VZJpq4HkXKKZ/GFT/gPNaLkJsOe/owM6I5LKoQaeqh0jy
         kCF64FFbdsrHPHEr58qSM/X6RMtyfepGTwKwhadxNRgSxABlyZsREnx+V/O73Yxc3tAw
         QKykNPdD3SLwM7Fr3yWZGnVOL4mIMamiz2o+7I7jUo+VEvm9mfhfU/oTEHl+chMRCfFw
         JCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778260995; x=1778865795;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXUQyFk3/gkaOHXxMJL4LSnKxu/TPQvEZNmcErPubxM=;
        b=pl1ZkWzrVkVLbgaGxm/NMmjiKPAt0Jvx7jxh5ThVovEn5dEy2yv2x27v0mFPepl+mf
         2mYNuTYFmnVpxH2Jau3/oFQfT0z9EkE256vnd7kLdn9/hYhA49ft82REEuLt1gZhCBEg
         ZfFRzKmHueUACq12ij7zrB49Q07iqrFQvQbPYRbgVqRnJKcCK15GBRvqDKfqxVxi8Pn4
         G34LMRtbFSApCm56gKjYJjdaJiQsbBcAj1d3XW0Y9vn+Hy2t2ozJ4gZ+ohhag7ZcmE/G
         J6KhYrYm+4UgdQZOnNBfsK4M6egZ+273VBHJX52m9eeMc2uzb6lPsjt9o1Ck056QkRi9
         NAtA==
X-Gm-Message-State: AOJu0Yx6tWkQPKt9hDNkNsmrf/3xVTBo05TlilXyg03C3tMVPujELqaM
	2b8RLl2Iz/ULANRlUK3Leyy3wzaRABSRgKtoe0TjsY3P5g5RwTxtyYSV8pf/nA==
X-Gm-Gg: Acq92OEktsFo0xjiqxVqM6hP7S3Xy5kDxRPOpdCUnfehXdnZcWQ+BCKy2ueTLNNtcTs
	BlWruZmrYuE6TGMfne+CvsXGvaQmjA+SKXyQCyGdYkb2RN/J+iWpcuml5DgP3PO8YGlAAYBcUVk
	Jf2kQaaJFhjJVDiUTXb6aaf2mQOy1bqMG5I/u07TJ3Bmeo4d6Z8u4J85ifCzn99KR0rUKjlN5MW
	YhfRmZtbdUnIEqxHCvB9BDfKIH8mmjPaEUZ4Mhk25uyfvlezV2Kwe5kSV88bfYbmGzGcZGxdkPj
	OYnOf/MJfs9ffqvChlxHzpcoQlighwbBz1N+2NejAaj1Ha4Qpac6dBRFDYztjAbqGVFFFAkBpXP
	gSBta63QtPQAOCwcHoO81J83NLDPeUD38dIEj+giq4ELf+bNYV9lXYi42s2nhECaRM4c6LdWBw6
	DeLox1ICgz9OlhOEmp8MeW1iRojG+fHCukB5PapmufC1He+J3pkoSUexM=
X-Received: by 2002:a17:902:8492:b0:2b4:68c9:302a with SMTP id d9443c01a7336-2babd4a48dcmr51407625ad.17.1778260995443;
        Fri, 08 May 2026 10:23:15 -0700 (PDT)
Received: from Black-Pearl.localdomain ([60.243.224.75])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2baf1e35487sm24907985ad.46.2026.05.08.10.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:23:14 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v3 0/2] dt-bindings: mmc: st,sdhci: convert
 STMicroelectronics SDHCI-ST MMC/SD Controller controller binding to YAML
Date: Fri, 08 May 2026 17:23:05 +0000
Message-Id: <20260508-st-mmc-v3-0-81c329ed28e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPkb/mkC/02Myw6CMBBFf4XM2jFth6K48j+Mi6YM0MSCaUmjI
 fy7BeNjeW7uOTNEDo4jnIoZAicX3ThkoF0BtjdDx+iazKCEqgSpA8YJvbdoa1GZptZteyTI53v
 g1j220OWauXdxGsNz6ya5ru9EKepPIkmUWFpdkpKWNOlz54277e3oYU0k9dO0oK+mUKCUhrNWN
 cryv7YsywtaZuRZ0wAAAA==
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
      dt-bindings: mmc: st,sdhci: convert to DT schema

 Documentation/devicetree/bindings/mmc/sdhci-st.txt | 110 ---------------------
 .../devicetree/bindings/mmc/st,sdhci.yaml          |  91 +++++++++++++++++
 arch/arm/boot/dts/st/stih407-family.dtsi           |   4 +-
 3 files changed, 93 insertions(+), 112 deletions(-)
---
base-commit: cf2cd8efd046c561191b8541d32a8bfe845bf06b
change-id: 20260327-st-mmc-c906ad95ff83

Best regards,
--  
Charan Pedumuru <charan.pedumuru@gmail.com>

