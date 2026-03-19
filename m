Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E3336EF1
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952623; cv=none; b=P1MjkqbNxr3Uu9lVJ1xyD0JT9Y4CPySRyOKZyK6Y/ShGrXZrJERi3ZcMWRlRwBFeC1Yp2U9TG+cZfYKbZoF10SX+fyk7tl6ppuEaijXB2oInk6rYudOekfenKGs64W868gdhp3tmdJmqIsQVue6eONGtBlFOickk58d4F6ZW1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952623; c=relaxed/simple;
	bh=5skePx64WNITX84S4NyRGOGsgVrQRd/nLA8489wbHmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XjbClQfI1u65Ay4WC8EAFDJjFqyj3pOtM//b3wnpcnJmxTV7MCA7p8yLlSvIVYZJ76bosRatAaX8aiFkTysrPjKoiMM1xcNiX2c+OjO7RBQFw65ls1O8Yrwoe+III4PsIlWyt6fvBTh/uUN1MThUv2xLqvFrviMtI5HfiBeEfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KBeBMIE2; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KBeBMIE2"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-67bac077116so628077eaf.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 13:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773952619; x=1774557419; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvqUQZCqF37oJV9dJzcVxfSOLY81NlMRRK2XtKQH9vE=;
        b=KBeBMIE2I6yLaVAiKOMOw7MMnsyAYshrIJkk8STe3Jknc2NbHyzX9C+DszaP0oR8O0
         JpQYY5/iC5HpQZ0eaRSpn7l1Zg8cn/z84MSDWz9OG9j2hj7kI2wChvXzcEwuNSIEFkwg
         KbQ62ZGdjeoXZEqxhMXxZo5/OT4RjTOu6R8iVRvwmICODg+WrNORlg2MJo0pDs809ARM
         zh6Z1SdVnKw1ML9ydnNnA1+COHXfZPRifNHd4kmFebpjNDDJQWznoIpW2pFDas7ZcwUI
         hMGruZmZIqcZL6Nrvkjj2la6pi7VkjKkY/8FIDDO/akl4u8WN77b8I6u8kCh9iV1Wy1n
         V4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773952619; x=1774557419;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvqUQZCqF37oJV9dJzcVxfSOLY81NlMRRK2XtKQH9vE=;
        b=Y9lGSNXQ9OgL+0VB/ElWDcq3JRvli9NuEPCupSKKkcHUsruW1lJRzrtriIr9yJp7go
         9KOBpfYMWFDgcC+OkS/VZtA/TXrLXjAOKpw9RV8lMJbln4qqUCIPkUz6oMbevsiJt0je
         DPhAiMaikTw4CILiCRrDabTddaTy9BLgLBJ118bGRSZhq6S5rb7DPx9MTpqIsUT8sQPF
         ozpsl/IfdCrc+i+fOXxRTFn31x7sT8HzS5tIkITB5Fq7X91nVNnxI57ZEk5JhfDc9Eq9
         oC3ssteu4/bSJoKBuOhACM9HJitbdJCTmKnxdCVqPAA/CRn38a/hFI5zq2L9Ai2qSRm1
         PXBg==
X-Forwarded-Encrypted: i=1; AJvYcCUA45+UwQKybHMGxUENjWG6+A1ht/sQpUxTS8FUhXhSbOZLW33Rl8AlKc6MaXWzafT+OuHS2O0iNd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhKqH9lhaUp7z4GOJd3TVQiTxIO7wfk5VwQ4pG0ienZ+a1/vK
	OofBAUamP/ReRxo8Dhzkiu713DS4lv3BOaMORxGL/xi3/HZsSSj3KM3aGO+BOiZ1u8I=
