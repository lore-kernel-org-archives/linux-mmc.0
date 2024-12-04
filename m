Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C871AC887
	for <linux-mmc@vger.kernel.org>; Wed,  4 Dec 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304546; cv=none; b=rg4WY7Sr9gTNSy27K86Tu/pOvS5y0pq+IcpAa1gWH1KLqXanGxJfqw1EdxTdwXz16yQ8AnYjYckwd1MGIYDZ8zZ+Un6xEDQ1d3D3wpOhp+6bJ7uf201zwbSuZBEDit9UlebcdmCOWq22jGz9Lf8aFXFTbt/WsVuy34IJ/8hpnpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304546; c=relaxed/simple;
	bh=BuT/7nos5URevs5nXU7ajsEIN7CIlXo3ltjg+xI8Y04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blqJGqsygpaw/ibwNOvs6kvZwu1ApSc+pI63uoRqx9u5GyD7ldO9brVDnbvrZIKS3znaRT0InGiHdIIrZkXQ8PZg3jA4SoeiVa4ESC3LjYE+HYuwEPkYblNA+AD7tSCnNLUY0Zf38wzJMag82+ndPwksuDl/hzmqz/FE/Xc0hFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HE0Lpkgo; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HE0Lpkgo"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71d41932d32so2858820a34.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Dec 2024 01:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733304544; x=1733909344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3a2o2nbwJCPSnXwOfL4XIKrCkhJXnP+2FlXfd5kTMs=;
        b=HE0LpkgoVheOfstNCMMGYBGbRCebMj76iPNB4UbUQfuTpqfpSpblRueQcjNleZnWW3
         r4Ibbr6NyoetusNJX47Jw+MjfWMRgvorgBly0s4yRNXkIzw+B7z+5evqRlEoIxoSeTCf
         RIG6+m3heeDthOd1gWGcC4B78hICp80PGnn/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733304544; x=1733909344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3a2o2nbwJCPSnXwOfL4XIKrCkhJXnP+2FlXfd5kTMs=;
        b=F4H3uL5yZTzbSyRFykE2Tj7/00fqUWdDlAC4nh9G1gWCqvLJa5UGCzzh1zHTT6F9Sp
         si5/vSNZ4ZP2XKagClPuCK7taMTog5KM2Sstq2dWZSyPuCfeB+ss9ixyXXSRcaPGgZ3U
         q2I3yqf/Y9yBRryGzBa/Do0qWB4FuMBwEUCamumlZNcbD6c0NG3wkY8wBdF1loJw63f5
         ot48Tuh5Rs2qGW83NyQdEH0vbqd+OmWnzdFndzWP1ujyTcF0MzxrCc+q4j5cZtZHetMh
         UZR6s7kWwlKN09JvtwUIbSVOuE8Upp7n0TzzVe2EdFbT8AY9TQBAHVHPf7SJGF2EHztp
         QSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbDJSpUTTi8/Q92ZbYARcotfKJ6LYNgw2QBtEpac4yPK12sbjcp3pVRzlV7MNQvh7id0NEca4qTmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLeoJICKDs4McszIis5UMNyF+nK+CcalN3RNFBK4LxqPXQFdlX
	0KwUk4ScoeeQU71+xp4Z3JGS+ACbJMQLf6FJr1Ay0dQftWr0JgSVoVDkRbtNPA==
X-Gm-Gg: ASbGnct8dx4KwBP/t9ZS1gR2WHiU37rWgqXGCGzorCWxWZ8nyxg7FrXmUCooqIxkTX0
	54kYbdaH56alos6KtAcdmkx97MUVR7KabD7wO0g0SkbPk2DXnDvwHy7qjWP7svvxD6PxfUVWPdC
	dqFJea8tcK8hNGHTTYFRBQ1HeZvXURUFss1juevsVIfohapLDMl9dPaT8zuoXUDbSRv+EtKczYC
	q2UpHkTiNFHd8GIiiJt/FD+L21NhKaY2Lrr+pb95NHIKaDGRDOWdnJ60UCJYAXV6Fa5
X-Google-Smtp-Source: AGHT+IG2OOr+DFMkoVU9c8r19W+ABIjfnQAct57iSGJbN6PcBsKoE81tPXls96jiKM1xKEyUQ5FchA==
X-Received: by 2002:a05:6830:2045:b0:71d:5b70:41bd with SMTP id 46e09a7af769-71dad610b0bmr5596609a34.12.1733304544427;
        Wed, 04 Dec 2024 01:29:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2eb1:a68a:2625:b944])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d38dbsm11049024a12.15.2024.12.04.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:29:04 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Document compatibles that need two register ranges
Date: Wed,  4 Dec 2024 17:28:52 +0800
Message-ID: <20241204092855.1365638-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241204092855.1365638-1-wenst@chromium.org>
References: <20241204092855.1365638-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides the MT8183's MMC controller and all its compatible derivatives,
the recently added MT7986 and MT8196 also require two register ranges.
This is based on the actual device trees.

Properly enforce this in the binding.

Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index f86ebd81f5a5..9ea035928563 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -235,11 +235,18 @@ allOf:
       properties:
         compatible:
           contains:
-            const: mediatek,mt8183-mmc
+            enum:
+              - mediatek,mt7986-mmc
+              - mediatek,mt8183-mmc
+              - mediatek,mt8196-mmc
     then:
       properties:
         reg:
           minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
 
   - if:
       properties:
-- 
2.47.0.338.g60cca15819-goog

