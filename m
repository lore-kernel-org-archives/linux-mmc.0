Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96E295DB8
	for <linux-mmc@vger.kernel.org>; Thu,  2 Oct 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439090; cv=none; b=K1xMANmsyr2f32dq35q4CAw208AZ9xPnqmlAaRuCDDzuzxj9oePwbpEaFVf6CemJncDMthoWlhp4qwjZ0/GMPNQPxU/ODr/q5QlopsTd2LFavxuyztx+M/eLgCHPo3ufu4jHxjrmMTlRTNRMXgDQ6WCe+a5p3Sc5ZOznQgJ9/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439090; c=relaxed/simple;
	bh=jK7kxcxxZSZOzxffNSAiY6865wMbhPwApNWPua55We8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=no6h8CAzECHXyDVQw7RWUZPybHtNLLbDmo/VDAwiaDtJ1svQv3tbVin3mFXLc5BHTvHKVYGMD8JY56PsqBMA8YxGzWY7vFCfnXJjTu/r8YFCBe6d3u3fe+7j+y6H8xus+r874rkNeH3GmZVuOipHil1LjOal1n8VlZbW1UYWSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B+mHKi7F; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B+mHKi7F"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-91fbba9a8f5so121759439f.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Oct 2025 14:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439088; x=1760043888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0VBquDv6g415iy1L7kGakH7H853FAzWxsvjxiCHfN8=;
        b=TTxSvK95L9+wTiRdsnrNalyzrTpSucpL40cHyySsXcZm/GFgtMMgTB78DmtWunKQkq
         OipvpNbGUysNCqqDsd+XBMUpJs04vVbstx0YWp6x2tETBi1B4HuScAJQvbAJw9fj3bs8
         kkZ0et9C1qlY/5ZNtKMazJrFj8qMFAKsFhCx7MOexBrB7B0ho57Eb9F3+kzjqgQjRsfq
         yksr47eIEoXeKyJLvcxblsJc4cG4NTLRTwGjzrykqEnC/OV5UXKkFiEUe8XEslZNloNq
         3q4aWgbZlpB4va0+RM8EERr0D1yYF1mJJOuHocJFXE3kQ1xlXcCJJN0/EGItkjAuJxdO
         fL9A==
X-Forwarded-Encrypted: i=1; AJvYcCUT2QNtQwSV7F5zv9GZLM3dVTeLjPaePTzSS0YoPPIXoQFWdAqyffUO6iSODzWBwKqmy+EB+hYNTvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz47yx30avSqfOZ21FekJCbRHHsGx512lF5CHJ+6i/sZlk60TTp
	3hrPnVrMtGtZM2Cegnt4jgN+FXXyecZHVEaZ//Ob6eavK4MyDioFdhP026hmoEiW6e4fqlCIzGH
	rX1fhhFv19390uGinx4VSM0+W6PML5AquhAm0vOxCO1lESklvMMWvrPe5Sh1PtOwUnG4moMwRt1
	tCBm5rRE1jaQZt4KZX3pBQe2lya3s0yO1VLXmeRzDCy0OnAmHcZmILjcaPrbzkdgzOvDdDHmf37
	SUigo+oIY5l
X-Gm-Gg: ASbGncs2Xp1Jeb0+rNJ9BIUTrcZuKPODifqzzi1oHHU9S/BRO8CshPhJ9CfbRLHCCtM
	1T5vOwq6g6USdGaIj8jzfamV96Zf3vrGgOLpWPdqUuUlfiXFEOEotbesJ4A5w/NwXwvP0MYq6cq
	eOgx502aZlRLBj8JkVd5Ji9+M7i+7X/uxveZ5zc7t3SoDD2mBDYIhuJoo6S27TLRIsjPm2BVOJK
	SsiZuDAZuqMicDKxQKHTLDy0qChFQDn3mlUGFt17+TSJRneAHh/rMzgEJVjJIIDxj9ANh1zebiV
	UDo/A3jKPQQiROPREOSHwddWbxrb4Y67T0kgv433UsWpArluTMr3MTqpZ+Udi+5c7Ux/dh0xUGc
	qr3g+8ORPsNhh+oNPZMdJEWaw2wNr6ZurmBxMFRMhIlSpqgUpeGkQT0PRklxAyeBFPZ/dkmf1IJ
	aQ6UrV
X-Google-Smtp-Source: AGHT+IHHVATxbdwspUWeMLtdO5/G32K2auLnw7/22Q4dTA0DALfCu60yRxUqbF7vXvrAXXhj7ertZSauG9pa
X-Received: by 2002:a05:6602:1688:b0:926:bbfc:a562 with SMTP id ca18e2360f4ac-93b9664cc6fmr82303739f.0.1759439088235;
        Thu, 02 Oct 2025 14:04:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-93a860bdbe3sm15337539f.17.2025.10.02.14.04.47
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:04:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so11674685e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 02 Oct 2025 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759439086; x=1760043886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0VBquDv6g415iy1L7kGakH7H853FAzWxsvjxiCHfN8=;
        b=B+mHKi7FrxKqXf4T4MBS5guhb/3IiPhc4kpJMT8Jx/STD3M/UTs5QwsYI3aQXdqBe6
         gCg7OSputMXRtqZg/Sf3Zq6g0mwI7VaJ/P1tM5hyPlI6IDsV0YS/ZBaNgX1GlVYCbBaj
         p6s/CpiPQ8Caear653sKwVVQ5eCE54X4YmGVY=
X-Forwarded-Encrypted: i=1; AJvYcCW3iSgEwc4zYtbG95y/wGNd4qdI4rqgmHfPdkOR2YXufxPQ5pNn9AYge75yAQn5GS6hFxGDCkDEP/U=@vger.kernel.org
X-Received: by 2002:a05:600d:420d:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e71172104mr4721665e9.36.1759439086300;
        Thu, 02 Oct 2025 14:04:46 -0700 (PDT)
X-Received: by 2002:a05:600d:420d:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-46e71172104mr4721505e9.36.1759439085831;
        Thu, 02 Oct 2025 14:04:45 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm61711295e9.8.2025.10.02.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:04:45 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host controller
Date: Thu,  2 Oct 2025 17:04:24 -0400
Message-Id: <20251002210426.2490368-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Updating compatibility to support BCM72116 and BCM74371 SD host controller
similar to other settop SoCs.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index eee6be7a7867..720d0762078f 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -21,9 +21,11 @@ properties:
       - items:
           - enum:
               - brcm,bcm2712-sdhci
+              - brcm,bcm72116-sdhci
               - brcm,bcm74165b0-sdhci
               - brcm,bcm7445-sdhci
               - brcm,bcm7425-sdhci
+              - brcm,bcm74371-sdhci
           - const: brcm,sdhci-brcmstb
 
   reg:
-- 
2.34.1

