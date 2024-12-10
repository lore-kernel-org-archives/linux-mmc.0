Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B822CBDE
	for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815944; cv=none; b=LbYlgJ8OqKqF2g4BjG54/MPQOraeqcXQXEY/xRT/s35hRf8Mc6pyKwDp3c+nyLOkhFYGLb7n+mYZ5dFc5b3HLUs46eA0QBTxh18V1Wzfj1rWsAE3NfO9kdCv++M0XwdMAwIaBrBeFjj9vd4uHbNSFjM0mCkC9CFR1A8oOap0b/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815944; c=relaxed/simple;
	bh=hsirGFiU8BzwJ9k9bRXj/aFU0gO5K783nFnr1XHXDe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+suVBG9HlT3BQDmXcXgyZ4+TuAbVyaobGFBjJdCF/HgfDBbTLDyqwZnuT2bDYZY/LIwXndanPYQRj4Xpyyl1xdbDFWqssNYqQHGlAiRk2NF4GeQJ+qU2qR1zUpoJeMq0kKCRmZdLPDpLlFtf68ZRRxeh9GE+ipoEalNgST17Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lppgcg9E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lppgcg9E"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2163dc5155fso18893865ad.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Dec 2024 23:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733815941; x=1734420741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fU9h1qciZfo1eCFrj9RBOWdEPoZjJk9V1VI96TtLyqU=;
        b=lppgcg9E3wpJVG8vWlDCF3+oOe0ZFP9+e2+dkAGLqdwpnRp/a9Czf7o6P4VqnTQpqM
         wNcox/86N2wR+8S9IdkuDWepzl6qXBG0BkpOmEAC5SLbX+ahxGTHdgyYSB7rwKWgdyMc
         E0kwS23XrCdplorg3eDJ1mFoGBaZ0ttr7vDSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733815941; x=1734420741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU9h1qciZfo1eCFrj9RBOWdEPoZjJk9V1VI96TtLyqU=;
        b=dFsHfJ8v3Zd19upElKieCOWvbzUqLC1sFSSBmHAoLQMBdoA3BRe7B8Yo94YKIftv25
         LMNdaWdvTO81eBI612EdKf0e4xqR9nXbdrV9CDMUOgB5GLgrH6fQT4LuPriBWjONzmUj
         HjmZX9eIyAKGtTrQdY4AZhlgfKGgsDvO+CZeLKooN6FALOAX5581wk00WZzQ0WnuIeg1
         npUB9XHwuqs62gKIXYpyO0jBBI0zWV1x2LZiqAVtqm1spBJJOuKnezG99TkDZzFwbftg
         6cv/p6UP0cv7RFU11ev+OVoCWpcNCqNPPNDdZcboPOu/tboKB/oCZX7zxyaIhatdR7tG
         upmQ==
X-Forwarded-Encrypted: i=1; AJvYcCURvVm3a80NAHsqsZDohMz9xhKQ/izBv6MHB5YX3npAAOvTNg7BYp3wdf3fkwgLI09KDhak/gCJR2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9GYWaWommkW6zsgxREeDEVof680572Ou3+roTTjw/slUDvKbJ
	mq5btgNcnsyHae35297/rhOl9OPid/FZJKWefe9N1r28YZPAHx0Qtp3d0L405A==
X-Gm-Gg: ASbGnctvaVB/JD4tkwv2LDhRytMRccZVZQUttrCfY3SDMz2LqkgcC3NsOH+/YyvKQu6
	BoXI4crAy6emrg1kuUWAg1rYwL5I9OyU5ORlXVhHV5ChdgBlZnPhFPM6BzfS1W+ieM90Xw5Gb3k
	t33z4EdncfaUuqRSS2O2d71PQyFOwDj8B9i2NjnOFaUdpGnHYgeE5hHTzb8iltrZ0icnmkSAVju
	qbzbbskN4mOTMx/MUa4NIIh6c6aztsucxLsXQYjIPTTWQZjp9s0zVD9YsU6/oLlCQmSbvtL
X-Google-Smtp-Source: AGHT+IHPmON+PwbNAPPZYDE53KwGnbvTApGQhaNGbUZe2uB605PBpV+ZcftSN2qQ7es0oLZxPl5QBA==
X-Received: by 2002:a17:902:ecc1:b0:216:3876:2cff with SMTP id d9443c01a7336-21638762fcamr152395915ad.54.1733815940983;
        Mon, 09 Dec 2024 23:32:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:89ce:2db9:f7d5:156d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09146sm83693295ad.199.2024.12.09.23.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 23:32:20 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document compatibles that need two register ranges
Date: Tue, 10 Dec 2024 15:32:10 +0800
Message-ID: <20241210073212.3917912-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210073212.3917912-1-wenst@chromium.org>
References: <20241210073212.3917912-1-wenst@chromium.org>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index f86ebd81f5a5..0debccbd6519 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -235,11 +235,19 @@ allOf:
       properties:
         compatible:
           contains:
-            const: mediatek,mt8183-mmc
+            enum:
+              - mediatek,mt7986-mmc
+              - mediatek,mt7988-mmc
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

