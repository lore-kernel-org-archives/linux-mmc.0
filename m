Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98223C819C
	for <linux-mmc@vger.kernel.org>; Wed, 29 Jul 2026 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785356073; cv=none; b=aUQ88I7dpcGDKuD5DyCeBjIrnM/7ZPqoI2EoA9VS2kXTUDrM6hMLEQOqalU/a9lBmr1bxdKvViKM06l8KERMlXyhcBmdM4glww+kjQ0vHtSEzo1vRL0ftMfiAdqvMd9rIOdx8tqHCP8pWZ3B4khEacVPjmDW77wHGw9fBTpQZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785356073; c=relaxed/simple;
	bh=uD4u9KTgNvJKJ5gV6MxgBAGV39N6ROb42LaNKTZXIdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xvl9LIRgQ3Rq66jLT0WRT3rkCeEAbtoUqG57X+X80bom7tUJGFEF8orGfNmksvWvJMZbQaDzqnJqZasneRhOY5q5od6UF99xIB2MketWfpnscDpx80y0L/rLBBDSloftmhqqgvYftDYnqmS1P7pcIgKyIx61hGyW3pbpw0KJEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=azdSlEtO; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="azdSlEtO"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cc73e322dbso16434655ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jul 2026 13:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356071; x=1785960871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XbWrGnIrUUsth3Yia1cqmAkJSDCXp1RV0SQ0sLkznek=;
        b=VSDOU3m4RBG1ASP+W4CZQd5YC1CuPoodVXKfUeybRGpl9eP5GoJjfVLCeKmpBFhDOR
         ZcGV4hSOh2DnLDOgShD8TqzwlnxPup0sFiCMqZV8y+6wAhozHhl6nD84/JNuTxvva6qX
         nQh7n6lg9zAEaDPi7T4uafMVGCkamYV16NIT6H6dBcblcpjWfTqCMvEjIv/OW+3AYy0E
         gLvFzWrsJLFUEVf/0RTOL8lXnEkX2DZo2TP2MdhOSG6mN5+NIYV1z3Vcrrtay9o2S6+T
         VWRl1D3uDfOK2ynVNZOdN40kLhPUNYHzMFOTJ0sSE8vZHeinVSfSSm0Z97LknNvVjVo+
         mQrA==
X-Forwarded-Encrypted: i=1; AHgh+RpW73BchM5ge1W2gQVMOrC5GgdOqReBZTJgeeYO3O0gegPG97Y7AmJsVG2IlDcDhxGUxdboNKZlbzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyob6VpKe6dng8HTryeHqOQOo62gv/cBq1mZm/xMImOIGBhHyGr
	npgTqsod7w4rDoTFOHfkAvYhknYE5ARIBK8R8da5FQdBB2shAd3hLr5yvLZwba+9icyzg1dgMQD
	pMcOsPPVhS2/9i28lO+CQstca+QT721LRoqXS8ucME04nvPXqCPg2XHnXbSwf/d5ECSUN0ogh0H
	XRHiPbUblqCYDbdT5S4XCpYFKKlM9juqQZOtUpXdvbMs2/nQZ0k27rBhJsfh7iBkv8roiBxFoL6
	qbAFKPRIfa4
X-Gm-Gg: AR+sD12mth2E6fkpA0qafaEJKWLjqZ2fd2qQXEoyeWsGcph3rVS6gMDiLcPIUK702tc
	L9UeUjMHlaDS02aFO63vi+HR7YPp93zR20ojQCanRK8QnL1EKt1KtaY1AnfgeYK1novqQEQx6TK
	B8BYyiSovFXpvSL3BQKTnsmO1lepqF6P4i+PARienueq38fCZo6juU/SK1hK/aX4ChB2Rf3G4ao
	ySHlfGQPKAKFWNCT8WtalmvhAQuSyC9hv6a6Q0uifJoN8ftr97AzYfXXF3hSuEVz6LAKLpTpO2N
	5eU49PpVfZkG/iOCAFeKN8eXCSFh4Wf6j9GkEAq/dIEjWhjYLE7VbBodDE+n/jB8rEwA0ejvE7Q
	jvxuwzQOSW/EuxZLxFw1RMvxb97sawAzAbn/tRwmS6UzqcB78bKBXdmHtXWaGw8tsxws+nYuV62
	wFItshntFbpk4GBVsZOedjzid9ux+PVDVu
X-Received: by 2002:a17:902:cccb:b0:2ca:329:3da1 with SMTP id d9443c01a7336-2d0339c2974mr3108775ad.16.1785356070716;
        Wed, 29 Jul 2026 13:14:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-31504935db8sm266041eec.0.2026.07.29.13.14.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2026 13:14:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f73fso24021536d6.0
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jul 2026 13:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785356069; x=1785960869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XbWrGnIrUUsth3Yia1cqmAkJSDCXp1RV0SQ0sLkznek=;
        b=azdSlEtOm4Oomid4DKfQG6xJo4A2mpn1Zik0jFUcWlCbSNZ0DIXYUeAFzJNihy5LMe
         C2pv8fHqPf9Ag1hxNK/e/i6MaBdObnsQUXIZpOgPtaPyKB0mLAL2K4DVmvU/EEdmcSJ6
         pHY/2Cidi0TIXNX6Kmqdh52BXbCQeQRfpRYxM=
X-Forwarded-Encrypted: i=1; AHgh+Rr0b+YeyrLBfLx6nG/0VN0pQIiHeNIZSd41zq9Ndri7FyvF8CJ0Z3OKw2VhDZzYdIVOL5YhTq+EVKM=@vger.kernel.org
X-Received: by 2002:a05:6214:3217:b0:8f0:9d9c:52c1 with SMTP id 6a1803df08f44-908302a7f25mr4192716d6.38.1785356069133;
        Wed, 29 Jul 2026 13:14:29 -0700 (PDT)
X-Received: by 2002:a05:6214:3217:b0:8f0:9d9c:52c1 with SMTP id 6a1803df08f44-908302a7f25mr4192236d6.38.1785356068701;
        Wed, 29 Jul 2026 13:14:28 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd8cb0dsm32033066d6.48.2026.07.29.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:14:27 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Wed, 29 Jul 2026 16:14:19 -0400
Message-Id: <20260729201420.4047677-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729201420.4047677-1-kamal.dasu@broadcom.com>
References: <20260729201420.4047677-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

keep-power-in-suspend already documents exactly the requirement
needed on (e)MMC platforms where firmware accesses the card directly
during resume. Rather than add a separate property describing the
same contract, drop its "SDIO only" restriction and document the
(e)MMC use case alongside the existing SDIO one.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v5:
  - Added Krzysztof's Reviewed-by.

Changes in v4:
  - Dropped no-mmc-poweroff-suspend entirely and extended
    keep-power-in-suspend instead, per Krzysztof: the two properties
    described the same "don't power off across suspend/resume"
    contract.

Changes in v3:
  - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.

Changes in v2:
  - New patch, replacing v1's card-level quirk, per Ulf.

 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c..f4663b318435 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -291,7 +291,12 @@ properties:
   keep-power-in-suspend:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
+      Preserves card power during a suspend/resume cycle. For SDIO,
+      this is a request an individual function driver can make at
+      runtime via sdio_set_host_pm_flags(). For (e)MMC, it is instead
+      a fixed platform characteristic, needed on boards where firmware
+      accesses the card directly during system resume, before the
+      kernel's own resume path runs.
 
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1