X-Gm-Gg: ATEYQzwxnvme77uu6p0RCZNELLL7PFCf7rSxoQJjEZgPyUqe3ACFNMJ3TCgY1Fis1M3
	abascVSBHrdCQqTyQU13BeqaV0wSOL9lFNi6DEfZx1FfRzsDlUqyT1VBYLzG8IEW3uxkCTqRxWC
	8cJPaw/J63DjtVnQtU9MMZK+CnnkLr1akh4Nshq//ID75lS26WPrd1sVBl2aQKDHNmPL4MYI/Vy
	rvDobEH9A0VCKtLhe3tFbxnUzRmr/zP4ZpfnsW5GVo57++Glbua541QkN6aIq3RgTv8rjwXsmbs
	tRqbs2+7VdYIBqHBkSNXsMEp7oysERELeGkJdsnSNWKQD2o7jxV48y7OxY5OPcEvSxg4sktnRpz
	DOGBiOj816nU1+UOMwWrbv1CiRe6+Wcyw0IH7zzUlCKikKVc70znanNIlUAO43WyNdNBy3615Wk
	Gf7joCDrq1c/NaNQ+nxcu8+AUFBygr
X-Received: by 2002:a05:6820:1349:b0:67c:1deb:4f69 with SMTP id 006d021491bc7-67c22bb5697mr599850eaf.14.1773952619310;
        Thu, 19 Mar 2026 13:36:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67c252acd32sm52512eaf.3.2026.03.19.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:36:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:36:49 -0500
Subject: [PATCH] dt-bindings: mmc: mtk-sd: add mediatek,mt8183-mmc fallback
 to mediatek,mt8189-mmc
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-mmc-mt8189-compatible-v1-1-fb7ef2186c92@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXfARLz1VYqLOBl12kYliaUgv
 rtpXR2+xfl3COyFA9yzHTx/JMgyJ6hbBjSZeWQUmww611VeqBZdfKFzlLZRTYu0uNVE6d+MptL
 W1FRaWzOk/+p5kO+//eguh61/MsVfEI7jBFHNVOd9AAAA
X-Change-ID: 20260319-mtk-mmc-mt8189-compatible-a62da7c5dd7e
To: Chaotian Jing <chaotian.jing@mediatek.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=5skePx64WNITX84S4NyRGOGsgVrQRd/nLA8489wbHmQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpvF5i18RSPpFlTkJhXKuRHU1GKiogcHWVUfImk
 AchlfWq8pSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxeYgAKCRDCzCAB/wGP
 wNTrB/wJp0iLTjLMrEAxu7kkALAuENcVqHfsvkgUSrsHT0Wy0MeoXaG9Cp3UIlJ9gNCXOEoAXUR
 3u/C1no4zCoDG0WMepZn6cHej94IB24DQZVNYdeDOl0OFtEDIuz902EinxNow8JfnAmLwX4w4aU
 RDSkC9kLidPbkFS7CsE4fLWlpRW0eY0OzpN55PuNEq+4jfPIYI+z5k3Qr99oTU+HCCCFVTC9j5d
 YdK7+xKXOz1AGfNSztdM7/NFqDtZPmR/8+baKRZQ01ZnuP85PSnqL5zO5rZ6OVqnVNcCv4ourPM
 WopQsPZ8TelzX2HGxM04ez5i53jSAozyu6LUB+V8ya9GVijk
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change mediatek,mt8189-mmc to include mediatek,mt8183-mmc as a fallback
compatible.

This has been tested using U-Boot and the MMC is still working using the
mediatek,mt8183-mmc fallback compatible, so they seem to be compatible
enough. And there are no upstream users of mediatek,mt8189-mmc yet, so
this should not be a breaking change.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index eb3755bdfdf7..9160e449aeb9 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -25,7 +25,6 @@ properties:
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
-          - mediatek,mt8189-mmc
           - mediatek,mt8196-mmc
           - mediatek,mt8516-mmc
       - items:
@@ -36,6 +35,7 @@ properties:
               - mediatek,mt6893-mmc
               - mediatek,mt8186-mmc
               - mediatek,mt8188-mmc
+              - mediatek,mt8189-mmc
               - mediatek,mt8192-mmc
               - mediatek,mt8195-mmc
               - mediatek,mt8365-mmc

---
base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
change-id: 20260319-mtk-mmc-mt8189-compatible-a62da7c5dd7e

Best regards,
--  
David Lechner <dlechner@baylibre.com>

