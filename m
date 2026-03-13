Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3D30E831
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407330; cv=none; b=a4dM5mvym1/7BmEC7tScXANoWrQz17IhFl0vRyqqjF6LpZVzjn1wzXUfwVtGkEvr4r6WOhVMHqLw0vUSG7oiR6Iffceyy7CsC126r9zM5mQCrRcuOPDkwQJ7fXwE0vp5AhlPrCUR+cHWm7kjRFVskRHb4hSsdr3OR3To/qPs6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407330; c=relaxed/simple;
	bh=t0JT+Wf1dWWLkJLV8Xaeolu3vO+8mn1BpGIdh7UaiOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ui1oMKmFkXRD9BDRSkKW0LPUB2VBDQDQ0Xw1TKhN0bvnXLaXHXGI1lyChTXK+6SZU+zhyb2NNEMggQWSrVO3seodNJoSPDPlABS6HgmdIX9ESptPyScEZd4mg82t42ADvzvPkJw4GX52jgr8x6A4MwLK61GIM3PyFsdOUmUWOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKoMqUnW; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKoMqUnW"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3269690eec.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773407328; x=1774012128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsmU3+KHC+79pXEFoWAli1oSj80e3a/HpsprpoFgQoM=;
        b=SKoMqUnWUHCdPzzdumWcXcQCM4ZBW7/+wlBSYbUoJSEIdpb+VdVcRHKgbYqmKsIIxZ
         fmMF9lEWVpi+vEgu5bm3C66t/S3Al1nqlS7F3IRM6TF5METqI//ORsj9A44GURglVrNb
         kv7jiFGeKoGgravQhvGTqaZCpzlcmDR6NRxtegHzMCceKvt6YUaj0/tOLhIyGA8TOp4S
         rLpuehAO3xH+8YFpY1U9lIMlgzyc9i2liSkopSpxfdnJIwsB2TZgIYgRWFRWB6glVCBN
         E7iIxkO9rGkDVjlyxXmEizi8JoWxNTy/3ib34kMCImlnShcTcOaJHBbIc8MvmLFbFqBC
         bDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773407328; x=1774012128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsmU3+KHC+79pXEFoWAli1oSj80e3a/HpsprpoFgQoM=;
        b=e1iW7aUz9jnE6sM7e5E54RLft9xrKNrvkXMxTHadwvjPIal+X4KlOxfeLRYCfZwWyo
         zfA7wsS071Bw3J+LG9tmNmUl2paluRUP/fdgKWJuxuSe5/Xfu3Bnhs5fVsmY+bWxOYSW
         YGzm53ejQ3S7ZedG1+7EH6RbJssjaXGzc2w4rwE7fDSluLlIzMkrLkiFLmQUYxbi6nwM
         UGUafFtc49fiVk8YAhhWtR2HwLLRiJiO2ESzwnP43jk+126+WKyCbHjeObka8NN4NT+L
         g2unojKlRXn9m97fy3tsZuFWMTJezvdWFAUhjardQh/rOv5xt5ndbdNp9x9yv1f5QETd
         F/9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0tWZuEQmvZmKykoaFSoEP5gAITFP5feUwXx395M+7hPkSSHhPIqDrSjWPnuDE6MXKS05rECTI9K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywws7bJKbdC0P87Cy6gi65lntHY6xK6wQ6E0E9R8cBBiP4bECjr
	WjPzS6T+XSMc5M57GeNkfsIcqhymO4KlmhUiS0sCHp7MVaNpeflPjoQF
X-Gm-Gg: ATEYQzw4hIqG76jDFs0ftaJH+BNic54PIfXbsOoU7oK9+LWuBsdZUNs5k8ulvpq88e0
	CobqZaQy4l/tRWR1bHLz63238qXsgEJIVsXkr9EFv3oBhLL4rTB7b6v2+s7KEdPpTf/t50n4xYJ
	AQubmuqQDLEi68Mn6zGmwbt7NrsiiDWHUDGkFc+R6O1Ua5TwEDMNIH2CREIiVhg4RNrzoirgBYG
	3E4dHbcqAu61JYcyFRkTGT5/GbP0zkqbDku0NVngeL0dwwa+TaO+2edQ4bOgToAF6KvthHR30mT
	VjilsjH5ecTuX4VJLRLxMW/AZ03QvHTVDA2g3AJnvxb9WyLlgbRfeExRL4n0EUMY8/UxDkUA8eU
	+fUL9GOQVoYipVQqbBq/TDUkuhtMm2Srb23pxk4SxYsq09wUMWJmuL51tZnXDh1vOyShLQTac04
	foeFRtxfZhIdFoCR9n4h5QxhS73IrvHK/GX9SpRWQVKHPbn1poDivDE1JDj10TowZnNw==
X-Received: by 2002:a05:7300:6d23:b0:2be:19e:3064 with SMTP id 5a478bee46e88-2bea547d159mr1501145eec.11.1773407327739;
        Fri, 13 Mar 2026 06:08:47 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a803:148f:b6b5:4:db6e:9a2c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab5706bdsm2831454eec.28.2026.03.13.06.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:08:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	shawn.lin@rock-chips.com,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH] dt-bindings: mmc: rockchip-dw-mshc: Fix the RV1103B compatible
Date: Fri, 13 Mar 2026 10:08:35 -0300
Message-ID: <20260313130835.708066-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

RV1103B uses the same DesignWare MSHC controller IP version as RK3576.

They have no "ciu-drive" nor "ciu-sample" clocks and use the phase
tuning inside the controller.

Fix it accordingly.

Fixes: 517b1e3c9455 ("dt-bindings: mmc: rockchip-dw-mshc: Add RV1103B compatible")
Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index a75209bd2710..4965bb518c54 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -43,11 +43,14 @@ properties:
               - rockchip,rk3562-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rk3588-dw-mshc
-              - rockchip,rv1103b-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
       # for Rockchip RK3576 with phase tuning inside the controller
+      - items:
+          - enum:
+              - rockchip,rv1103b-dw-mshc
+          - const: rockchip,rk3576-dw-mshc
       - const: rockchip,rk3576-dw-mshc
 
   reg:
-- 
2.43.0

