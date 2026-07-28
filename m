Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3844471CFF
	for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265410; cv=none; b=mZ7ztDEONdTVY+7+LHO8X1j8sbMxqTWqoa3XraGkYHOisIK9QZw0ZNZZxeqBFRaUZlNRDOrBNQsNHORYCqb6kpNne2Dl5zfkD9mMgEio/fE2fVgF17UILXatwws16D+3OKk1WmIaIwnc51T3Bb5gP6uyC1WxEG5clyitrCTIFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265410; c=relaxed/simple;
	bh=1xzrBy33KLcUh2Fo6WOjQjNp66pfa5jlZtfDWhLzcYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fYiPb4IUKNqx5G8c5JyC5I6UzBy+O4Bbiil7JsxYupx2sBoVwJ5q+/AOK7zl639NLTgF94HUWLvTaLc3w/W7kIjrtaghTIH3X8ltVnuXL30TKZJUd3qRKRCOOFPWuZxXLdd1gYkD4UqwU+tlANU82/u7ZLwRvHgT7EBMvzU4N+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BMO6IkrS; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BMO6IkrS"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-902fc790cd5so920996d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 12:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785265406; x=1785870206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jD5hBY+xcEEWI+IDnVzAov300+ilRU3clyqXwW86j6Q=;
        b=Se0XNy1JHYZjHIzFz/EJz7xsoA6lQL/Eg73+Q3uPH6aLrhGSAwnNwONen1VLffB4+d
         6/Bh43gQ/fQhbBNc+dE1cvUKZHjITCBRxzwF/T0AT9YnQMvAjGPAyaNHmAZZxaVXNxg+
         t0pJ/oL897uDCll/zAlEEvmCP1dgZwZueyPoNVFq5vFXOQV8/P4Igu8Z+B5TNh+pREne
         bEhjNQYu4shGT62c6Xpkf/s/xMqF1xehJU1UlTtUrBZr7H0i3F2P9LywShOj9VFpwlo8
         lVP0XYeDwOax0R5D7g+5/eJ8YrM+WJK8Z6PJf0i0WipjS4HeWjBswr4wauYbW0P6DGwn
         m5OQ==
X-Forwarded-Encrypted: i=1; AHgh+RoPNFDIX1GB2zFnCgTBf5tQz8oqoz5iKQg9XBZl+VbkqGqahvOhzMmbtS+mhYzUOpBhKKxeydxbmEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCDuf9yTTvxp7F+1wdT7OJWfMQnqTfeuyd3VK7VcSbCDgKoxlY
	IR3qRxLJDQ/V4IeKZ1QZ3F+9yWwwSVee9P0W3Z+UY8xCdTvCcG4rY1S9F3KHaIPfAApoZQApZq7
	ls7QK2ENQyEbiuZ3ycXhsUJuXPJAaT2nDcB48Wn7XrGQDXx+2icbEgPms6g2/+qJF4RsPefPNDN
	yJ/DhORokm1+pYO8nCo9/PbdQIk5mB/zQX0ihzttU1EF6ISYxxc83QqXMWF82CTEsmScZQuEBX1
	aCUmKh+JbzE
X-Gm-Gg: AR+sD10vIAYmMTh3GG7w/6CiyWQBDXbfwvHqo1PGF9F/i/BkwWhEP5uyooi1RpvVR7+
	EICGlWyuA7SpVRNXulHqtiP548ff3bTcwWVaQU/Gxr6Ok/qxLDd5RL/8xN+61WvtbS0+0w8nC9o
	lrtxOXZ3rO5Q1tLxnkyMF9m+vOL6fPMyopw4d6g3dLT5QKAn/J5RPZ3JZZLhoqushhsFMjFy/SU
	saQv5kuI2L3u1Klc3nVxcmsmgR3bMEGqNS9QOCi+sDbAiDuv/V5q0R0/hHj1NQzuGFu5uQmtuSC
	GLDaAjCTz18jKWap7BrwgYWKN4euIRp0fodoqTJxcHbeTwBDFTOCfISmgBNqBW9OOmC13m4bJKk
	Do81OryFUyGmLaqyGb50elMTQJyIHwDFHdoGrQCbPP4KtPGQSA6tNBKnq0Whpk7jg3BCtrxLwrl
	CVp/2Wb1H+TmTy0aPL0py/io4LYfU83YZ0
X-Received: by 2002:a05:6214:3a84:b0:8e7:8d53:2417 with SMTP id 6a1803df08f44-90817015c32mr41531196d6.27.1785265406323;
        Tue, 28 Jul 2026 12:03:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-9081dc281c6sm407686d6.5.2026.07.28.12.03.26
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jul 2026 12:03:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90410c668adso1782686d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jul 2026 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785265405; x=1785870205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jD5hBY+xcEEWI+IDnVzAov300+ilRU3clyqXwW86j6Q=;
        b=BMO6IkrSIjfxgdgFjT92hjdmF1PH2HPr7bMj37a3/3zLI6gympu88ih/bcJeh0U58Z
         /pCUX8bZ5Pv9UOf5jTE424v+A55DYerOXJma1lLxp9GU5j9mQCeTD/lQxjr2+tjJLmy3
         GRKuY/loH2hCpFYDNduUHjwpkYuUePJJKhkaY=
X-Forwarded-Encrypted: i=1; AHgh+RrO/uneaXIQRVwNLyMGs0Zg/YHZiu1pZIXvjjM0r/g6UjTyFotp4lVV1KCLVOxLH2NCXuUfNkABj2w=@vger.kernel.org
X-Received: by 2002:a05:6214:29c4:b0:907:5a5e:ead1 with SMTP id 6a1803df08f44-908173340f0mr42102136d6.61.1785265405562;
        Tue, 28 Jul 2026 12:03:25 -0700 (PDT)
X-Received: by 2002:a05:6214:29c4:b0:907:5a5e:ead1 with SMTP id 6a1803df08f44-908173340f0mr42101076d6.61.1785265404954;
        Tue, 28 Jul 2026 12:03:24 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd8b21esm5502856d6.46.2026.07.28.12.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:03:24 -0700 (PDT)
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
Subject: [PATCH v4 1/2] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Tue, 28 Jul 2026 15:03:13 -0400
Message-Id: <20260728190314.2325906-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728190314.2325906-1-kamal.dasu@broadcom.com>
References: <20260728190314.2325906-1-kamal.dasu@broadcom.com>
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
---
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

