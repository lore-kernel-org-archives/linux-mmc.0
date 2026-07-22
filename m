Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0304048A3
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754865; cv=none; b=lwUPpb6EC1y0M4qkVYuY5aGVP+xcANcNBiW9tkgckXFe+V0NVZhZnK5MATHoHlGioth/zJsXtVxTIY9KDRWsyJENZcDrtk4XShSoahygdc4Nl4//FCsfuAASfp9Da8pPVaqw9VLo0Aw2M9PuWY0EtHoK3sxiHmPxu1KHorY/0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754865; c=relaxed/simple;
	bh=vvm9MiiF4qT9D4Qs2ERzb7rUVfglIiNSjcfJaY+TlO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXjDPIBzGz4ggcSrD+1/Itjfw59gY/o6Yg/m4JuWusupEEltOQH1dGy6/5uzPjHPMeE5San/9o/v41cDaJCsS2zcRFKHZTmvfVEepYQ0OiWKf5FnrlalkYbCnXvx0Xe9lLxXZ2616n2UigHXCi+9qM6FgFpCVFkO1UUOXpbn1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I+HA06OS; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I+HA06OS"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cad4170e8eso187138065ad.3
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 14:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754863; x=1785359663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79r229Sv14C/d08t9Dy2alwJans9h85H9rzz2r6puFo=;
        b=R/9ghbt3f52+QGq+EbzTpEB14hDO3kMi0xzXI/iaRLqnSeeAAyi8Inqe/6zwCtWNZs
         6EjM9sHTV+kwOQ844JIX0B+f+GbAd7lOSIc+A9qpCmZfyHfBnt337Mr4e3LK9qszC5Nu
         bdp4oect7y5f+i37nFpvhCIVJFArf4oiUuQeD75qm+Li6cQ3gYabuGpxw92uMJlcg4Ii
         ti+uz83n1HsffP2vO0tvcNAULxhTrpQS6VPG+lYhX14x4VIjS/0TmSuWCwehyXyQF4r/
         wRhiqHtAbE2oeLmbVHA0lSYo3g9u5NWO9rE9LCAaX/wraL7YyNdRD5oZazW8ASQO9FTw
         cxkA==
X-Forwarded-Encrypted: i=1; AHgh+RrOGBRsNybVMT2zTRDkObaj9QhPGKy+0xbOoTg5hBe7UTTZQ7bl0jWvKaRyeiz915KU6QfSryDmoIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZPjs2p2zrz9STx4UcgIr6M0JMMkqLkTI1y301NZFn3NESWXM
	Ej1VomxPQzIdMwmEkC2P3Ws/RwGmL8ufH0Yb4vaKqhMjwcTlnw/8Dh/KBIewJ16xcQPQ09/3X2k
	OHrmumLqcLBC4MCPUud0udubJfwhpTcZxzsXjOFULz7KVZ0rIBLDcGrlr2y6AGh/iLz6xQA2l1X
	Y2ZoxXruQ3HMY3BJoQgvAMnpEa2VuO2tD4A+S+9e7qtLw0Ox/j9TgaOyVoQJW9OhblhFxxdT/gF
	4g0Nx2xGsiv
X-Gm-Gg: AR+sD12gtW0xOT+CLvNy96/sWC65OWVg4Z9zCfG3KvuAX0ltyzh726KneNCyuSSNURV
	9JgadWjPLqqVZah8+RuUc6sgzczMoluErvuxiL1CkMoY0xiIoPH0FCb0yLT8s2KLTYgOopeXe3e
	2lmJw6iz0ewnGaV52h7XO5HYqXApFnzKWxXwSYD8aml0pIjuN25evAh7mlVwbHSrxpOwTWRzvQb
	xBY5K/X3ZVy6qd3L1a6uHJM5dubUrz3kpD20fwM4MCRXBinm26cto6hkzWhWeS900UCf9D2p0kO
	2I3SMDbppJ69RJR2qyVhv++o6LtBWLaaTbS+qvbV5n0Wv9ZJE2w2uLhbHl0irn9FCjCGpj0Pih/
	9XwhdppBPtF/5S7VOmFN2O8ZZorxYfFZZxO7K2RufjWggtvOP+MFrLwaUzVfLoTcvISapORQOXW
	V7VpHUa8zItA7CYuP7lazjmuHjKqN9oETr
X-Received: by 2002:a17:902:ce84:b0:2ca:ed41:d337 with SMTP id d9443c01a7336-2cfa6f7fbfbmr5700115ad.43.1784754863174;
        Wed, 22 Jul 2026 14:14:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2cf8efb2f19sm3299865ad.3.2026.07.22.14.14.22
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2026 14:14:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-91931144870so1925329285a.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2026 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784754862; x=1785359662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79r229Sv14C/d08t9Dy2alwJans9h85H9rzz2r6puFo=;
        b=I+HA06OSjpgVcglOhyL8zRRkEn5h4Yc/tRcOtTPisTasPaS/x4hiO7U2fj2lsnf//+
         4P6gNFrSBm670TLdTamA0rTCbXY3gf7ScknB9HEfHbbjn25lfovBPvegxrYGehEEc5l2
         ivr0ZCpDsSO0Uq1qGHoSAKSOyIkxi2Dk25+uY=
X-Forwarded-Encrypted: i=1; AHgh+RpcJsrdd3YcclSJ6DnWQUnLtHG6L1hGfj5akvuEIom48j4CnPyHblwgURmByqzLTHAgOUjm7heArgY=@vger.kernel.org
X-Received: by 2002:a05:620a:3911:b0:923:7821:dc0d with SMTP id af79cd13be357-931038938c0mr40973185a.33.1784754861639;
        Wed, 22 Jul 2026 14:14:21 -0700 (PDT)
X-Received: by 2002:a05:620a:3911:b0:923:7821:dc0d with SMTP id af79cd13be357-931038938c0mr40969085a.33.1784754861114;
        Wed, 22 Jul 2026 14:14:21 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f68a7fffsm253004785a.11.2026.07.22.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:14:20 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: mmc: Document no-mmc-poweroff-suspend property
Date: Wed, 22 Jul 2026 17:14:16 -0400
Message-Id: <20260722211417.3702709-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722211417.3702709-1-kamal.dasu@broadcom.com>
References: <20260722211417.3702709-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On some platforms, firmware accesses the (e)MMC card directly during
system resume from Suspend-to-DRAM, before the kernel's own resume
path has run, in order to load boot code using hard wired logic that
is not field updatable. This requires the card to remain powered
and responsive throughout suspend: it cannot be put to sleep, sent a
power-off notification, or have its supply removed.

Add a no-mmc-poweroff-suspend flag property so affected boards can
tell the mmc core to keep the card powered across suspend instead of
sleeping or powering it off.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
Changes in v3:
  - Renamed from no-mmc-sleep; dropped S_A_TIMEOUT framing per Ulf.

Changes in v2:
  - New patch, replacing v1's card-level quirk, per Ulf.

 .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c..5f7b3f8ef1dd 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -232,6 +232,16 @@ properties:
     description:
       All eMMC HS400 modes are not supported.
 
+  no-mmc-poweroff-suspend:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      On this platform, firmware accesses the attached (e)MMC card
+      directly during system resume, before the kernel's own resume
+      path runs. The card must therefore stay powered throughout
+      suspend, and the controller must not send it a sleep or
+      power-off notification. The kernel re-initializes the card
+      after resume, since firmware may have already reset it.
+
   dsr:
     description:
       Value the card Driver Stage Register (DSR) should be programmed
-- 
2.34.1

