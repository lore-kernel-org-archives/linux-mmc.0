Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010121;
	b=4xt5MGhaxqgJ7bCz+JG3iHQmMykG732UjPWTgKpYyUtAtaDvtg6UZaTrHNijsfzlXjBq
	 r2A8VZuf7O+QmT1Zas8X9hpxj6CNNdhV63loG55vfyYUMSXKrAsrxTbF0CybrUB2DdEoY
	 Vu7M0HVE7yYZoynjfex8uqNR6NrTdB4LcEN7ySRn95q6czEWGJd6VkC3UbvH5NjPC5hEC
	 KmnmY9+Boho2rJjTB16o6HXGDf6p4y+cuXOJfyLEQdnRZGC59djK0ndlIyJTx6cUDgR8h
	 90TNV4Fr59fegiH/2rakLObZTur5pZl/ytle5slxSK+hVurYFkBS8VwpMu854d8N8Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kr1Aa3+HTl57ifUnZ6jARduOXVoJ4F2DQRpWjtSxKvg=;
	b=d/6aCke26UX4I1H9oOIWvFwzNBmRSdx2aydHNpY2uUU+LO+7QxJtouFR6iEzvRjsrArF
	 M15GI63rJNYa1gDc2bTwgwtcvIxZkACdQ/6K6Mlj90O9EKv8dxHdRcJKhc1TG6J3WMmbU
	 uanRwTgILLXXVobyoII0L8HlJ32MX/VrM23mJj6WGC0oxUkhz/zwiT83vdHdBN7+5+ZRg
	 cYGbqgEgA3C5uTzlmY1WYv1sJ1pR6KmV5+5SM4pLKKaa9MP06YwFc34cZJGjlYy9Zqupi
	 q/Er2p0wZ2FLbXNDpDj63y6v4/nrLC0rd8nt4MqQVJ70fNxxhsp4xALq1ez0+U2yoxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Whiq3r5d;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86475606A337
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 10:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86475606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Whiq3r5d
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so1601873f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010120; x=1793614920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kr1Aa3+HTl57ifUnZ6jARduOXVoJ4F2DQRpWjtSxKvg=;
        b=Whiq3r5dD47G3/CR8yg6f4enuOc7fSamDkiEzrFlDgN31Q3DfhgVzBioNEpCmkg1xv
         4/2RathywmKAwup4MGv/z7qxz+JFLKF9i6NHmNcBFe6fQj6Xxz4p4xVsdT0TtkDdWMvG
         5Yi6Z1P2aPixbMBpTg0GTSG3X3S/TgpumBZP7sO6z3OXd608a4W7csu8OZmLW8F7KH1k
         j1UxfIyj7+c5n7Th4U1gifTAQHee8vRJu9psysHyIAIR4jgaGMQHqyCHeXyq7RsbU9f0
         EdN85/ukV4J6vJLhzyZyTM2T2VNNTBqc2xk/+n8DRtmn+w981Q94BKTfbYRnVHG0oV/b
         oAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010120; x=1793614920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kr1Aa3+HTl57ifUnZ6jARduOXVoJ4F2DQRpWjtSxKvg=;
        b=FpsvYG2uu2rBrJcv1Hgg9C2RHhEJpX1HhndWWUqLFDyj58yTAFRlej/VWhNuuYN8I+
         cKVGyrxXkAhGTlcXCtckXjCCsjYmqZP7fYG+kr7Y4ruHISBY4h1b8zvoHGNZHcTibtwq
         LKucCPQyFDEpAVzejG/cwyn96U7+f9cmFlae/TLVYj086Xc6WBW3M00PqZYjwu/Kl+Gq
         UHWd3gVBdPXxByOemShmfJ3IDA9UPIebjwzLy9+iuonIXKGI/opAYztCdmHz29nhKJrr
         S3D7HdxR1sMA/39Xl2AZlSaqDCjudyg0xqMgP0CAQjCiXV2LyHxbwwcT2BLgW9e/ZHlc
         6diA==
X-Forwarded-Encrypted: i=1; AKwUvByJXZV58HtrZo78HOqSzhpYuMgQZKz3Rl93h3P16wDZ+kR2DZfotA/f5uxYfjJuzZ4c06WZJObSkL0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfl3Dr4xD3wNEAJrppCOsKPJ7mjczvL3vnoaPGMWi320EgduRi
	MxTBgokCG0RvOwM4i4xNjmmDfGAzSssrlqXWad95zppqX/nslw0PTKiT
X-Gm-Gg: AYBFou1/ycu/EIBDI770BByxOOVcxwFPipwVYBoyhRubY77ldlIk6/3XLT6+fbMPKHP
	tEdKsBULzBc+UbAJEAaBkJylylA5EV6EKo9OdHvi52pLNYS3bg7O6dNg9PddmxRpKGWPi4tFYm6
	g36B8iTwLW28TQLnITeHemzoqSXZMD6vEKs+L1mRfsuRcVDgVxES5N27M+clXPdMetPVVCHaLKj
	VYQ8Dchx35Au03b5SCWsCxJvYyOkQq3pkx51ms8duq5drIXci3fisoM0MuBQYcTPcxAgKwNsn3b
	LmSrSlRpLTggw//vwdoGq3NI2QoTGLstNu1qsnC8DBtIblZNW/08ufzO6Ihv4ZELcnymXjuJcV5
	g5ZWYh93E/ZIklfa3WdP8Y/sIj18ZfpyCCSpzkG/IxnPl4SGa//AvY2wWcn+9F68lN+0dXbV6yb
	c51lb3oWyE0y2YIzqhCK+jTZob6qYJoXI3IIlSSI3oaRxsLu3RtLKuhX89qRoLyHP+EfRMjx6Kb
	6dh1wGxb7/k5Wi7dXg57bB6LL9K3txB+JKDVVOwwjzAb+xNdCqInWw6/ZMvyvWjv5/aAQ4Dtkgf
	ckuaic55ethSoT7kp/xuAch3FXZHLn2NmFyz+XFUG2/TngYSBcMUWrokgDqJ
X-Received: by 2002:a05:6000:612:b0:48d:b650:69aa with SMTP id ffacd0b85a97d-48e3eba5700mr11608540f8f.50.1793010119803;
        Mon, 26 Oct 2026 03:21:59 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm16762876f8f.18.2026.10.26.03.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:21:58 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Document support for Airoha AN7581 SoC
Date: Mon, 26 Oct 2026 11:21:36 +0100
Message-ID: <20261026102138.36786-1-ansuelsmth@gmail.com>
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
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index a4d032224dce..49ad2a8a390d 100644
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
@@ -238,6 +239,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - airoha,an7581-mmc
               - mediatek,mt7986-mmc
               - mediatek,mt7988-mmc
               - mediatek,mt8183-mmc
-- 
2.55.0

