Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681C3537D0
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569488; cv=none; b=XOKE2OO6c++rQB/c3YAC8ccAdfPjMw91n9pSj/U2+jfri/OC6FYKiEQDlcYpa52KRdTda6HVHT15TxXQc74gDMc4gRt1y4TvRh0uf4F1oNpklxGanY9yOIKCAk/bsBYnaeKwRfKNiCK0umaNyfSf+UMElSO8CMgdjT0aVSSk83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569488; c=relaxed/simple;
	bh=3QfgIH/GgpjZ3VkdsfXWUQfOIdxeyEfDrjW0KFRGvA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEwxFZ3GfI2Iq3fPksqhNuL50mT97UgRlDtDyn1qd/FJJ92U43suKAfa+VfJApkioOmIe3TDAPZPZnDA4vZFNHPzANzGQWJGPXFvkp5m6LhkBQRvSI/4tyHeGfWCI+mN1Z7HMkNd0pYBCyZjfjpFVD5ixI0ZTJymvGBHNpU7fnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mFvuDLDJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mFvuDLDJ"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a144c8eea2so6109966a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 04:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1787569485; x=1788174285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NxuxqWbvyXC7ugR8MRCNznILz1F4+G4M9w5UTCg9J3I=;
        b=mFvuDLDJD7en2Q5ej4a2IkuH5R5F5cD/AGLPKkcvdHdSk8M+eUGSNKWfE0w62liUs+
         i3g4CMN4aeoqDHfr/d+EmhLPeuVvadt0QCFVL0FkTRiODTtqpkMaGqIk5hbz/mhQohxd
         EiubX3k927920CK2YFvEypKTG2+tdCoudTG26AiLXq+dZNVFs31CM50HLAhqUYf74Bw2
         x1Yv3RQuSeVgRnHdjdAkoQpqAvGLdL9sd7HrjUaLZeHN5ZQF6/dA1Dq/DIUT6poqIilq
         VdehDcI3dyi9xlOiwCij7mFCuZTDeMZQsJtT7FFmYpHz5L0D8j+QWwMnhxH496BUF8b1
         k0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787569485; x=1788174285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxuxqWbvyXC7ugR8MRCNznILz1F4+G4M9w5UTCg9J3I=;
        b=JQb0W8/L62m12s3DSPnEHg9QtOPgeWG2v9gIl1JmPN5lDBB0uZaIdXZa+l8BExw9Wj
         9QdLx+fBFKQsda8IDOx5fJOBlxi2TylcOPLmnlV1AeT9E1QLuXkPt5exm6NFz9lCn/iv
         3/TuNaJkba3TBnhA+EouuOduX7eIxxA/ubD5juQ7GyEHk9mDpYwDiuWERSLjnai3XY7A
         x/mvt0ZxTlsAeTFz1b6nvmCJMJDflVn5tN2KaTjMFAuN4HdtKM82no4Piq9rz25O3Z2K
         6uUE9ZCoDAG16Qezs+aSZCIaDgr7LZ9k6KXQm3bA1b5iOmnG8vmb8lueO5pgJqgs2kaA
         KFnA==
X-Forwarded-Encrypted: i=1; AHgh+RrpEYLK4D8kp789jd36h0DtO+4A0nXovZ+TrSru9XdvDoxFhHMkceROO869GU+jEPlu44RAbuSMUFA=@vger.kernel.org
X-Gm-Message-State: AFuF++ktp6N8WlI99IdrsXD4X7+lqmAL79hMRI8AiTU4HuvthgH0FXWf
	hVfdsY6N/51Muh/+nphrlXi632hPFYXsoe/hr+HSiE3DSncFGFLRLHUdz9xq3RTp+QY=
X-Gm-Gg: AR+sD12OkSlauu2/9qdKPqa2DzHDVkujqAAidQt4Zepu/HKtNmSTaat8AuMSFTdOB+Z
	5La8aZP9PwaBnM+tuu4+6wuawBUIL9TgINlFBU58zwUszh5ZQrTmra60xVoHRGfWDrBl87wbb7z
	0fF8SUeGt7uO0ONyjmne3GLhvm5OVoUjqHZOW9lFVi5BZQ1kApPQqS8TEFsfdrjn0J4u6GUNnf5
	FjJHfLVLjxe1RLiVo2wm3K2kENlKBTPXqHSDKDOuq0xskBPRwOhFWlNDfsr4Lwv6RdgtbHbmHQ4
	gU1snTGEiEoC1+l2Q22LAdxly8rakbl0iLlw6eFvtk4A8O6wIHIh6DVkFmja15+ETdRoVC1C/xZ
	IGr8p17VYAEMelQkK7I1+g2cHLS4i0wOiKFv72GJZWAv4huvaLacBlWP2cae7YO1CqhVf6MflBK
	9iVlHsd592I2TcmB2PRgtpNM6Zo8uE6T/r/oZkRk4Dc05CtrCel1rc5Ecg5sT9KBfP6JQpj2NyW
	tg16Fo07bCd1wlN6/5Y3I8nlYGEMKQ8xi/qUif1pt02DokgIi2uPbeRpRH2Ab6PhVqarOXbNbrq
	WzDizj3JrhRxvqJGTZ/NSZLv704MqfTA5Oi+pA==
X-Received: by 2002:a17:906:9c93:b0:c24:6687:bf6a with SMTP id a640c23a62f3a-c2492663ee3mr1888041866b.21.1787569484828;
        Mon, 24 Aug 2026 04:04:44 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-103.zg3.cable.xnet.hr. [109.60.82.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm1331954166b.46.2026.08.24.04.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 04:04:43 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	aubin.constans@microchip.com,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/4] dt-bindings: mmc: atmel,sama5d2-sdhci: add LAN969x compatible
Date: Mon, 24 Aug 2026 12:56:49 +0200
Message-ID: <20260824110432.1074136-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SDHCI controller in the LAN969x family is compatible with the
SAM9X60 implementation. Add the microchip,lan9691-sdhci compatible
with microchip,sam9x60-sdhci as its fallback.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
index ba75623b7778..af1c66a1f882 100644
--- a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
@@ -21,6 +21,7 @@ properties:
           - microchip,sam9x60-sdhci
       - items:
           - enum:
+              - microchip,lan9691-sdhci
               - microchip,sam9x7-sdhci
               - microchip,sama7d65-sdhci
               - microchip,sama7g5-sdhci
-- 
2.55.0

