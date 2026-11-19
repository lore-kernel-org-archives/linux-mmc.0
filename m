Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110612;
	b=N7Ti+QM+IDiaCUfC7CsfcpMDBBGZG/+t/C3XejctY18e0TVfOUjl5HLtticH72UR9mn3
	 A5HR0sL34QxVYfIgZE/Wu9S9g/kYzhOn35i/ZJM/rPHp3vn4lqTHyFETeUafRBaJzGQu4
	 cjpJlmVwh6HhHud+HRcdSQaiJvtoveNuRoN535bbvpAgH006PpHGm7mvU96xVd4niPdWc
	 ZrojIebnJeBJQe+bYOIxPdpYwdP+wP9nyXjZYpG8TZQRRqb+TeP2F6woUOVQGSoUQ11CS
	 cgdir2c+9BdAS2+A3mgcGtDE5rroAAnDUtHtC74I6UXKog1zYHgWGJBjGLCnOF//TuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5m08k+pWTgZ26W4H99NIdw305iHAopUdzj3Kg8DMx8c=;
	b=WP3VNs3sI8/IbyYdbm1EJgru6WWa2U+9nz4OErRBc1K+I6Rpdfsqd2vemNHZuCkmdCYJ
	 Ug/zU/VYcvLaua8RKyZj9nG8lN3qerSHCFiwSrQ4OIod/auImW7N0BHbQcB6o/kFfaK8b
	 ywEq/ushvq4wCwEjjFXacxwSVDG84/h0KCk+z02GEd3EqFAjsc6Nkr3ahQZqYJyA0M0D0
	 Pu/BNCo4+dmOV4BUOsB35J7tFa9sO+Gd/4NIya5V9V+XFXLxpwPI5oqw8OlblXGg1JuWm
	 ynqtji868lCFuNMn0l8C8Uv6jKA8QHUAL2noW5kOR5xluS4QfmS9iXxEhbQLxLUMHgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aheymans.xyz;
	spf=pass smtp.mailfrom=aheymans.xyz;
	dkim=pass header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="fvJykZ/n";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F32606A335
	for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 17:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F32606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20260707.gappssmtp.com header.i=@aheymans-xyz.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fvJykZ/n
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so27644815e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2026 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20260707.gappssmtp.com; s=20260707; t=1795110610; x=1795715410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5m08k+pWTgZ26W4H99NIdw305iHAopUdzj3Kg8DMx8c=;
        b=fvJykZ/neLyVItFEhBuAi0WmfnkNb8Y4jIVy1xZB3JP5mhV0QHRRKZuIo/1ChInedQ
         ozTOCjI7wfcchmNYhF669sue2/HmF0Uy6XdyhIrtktpdEYN3CyMnTTIufpcXJDebi4CY
         eOcOpBits2EoRc6ryq8QttSom5epvDHt7vHgHeTqiMIJNN1aOJRK0GQFL1Y5FTfzhkXE
         yyYVP4MJRF9EH1kSLVrO+m0Yi0PYAKmgSL7sGRfB1YTQtsDia+DoKocrsqZHpJoqUY59
         n+XiF6L3WfCtONnXjhitg2wRYLsXpW8Si8BnzO+aQ5aVv6QnbUq+c4PNY+/Od58FQ+4z
         HSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795110610; x=1795715410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5m08k+pWTgZ26W4H99NIdw305iHAopUdzj3Kg8DMx8c=;
        b=DBKTDETs78kh5lCLBBlJPWRh5QMpiuL6nuAJS8S97dGGxu3q1IkhrODa0gMkDcbs33
         jg5Shj4CAWwBBQYiLKv0wQ5E1DiBrHFy32fnkEy3AqsTAxUagrzfik4eQWul42Ewl5LT
         VQdfdlolU5pw3kjSQ7uM9jfYD1XnzxK6v9Ayw0rzhQE/ILWfAIznW/1jKa2R+dQI0n4f
         3ybt4h/65FNuc5bJWvUo/Gm5yiAvfTuHEWxGqgpskCldLPF/3m58UuSoj4VBsUovRUl5
         kRoIDigjnl9YtQV2h1skbxGYzltoeLt5hOmARMD7kMuJTxDXMtp52ki7OnQw0XutRCGA
         ZBpg==
X-Forwarded-Encrypted: i=1; AL+hErEBVfXZqVm0K9FcDCWBlNFdUF9M+awftPAZki/RtyYwm0GaNmy6bjfJ9tXFdZ21s/d8SMkb+9TJ/tw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vG7XnGRJAzxMtge0/vTRWcBETplc0aZHeE5DgFHuvx73NgLMD
	rh9ipiundEltQopNX0uPZZBERkPnu9RvXmDcgtrpzST25CCIruGc0RMAbhFNjYiIS0XDXgepaL/
	oxLiQF0o=
