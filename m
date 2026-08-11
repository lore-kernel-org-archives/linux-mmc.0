Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305043B7B6E
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466303; cv=none; b=f0zZE/TruQJvxTQauND7O67extmBzrG3/tplXKSt+Tgd0NWgHCKR0MG+stpVWNK0QeTjl5KWTtEnxjeRSrQmFxrdBgpHEduyN0we/GK1YN1bMu8GYLf+yVSOVKejLiicSiTOO78mVt/RfWXAJWb7glEuG8SQbDvnjFNaDWQhV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466303; c=relaxed/simple;
	bh=VjAm/G+XBV3wqAMJf/jE90KbOirqngl4/9uUrm3AKo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AffXDUrE+w2ka7s8JhltM/szWVovgYHVXlZLIDZnaU3Oh6oWhUV31rRz+yO2H7WL9gWTLeQ4EM5UWQnDdp6LWIcakIq8GS3yQ72zTIUt+/38T1+P83lxO85IOg0lvrN8vymggTFwNdOr746sYKQP6ZFoSYNWpoe10js8kPiivys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Op0M3OTU; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Op0M3OTU"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2cad8076b01so1286625ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466301; x=1787071101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IP0oJG7AWLjJjpPY4ZmVTg/sHwIBv1HYr/k2mhlodnU=;
        b=AtTSmaBdFPDfOyhotPSkahrfb3QQcrSVBop2XXx3AcxLWv7q+wTZe3P9nt6bi4S6wc
         STR6c9iUNJxlicJ3zC6fJBnYMyIPlPeDuS9DZ5hFgDK98HDbKVS8VcQ1nmIeH04ZXv8U
         wtM8LrzjW1ft2Z0AdZKiUpFejRhlgIAXTiRUknO6wuWr0hXCCl2yVtSivI9uz9aRb92F
         hV8eqioVbj3AeRJrTEYbP/mivFLTd7Fw+dFIdWQev/XRut2koDGq9oqWFoD8a7KOKdl+
         Rgcb6fvs+0PyhySL84/4MBL7KhStWtL3+KJ7gK0Kse9g7G0Y0ktHFUd+H2cdv6/XIUV2
         6Wqg==
X-Forwarded-Encrypted: i=1; AHgh+RpqryAkESVIxlhQmZv0WtNC3Y6ONtB9iC4uWhItNOYLJg6exndfhYyCMuWSCAHAW9DroIHY1/slgOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdDRoC5qfJa7btAsSz0qAsufIpNzyc2XUahljknIpP2DoMV8WY
	4HnUnZa7UdukQcktyYFALoetC4QfD2flz+Tz9mxKlfexWxmWvAffvOnR1LtRhDEW11IOufRf0rR
	RFddP9xdy9j8CaKYhO1s+38JFmJigtmyuS91+nlu/wrmf+7AbiCEdBpYYm3VATVvRbFOemft6eA
	NELZwJI5CMDQV2OtXM/pR83yQyjRx25CYkZclPNNA+rBESLmkswtk4N1BWUjP809yI+esTRjIeC
	fuiGJVcyp+1
X-Gm-Gg: AR+sD11gcTxY1kYoYbt1Cu4Mfdo/h2ny4gE7tJsII6X+WseqzijHM7NpissIFc4AgY0
	3zAcUrVvyNqw0o0TQMeh0Tk2/zKYJJKI7KxEuha+d7te+kDA+gUkz7+x8PDfv7rjIUhS4UOCdUs
	JA2NLnPN2v+A3S8tO2ve/EnlLrqylvxosuXguRs6bmUthEuN9wRTP+9HXINTOlbOv7AxKTWo3BA
	24qzxQ1K3pOn0pPmalgxXndyKghr2xEzLIQffw8o6sfugyKlmBXtcV1IXcMocDZVu2eo7CUDXTC
	JDQuDs6KDYGH6y2/cmesrDb4xA8jmgfLFkWxrDMFAXzoDTN51j3cGi9952ebEnlf9kIUN9zv/Qd
	snKr8Xn85C6OGBW3Yp+yAOeKN2k0OfXesPZKjO3voqUZ+rGJaf52WLJJUrCEFQkxD8oFDK03qe3
	6SkFvW1ZyCirDYyjdBdfu6UXMwf+LBuI3nvH8=
