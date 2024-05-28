Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5716F858
	for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903182; cv=none; b=W7t3HolxF2AKgLynmeFSEnxbgdP6Ufmg/P3UW42wXgH73/RYxv8o8doH4uJiNQq0d6e/Fzp3iGvOIoCegjFwJOiczqvQAYThL0NCI9Sb2g38NWTBhwQZafB1EedaypnS0Jw9YKtcqv+WEOgDKfexHnqRFwF8GhkppTxLJruOrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903182; c=relaxed/simple;
	bh=9k25ZsPTf+WrTiK8qVLkskl+r232la4YhtO+5MWY/Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISEegfvrz5UFYAWCeLFXWxPTltzy+wsgoc0YewEFWVuAqp3m3xPYHh8pdYFIdB56h56HN3/7TUa3OSwUEOPoWLrDapHEJUAxvnKG/vFy6KHwZL1CC/3evFCl0idDfIGglg3phfdf2PkagZSF3JDe9B3piZTaOfz/60CbZwsR3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fd3kvgt1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fd3kvgt1"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e9819a630fso12732191fa.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2024 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716903178; x=1717507978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=fd3kvgt1mB7F98/c+nrDsIQR1aPE4xbrVgnvejOCN6hP3kuSPyfhEyyrYWdUhQP+yx
         PD7SB2F00cCkS3g6GU99TVCjj4dfEKgYsYg5zarhgv5Fb14wuVvgWs1DI0LOCXibAJYJ
         ER4glnZdMNkoK9gIkxA7nQSQput9arVSB9fhWSsOZukFSA/TUStU+wcO8yL6wJbQs8Ag
         YWWrxCzsMW6sjIESkQ9Lg9c6WtSowCJclFsw4lboywn/rBe67chVm+rwiM4IhfVMwAy8
         J4EobSszR40irUj/nvGflzNpHOiDz9hlYtno+R6bwYZeKKjwtHRGaeiC612+o4lT9bEH
         pIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716903178; x=1717507978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE1zrpU4sY3RHfj/RfOgVZHYb52D/eP6ho+94PIl9YU=;
        b=l1ycXZPjaI0fRJn2eXFL7rRomSm/COru9bPmNXJ8la/cmyACL61H4agRFLiUSJSmTv
         poSX6YHzk71uVM6kjRO/tQMybpz9cVSzJ03rLhNqoLcDazwEqMtzLcTfZLOtnyod9Ci/
         XgekZyx/HLAV40CKcwpGQhaV31VzT11lbGNl2ij4Z87Yb5b20ztVmHATFeSrdbwpAqCe
         fVlVyPd7XPT9Ac3vBeEXBlTHaEjG9ByvCIjSws2549xOmL5SeUI2FD4JxBEr3JiKwZLq
         scEt/fS4nhDGsrgKT5ZgevmFYdwb/ELaQ1c+IpyoSAwmeYIHEZOkHPpHP0t12lfLuXly
         w10g==
X-Forwarded-Encrypted: i=1; AJvYcCUuYe94aNrfd0fVCqRlfKU5hZcUCIvjgMCTgiiCt8PeujdamyDf61ObQbR7d8w798LnztOxv0MlJb+mWdCXFVeMTSjpRVw1PDYF
X-Gm-Message-State: AOJu0YxozJ1QBa8wR2plHTWEuOqxKQ+0nXujz82onWV+uhqEuzUhYG+L
	HFaJoEPWmlg8GDKCWPcfJOLXJk1LxmlDV9uz5SMVvS9I+b++jxwWfNMLjBPUfOQ=
X-Google-Smtp-Source: AGHT+IHEXl3H52Dmzhq+38r5mv+t/FOvPtQ+YYhX+r6nXpLxsLtRN0zdfqcZDN5fXmZhSF3uHYSdMA==
X-Received: by 2002:a2e:a403:0:b0:2e9:8852:3d16 with SMTP id 38308e7fff4ca-2e9885242f1mr14453351fa.35.1716903178395;
        Tue, 28 May 2024 06:32:58 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda60bdsm615456466b.207.2024.05.28.06.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:32:58 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
Date: Tue, 28 May 2024 15:32:38 +0200
Message-ID: <cfc4db17981ef946a71d40d522118a560aa0f15b.1716899600.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716899600.git.andrea.porta@suse.com>
References: <cover.1716899600.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
acknowledge its new chipset.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
index 162a39dab218..e4ff71f006b8 100644
--- a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
@@ -23,6 +23,12 @@ properties:
               - raspberrypi,4-model-b
           - const: brcm,bcm2711
 
+      - description: BCM2712 based Boards
+        items:
+          - enum:
+              - raspberrypi,5-model-b
+          - const: brcm,bcm2712
+
       - description: BCM2835 based Boards
         items:
           - enum:
-- 
2.35.3

