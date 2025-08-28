Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45B311955
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386930; cv=none; b=VybBFRB9uWtQe2eYSaobiAZM3/GbfWQu/f1iV9r4mD1ptA0EFTPPt4TdKp/oaLWVL8/ygpsAb+qoK2LopQpKUy/+ACtPkI1c+ih89PPykPhaC3ro+/pka/hHEF+pA3beYIY57lMAEgQmPIiYKVUIUO8Ym2tUF998Nme84WRmO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386930; c=relaxed/simple;
	bh=cplGFDqmgtSpbjmRX3cAoVtjixMSRofZ7eAFWsu8/iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMwpbVVpYgawqBI+5NjQw5wen41IQiNVXY+xvygPxum4DXpGYdkjS6fdmUweSZpQcnQKdUUaot5mztm2aiyUb86UWjeo/i2Rhv8gxaZmFQpnTIwBt8BXjYhfggAtnK/FVCVqQ7yC5mbet/LWsma4tCCU2UY2FzG0CM/5wRWQsBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aKK9f6+p; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aKK9f6+p"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb73394b4so134301966b.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386926; x=1756991726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr8F9oLlUMXE4zHvyjlznjcTWEkXwUVRTFmLoor2DC4=;
        b=aKK9f6+pN2tIa6PHgMWIb1JiUm2xc+jVylimGixQkkQs6bmsyvDfKm9oWGWeFKjbYN
         DOcL9BjwSGcgIUCEyWS7CN3zGeCySSxZh0sYXcGgqjcefbT3ryPog+Z92gVKjh1iCJ4E
         Qn4ndcR3RiQmMqVELirin/iyF0s1Nenw4Ru5EkG08WcDv2FA4iNSsCbzIaeYNcEJKI77
         0z769kHt+oZMWB5mUMuSCMPgBsG/YCGZmMfKn7vTSkLPzHHNY09DSgfR0f1DuFL4Fb/U
         8P7JMfkHc/SlCWR6+F1PYg1Pn/ZOMJLoMsi+Hzdr59sc5HSCxwRlIPa6+4qeLKzZQFtJ
         sUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386926; x=1756991726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr8F9oLlUMXE4zHvyjlznjcTWEkXwUVRTFmLoor2DC4=;
        b=CYABg5bxAjH3K3pvUojBdd2b9maQQupFc1UOvHZ4ppRCA/q3VkIxSo79myNRLVi1Wa
         aisHRiUynezOQ/EsJe5J/sIAaPsMaAtNyzEAGF2oTrrHMOgTjPcqZENWDq5faDTh6gRd
         KzEOFYrq+SCCjX1xNCxGaPnAVGcEc4SG/fYi8lxv9QdWukzSiuuNrG+Px29OIB/PjROh
         K4MhtTxtbE3Jlr8DLB4+4tTp5RmCsiheyJTzYDv3zAV6psKv3BjeZtwHErR/6u1GE4WW
         IVNl+Thhdk/E4UBNsqZ5hAA20dLNEoTWxGojWLPH+BYJiCKSbf5FfdyhqG6VNOEmuMb0
         R98Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgpUfPyWsBC2mbKwOZJyVAJ+No8AhXC74dxIQDNpoiG9V0hK3l/+nRDEugrQoXv13wzyI8N90bqOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7t2xZbBlRr/c+z3hg3/i5/BLVpp6cbN9QO5Vmdfhy2vxw5RtV
	xUQcxEwWXB9GYB+bmCkmWDIa2IOEtmt90pdABIq3VXYUtI+8UolRACc1930Q5JjJtiEhQpPvWgA
	Ovn2hH1Y=
X-Gm-Gg: ASbGncuoNMNCa2juBnUxmXGLPtoYNTKp8VZq1RsJcMVmDfaoqg4UBlwEJgUVZt6wwst
	z+uYO36gHv+IGE3AUk6cJeienwmfZ2OJ5IDw0JC72rGpcyDgWdRX/zBPpQf9333a9MgfHNKctFW
	wrkEM3ZUN92ePe/r+pxPgX6x4nkbX+82gK0Jjo7QBkCT4YlckYL2t8nEI9Gow6gZzJnFs95x1fu
	UjBgOJM+kzOYCGtIxzLwbSQJZ0r8FYRPC9y4yUIzdXnDsyAqNsLvWVT6XuH8eHkHtW8KplIxMrE
	vNUBaDjBTvKpkyvtBxI/3Ey/bmnz4+3ZGyV/lruyJ60vwFrEB5VPhxxMH0dFIwazji4KHTG2Byx
	BTJTfHwmh1+4epC98jwxz9XRL6cTrjcnanM0hsB4PZCZzT43tXZUwxcjF1VLcgyRRBrbQ67TzBS
	Bz1AG1SGJI4pY3T+bM
X-Google-Smtp-Source: AGHT+IEI9YD/yIKwxGzebC+FCV1SyBTlu4bST+Ltd9CEVkIOaKvOCGIoQzOBpgJhki3SAdvQXPUT6g==
X-Received: by 2002:a17:906:4fd2:b0:afd:d994:cb3 with SMTP id a640c23a62f3a-afe294d3edamr1890495566b.65.1756386925746;
        Thu, 28 Aug 2025 06:15:25 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe7ddbf166sm895554666b.78.2025.08.28.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:15:25 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 1/5] dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI controller
Date: Thu, 28 Aug 2025 15:17:10 +0200
Message-ID: <181cc905566f2d9b2e5076295cd285230f81ed07.1756386531.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756386531.git.andrea.porta@suse.com>
References: <cover.1756386531.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Broadcom BRCMSTB SDHCI Controller device supports Common
properties in terms of Capabilities.

Reference sdhci-common schema instead of mmc-controller in order
for capabilities to be specified in DT nodes avoiding warnings
from the DT compiler.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
index eee6be7a7867..493655a38b37 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
@@ -61,7 +61,7 @@ properties:
     description: Specifies that controller should use auto CMD12
 
 allOf:
-  - $ref: mmc-controller.yaml#
+  - $ref: sdhci-common.yaml#
   - if:
       properties:
         clock-names:
-- 
2.35.3

