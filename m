Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188A3F7AA9
	for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2026 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785968719; cv=none; b=lcxcNWLK6HsIfCCFxewybhQxQvByAqid7NCJQRA9RgQ3+Xxk+rSn6Lo714YPh/4veM5EZU7Mtm46hXrjF90j2al+JXHr5x8V77Aksj5wOf6Lq1QL9opCJYUPQ88zX/E4q9CEhNiw26G52aQjKGNGiNwOWGhezsE2ghY/n/AOwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785968719; c=relaxed/simple;
	bh=6qwL+yfFZcESUNF5HiWRkDnZTCmWLZVhdGnov/uFMbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vECUphhfAZ2+V+swl1cQeh3gJ/h9wxYzbl0vBdW95LXiM5253sD3jTNVNkh0GxuV2E5k07KJBk1sSB+fNC/l3Qu2mPyl1QkuyGUhJLMypgKPiyIgPcOvWXdyWwKczhiocnJml+ItnoTVE1rvr0404GNBFT8OkXAsxNJB37Ax8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=erIc+Auj; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="erIc+Auj"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so10470546d6.3
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785968716; x=1786573516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aR+KeTjwxOC6HIctWVlnauptoumuvtPEgsVHqo6aA/w=;
        b=FvHY6Cfx0+epEJHojreOzkdPOEQmRQUKw+aadOctfNOMn70LEbILL03yXRYri3AV3K
         vvfEiIAtUxwQiA93zS1nTn9R3MMlf7dAFuZ+GWmaOdz0uf0zbLI8RhGksnGE444wj2IB
         J8lFyxuGPo762kjry43jSJz672QipR6/pJoxrUvs9kbtM0s+bJIB4OQXL2VbhuJsHned
         a3+4vriLpJSl++HtzzYH7i+PoqcrqN6p7YBXYiWJcAZBJ5r4Y6GhsjNYJwsiT3maimZy
         TH3hUfaiJGfa5tWreu7mZPInPrLy+IDk3+trX6pSn46PgdKeVFTiuHJBfcG7wL6M3PXv
         PuhA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8o33PAA2BoXo/kDiAfxKcrLwVq/T6JsUyBr1GhIT1SgHmXBKVwoznXAi1tkBsUpAE4QYBl5ao7js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0jLEw5X6F2Y+FowrH8ZuZOfhroENj7Up6fSr6uSHcOfkoaVN
	bb/4WRGsHMv4GDFrWlU514x6uqfDdF7rMa1IHnFpmG3KELpgoWv73t9xqSzN+NwsOi6b+C2gONq
	VIc4Ek/gqIA6kSkAv/JBNoBdhoxdGZ4jFxSDcLuQk7agB3vyIllM9nQekhKfY/kBcgTbs23Lvaa
	15TgnzuzbI71M0Ni5qjQanHO/6bdbTsfHL3kec5mINhpg2uNDIVrD4imoSsoqNlHyQ67QBF85DC
	UCe9X5FSrqF
X-Gm-Gg: AR+sD12cv+0ZNjx9Q04mo+rM9IC/Z4ZmC/q9Rv9XHIY4lL5R5TWYJ6GotBUN6ex6Ylg
	JC0lJO0KGE/meH012hznufMKN0oyroeBZrN+8HE7t7oTQ8WV/3JpgpSioQz8y75udR/CS6z8dcB
	bD8ynr/bvCfBSfrLpR7pqpLGXOBA2nUq244tZqgSWsCE4QlrTCltvQ0MSC18ssvHm2GrQXPC36u
	wjNKwzyFTQpyLnTyx4n1G33c0Csa+NmHljTNqkwKnT6dNk7+lvnnwFZyPEgY6AolYV+b5Z1i6HV
	mvH8b+XFqp+lDnTnApcizXVsI9p/EQfVxz4xiX0Cm2CO/fZVO4eMPNLpKR07RqXP5yhv/fZ6IEJ
	2ONvpnwgr1r9t/q8DMF2/C+4hDWyocwlnfjh2q6RTN3hvnaZaYsQD7U9VyhItz7eHXY61SvzfAt
	ooi0/7TvjomezqW70O6vYD0/OhKLZLdNDh
X-Received: by 2002:a05:6214:2aaa:b0:907:5451:8954 with SMTP id 6a1803df08f44-9088125ac58mr104482966d6.16.1785968716098;
        Wed, 05 Aug 2026 15:25:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-908800508a7sm800416d6.12.2026.08.05.15.25.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2026 15:25:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so36568135ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2026 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785968714; x=1786573514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aR+KeTjwxOC6HIctWVlnauptoumuvtPEgsVHqo6aA/w=;
        b=erIc+Auj8TsMWxfKzO/qaB51lq+FRDe2ySmLtB1kkmg+4NheD+WSCR3CPWQZutvjv0
         ep+xGAGy/3M1uAp8CHxrTkvzieik/ORrfYzr2gPAPXa69jGgG2CFr0hObhyD7BARbgX3
         DrAcb0+gaRMFb8UQInSZ7iKg3fMJZTKoUOInA=
X-Forwarded-Encrypted: i=1; AHgh+Rqvd+4gbIbJw5HSHS5E378jeVCrkj4HmzpvNG6+ILXUpLLx3Kye7X4f5VMbmnQyly/0c2oQbg3LCq8=@vger.kernel.org
X-Received: by 2002:a17:902:f644:b0:2c9:b2c1:13ec with SMTP id d9443c01a7336-2d0ca756f9bmr18188855ad.11.1785968714422;
        Wed, 05 Aug 2026 15:25:14 -0700 (PDT)
X-Received: by 2002:a17:902:f644:b0:2c9:b2c1:13ec with SMTP id d9443c01a7336-2d0ca756f9bmr18188235ad.11.1785968714061;
        Wed, 05 Aug 2026 15:25:14 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158676f579sm18526160eec.20.2026.08.05.15.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 15:25:13 -0700 (PDT)
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
Subject: [PATCH v7 2/3] dt-bindings: mmc: Add reset-card-at-resume property
Date: Wed,  5 Aug 2026 18:24:59 -0400
Message-Id: <20260805222500.2567801-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260805222500.2567801-1-kamal.dasu@broadcom.com>
References: <y>
 <20260805222500.2567801-1-kamal.dasu@broadcom.com>
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
Changes in v7:
  - Added Krzysztof's Reviewed-by.
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

 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index c18bf0d6a56e..6929969ed5a2 100644
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
--
2.34.1

