Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3516F0C8
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757263; cv=none; b=H6h50gO2gpJvtp5DlHCykssvRdlasrsCbaHsWyzvKUtq5UU48Fl6oOTNFYZSA6sw+E41F6y97cgABT7SxWp5M26WNo/wfcm1oodVStDoqAVBtYbSsKvvRZIU+a2GLAfQW8wlJXHddj4Cj+jdwL/A/8SRIefWEfQiJ+VSmJ3S0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757263; c=relaxed/simple;
	bh=FA/JdKZlZ4wileZrc4xp1llDql17/NQkyQ+ez5FGdwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f0wzj7O8Mhz63F/TUhXp5qTKJB+lsjVKrNqdOsju9sWe1l5KJ5UoJbw4/wAfmjDmKPUWCjYXJwvyMvXzkUUN3NxphLERZjk/+lelqSZApEdmYgDZAfCM5oXrb06cFu0BDhdztDrjyRkkoy9OrBee6Q+3+B10cRK/tskJ/dHRvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IzDMXIcE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IzDMXIcE"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso10044536a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712757259; x=1713362059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=om0OP/V4nCTPs4aw/OiE4dwxH9wZZxHeDC9s7eqLnZs=;
        b=IzDMXIcESBv5IrpIpcW0X1lmc+XKu6Zt15PO4BYAj+k6KhlUY+rEaJ2/xfD5Zex8J9
         Va4A3MCsgWm6x+k5DyJrWn9mK9XN2mDe0UYfTnwAwmkwtkBv9zg/oLFtjokWoigLaDjJ
         8eSDhOAeLObXl6TgaUyNBC2iQCVOyt3bv/supk4Qiyvxq0DKhJLu/f2sh15iyplApeEl
         7FgAP7qMzVEWSY6ooCLvZuxnVLNcORaaj5F+x7d/5dgo/3N4IiXp+51vXXwwq/NZUY7p
         ATSIgp5RaLQvVU7RUmAPy8dM1qo9bIF/9XOliLIFyIfl4IJCgCiZ9AAtmVJ9uBRDpQBD
         9BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757259; x=1713362059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=om0OP/V4nCTPs4aw/OiE4dwxH9wZZxHeDC9s7eqLnZs=;
        b=dwecMdc4PKlxpT3lSG+w5vDNMaFUYKNHNp0fD+Hv0Kn6Rwd4FbzKk8SYQl8G1QHIpj
         p4eYypAsJ0Cpd0krAdWrKSwBQqUEM/ODKJzEofXI0g463eHuarGVYTEliCYTXwRHbHyV
         ZNo7Gn33hj97q0GZ27GiBaW26EzROKcDzz62mxYBbZbZPoRX6Fn/0nvuJD+TQkp1oXwK
         Z7NfGfmknC0Zj2Km2atFtYAxcrSgL0muwjGONMyARmGOgOj9HEdfGd9GPkTF0p/OqrpG
         /5L8W2RDDXWRIrUsSTCPlr/eijbb0eQVtrAuzq3wEAUuzviac22G2ySqU06V/ns4PjoN
         zkgg==
X-Gm-Message-State: AOJu0YxIWUsjJo1zTXcj7mmJpUUjRZcEKwZKqDEKc02J2H/zF+i/A595
	Wdm9jFfwAu7uDU39yjkEZOvx8D+EPxbj6wI2NeI3aUp3DpNcu5xY5kemtAr6V9k=
X-Google-Smtp-Source: AGHT+IGFaK7YauW3aftv+Qevb50NofJrq4hZ5pzMklC6FKomV3FAiFrZZzWTPk+ZoftKIoNvunVBHg==
X-Received: by 2002:a17:906:4a54:b0:a51:d1a7:ad6 with SMTP id a20-20020a1709064a5400b00a51d1a70ad6mr1598346ejv.76.1712757259608;
        Wed, 10 Apr 2024 06:54:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id j24-20020a17090643d800b00a51d46c684csm3979691ejn.89.2024.04.10.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:54:19 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>
Subject: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Wed, 10 Apr 2024 16:54:16 +0300
Message-Id: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For development purpose, renesas_sdhi_probe() could be called w/
dma_ops = NULL to force the usage of PIO mode. In this case the
renesas_sdhi_enable_dma() will not be called before transferring data.

If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
call from renesas_sdhi_probe() will configure SDBUF by calling the
renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.

To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
removed from renesas_sdhi_clk_enable() as the host->reset() is optional.

Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- fixed typos in commit description
- limit the comment lines to 80 chars

 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f84f60139bcf..5233731a94c4 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -589,6 +589,12 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 			priv->needs_adjust_hs400 = false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
+
+			/*
+			 * In case the controller works in PIO mode the SDBUF
+			 * needs to be set as its reset value is zero.
+			 */
+			renesas_sdhi_sdbuf_width(host, 16);
 		} else if (priv->scc_ctl) {
 			renesas_sdhi_scc_reset(host, priv);
 		}
-- 
2.39.2

