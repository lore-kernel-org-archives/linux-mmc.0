Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEEC3B8BD9
	for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466300; cv=none; b=D1SgP17HVDtJTueODYlOXAN/HQ4G8BTc3E4v8IuSJHyf7bAkOaZAu30WK2j8kGEQahBp7JWf3RDaIGNZfDF35oPDZio1nx98XiAqQ/oiUf0Rs9ojpGyNYBllvoTOnRgUNpASNl3ijrk6a+ldpvqOLMvtzXgzfZkczKkpdF0r0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466300; c=relaxed/simple;
	bh=Pn1CRRczXoaCNuEg3/gTPS8bvh9jftQiMH9lZRLES8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zhwz9N9zmeI/wPdHPCVCnan5srxwsHHZ/5UFvQ095+AzjXA81R34U3+efZdihC/tjYNYF6tN/OF8cUdmksVbX59LGbqQSzQZ2roeGYKNv3MKTwUnqWw4qm+9DdNUOlMxi5E/k/lU9ZJ98hapqxVN7qDowbqPNrDvotxdtXug2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fMWN3bac; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fMWN3bac"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-81f36179dd5so44177787b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786466297; x=1787071097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CSmcaixicWN0/teuSYgIhYRtdBpb1IrPNrZX6fZUyRA=;
        b=UMMbr2Tn1OKU/tY4dEN9ev6zG8bBSyv1LBNr9ikwkjH14MMyaK1SiYb6b+tAiGDZ31
         eyYr69I2vYYQ1+DJHwtcGhKja+H6swwhBjrt1LkQdYKJLnP1AyDBBJnZZJy9th6A9Lo1
         NPbBX8E3Y2u08AZ+NyfuycRh15cZAaCj6RtnKXDWagfaokDyd7SE8Pz2wTG1WX4M+odK
         kFZvv6XIfKjeBEtdA4QCH4bFLpMsXesFWDA0pSqP2oERvIcm87YIYafrn1r0WPTirFal
         0gJlWhDqmrNnVfAAMFGTMrWtC937C8XRWHfVbnzq8rU3O4FAlsmCIue2QV0EXXDsY5P5
         o9rw==
X-Forwarded-Encrypted: i=1; AHgh+RpoP1wCT8GQH2kukO6QYatrryCHm0Qiii4LbB2M0o0ZOkq+jQrWfDjYmsLqVxRlqH2vUE6jNM9vIek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxW7HpjdLSeQ53rKVgWiMC3n3SV0N9PVC1A/p4qZb/Kzn2zbv
	y4qs/qorCtOF/Yhf6ytNXlGCPB1K+iFEVpBmCc8ngettV4MqcBfuVNQMvj86A1E5/yxiXf/YqTn
	HcfzX6kti84pcnmcvc8rWqSjaN2nXMy1yDGpjfCQ3bpA+aJ5VWbNN6TCJNMWy1CY6aQCksYOlY2
	WlKgP5GWwkYObSIOQ8gjST1OWDwl1NAILYH4Cz+FALZx1OqU+9uBmdRnBHs5UsFfmWxs0rUpCwW
	LfWRATiwz9/
X-Gm-Gg: AR+sD12G0MawgaxxhaBsmr9OItfpQlkUdWQpji5WxqzG1otjnpAwnYKGf3/tdl4u5zW
	GDgGeXNuFP4O/dNr+AY1ku1QRt2VKpbhwBUWBg9SxOj99RKM/y2wyOOdGhIbit5ZX2M3C/dn9WK
	WxFYnocQuK4EPQ8iXfwbG9xUGddjxrLReqf+gSeW2L2vKdqtjSKjmlqqDQcGFnoOisBMbCUla8Z
	5k2D1J1UnKDR+O1NzFc3D0NQFzNnAwW4QVUkDE/ZOguFdpuJ+80ziIyrkpZ2VoNAMVcpap8pZCK
	8x4yJiypdISuVmrYIn5Tgr4i33VUHdhaqzifZUFAxNyl/D2gbw2AlFyIjRtG/KZGa/Z8RlfEkP5
	WhLjEQdjwvbEsaAmWRAH5NSeyIQUf3KUhRytbqzOZ8hjqTDtZzsfplhMqq3LfAljxTuyvYJz02s
	WR4HAU7u/GyEnIMXFDVzoJvo9+e11BQhxO0VU=
X-Received: by 2002:a05:690c:884:b0:81e:8577:d044 with SMTP id 00721157ae682-82f2dc951e5mr31107197b3.35.1786466297376;
        Tue, 11 Aug 2026 09:38:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-82ebf0e1ba2sm909437b3.13.2026.08.11.09.38.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2026 09:38:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930b6bdcb4fso15259385a.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Aug 2026 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786466296; x=1787071096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSmcaixicWN0/teuSYgIhYRtdBpb1IrPNrZX6fZUyRA=;
        b=fMWN3backj+66pLPUqSWLZG8Z4xnDqJqzOZpRy8TMD+r4OluV7CvZmFQ88jPXwAjQr
         3frRF4Nga9B5gCB4sc40i5WbU2WjTXaboccqZkltjPvfhUrTGrM/H2vmUtrLtXa4wEFO
         D2AIn8vWT4MaHT+2eis0Dsjcv/kIXv9QsQAxc=
X-Forwarded-Encrypted: i=1; AHgh+RoKL2otKP9CKcxargHuzb2YY7mZDdmeU0pV/HeP47se2eoSBfMmUvhKB+OBWWRLEIkvRTyc1Y8UiK0=@vger.kernel.org
X-Received: by 2002:a05:622a:c3:b0:519:f884:b587 with SMTP id d75a77b69052e-52d585e7f3bmr41298961cf.27.1786466296496;
        Tue, 11 Aug 2026 09:38:16 -0700 (PDT)
X-Received: by 2002:a05:622a:c3:b0:519:f884:b587 with SMTP id d75a77b69052e-52d585e7f3bmr41298471cf.27.1786466295898;
        Tue, 11 Aug 2026 09:38:15 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d57c3c09bsm14427981cf.25.2026.08.11.09.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:38:15 -0700 (PDT)
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
Subject: [PATCH v9 1/3] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Tue, 11 Aug 2026 12:38:08 -0400
Message-Id: <20260811163810.1599747-2-kamal.dasu@broadcom.com>
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

keep-power-in-suspend is currently documented as SDIO-only, but the
requirement it describes -- preserving card power across a
suspend/resume cycle -- applies just as well to any card type. Drop
the SDIO-only restriction so eMMC and SD platforms can use it too.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v9:
  - No change.

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