X-Received: by 2002:a17:90b:1a85:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-392f463c17bmr1358371a91.2.1786466301267;
        Tue, 11 Aug 2026 09:38:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392f9514bc0sm28854a91.13.2026.08.11.09.38.21
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:38:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c12e43b98so1208541cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786466300; x=1787071100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IP0oJG7AWLjJjpPY4ZmVTg/sHwIBv1HYr/k2mhlodnU=;
        b=Op0M3OTUTMkFLPWtUxiliAZG3UOziPjygJMQrKDkXIaC5lIuXUNvXk3uidu6F3gzH6
         jPk8VJvm0n327r8mu92FZwLbajy6nRmKxnzUGMf6QCvwwDu83HOLFnxuUY9imbz35dTK
         zDj6XCeKFFdel8h52mrdP53U5S1xOhfuFRnME=
X-Forwarded-Encrypted: i=1; AHgh+RqyvuHl13k2edDVLsL2MLpkF5RfMo9/7oPC5zhBQaVtvCs34fxYyeD9rcy7mXWTuQGkLGCuJRgD+xA=@vger.kernel.org
X-Received: by 2002:a05:622a:4185:b0:51c:1c2c:a8bf with SMTP id d75a77b69052e-52d60284dabmr16893871cf.43.1786466300050;
        Tue, 11 Aug 2026 09:38:20 -0700 (PDT)
X-Received: by 2002:a05:622a:4185:b0:51c:1c2c:a8bf with SMTP id d75a77b69052e-52d60284dabmr16891771cf.43.1786466297946;
        Tue, 11 Aug 2026 09:38:17 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57c3c09bsm14427981cf.25.2026.08.11.09.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:38:17 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Avri Altman <avri.altman@sandisk.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Erick Shepherd <erick.shepherd@ni.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 2/3] dt-bindings: mmc: Add reset-card-at-resume property
Date: Tue, 11 Aug 2026 12:38:09 -0400
Message-Id: <20260811163810.1599747-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811163810.1599747-1-kamal.dasu@broadcom.com>
References: <20260811163810.1599747-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
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
Changes in v9:
  - No change.

Changes in v8:
  - Sashiko's AI review of v7 pointed out this property's own
    description says it's "expected to be paired with
    keep-power-in-suspend", and patch 3/3 now enforces exactly that
    pairing in the driver, but nothing enforced it in the schema --
    a DT could set reset-card-at-resume alone and still pass
    dt_binding_check. Rob Herring asked for this to be addressed on
    the list. Added a dependencies entry requiring
    keep-power-in-suspend whenever reset-card-at-resume is present.

Changes in v7:
  - No other change here; patch 3/3 now requires this property
    alongside keep-power-in-suspend for (e)MMC rather than treating
    them as fully independent in the driver -- see that patch's
    changelog.

Changes in v6:
  - New patch, per Ulf's suggestion: rather than fold "needs a reset
    at resume" into keep-power-in-suspend's own meaning, describe it
    as its own independent property, so the two can be combined only
    where actually needed (brcmstb sets both; SDIO's existing
    keep-power-in-suspend users are unaffected and set neither this
    nor a reset).

 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index c18bf0d6a56e..c51e9184384d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -293,6 +293,13 @@ properties:
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
@@ -361,5 +368,6 @@ patternProperties:
 dependencies:
   cd-debounce-delay-ms: [ cd-gpios ]
   fixed-emmc-driver-type: [ non-removable ]
+  reset-card-at-resume: [ keep-power-in-suspend ]
 
 additionalProperties: true
-- 
2.34.1

