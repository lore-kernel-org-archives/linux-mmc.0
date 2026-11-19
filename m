Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110615;
	b=jT2aIa/u6WGu/aCIy+CNCVDNXinkOv9P78CGJMoXyVh4USMvuM8l8L+4lJPRJt+E/pYR
	 DCREDZJumVqr9pQ55j7y7ipDXmMInoDbc3gxK3K4PkqAyZY1UpJXSwmZgpEwThNIXT9KB
	 fIMho6tJWQZT2DwH4n9295sldkCX16YJYCjkWB/R9O6yCgv32ow4hTv3nYOSWhz0wCtRG
	 zCnUtlG1Cr0KSlCnuOGtswX28rGZNHZOrl14lX17hchGCY311VIkenOg3svO6o67G6d6Z
	 5w8yewS9zN91r1cL2b4PBKEfG1vV6MLBCh2dR6mvPlSU8moSNnAner4H4LYyx2jwuIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V0vXpQ0w5/8cdfKY20evJG5SNfOITIVEXlv4OVmyRbg=;
	b=Ow2qM5ywsWMVSNbCduTZZrArVzh+Z3TQog/KfAv4i1xeq057uQPBi/tKDvO6H2jR4vN6
	 vDToTnvAbwHuoH+6qCQiriqtqp+dzzxdJ50Xg4ctt/nzm8u+Wqvi5MOoFNfnHPtKix5l0
	 1YUn95JCBm5K1DTc4azxGIeZ2RzS1FkYsfR8sEpDuuh90IgZ2CQrdFu/R8zomW7ZkR7PZ
	 fwPmIs1/YRM6qNlUta+x8+4dJpYkgX4bDmDePo3E0jbaiPaLi6LWPqZNxJ9GCYO+LRDb9
	 0EaIe1AdU54R80acmN7f7FfHc5RpMlMdFgYjd5fc9PnOD8wOmoHCuC9qXKwYi6Gr59g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Er3vtfFG;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DB60A380D
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D4DB60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Er3vtfFG
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e09aa5264so1518800f8f.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110613; x=1795715413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V0vXpQ0w5/8cdfKY20evJG5SNfOITIVEXlv4OVmyRbg=;
        b=Er3vtfFGoCzSDbL+gYHxTGR5zk9JEAhm3BZQqUoya72WEJA9eVxyNXImSfwOYUsiFK
         2mPYEn9mbPUvUMe9eAzZ58egX6hIjz/oVmYuvzOA2zI7b7/zq0vGkZLSokrd0kDcaY3F
         ljalrKl3DU65DnwTvq35I0g8JQwvgZWiJD9jMwJinDDhpJAc7SylFHygyPlDrI2gDKVf
         KPctNg5kBlEuYyUeUYlDmrB644Vd8uAXs4s3fvehcO/TW7S9o0yFWRMOReAs0I/3qJXS
         r8e7PYhQq/eKZhwHgAUypbxjlSLJFkl6ZBAf3Bhteb8Ypl0CG6xPLWOA02ZqPG9vGl2b
         YcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110613; x=1795715413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V0vXpQ0w5/8cdfKY20evJG5SNfOITIVEXlv4OVmyRbg=;
        b=yMTdoZV7L/FE6EefY0OHySPI/A+OcVg2lyTPyPz8++ozLIxSkKtVZs0bMze++5bcku
         NBWw4eZaba+2trsJ46dtr8gA34wPsmfw78dHraqcBY9HkrASaI0hPWAUW/4u/9pIsmCZ
         ceQiSCL99hZni+ZnjO+kEE0iIWQUGyA/WkoSeMYVLIBvRoF/Olz3QlHqTrirqLrz39ji
         vv2tdM85++2/+gtrMEi2VeER18K39Rs4sl/13NHzyzQOLJMwZNXHRxFSX6sUdIzAhPlF
         Cl59EqZRoXMLbzKIJQ/PdySUPvL9ax82jUAtkUNSCVHMgb84nFuZif4Z9bS8UVl2WiuY
         N35w==