X-Gm-Gg: AYBFou122nPuFcKO08JuKrpRVhJXeqrQ1SGefM7EqdBZPXWXP2gvUmb5L/Os17MUmgd
	YDZ8NIy0GHXaws263rg1FrFOZxm1a+nqBRJ11MezptyURwkHtvjtX7CjTUdTspEnnwzTgaJkojQ
	TJmhAQ+gMxa2vBiK+SyqN4UW5jvjNoKNAvZvpGPcDhLNsRVqJsKAcGB9ZVjIrUJFIry11F+pCvE
	ZxR1OhYqbiwb0pWRV9k4IRUtZmSN/268ENRWZrsVZ4qBdIZdS17EeXw9QJ7fhZ2Mv66yErap0L/
	aKLfoQgVz1QCBnrfkpGXaCIYDKMXvZ7Nv7JdCq6Xuev/BotHeM0UAO8alEim9CMfrh2J128i/cp
	jyj5BMLv0gD8ms6F0AZR2ZOXQwpZhBMKdl/PN8huL21Lm06pShcJqi4gjBokljhNjyYUbD1KXjE
	Jh5I7Pj/9cMQLOvgrxc08bs4VtSms1rjjJyttr9lLvSBH9EHZzPecdg1NTaR85MdsYNxgva3m4P
	eDBwLzU1phvTGR1nHZPbG4CVsXYjv8k7WvnvVbZShvL32l2/p2y1XbvqRiRrLPTBGYh07QrW/55
	piuv0Ld5gI10vptGIebP+x2xyC7YZEKzO6AxM+dsjfGgap2KL4+lOdTDCYJruAEoy9smcOMVxP9
	c6Qw2rto1yBq3Lqqm1h4qTpHaewCskzE2+UySlBgIzFv966jjdFgBiEtsgzkkEy/C4vx+FLRfl2
	o//uY=
X-Received: by 2002:a05:600c:64c7:b0:4bb:68c4:2044 with SMTP id 5b1f17b1804b1-4bb887fe725mr6329465e9.11.1795110610075;
        Thu, 19 Nov 2026 09:50:10 -0800 (PST)
Received: from localhost (2a02-1810-b422-d400-611-84c9-252f-74ad.ip6.access.telenet.be. [2a02:1810:b422:d400:611:84c9:252f:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm68993685e9.13.2026.11.19.09.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:50:09 -0800 (PST)
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
Subject: [PATCH wireless-next 02/10] wifi: cw1200: check SDD element lengths before reading them
Date: Thu, 19 Nov 2026 18:49:54 +0100
Message-ID: <20261119175002.458988-3-arthur@aheymans.xyz>
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

SDD elements have byte alignment. Read the PTA and reference clock
fields with get_unaligned_le16() and reject short elements instead of
using incomplete board configuration data.

Prepared with OpenAI Codex.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/net/wireless/st/cw1200/sta.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 5d8eaa700779..db9f0c4a07aa 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -11,6 +11,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/etherdevice.h>
+#include <linux/unaligned.h>
 
 #include "cw1200.h"
 #include "sta.h"
@@ -1072,28 +1073,34 @@ static int cw1200_parse_sdd_file(struct cw1200_common *priv)
 	while (p + 2 <= priv->sdd->data + priv->sdd->size) {
 		if (p + p[1] + 2 > priv->sdd->data + priv->sdd->size) {
 			pr_warn("Malformed sdd structure\n");
-			return -1;
+			return -EINVAL;
 		}
 		switch (p[0]) {
 		case SDD_PTA_CFG_ELT_ID: {
 			u16 v;
+
 			if (p[1] < 4) {
 				pr_warn("SDD_PTA_CFG_ELT_ID malformed\n");
-				ret = -1;
-				break;
+				return -EINVAL;
 			}
-			v = le16_to_cpu(*((__le16 *)(p + 2)));
+			v = get_unaligned_le16(p + 2);
 			if (!v)  /* non-zero means this is enabled */
 				break;
 
-			v = le16_to_cpu(*((__le16 *)(p + 4)));
+			v = get_unaligned_le16(p + 4);
 			priv->conf_listen_interval = (v >> 7) & 0x1F;
 			pr_debug("PTA found; Listen Interval %d\n",
 				 priv->conf_listen_interval);
 			break;
 		}
 		case SDD_REFERENCE_FREQUENCY_ELT_ID: {
-			u16 clk = le16_to_cpu(*((__le16 *)(p + 2)));
+			u16 clk;
+
+			if (p[1] < sizeof(clk)) {
+				pr_warn("SDD reference frequency malformed\n");
+				return -EINVAL;
+			}
+			clk = get_unaligned_le16(p + 2);
 			if (clk != priv->hw_refclk)
 				pr_warn("SDD file doesn't match configured refclk (%d vs %d)\n",
 					clk, priv->hw_refclk);
@@ -1147,7 +1154,12 @@ int cw1200_setup_mac(struct cw1200_common *priv)
 			pr_err("Can't load sdd file %s.\n", priv->sdd_path);
 			return ret;
 		}
-		cw1200_parse_sdd_file(priv);
+		ret = cw1200_parse_sdd_file(priv);
+		if (ret) {
+			release_firmware(priv->sdd);
+			priv->sdd = NULL;
+			return ret;
+		}
 	}
 
 	cfg.dpdData = priv->sdd->data;
-- 
2.56.0

