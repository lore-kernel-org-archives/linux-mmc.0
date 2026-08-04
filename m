Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6399048124F
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875913; cv=none; b=Syh/UGwWNnoGJzBj47a04z8O2gm35cWvA28MpJDlCslFAMC4ZWeGwnka3NTGeNltB4rZGff2vS0hGsWXuUAbRj8FRISuJHCqpY1F6I5dScXLRAXa/UDHQPNGDx63l6e9qD9EEnLzhydMV1OYsVQ+UBpeAAmEoZJAOAzgoX3SMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875913; c=relaxed/simple;
	bh=PZ//jzzE5h8FHzOfZGXqgUp+ZOZar8706pfw/P/zTb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdI6zNiRAY/FPHKodjDR4NeCgi9pK+XM/UyWFxav4p22HP1l2a0O6a6ttdNb7CBbFH4iCNXI2ClV6IVHGtqwlGX3q/7THUXSVmaoOwG9Io1d/jjZxs8NPc5ljqssUvFhMCguZLfGg5fWB5lDLILLZK4uaTkxiLZZcp+HTl1aMyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cNQzxJlo; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cNQzxJlo"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-848643382fcso275798b3a.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875912; x=1786480712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIZk2NKICUFTz+VkVHlow8aYGCzUye8f08tzlW4UKMM=;
        b=osmtHczzzdNeX4XfEbqf8gTJOuqiX/6SdIS6co6d8E3jVSRlGKr9+BdBZcNcZ7WLO+
         7fVs5cFkVDWBYxdaRz2dJZ9sMW8wfabI/9aByMaNFGmM3O94TN0XD2JH6/MIPCqTuYtu
         yo8R4cXwPAwf5KMUP27u0RFzVOlbjBBrpESlggQ1vrGgEjg1RAbOTXnGg9p3N/N73Xei
         VPf/lD8v1GYboIYzf8nut0O0BPh0KLXCF0ORVrGzYJ64I8bTljVgq28uzr1pPIOH7Fj+
         qdxSAW/6yTP0IvcBQO0GW0N7OLIMi6G7oI1PxtZ1N+M5As+jxOa5n4ZjS4p1f/JoqXs1
         sIOg==
X-Forwarded-Encrypted: i=1; AHgh+RpzLpXHIrBXO1rUdsHVvbzorIxOp1wNSaxdHyQQMbB3oVisiXcqYZzWIwN26x3o2YESKFcZIRDKJjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSlGDkFSNO33MH6mDqbGlbmn0BfOUFcXyXOxTotzJBnvBCZvI
	STYf0yIz9VVE00QhqvvPECd0eq1kOb6ikhXrpcaA+aNX2WLKK9PaPxO3qEsH8t2HkaEYWHunTuS
	B9Y8l9K+8Hep49Gp2s0uXNjk5xwmFPIf9+aQKD37MvIgn21pDn8jxfmwsfD/q5EtfxgUYlhQoYd
	9PXUyGEpLtmGNPS9tg4Va1EZiZ6xXX4nn+GBOKvb42GRlKc0mCGmB4fLzpeMAcmqpx17b4ExNxU
	1D179MxRSXQ
X-Gm-Gg: AR+sD13Hr1yxcPDtCSfd1J+GDLxfOYjy9kquCt06dzIbty5MZWFUrj2CMKX65mOPCkK
	lnaogbFKj5Nuz7Mn7sTKgvMSgEz1SruIYGc1FoPG3FUSyDBN3yhD0YFSZv6gbSJKeIDkVtrCxD5
	14XDI3kxYFCjKzhdnljOYwu/eokLAWpCyAiBYCl8E/NbrRlVUGyVGkoDP5BH3bZThQmQxy+Peh3
	Shb0pEvhHxDcsB9PiJlzAWRTHWA4gCux9tCniTJ1gYOFaaq/ClRl9cwMTkJd8AkYANj7tVVwrMm
	fJJGJJTXF0jgg8aC7LKcMAbRfdBb42h7C4QhV+mjPgEgdRDRORp5FACA8DRSn6Db2gEdkuPLePl
	+axzr65O64WgfCXS1kJ66wfjhtAKyH2mkYqEIoOfCTAnRVorNGQfu5uno95nHd212+Fh4uTpbZ+
	OmsjPr4WdQxvNq5ANM2dn+TenbKXUIntMT
X-Received: by 2002:a05:6a00:92a0:b0:848:4d4f:d477 with SMTP id d2e1a72fcca58-84f2e0260bbmr1148773b3a.18.1785875911759;
        Tue, 04 Aug 2026 13:38:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84f2e4d07b7sm55669b3a.5.2026.08.04.13.38.31
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 13:38:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-904ee4473a8so2187176d6.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785875910; x=1786480710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIZk2NKICUFTz+VkVHlow8aYGCzUye8f08tzlW4UKMM=;
        b=cNQzxJlotuAk+Z92InR4LniLUgBS4qsc5B/UymFSdWuSl7PHyQ8OhjxjMz9KIBKmcQ
         KQdLrnue8FQTyjFhIeOajvBo0KXa9ygFdw5kRUpa7FfzdBtMoMTgF7WOi+wL5qI1qssE
         B+fNhhLvMvRZz6HGQHGNT9Buu2H8zDDAlJJLw=
X-Forwarded-Encrypted: i=1; AHgh+Rp1c/55buRntIkHmiceOX4CT0nO92Gxd6J2TzZz1OYoP6k2H4vmURuzLreeT/LylVkAxk7ckXu/3ls=@vger.kernel.org
X-Received: by 2002:a05:620a:a415:10b0:932:da46:6279 with SMTP id af79cd13be357-9364921af86mr105779285a.23.1785875910319;
        Tue, 04 Aug 2026 13:38:30 -0700 (PDT)
X-Received: by 2002:a05:620a:a415:10b0:932:da46:6279 with SMTP id af79cd13be357-9364921af86mr105774385a.23.1785875909755;
        Tue, 04 Aug 2026 13:38:29 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a52dbeesm11089085a.30.2026.08.04.13.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:38:29 -0700 (PDT)
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
Subject: [PATCH v6 2/3] dt-bindings: mmc: Add reset-card-at-resume property
Date: Tue,  4 Aug 2026 16:38:17 -0400
Message-Id: <20260804203818.881765-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804203818.881765-1-kamal.dasu@broadcom.com>
References: <20260804203818.881765-1-kamal.dasu@broadcom.com>
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
---
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