X-Forwarded-Encrypted: i=1; AL+hErGoslkjpF2s4F/whpeVNTjjnOUimlSq5KC2CLWQgJLPz/7Nm5dFufITL0PPjVGRi/bi8Zj2rJQhBc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+H8Kvi7BeWVyLsphoZH5z8dfs/ObMlY5qXF+PdGZU08Zxf5zA+
	LptVUQ0mVAqql3dU3UCFkjA3lv+IUBN9zgKVehI+gf+7yrDtxXpSGXiBN/QrooKZzTU=
X-Gm-Gg: AZFdTZezHAMSa9BsWDMFxCGWD5BS5CO0wzmOSRPeGrB2zIkrG/g4jqShMNYveEoqt+L
	RINcOSB3mEn+eEIKeiHPpx8DxPOWp/HR50rqoku1X4X8RcZ4WMEXwH0J3KJujTZEx148PCsOVeu
	ufNbbvLAupwCPmxoNEFrJab1p8GfIdo3otuVI6QETmXG9+i1bPG6Y34eZB1KeCBIc2I7hQQQBUf
	9IUbTyUk0r9B5tKQtfqxpkZ3LrXON/vjjYycklBaeY/ADjYnl3D6FGYflNJWBlc0JG1N0Vkd6Ul
	eFHiseK3P1ojF8Mc37RPUa5w9jZma5YxZAvmsh1fq5lMtZVEv3pqoip9Wjefk+pqNpBo1kbK8iF
	jihLV1GFsaXTJaCjqRlseGuLfjk1vriIwMFVQZTlViGhFqt8umNCGGjCO1Ab8u/NypFrh0K+jbX
	t445XlvD+Ku4v5sSe2godFEsvqp7qrVkuxV1B8ob7538nqX2zMaY/VY4WXKvHQY5D0hemdD9wF2
	tUUtmV5XFSkvlULZ/PgmoYC6M0led6JXjnRpgByxwqPmI4UvFu4Eu4Xoj6dpjrQ/V3H7McVHz90
	BPxLNb7hcK2soqwgikaVcdkWhk9RCV+vddsrHoRHs84QuiKdhgL+X/ns876nVcYsoFIsfiLW1dC
	3T0vcGyf+/qtGwJ9H2sq/6LCWLEeWMoFiVRFZfuml8XvdGRDCgvtT12QWMEOYcKE1RXz/GuPsss
	qCQSmjBdjV/Zrz4FpDV3BBehg=
X-Received: by 2002:a05:6000:29ce:b0:492:820d:1e with SMTP id ffacd0b85a97d-4abb0f3c464mr154289f8f.11.1795110612350;
        Thu, 19 Nov 2026 09:50:12 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm894064f8f.58.2026.11.19.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:12 -0800 (PST)
From: Arthur Heymans <arthur@aheymans.xyz>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	Solomon Peachy <pizza@shaftnet.org>,
	linux-kernel@vger.kernel.org,
	Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH wireless-next 05/10] wifi: cw1200: unregister from mac80211 before freeing the interrupt
Date: Thu, 19 Nov 2026 18:49:57 +0100
Message-ID: <20261119175002.458988-6-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119175002.458988-1-arthur@aheymans.xyz>
References: <20261119175002.458988-1-arthur@aheymans.xyz>
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

Removing the device unregisters the hardware from mac80211 only after the
bus driver has freed the interrupt and cw1200_core_release() has disabled
the device interrupts. Unregistering removes the interfaces, which sends
WSM commands such as RESET and CONFIGURATION, and their confirmations
then never arrive. Each unbind of an associated device waits for the
command timeout and ends with:

  CMD req (0x0009) stuck in firmware, killing BH
  [BH] Fatal error, exiting.

Add cw1200_core_unregister() and call it from the SDIO and SPI remove
paths while the interrupt still works. The interrupt is still freed
before cw1200_core_release() frees the device, as the handler uses it.

