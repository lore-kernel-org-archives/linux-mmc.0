Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010123;
	b=5CRAK7nX65TRmEM9yFPJKRMDDMNGRWAnzE7Sb3BQGu/PTQfcpplI0W7YRx+D4XTFbpSS
	 PKNqWAd2iKrlNirWKl9KRoNG5HJhTejUNT2EQSooHJO8iaUYomCKTRAxfN4GFis/xOAfo
	 tn4PiQfIu8YRl14ITvZ3u5kNqnQJn8GIc4k9pX+TwIpKidmbpO8wvtghCx6k3rWbqAkhQ
	 rGvsA1fhcCMzke6/Rn17FKZ736mDcVFMrfzmjmalGdPkTApSsNOJwEUOva/KtrI+7mKP1
	 +ynPGJDO4EAvCkw4+q/oPiExE4kaL2sDfGS2q3FlEpfm6d0Ib/oQaMDYPd7Y2vtGkxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ssGW1Dqn9NQO094E/8Ttr3abz77jsGgzbaDPU8z6CLQ=;
	b=rgkqImzjewN5Sr6Dt7cc66Wd6SMuaiGKu4Y6tcCutF+X96W7uiKy+0nAuDM7DnbJjfr5
	 5Tzsldm/u3qWP30hN8BmXvZ0Pl0mPozktQ3Ka9WiONp9P/O/izeOvbIwcBJoKZbLIrbqx
	 PAYtECGc/PDxPw5yTUzlvz1Tk7qRnESSBSdCnzZNN96rhec/Xp0+dDp3G4KiUaY9y5bMd
	 Sp+lSXf5/MRLJjdJG8B10GPF39+lw79X7qYkL6p1KJXnDpYjbmzsZ/LMorXXLf6P0jmbe
	 UAlPCO2GoRY6OLVPjawa6xsu/RZIV+r5CJ98xXSeXJaLvZk7HFR18yatjoOQOmo0msA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=epHsHRrR;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56960A261B
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 10:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC56960A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=epHsHRrR
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so15648785e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 03:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793010121; x=1793614921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssGW1Dqn9NQO094E/8Ttr3abz77jsGgzbaDPU8z6CLQ=;
        b=epHsHRrR8/hmeF2wr+cmt9qhWoqEkZ1CMgUbwk/MnyKYJqP8qKurKP+o/4atOs4UW1
         EJmH1OcLpSRd5duXo7dazvYHTfmd8gwuy36g73vqfA67vMnAOq0+k1zc7gFFKx1ODIlz
         KaXWjZErAXtxuqgLGMcO5BF6nx6b31J7+EUl4giMzY9wJE8fr4WDoV0yIQzhR2Ngw2Ki
         E53reSsyOafeBU+dXft9Ymbi0OOI3wcnQ9B44AQFUEjY5VEdsWwYGXqpmpBebnjHI688
         qUvm7gOP0XfX73+PPKy2hSJO7Z+1cTOw20+kqkauYMWAUcDszabSzDkfbBIJgxE+K1i0
         F8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010121; x=1793614921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ssGW1Dqn9NQO094E/8Ttr3abz77jsGgzbaDPU8z6CLQ=;
        b=APMMu6zZZcuLaFg+jf3Lx5f60uAtVN0xOwbuM9GYjjmrjja6xcrD/IFSUEfrMjjvcP
         cFioL+BhVSvVDkYkMf/IhROnhjQiKRXXeahY7MzngjRY1VO4Wuty2r447UkwYSuwo66h
         EqDdBXJEWhMYvPbjwtnKb0dTgb/95PT6zhRs8p5nSIbM7C5OfQFmZvReCQ9v9EkwL7yN
         dRXDyPjr1DDhs8CxJ0hEtZyNqzCqOh/QS4oEHYRG9+wkyXkEL8dOvgZztoWhaLeBNPFv
         fdOYGhHraRC3R0gCyx57McJxjM/b0dKpJWNax+x2hgtStArVa0q/PQ6PhuSTFIOd1r4L
         H8Jg==
X-Forwarded-Encrypted: i=1; AKwUvBy++gOJ8/FqybAUWxN8OcVQZelxJd21o6nZS+yg7yTvpcL2IgMzUQcjHLdoRgRxQd3QbYmhBiLZ9RE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkGZvN4Ge87L+NLxGR1TM1uO7XCQnzkWmf8ArOuJa423/sPwum
	6lWikzTBQw5axwoMnvOTqVHNoZInoXzEGyhwhE4LgkUbmxRbL2piBwOZ
X-Gm-Gg: AYBFou05QlDZLSMJKmlU6iusk+h4UhXCGtrEmHq8iHkRztLK3b9eYH1VjHQo2Cr5KE1
	3EQRk8iUPVxMS10mX9Pp0RNkNcRgbag9wmLJxCZjcH7lrddJ/2oe2/7YZynmMn7Lq3LC6UynBgj
	2nwwIouVfg4WjEYbc1mFTErXL2g/cv1qkSKWMhrYNkP0HatbIesnXkVnKz299iliiJMPcNtpr1n
	rkkqN+/pdnm/VFJkcBpHFswLDQetVMJd5rt/9KTGgMQYW0iUSgN6S+aWsUQamCkambCq7TfdJ0e
	t9R9khKZ0iWtMqRud45ktxcx1/l/miEc5dH0UbhVoIenNegYTlTqkRafQp3KJLS5/Cuit4WgYi9
	PHgXBThh8UqJzzDBRy9yLv4pfvLf5JH8kowo+R9ZkXLNjEiZg2X44hZ6Vsw2gAq39YH6MGZ+xTv
	dl3ej/IQd5zbOzBBQB4m2y+Psvui+FWvkvD8t4CLt9gmlFVjT5Ftd0oM+dxjWrG0xmUvXiy8Yui
	JFXPhxFzQ2x7YVmYl9imLWlosJ7q57xKMSxDqQIDmxwPS7+LX3gNowXHfeWjClfVrz4pAcLJtiD
	JNseLc6iRCw2/lICd82GPNmVkElb8tlY86Hx+kYt+wMZf6rEiGyXT3W3a4dI
X-Received: by 2002:a05:600c:a106:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4a35aea23edmr84243625e9.9.1793010121069;
        Mon, 26 Oct 2026 03:22:01 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm16762876f8f.18.2026.10.26.03.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:22:00 -0700 (PDT)
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
Subject: [PATCH 2/2] mmc: mtk-sd: Add Airoha AN7581 MMC compatible
Date: Mon, 26 Oct 2026 11:21:37 +0100
Message-ID: <20261026102138.36786-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026102138.36786-1-ansuelsmth@gmail.com>
References: <20261026102138.36786-1-ansuelsmth@gmail.com>
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

Add dedicated compatible for Airoha AN7581 SoC that implement a dedicated
MMC controller based on MT7988 with the difference of having a single clock
controlling it.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5b160fdad3f0..736cff2783e2 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -713,6 +713,7 @@ static const struct mtk_mmc_compatible mt8196_compat = {
 };
 
 static const struct of_device_id msdc_of_ids[] = {
+	{ .compatible = "airoha,an7581-mmc", .data = &mt7986_compat},
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
 	{ .compatible = "mediatek,mt6779-mmc", .data = &mt6779_compat},
-- 
2.55.0

