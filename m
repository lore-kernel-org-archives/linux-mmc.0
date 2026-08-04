Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D548AE0D
	for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2026 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875911; cv=none; b=Xo8a5Kii75sfzD4IhuYUHv2e0KaRgs557Qs/NdRJtxoHuApKMKdt6y84mo/RLTJLkCP9xPHHUPrhy7yItbR3LnDJSV4YupP840iFwA78pyZheTugbS/KTtS1xSJ7s0RxChvVu5OK7PLaLlBeJgKgzcXUUSEs0WH+8Ah5EBFmyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875911; c=relaxed/simple;
	bh=1oYwQGmu7egbaYzszdd95TYNSc2CcNOc/t4HVfErcC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPpgMOeCqiUzgojZqG+XS5AI1rsLhZSz3LEamR+bKZ6k2Rfs+uUnaA/j70jNOLsON1E0loTki4SfzEii/RzP4brE6jkDC7mrOCDx0v+WzGOYmdEFL0ZWEr5VbpJR6ggPQykZl5yJKJ1LGVNqrYenoUMD5Ak8Q7XflzVlMaIYTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Dxf+ReDH; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Dxf+ReDH"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso296435b3a.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875909; x=1786480709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7b6+tGrp8ymCoXe9JGu+0YvTkdgKzEYKK8fFBsOhsEE=;
        b=LPtGPOdgeoPpzCklMlk9paWkMgBBxTza44J0rq37Z6iMk3ij0P7Yo6ha4mIk6DBULa
         6gZkMpqMgXwr7tv9e1Y2TPzGNiFk1vbwbtu6cJnNhe3jyr2aEFh/mXfi2fcPXXn5KQdg
         oLG3qRvtW9CqNo12LAM673knZA0fIc2Z2J0NsYBnnw7IkdA3T1MtRbkGG8aHjdanX/TV
         DzKXK/9fXAm7rGRWIUir28exO4yrxcrDgAU3wvxvXTXehak2tCUe34vrRPVcqKdG1Sd7
         6irU1aaUSKiSdESEn1PNz968+JwUiW4NvlHOrG/AYD3OWgQ/Ijvw3+8AodjCttcHbY4/
         q+mQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpvj1TmRYWLe8ngLy947Iosmrn+/z1u6AhEPzcp3xnrKfaXbxviOKaE8njWa1Q364vv9gDgZklxvuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyU4pQQCl3pu7GtOnXFdDNQ/6DVSUOJe4MVUHJ3V4Kxvfb7c7
	Q/NXjRFrpiEmZ6S/0nVaCF3mjOteHuzxDIxRmNfv9SjKyun27mLtXurXgF//FxzKpg76Mf8lvut
	3cjH5BCN22y3O4Q0hcVc8j3OlQ59kNd/82tXTcHuraNxjRqp+jtWeT67Y2jw0MQVLBmLEZyXabb
	egmUJ4aKKfUW2Q0hX43HHQ56BrlR72vjOl7wQBQM1h3CsWJbTchmleEc3bSQTEINJNsy/+4knQ0
	zJrWOSNTHbe
X-Gm-Gg: AR+sD12sKrSOyywIubaOd8B7v9Fy8HCyH0LzSjrKd2FelpQ3atEUTi8zdJkRcH31poR
	+fKrZJ5FUxLUlZBxU7QmIhIvzwMbRyj422Fjs9aeqmznHaPr5uOl6ivp6i+t8EHqUh+6/xq3hP8
	DNCKB9UJjjtgj3jzi6XFRt+q0cHCOEh1VkM4UGuQFZU0XflxvuPjRelBuSENZAfGPD3IGvkCCuQ
	dVImxjPdBtjYuNDxIYtDrUgIJxIDqGubqiOb6M4N8cmyhVBAsY4XkFuutDhnbJFgL4At1igGmOT
	fcD+T2qyHlCnoRyTqkDU2u3tXLHgRGx50Wcwr6oyuL8lPwYyYI/9EkV6Ob8PkYXi/ifU0Y7gnx4
	a/D664vAq8gY6+ilkOHg+FfvFyAQci63pafwhxExWeMCiJ6iTHWzPYhgBw4EdvoICnsyMiST5XN
	w0B7IgwYJ6PLbxvBftuBMsbr1KWu7ko97z
X-Received: by 2002:a05:6a00:35c9:b0:848:6c37:cd74 with SMTP id d2e1a72fcca58-84f2e051bd5mr1536226b3a.22.1785875909047;
        Tue, 04 Aug 2026 13:38:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84f2e4d6323sm53221b3a.6.2026.08.04.13.38.28
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 13:38:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso4702146d6.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2026 13:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785875908; x=1786480708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7b6+tGrp8ymCoXe9JGu+0YvTkdgKzEYKK8fFBsOhsEE=;
        b=Dxf+ReDHAzckB/QE7hwm2XpDeZEvioDuAMbcY23E5NcgUSzsfogvuROwPhuaUEyXqZ
         RmTaAocN1UKFIZefMMrodPgdk3LDeXdzz5kDirBd2M7vVdnVTDNh9ItQsWO7bxZkFgrr
         w9NwY8dpJJwO0XdBsrtydBPfWz2lF+MVJnVCc=
X-Forwarded-Encrypted: i=1; AHgh+RrQWuSUFwdJOnUVsRdAEef0VQKoS2jY3q/ViYirqciNyrCJfxfVZim54UQwJRDHsaAYEcublDMg2/0=@vger.kernel.org
X-Received: by 2002:a05:620a:a493:b0:934:afce:cb36 with SMTP id af79cd13be357-9364906e044mr115288485a.13.1785875907897;
        Tue, 04 Aug 2026 13:38:27 -0700 (PDT)
X-Received: by 2002:a05:620a:a493:b0:934:afce:cb36 with SMTP id af79cd13be357-9364906e044mr115283485a.13.1785875907302;
        Tue, 04 Aug 2026 13:38:27 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9364a52dbeesm11089085a.30.2026.08.04.13.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 13:38:25 -0700 (PDT)
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
Subject: [PATCH v6 1/3] dt-bindings: mmc: Extend keep-power-in-suspend beyond SDIO
Date: Tue,  4 Aug 2026 16:38:16 -0400
Message-Id: <20260804203818.881765-2-kamal.dasu@broadcom.com>
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

keep-power-in-suspend is currently documented as SDIO-only, but the
requirement it describes -- preserving card power across a
suspend/resume cycle -- applies just as well to any card type. Drop
the SDIO-only restriction so eMMC and SD platforms can use it too.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
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