Tested on an Orange Pi Zero (XR819 over SDIO) with both the SDIO and a
GPIO interrupt: repeated unbind and bind while associated no longer
logs the error. The SPI change is build-tested only.

Prepared with Anthropic Claude.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/net/wireless/st/cw1200/cw1200.h      |  1 +
 drivers/net/wireless/st/cw1200/cw1200_sdio.c |  2 ++
 drivers/net/wireless/st/cw1200/cw1200_spi.c  |  2 ++
 drivers/net/wireless/st/cw1200/main.c        | 13 +++++++++++--
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/cw1200.h b/drivers/net/wireless/st/cw1200/cw1200.h
index 48f808cdc1cb..6dc85ef6e0fa 100644
--- a/drivers/net/wireless/st/cw1200/cw1200.h
+++ b/drivers/net/wireless/st/cw1200/cw1200.h
@@ -293,6 +293,7 @@ int cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
 		      struct cw1200_common **pself,
 		      int ref_clk, const u8 *macaddr,
 		      const char *sdd_path, bool have_5ghz);
+void cw1200_core_unregister(struct cw1200_common *self);
 void cw1200_core_release(struct cw1200_common *self);
 
 #define FWLOAD_BLOCK_SIZE (1024)
diff --git a/drivers/net/wireless/st/cw1200/cw1200_sdio.c b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
index dda201e69735..4f4bd668ebd2 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_sdio.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_sdio.c
@@ -359,6 +359,8 @@ static void cw1200_sdio_disconnect(struct sdio_func *func)
 	struct hwbus_priv *self = sdio_get_drvdata(func);
 
 	if (self) {
+		if (self->core)
+			cw1200_core_unregister(self->core);
 		cw1200_sdio_irq_unsubscribe(self);
 		if (self->core) {
 			cw1200_core_release(self->core);
diff --git a/drivers/net/wireless/st/cw1200/cw1200_spi.c b/drivers/net/wireless/st/cw1200/cw1200_spi.c
index f71e71e06359..c08d1ce5605d 100644
--- a/drivers/net/wireless/st/cw1200/cw1200_spi.c
+++ b/drivers/net/wireless/st/cw1200/cw1200_spi.c
@@ -437,6 +437,8 @@ static void cw1200_spi_disconnect(struct spi_device *func)
 	struct hwbus_priv *self = spi_get_drvdata(func);
 
 	if (self) {
+		if (self->core)
+			cw1200_core_unregister(self->core);
 		cw1200_spi_irq_unsubscribe(self);
 		if (self->core) {
 			cw1200_core_release(self->core);
diff --git a/drivers/net/wireless/st/cw1200/main.c b/drivers/net/wireless/st/cw1200/main.c
index 5d569eeb353f..ee9fcecb0100 100644
--- a/drivers/net/wireless/st/cw1200/main.c
+++ b/drivers/net/wireless/st/cw1200/main.c
@@ -456,8 +456,6 @@ static void cw1200_unregister_common(struct ieee80211_hw *dev)
 	struct cw1200_common *priv = dev->priv;
 	int i;
 
-	ieee80211_unregister_hw(dev);
-
 	timer_delete_sync(&priv->mcast_timeout);
 	cw1200_unregister_bh(priv);
 
@@ -594,6 +592,17 @@ int cw1200_core_probe(const struct hwbus_ops *hwbus_ops,
 }
 EXPORT_SYMBOL_GPL(cw1200_core_probe);
 
+/*
+ * Removing the interfaces sends WSM commands, which need the device
+ * interrupt for their confirmations, so the bus driver calls this before
+ * it frees its interrupt and calls cw1200_core_release().
+ */
+void cw1200_core_unregister(struct cw1200_common *self)
+{
+	ieee80211_unregister_hw(self->hw);
+}
+EXPORT_SYMBOL_GPL(cw1200_core_unregister);
+
 void cw1200_core_release(struct cw1200_common *self)
 {
 	/* Disable device interrupts */
-- 
2.56.0

