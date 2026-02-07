Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E83090EE
	for <linux-mmc@vger.kernel.org>; Sat,  7 Feb 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770469852; cv=none; b=XgMd6Cae/l+BlMGWa1xeWJxWxEvzYqZ07uurOscpSJRU6WHMjczz++COJplE5I3Xns/mIVu+8IXoJN+F03MWWY1hS6NKYFzHebBRvgpeSNmq8JKPp5XTHOwC8OnB0/XgjEMKYPZrw9qAl3zEwUs3pwD0iZuZVJl12o1vOQkeKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770469852; c=relaxed/simple;
	bh=jLCHrWJGkSWkMAK7LAwWvERw2Dyi2yOrDrbXle9T1hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RSs40lr0ZihOveu7omcb/zY+AADeupRciGe6o1WXIkmEDVfLTVdttg+OiFqTQjx18/6L5/k0xPBOgNJdgjawqsWA5jSagWjgMoUbeQZy/gM1SShZZogC+y4XsqV2VGcWDhJltN9lOs+FaUfD9ruCevdXsSeMMkpHggZ7w6geOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0mua3Gk; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0mua3Gk"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-649bff225d4so2702120d50.2
        for <linux-mmc@vger.kernel.org>; Sat, 07 Feb 2026 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770469852; x=1771074652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QBpsIzCCQeoZZ/GNnpHx2ANdVkIKBFfRNNmEzWBceUc=;
        b=S0mua3GkeNe0ewq6wLcSDw3QwhhlNHcXD/LRlSHWBXz5FtxgK8SsVmKTorbmcBykY0
         Zt/I6hYxpC3cMvVd9xRD0jJ4VRTUwxIj9L5KzqK6+c/swmoLi+DCowylOyXFkKz5Ae3v
         Fzfp11XY/kONjxo3PL8EczTunjhWKoWGjSfyzDV4/NPudjY/LfPvAsAd3+J7JrriEt+1
         f0qFRYu1uYS7vChcWMeXoMAMeQswWCL7WA63rlWj1BVHysrQlWLQ76rAbTMjqrdjmAD9
         3mVvGJKo3vyLHp9FgBRMOOfFmkWb3VMpghnaK43Z4hpFqdeywi/mHIoI1qXLAoInmNnT
         2cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770469852; x=1771074652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBpsIzCCQeoZZ/GNnpHx2ANdVkIKBFfRNNmEzWBceUc=;
        b=jODuqj77R4puj+C048f4YSaEbepTxDD7qVcBijrOo4guHlAyZKTmJriRGggxk03wNk
         9xNAse7ZeXHlHkHhp+A4yorKZq/RaG8S62F0XxgZ0a9CCtEMkavUVTRLP8ONIH9+gsws
         /QIdiecC/yRlZsKRRfZpzvVj9muUtZTISRNIqnqIZ8DGmONxoZYTHG/EXqO0EJ5MWO9S
         0Pj70uVaENtR2g5/HhNWHCMQRoKq50I/aBs0eMRlUSqrWrfHA9QYVknx5IlHMOv0ZWRw
         lKipDmy9xlZPmeAGifWHIIaUqR9BWOIYH7e5cnP359KJj3pcdqAenXO5PBw1tys//0nx
         Keag==
X-Forwarded-Encrypted: i=1; AJvYcCWdBW2oD3Y9PLBmfZKDRLN+vDywcGSThqQiv/20KpiuMvIYChrG6LQBJffvvOpC8sbvscbXnkRU2dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ahuthySB/PfO6AaIl4HHECMJkxH7dBiMZMMp31Rpr9rpNjuA
	dRx143i081li2vRhFW9aE6rjq1t29NmFo0IRbCGdvcZaWBDJawiAEwsy
X-Gm-Gg: AZuq6aJ5mS2Llyfi/nLM7qtZZVvgsT7fm1OIweatmUKCKV2V2AqXeokmHrkCQwqXcq5
	H9PHBY48PdCl4XgP567EAlIsBvILdpufvhoU+ynTQwuPfCxEoQhtBuiLxKTNbPHPgKE9BaHuFVd
	1fLlhcBlAIqki8roYR6+4jxE3KjiO8ryoW6qolZZLlEsD2KNZvcuCi//mAJc8MSMsn/u27zW9BK
	CVJ9gmnQ7m4iGovED1LhXYFABGNgFgOmwhWcBInW9Gp9yQ/4DGy62xW9oIIeSwpVKVglrqcyaxp
	ZnrMWqQlDAscv+3koFjBX9O8B7jehfD3+1tINy91z8Bhec3hyAXCxziV4hJ67gmkX1QA0rKEQ0n
	u3LP4pbOYIOzOGP8xrebcGB68Bi0WPUVjLND+Uw5EciRX81xrXb2YzDKc7mTt5/IBPFHz3A4cZL
	tUiK23tPvqRV8aLD43q56hasjp
X-Received: by 2002:a05:690e:418b:b0:649:b851:4ad with SMTP id 956f58d0204a3-649f1ee4aa4mr5307230d50.42.1770469851708;
        Sat, 07 Feb 2026 05:10:51 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b1ab:5cb0:a2f8:764b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649f255ea25sm4965466d50.17.2026.02.07.05.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 05:10:51 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: ulf.hansson@linaro.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2] dt-bindings: mmc: rockchip-dw-mshc: Add RV1103B compatible
Date: Sat,  7 Feb 2026 10:10:41 -0300
Message-Id: <20260207131041.2833840-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@nabladev.com>

The RV1103B uses the DesignWare MSHC controller compatible with the
existing Rockchip RK3288 variant. Add the rockchip,rv1103b-dw-mshc
compatible string.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Make commit log more concise.

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index acb9fb9a92cd..a75209bd2710 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -43,6 +43,7 @@ properties:
               - rockchip,rk3562-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rk3588-dw-mshc
+              - rockchip,rv1103b-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
-- 
2.34.1

