Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F23F9A05
	for <linux-mmc@vger.kernel.org>; Fri,  7 Aug 2026 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786132896; cv=none; b=o87L1ZuzpX9x711uNOiYTb8jpqin26A3K/8fhStP8c8Chrmm/C+8NAjxRGtduP5UV7m8tLaERoP7htlMLPjSvntIrSzl6mlmzjUALLiWZU+C9aCxoNJ6vFrlpobF/IjSQ35b4bn1U2EZL1+1iEKHblpFkzIblwjSHZ7znCn4M5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786132896; c=relaxed/simple;
	bh=fi9UglUsWL14hbGRB6OZdcqhciF+dibx2nkLntu+QWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i730rklF8ahRUL6I87Cjlg1Hh8ICq1umUOAVoiKyEe484jI6GcAy/UEV9zKwh+8xjf4EoaCc3f1kyvzIQeZiHacz2vQ3brYyYmZpMSpPRGPUgi+TS+4c53p53Pq4tCxZZJWNXj/XNbq+lo34EK3SBsJVGpS9hqjiEXBUD2WZ8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LNHPIPki; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LNHPIPki"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3713301a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 13:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786132893; x=1786737693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frEqhqTY4YyOiZv5F5GY+l0M2IOOmrFEYWVkjKDi394=;
        b=GpkTWQ5dVosUPGe9IsgotpHT6ZXa7ChU0BudA1PpQ/Ra5JQyZbEtcRu1wVf0BCZ33O
         sJULJicePK3UKEAPUkqpgUoCjnI9gNtve0N8aF4Bd0uke+/BX3S06f1776rT1OYvQbIK
         ftapp/8vqjXlZilGOgZF90wC+hnI5HIjOu25+TvrpeKelG9pHdfQHHW+ux4d6BUuk8hA
         C137GW2hBBiRiGBxoisrjKLB94OZOOD3o5FzE3jzYVhr0h7HQHJG0IkNKS7oNkvgelFs
         KyKAc3vCkp1/Iqz7kstXGFn47mPtuu+qSE1UnqubkBIQLyIi1jPO27lDucER4fJ/yUdT
         fHkw==
X-Forwarded-Encrypted: i=1; AHgh+RrdYB29R2Zpcl1XdkU/tyn4Hauo7UZCIiJ/fYIls9HRB3G41KkRB//M+hwP4vFomZLWyU27hKei1H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90rpfZ079TUNUkwToSYLh3Chju3RErOYT/RI8ZZAmyofug3tz
	7xqDCmxPWY6n/MmLexhdybEySV09XDysuBtm8lYusCSbpBnV8mEuDQz4OKmAvjgtLRx56dRa9bp
	ESjMe7aCjjo64eYlnoaNvg5XweJQOKa7HIOsXtyMRjcO6fLLrrQhegX/7R+qU80B5lsZvt+aUqJ
	MsiOHTk93ScA/Uz9bKNrPLdqVCn2JCma/6Xtcn+q+g1TYAvg51UQSxlMF0YiVPNV7TynzHRYpos
	Du6Z40aRlOY
X-Gm-Gg: AR+sD12SxucDXxVHaxXU7dTWnD6PWIRZb0GOUgtJckN7TDep36fp0+QVIGJvXWkbwjN
	t7yo6O962759/kMQhSdn/xzC/nk/zUDUV2V3xOb77jVtMM7GjtPTs/w3s8qCSeNgfhGdlzwkCKM
	+GnZM7qe3nbH5i3aQ5rf9zQrXvdpreLcJ+/CPV6YXzBJqlmx9r5uQ3CybLM58steA5wNFlIhnPX
	HYOiEPShw8JVJ6nvMG0BN8S1UtkuD4kQifhpIaascqC6Hu/zLdVBgM4+kd9knOEnAXVwqBOs9Ij
	OCPiqSZHPYv2RrdNdYlIRB77EcVVHWqzVhWXRSDGxGXRg/Ts82Th4FlIO7FDg60U50N5vEJgEed
	SF+4NPzd6/Uex00SpMdI9Rh64kV6pTzVLEkU3KEHGhS8w12+3CtVoP4ua64JfNjjVg0xi0bPIaG
	ETieRCHgzrBkdrz7Bvli58zOGxdWrOAw==
X-Received: by 2002:a17:90b:5447:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3903c66b3bfmr28360991a91.21.1786132893098;
        Fri, 07 Aug 2026 13:01:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39085ee6b3dsm2560964a91.4.2026.08.07.13.01.32
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:01:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934963b2bc0so371359785a.3
        for <linux-mmc@vger.kernel.org>; Fri, 07 Aug 2026 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786132891; x=1786737691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=frEqhqTY4YyOiZv5F5GY+l0M2IOOmrFEYWVkjKDi394=;
        b=LNHPIPkilSl4iP7DqzuRNuo+gZF4Vc92FPDtO482YdzYoBpLikIzkvUvdJ79trfwOk
         /UFrliTBPp+kTXCRKNBt+y37uBss3i5nwa5fZAMZy/wzVxHJh8s1v6eb2Op40xTXCIMC
         KMrF3flVsciTLfLmxzojkUy98BvRD0hO1Lo2c=
X-Forwarded-Encrypted: i=1; AHgh+RoOj7JTQyGT//gZnAw0fib9x2usbXeySMGYkIe7DJIVmkQX7wlVSuVlEabE1e5ZEJqpoCA406RpyQE=@vger.kernel.org
X-Received: by 2002:a05:620a:8010:b0:92e:7a3c:add7 with SMTP id af79cd13be357-9364921c0ddmr2287894885a.27.1786132891310;
        Fri, 07 Aug 2026 13:01:31 -0700 (PDT)
X-Received: by 2002:a05:620a:8010:b0:92e:7a3c:add7 with SMTP id af79cd13be357-9364921c0ddmr2287880185a.27.1786132890663;
        Fri, 07 Aug 2026 13:01:30 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366dc51b43sm225839185a.0.2026.08.07.13.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:01:28 -0700 (PDT)
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
Subject: [PATCH v8 1/3] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Fri,  7 Aug 2026 16:01:19 -0400
Message-Id: <20260807200121.2590202-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807200121.2590202-1-kamal.dasu@broadcom.com>
References: <20260807200121.2590202-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

keep-power-in-suspend is currently documented as SDIO-only, but the
requirement it describes -- preserving card power across a
suspend/resume cycle -- applies just as well to any card type. Drop
the SDIO-only restriction so eMMC and SD platforms can use it too.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v8:
  - No change.

Changes in v7:
  - Added Krzysztof's Reviewed-by.

Changes in v6:
  - Split into a separate, minimal patch per Ulf: just extend
    keep-power-in-suspend's scope, with no brcmstb/firmware-specific
    rationale in its description. That rationale now lives in the new
    reset-card-at-resume property instead (patch 2/3), and the two
    are set together on brcmstb rather than folded into one property.
  - Also per Ulf (applies to v4 and v5 alike): dropped the mention of
    sdio_set_host_pm_flags() and how Linux's SDIO stack happens to
    expose this at runtime -- that's a software implementation
    detail, not a hardware/platform description.

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

 Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c..c18bf0d6a56e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -291,7 +291,7 @@ properties:
   keep-power-in-suspend:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      SDIO only. Preserves card power during a suspend/resume cycle.
+      Preserves card power during a suspend/resume cycle.
 
   wakeup-source:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1

