Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112012;
	b=qubimuCWzNgDdz/xX4kWPqpg+d/kIN5marKYHAhlTLwlDS9jlVofwtvo3AiBcc9tvTH+
	 CSalNDe3ST1M6NhlDoLhWumj8Giy1g/E+CvUdhVXmYgiQ7GB8srbQE78tmZuG3T6X1P1e
	 hOV0iowUdoRBLUFB7CYQLSzt9vkqMJ45g0YlVPcijMdeNf2yi2CyWDq9wcBvKmPMwKSpr
	 no1F/Y7c+l70aAjTI6lMP3ZsFyVEjmhT87POx2YMDJkqkUpIZrPe/D9rgyEoBbRBs+zK/
	 SOL2StRXPi5UiJRjI0OAplW5Z/dnUzeTeItC/VM9kCQAkOcr306ylkAI21i7sO2FDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f+FSGmmtRncCiBbsjEjoljPu87wlMKlOjOPIMoQyEbs=;
	b=G5+ptt+QfsVD6an3y/WVPDVtaDgUHXaU82Sv5TRUHmHAfyMztrkihNsy06dFIDs3Ihnx
	 PZqLtGUD5U2hgEhFvJxstu/lNXgMKBEPXg/tQwrC8tQRQsQHOxHRvNb9DNIsINuzO9Fw8
	 aAprgIeiX8sBpua3VcqwU/vs2P+Ic+eF2DYVIFllcPHkDO5m8SyzuYz+fyY2l/hb3U7OE
	 21oAO6uRycbPRLoGhz5QAHyv0GNLswSxA+SCQj2H5mkGygZ8edA61J8qqTPM+DPAjBjmi
	 SlCFpEaqiL7f/yoJ3uvNV7ju/doMpo8pbtY9JKbZH56l8Z0pEvPUzezvEfWU8IsohMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQfYoMZM;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE98606A31D
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 14:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE98606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uQfYoMZM
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso3071971f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112010; x=1793716810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+FSGmmtRncCiBbsjEjoljPu87wlMKlOjOPIMoQyEbs=;
        b=uQfYoMZMNn1b1mHbh6BEdHCCn8DL5Aam6pau5FsCwoApvaqSWc6sLxG21oIz17BYzI
         L0k2l7bv0VS+ZIGumi42bUm84ELP45TwdrWN3CGoU7IbX4XU9LVeg9ofwkfWCjDWWz1s
         JNOzuoyKHh1F8uyfb3dhlzvQbJV/xEVomKgYc8DNOYZ3/WHWf95BJw1t7uF1D4XGgMWQ
         sETGkTXXDsBUpc/3S+2vBdIWiMGUQKNj3B4bxzUjSfYAlbPnX6qrzBXFbEx42cfzsofz
         Mi4j8QfggNhHyZhBbRiycvz1LOO+Hw7lrmym7Hv1C6DVZP7HCAQ9Ue1bh5z0yKowys24
         SB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112010; x=1793716810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+FSGmmtRncCiBbsjEjoljPu87wlMKlOjOPIMoQyEbs=;
        b=t3geQfhgPprh5jQQ2XM9fdYXfuQQgpS3ErGz+4EMVRQm2zATobAqnkuCs1Rxfegoio
         cbrf/ClmzMXKXQlFC9R3fBPU3jNB9HrCOdj1DmjgrYQpFEGLTCeOV2vDhcpe2EGm2OaF
         IE53C9Nc5AjRPZHO+bpB2g85sYBPC17oyB7sv6w7Uc0JHVMHSG0z2vn8xKhanARiC88g
         WoYaRQyshBVnokCcLSY6iG9AbMkU3k1XO4AuDOX2p3SeqWypcnRWYQkJJUhRQpL1Ls8B
         h918857DIr9JSybLPdJgK4U8oqJqfs3mb25fj47HKDqnavdP112Ilyutxfobn5HbLEiv
         SHRA==
X-Forwarded-Encrypted: i=1; AKwUvBzw6rkVf9QVCOmqSX0BPzTp96s6nB+lsgKRHPzVZ3fymcBdMtH8KiaFVT9NiKBVx1cVB+1OjWOX8Ro=@vger.kernel.org
X-Gm-Message-State: AFq9FYJY5ONCixHlkf4J773qInIYo1e0b0FBLz/1PHn17iCfk3m2UMpX
	wMzWv4CXutv3dPqLOGpExlLUIxMgdqG/HUpN37FipHgXO2DDTfGCudhA
X-Gm-Gg: AYBFou1C3n0VJoazOtjAi1wCBmAs1kbaGvgrcqGXVZVl7/4pSn0vAbB/Za6mlF5a7Zw
	jnZSVQrbFoMYr8xibwHFPAUm3BOf/RkKhxJ4kMIfgZXoyW+ATvb2vVRa2lZNxOvf6PYc2fCAgKb
	kodzqOXNFuAe5ePGwxSi+uCemcDimqXS3KrsFaq6ZlKiuL+X/sW8BGqP6do2+KCCPOEkf0ae65O
	RmYrKzc9WxRqXkH8ddx0czWW+OkHrQk+VxQiEHAR13XxQ9tKeBj1AHntQM3TxKRkVipAkV8oHd7
	wiVXxtXGTfHBWUfH+GFCzw6UKYT6PsqjmRr0L+DST+dwMe7QPGq3M7A67JvocptSjTl2rECBfVZ
	PYiKf5t4LB68UKWB9wLCvm5nGTYz2pHqR9v9YE5Q8ftF+ixoJY1jM5YRXThfMOcAapOyfvGnO/1
	Tj1d4rIg05E4IjOMKG0x/4vd2vrxmn2zevx8LlZYwtp8tDPFxnALN0NwZpJ57SV9q4PB1SLwLEu
	eRMLUXptYxLGj2SEkijbKz9G5dRkKj/ZsEqB+iPQTdDq3OrCQiI9alMOJQFcCro1XngOw8SMRF3
	axOnvwaaQ7JMmi0/2iYey2cYDbmE0UIghheeJ/++uoB9izIu7bgUO7Kkoi3U
X-Received: by 2002:a05:6000:24c6:b0:48e:3cec:b852 with SMTP id ffacd0b85a97d-48e3ebb0fcdmr20256092f8f.40.1793112010059;
        Tue, 27 Oct 2026 07:40:10 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23354151f8f.25.2026.10.27.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:40:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document support for Airoha AN7581 SoC
Date: Tue, 27 Oct 2026 15:40:00 +0100
Message-ID: <20261027144002.10606-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated compatible for Airoha AN7581 SoC integrated MMC controller.
The MMC controller is based on the MT7988 with the difference that it does
have a single clock controlling it.

Add the dedicated compatible to describe the 2 register requirement and
permit to define only 2 clock (the main one and a fixed clock for HS)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Also add compatible to restrict clock-names for source and hclk
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index a4d032224dce..704d59360bcb 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - airoha,an7581-mmc
           - mediatek,mt2701-mmc
           - mediatek,mt2712-mmc
           - mediatek,mt6779-mmc
@@ -182,6 +183,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - airoha,an7581-mmc
             - mediatek,mt2701-mmc
             - mediatek,mt6779-mmc
             - mediatek,mt6795-mmc
@@ -238,6 +240,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - airoha,an7581-mmc
               - mediatek,mt7986-mmc
               - mediatek,mt7988-mmc
               - mediatek,mt8183-mmc
-- 
2.55.0

