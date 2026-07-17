Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140EA379EDA
	for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311599; cv=none; b=OxKwsWXNjInrNQMgPYz75ip2InKPlShk+mZmWvGKgVq2+EUFcsPznwkmldEyNvy2qsYfoWKOCg77HcYsZFX4FtrsZn7QsIn29vT27Pi3mMQmTDp+YvEnTKkD50Q60EnfIo2PbdjxAtG3/U516iBV9pIiyqAwuCVoXGn4ik82jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311599; c=relaxed/simple;
	bh=+GOgfNtPrmMuyHFx75brM9BcQ2B58WHv8lKKR9nhUkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+MF67vR/ZR/xug3cSDFyoRAe00k0kD65wueWIXmLeoAhHFFBjifQDL7P0Qxtbmvj0uEv+vKPYyiHXQoSI94br7nfks06puP/3G1mGi7Bjb00ns2za59KQH0xkajVoR1gJhHNrkt8KfKwrQ7LTT1jtTnglHz9h0VkplzZfxoq6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MyPOkRkF; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MyPOkRkF"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso4639662a91.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311597; x=1784916397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93QkjjRqo0Te9/7g0wIib649nSDyvtIkr1k+4IQmqiM=;
        b=oBItvAOwozYcwcjxyWegzUU1Jlz4hgpS6ds9OfGGC6bi3FkNrWxri6dJWeejiOLfmi
         sW5B1bmJybpX78JN8M/4cTEqf7f3R+sxwnj3wEd7pwBJS494YHk/XU3DOdQ5Ls40iVZ6
         pN8zhAhVrUEZn0b0sVS8H28VhtOBlW0UjA9tHvk3hE5hGJnlHvvfciZmkVjuDDmlgqu+
         /OQac/RMe1wAJ1skyWrRy6rXag3kGCF6hE083fF2vUPqSy5ZZwqYFFhL09c0sqFzSKrX
         jdxBJjn4mQwKvKDdcngtd2kBL8LULgmbOo5D52JKxZYYF6iLr0eBu5B4MdniB6wNuaOi
         hDYw==
X-Forwarded-Encrypted: i=1; AHgh+RrvlnHas3oX66rExQAnt90G46l5O+g8Hd5fYIdVNKJ3/HaF0mvo6tTMfsdJsPPkGISV2h2V5U462qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgyRXwF15b6jcSaKD0IVA2j8XLcRNiHdPD1wSJ7rGFb5hxyNz
	iO/AvLGXZ6d6rRVoZz4ZaTFPsxnPjbm2uPOWuhX5GY+DViGKRiFOATJpgA3aUGWmZZLXAtN9eh3
	brJKr3+PdHU5u7635P9QRtbNImz4GLoUw0ctj7qlxFz5OoQVHA7MHX1GCXOH3Wrc0N6znemPqvi
	rH1/+PZu74r+GzC6Yxqze3TAMxWqCQYM90iNkpsOpA+QXm3/P+lDgM44f2rNnNZlGMuWam1AjR1
	EIZVsR2k2p1
X-Gm-Gg: AfdE7ckfR9FyTmy3vAJeyc5v9pG6dpa62/IVBpT9PTfbQL2MMJ8ZnUTGM6tBQeBX5Ue
	1M+aPA3Bx4b8Fmf+pOgxO8oaT7keqHaSetxYg9fapdXBDB7Js79lwOM8BRac25I0bKPW/GjICjM
	6wMFJBPDCyQ+NAR8E/VOvaKkq3GD0SZJidTizewqPPXa862DJtxQAghHBzBu1rcvuz4pBYT0iU0
	/LQ6FEcaOEQw9CqyfwFpqYx6KPs8hvvgI27snuYj8CnI/A680GIDrdN4fNPJl4JjGbAp+/9B9mF
	DVSH6/lYxvWb3OgS4+7JD0Nn95QGsOn1MIaBjyaNlMbHA+vUlOMPSmJxdThLt+sDWpiXHZN7wHO
	393uRsQ7uTjZYVvpiiEdp4zbBMupT5QLcE/Mi2CWaNbvm6Twxivx5f4ej9V3sHgO6YWiL1jPHHa
	oOCPP0QPni8hUYukUPJe4ZFQGdbVrKuBbF
X-Received: by 2002:a17:90b:58cb:b0:381:5bd6:eb19 with SMTP id 98e67ed59e1d1-38e4b47765dmr3919020a91.18.1784311597271;
        Fri, 17 Jul 2026 11:06:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-38e4ae41243sm207552a91.0.2026.07.17.11.06.36
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2026 11:06:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e9489f62bfso175475146d6.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jul 2026 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784311595; x=1784916395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93QkjjRqo0Te9/7g0wIib649nSDyvtIkr1k+4IQmqiM=;
        b=MyPOkRkFVJ1cehCqTJcpIDUTEhC7LpJyzyN8IpO8l97h1xrOnO2XkfuLlt/wa32Qzs
         mA36FYvAxUK3aRgVShGVtTuhQ4pRn1qk617xeu9G8DFU51zpsqE9/9itV/FQbEmqLYwV
         KhTQ+1zhsumYrjV4wdBirxXtwhM4EyGdiMGBo=
X-Forwarded-Encrypted: i=1; AHgh+Rr6ZVOKOwUvsXGhe6mZiZfiQNmyybBRPS17U7rnUARX7eFA4fuEhlf4gH978YiZnetmoFsm6ZP9jlY=@vger.kernel.org
X-Received: by 2002:ad4:5f06:0:b0:8ea:658b:aff9 with SMTP id 6a1803df08f44-9077852a123mr40715576d6.50.1784311594784;
        Fri, 17 Jul 2026 11:06:34 -0700 (PDT)
X-Received: by 2002:ad4:5f06:0:b0:8ea:658b:aff9 with SMTP id 6a1803df08f44-9077852a123mr40714966d6.50.1784311594095;
        Fri, 17 Jul 2026 11:06:34 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077856002esm23175896d6.11.2026.07.17.11.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:06:33 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: mmc: Document no-mmc-sleep property
Date: Fri, 17 Jul 2026 14:05:35 -0400
Message-Id: <20260717180536.1757204-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717180536.1757204-1-kamal.dasu@broadcom.com>
References: <20260717180536.1757204-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Some (e)MMC devices cannot reliably resume from the SLEEP (CMD5)
state within their advertised S_A_TIMEOUT, which can be problematic
on systems that resume from Suspend-to-DRAM by first pulling boot
code from eMMC using hard wired logic that is not field updatable.
Add a no-mmc-sleep flag property so affected boards can tell the
mmc core to never put the card to sleep.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
Changes in v2:
  - New patch. v1 used a card-level MMC_QUIRK_BROKEN_SLEEP quirk
    instead of a DT property; this documents the DT property backing
    the host capability added in patch 2, per Ulf's suggestion.
  - Reworded the rationale in the commit message and the binding
    description per Florian's review.

 .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
index 3d7195e9461c..11df0524530c 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
@@ -232,6 +232,14 @@ properties:
     description:
       All eMMC HS400 modes are not supported.
 
+  no-mmc-sleep:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The attached (e)MMC card cannot reliably resume from the SLEEP
+      (CMD5) state within its advertised S_A_TIMEOUT, so the
+      controller must not put it to sleep during suspend or power
+      off.
+
   dsr:
     description:
       Value the card Driver Stage Register (DSR) should be programmed
-- 
2.34.1

