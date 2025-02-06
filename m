Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1B22FF3E
	for <linux-mmc@vger.kernel.org>; Thu,  6 Feb 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879807; cv=none; b=NkhNGPAgvdtIKttDSoojUxignUiKJ3pp3mz9HBchMI9g4QhRcwkh/njni2jUNxsXEKFHAdGhpRK65j/JoGevwwthebFXaZjjk1W8GWksKbrX9BxJXQpU1QqQEVbcYS3lho/4rEKcZAa/8To1HR6lo6d6kOm1tdcnkWQNU3v2grY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879807; c=relaxed/simple;
	bh=AL/Q38C8GaSxB2X7k5q4eSMpVP3I19XETccxZ0i5coM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EYFeQez742G8YH0bR5OiR4sqT7CAUcpj4XDoAITkHzVnVaTxCDlaNNbH3kXDw0wXaLOoP9miyDM3wCn2iLuqTz3o5LSEjTzhCS40rt4eqiWOlmomGyE1TxYSoTqJ3/xJW2O8fOfprpEirWcC3dXkeYJCVrUETmNPgOtL/k6mPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c4Qdvfg8; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c4Qdvfg8"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fa22d0b88fso834614eaf.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Feb 2025 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738879804; x=1739484604; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O/a4xSagbqmb3UAk03PlQCeWIa4LP7rwRFx2VsXaGsc=;
        b=c4Qdvfg8OlT6hyAxhE0d+XDrCrKjQhneFcw+wMCTWxYPXacw52kid/Jd/SC6Sl7evx
         IdXx1uSIpY/Lr27wJa3GcPSYn0SzMe+EG4QFt1CApbBqizkLIZErceIuTUkpqgX6VCVe
         DFHRdCvC5rDiUXNr8bwVYvglhWF8xfip6GBxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879804; x=1739484604;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/a4xSagbqmb3UAk03PlQCeWIa4LP7rwRFx2VsXaGsc=;
        b=xOtftbfCdQm/zHAse4nKC7ORsBmU5sQ50VQvTtG2DetcNEKaG2fOKsf01BNba4MEKj
         Kdy4pCyEQcEukNaeltxFsDICfd7aPbdav9nlrfEIkAJBj+0j3nCKg0KUgaojVtyGI+4U
         Ril9ltjKHjss6PtAUTv7Phr34+BrgQfmXisdRyNzdzGsAxMR0WhmJ/anCHfIcKFGq/AZ
         F62GNtoFQoE1YIig1nYTg5BsXV6Ba40l275LilO3Gz3xpXbzX9/wATxUA4GBjyG0UftD
         vgBGVGYtSGat9StS5aP5x9i/9Sq3oxYH26jglDeKOA9bkw/CTfB38KCbnyuNIlmzv6Kz
         hNBg==
X-Forwarded-Encrypted: i=1; AJvYcCXfsi2IMYCYVhVnGxUVV4w9Z7bJUE0cSP2TqFAvBUtVWuRi3E1b96qXzXBqNO2M4OP+JNu0dD9Q5IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2GMhUhwoIytmyKbGjolJmCJhGowy5i/hO+F/icga6s4SxRn4
	hwOZv+baByokLRBkdKU4fk38PvPOO7zzaHeJ2fv4IAUZsCfBkExIe+m6e7ZDJw==
X-Gm-Gg: ASbGncsIGuJu3zEbWEa1YL3tz+M8a04YFwOL2qQFO5N4G5lFhIK/YUQ2rsO7rDe5RN2
	7NdzklJJJi19gKnDtPvQWYQbpcuDEdKtgqSExKcF8GJmB7zYS4XwG35+NXhXn4rvc8Vbajcizai
	Pod/ftdAysO5de6W37iXXY2wMJ3jQJ3q1BXx8n+VqTu8yiq88CxScB/ocnSigiHEnVH2vY4m4KI
	t2Rms58osVLGHQLk6sttYtiw+rn9C6fH68iNDiMmeAwp3pEyfjgw+5FPw1mgr6q/gKciBC/U1d+
	BJFKC7HFKnzmTQH9X43ro+V1rSjvi1ff74lx1znHSbxTt3U54UQ=
X-Google-Smtp-Source: AGHT+IFUhC9g3GBMlrCIsfgANO5KdvzDEnLHzgT9bVl7MomkcLWvLwEBIiP+tF9jny8ui4xtcfFe6w==
X-Received: by 2002:a05:6820:1689:b0:5f8:b916:2516 with SMTP id 006d021491bc7-5fc5e45b47fmr729717eaf.0.1738879804274;
        Thu, 06 Feb 2025 14:10:04 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544cf88esm454109eaf.15.2025.02.06.14.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 14:10:03 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	wsa+renesas@sang-engineering.com
Cc: f.fainelli@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH RFC 2/3] dt-bindings: mmc: brcm,sdhci-brcmstb: Add sdio sharing support
Date: Thu,  6 Feb 2025 17:09:39 -0500
Message-Id: <20250206220940.10553-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250206220940.10553-1-kamal.dasu@broadcom.com>
References: <20250206220940.10553-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Kamal Dasu <kdasu@broadcom.com>

Introduce emmc flash sharing support using hardware semaphore
and SDIO share register to synchronize between TZOS and linux.

Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml         | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index eee6be7a7867..b0ee39aeccb1 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -27,15 +27,23 @@ properties:
           - const: brcm,sdhci-brcmstb
 
   reg:
-    maxItems: 2
+    minItems: 2
 
   reg-names:
     items:
       - const: host
       - const: cfg
+      - const: share        # Optional reg 
+      - const: mmc_sem      # Optional reg
+      - const: flshr_ipis0  # Optional reg
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+
+  interrupt-names:
+    items:
+      - const: SDIO1_0
+      - const: recv_ipi0   # Optional interrupt
 
   clocks:
     minItems: 1
@@ -76,6 +84,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - interrupt-names
   - clocks
   - clock-names
 
@@ -111,7 +120,8 @@ examples:
       supports-cqe;
       non-removable;
       bus-width = <0x8>;
-      interrupts = <0x0 0x27 0x4>;
+      interrupts-extended = <0x1 0x0 0x1f 0x4 0x18 0x11>;
+      interrupt-names = "SDIO1_0", "recv_ipi0";
       clocks = <&scmi_clk 245>;
       clock-names = "sw_sdio";
     };
-- 
2.17.1

