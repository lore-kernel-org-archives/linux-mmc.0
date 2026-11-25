Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630865;
	b=MVbWMu5R1fvef9IaUUoOtXffRjH5erAMn7p+fuGvUYH08aiL5TquKMzOPto9VGv8DsCm
	 tjR8TbYrpNnytvLrezaNMXFgzfffmF6X8Rm4tpC0WEGs8fdQPbfeMhvSZN3V12r/P2So7
	 DD1i4Wg675kWzAcZ9KXQE+nVvtMeiQOhvB25jBg90yC7uER/tisb5nElV1CbGRhKGeTa7
	 i7ohnNtE5AVk9zxtHGyEVq56GYhSo7JRawLJsH/jiPOOXKAXdhOTgkJE7EntsZThRVIHK
	 fvHejfWmbpFrXFxi3zm7ZrmY62Kk/j9bZLXg74n4t84DRuV8XqK75oS+vLGQkIdDl5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630865;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
	b=L0qbFOtw+An7i0A1S15oFqeYTzvf6lSBAdj0IRis1fX19yKUKbQ8m95q5bmHq90JAilS
	 fvd3t6snC5S91VrCE2OAKiPGoFJZMa688MkDkIJpxQjckvxY1Cg8lZUFLRfuGJY3TwV9F
	 hBonAP/9fZFFyKs/6oOnVxAsmQ4VGY48vtGBSskN6nhamRYjzC/9YaBIoy5rMXaXmRcta
	 ZrPqDVLUDmaYmBYwkpipXV/9/z2rqU6/c5k5RcFwMCUxzwuSPWr6SdlzIvJXIOGYZdghS
	 velYV5PaTmmWYWY2fKGr3wi+VDZ5rOqm+qprDpdNF8odq1PXOaA7uq0gRJ4fVD/oSww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="gOl/P67g";
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC9606A685
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 18:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9DC9606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gOl/P67g
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso2934017a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630864; x=1796235664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
        b=IIh9j7bYRSjs4UXsd/LnnnH9e4rtX5CGBzRl9Yj79yhAkK/fdiVRv85YxlSut6l0Or
         uCtiVCrL/J9THAHPJeE2f39GeunIjmOYZN6/Jsx+Sgi2vnK99SdzP4nVG+pH/qhqGTHr
         SVllVTDFZzPEyX83/CLr65Fs+NO1d8wo0dcQtsK3w0AvphwhGjRgnWNJdN/yYPTau9ZB
         4o0+IF2gvFEPeb6rQzoH1kPuJFgqG/EV6aqd4QiqKYNc4KKJPpeg919P3IQzUD2d6zkP
         V0U+aXPZqnGX/lj8jqETymPXgG+eW3CgEJvizGz1CiXvlX60ThPv859tCjQp0I7K0OzW
         IPOg==
X-Gm-Message-State: APuU4Z/w8yOtZ+H+lJTRSLGQ5VCxy7zCTMvmNDlwwq7SHaPiJ3/xxguM
	Rd0gfQzlT4GIxDa0tXrmb+ItzeIl2R/Bwp84KNMLoSYs7QMY+BUo1VkKi0pyuB5MVrE8uRpz7tl
	gnfjlf9wh+MUC9mwfoaOOO3c61bg0jQbgBk8dzp2AJYVu5gdPPary/1rYIY5+4ExBEg6+WpmbL1
	QQ8Sct4ZFxhdaa+PHivLa9K45Z/YTg32VTsd2B6kCbSJ+ao1IZnYYeVrS7FRM013DqzjNu0WiFc
	ET9yY1ZHLFx
X-Gm-Gg: AZFdTZe2q3qvVVadHqhWefd6fQe6KdEv0F+EqT+7SeR+xq/J/3zHzKr35FxrMx9OfXg
	KrdICLB3hw8xBWWsn5aBrMA6TQ9iNRu7u9hs6fXYvqwdvTBFoAGsZGdClDNUc9BlpSI8lHZZV8c
	3MmvQ99rd2v44kTpy+Z5b62dF6s2VP6tMnRtCHBD5Tqm3QHL7YAcWo3AdO6cIA5LJJiBqFHlcw3
	W/X5Nev0mfMKPRli2GzDEknN+LLdpuLkhGRS4jzkaG/JswcaK4+tm4vbcG2h9IGAAy9tMX0dL9/
	Q3QIi3jFT70/v2lvDb2HL4tVrqn3Hd9JQR988+5NKskVPiqcktj/e1EPfyPZAFa92nTsQ6F6qc3
	sol7sjbHQbCw9IFuCg2kofOKLbEIZ/wQNTLmkCoPlJSQsiaTmvX8I+4Foe9UNSXFGAhyvynzHnH
	4y0eSQIcaJgJnK4lUJZcRV9blJW2jtdd+6
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id 98e67ed59e1d1-3b41c906b61mr16567544a91.24.1795630864224;
        Wed, 25 Nov 2026 10:21:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b41add899dsm13089537a91.3.2026.11.25.10.21.03
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:21:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9495c71055bso248201585a.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795630863; x=1796235663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6b8iqkpAnic8aYFUTWit4E+L+/N2cQqDU3rU0AhCuwM=;
        b=gOl/P67gjjkFZEW5ieHCBToIlAmjGW+aA3n3HQFvqIFwyPK3VS16HKDtGmovsfWXku
         wSLoKmdoi/cLGQms69DUl1b1SasZr9YOdNTA4brqgF8+aGgDogrpp4yIj7N7SC5WtqIA
         SfMCpOoMOIY3IUSFjHxh+1VPUw2Xb+Tye2TK0=
X-Received: by 2002:a05:620a:1a0e:b0:93c:a40d:e3cf with SMTP id af79cd13be357-949ba828099mr3342615685a.1.1795630862797;
        Wed, 25 Nov 2026 10:21:02 -0800 (PST)
X-Received: by 2002:a05:620a:1a0e:b0:93c:a40d:e3cf with SMTP id af79cd13be357-949ba828099mr3342607685a.1.1795630861913;
        Wed, 25 Nov 2026 10:21:01 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb38322csm1375419285a.17.2026.11.25.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:21:01 -0800 (PST)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v14 2/6] dt-bindings: mmc: Add reset-card-at-resume property
Date: Wed, 25 Nov 2026 13:20:49 -0500
Message-Id: <20261125182053.3915833-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
References: <20261125182053.3915833-1-kamal.dasu@broadcom.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On some platforms, firmware or other hardware accesses the card
during suspend/resume, before the kernel's own resume path has run,
leaving the card in a state the kernel can no longer assume it knows.
Add a flag property so such boards can tell the mmc core the card
needs to be reset before it can be used again.

This is expected to be paired with keep-power-in-suspend on boards
whose firmware needs the card to stay powered and live throughout
suspend: since the card is never power-cycled, nothing else would
force it back to a known state on resume.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 2fc8e06d5ec9..c824b95f2ae2 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -303,6 +303,13 @@ properties:
     description:
       Preserves card power during a suspend/resume cycle.
 
+  reset-card-at-resume:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The HW/FW may have accessed the card during suspend/resume,
+      leaving it in an unknown state. Hence, before the card can be
+      used, it must be reset.
+
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
@@ -371,5 +378,6 @@ patternProperties:
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
+  reset-card-at-resume: [ keep-power-in-suspend ]
 
 additionalProperties: true
