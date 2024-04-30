Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84941292C7
	for <linux-mmc@vger.kernel.org>; Tue, 30 Apr 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469851; cv=none; b=YW+5TU6q1cpKC0dQIyL1JOLNJJEcDFhHWMdiiWsR9S8dOngv7W6OyhKQ2cs90gT5OpzVGrr7jDFLaoY/877jXA1Lrj8Slh+WzpKNyKsBpW29sg02rKRNNsI6Inx6ElIr48Ip4TqjSp3sQ20aaubL9yyhwqx+7q9RZl/djFGrUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469851; c=relaxed/simple;
	bh=uhKdkmK31MXKrfFbEk2DLsbTDwgGQVf30ZHxv26DDAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmNLfFMgEXRppLGTV6NLK0ETWIzZhWuopU/MXvqYrymfkNB7vmxHxEfBSFkDPC8qgsE/x1wAGcbh2inap27sBj1yltLOXuOvDhFrfOzs2GQrQc+DC7rb3CwMu7VTdDEGDQtIy+EuguFK64wSikqdnBdBVBIMKHCEpCOczOAPxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y47kbsDL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y47kbsDL"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so6849439a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 30 Apr 2024 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1714469848; x=1715074648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3StYaHb+jugcbYETWpU1s1DMvudTBsQ5hJ3Pe6RKnEM=;
        b=Y47kbsDLY60xGN0JqDz/swP/KZyZbEv3Eu7eweo7KQTjPYRybZ44zPeoIuFdQ1t0C8
         7ixcexpVZSUixS/4grmk0EA433PAV1+cPBgKppdR3yYtfoKrZx6C35JnP/mbuvzP6+tV
         /eia6X5zAdAc3Z06XgYiyC0gLOVZsrT6d6L6zafI08pvJQKOU7MCIpum3uDz5xvEn/QT
         oGklWH9dFRZcDkE4bxhXtI1uRpHctVc+gAojjt3fPcG2tvCINQy/cnKWYwGcksY96HGh
         6psM9TT2EYSqIfjej8HkjTteYTMLODuDD4XkmL0blClAj6tUobXRkWLnSuT5XoCNURmI
         O6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714469848; x=1715074648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3StYaHb+jugcbYETWpU1s1DMvudTBsQ5hJ3Pe6RKnEM=;
        b=dYzbLTXPOyEfRmicp2vjoHlC61QXW01ueMn1jVE4fEJe3j/KoTs35axt55GFL3oX44
         AG/2eyQC3taYO5SFbi38xhBPJ0Aw/iWKxyIJ+7WOINMdKD6lL2sKJIxf4GiaSGh8PQ+1
         crLgdsPcOLCVU3NJYCxcZilRMZ+DypcoQLJrqzvCrB7+2V6C6JEuRw1IZIcZ3UxhfOQA
         YMk0zJqLcogLtxbGRN43xstAFbJwHH/UtqUVE5tPLuaTvc90CBKi9yDRkgDHk4SQNOW3
         GbFlobHnpsjNn4yWmNbpkgf/YswpRvPRlOpPjJXlq/CaeeuwFrw2ibpbUSsI31mSSr78
         /CZg==
X-Gm-Message-State: AOJu0YwixBnkdr9AENtAAyElpqFyzkxvbAZkPvVyr/wxbQUXh0hUE9PW
	g489ymG4bvYSqkRRzgAD9MZ3XBXIBBjNwIJh072axdKdGIlrDQtuElh15poF4RM=
X-Google-Smtp-Source: AGHT+IF791IVTgQYCkDZyT5QfKzOiH/FUM1qkzc17ar1STLr7dQzsY+zNJl2I4gZet00wmrxDzyerQ==
X-Received: by 2002:a50:a456:0:b0:571:d380:95fd with SMTP id v22-20020a50a456000000b00571d38095fdmr1506622edb.28.1714469847790;
        Tue, 30 Apr 2024 02:37:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id cq6-20020a056402220600b005723fe809f0sm5490448edb.80.2024.04.30.02.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:37:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>
Subject: [PATCH v3] mmc: renesas_sdhi: Set the SDBUF after reset
Date: Tue, 30 Apr 2024 12:37:24 +0300
Message-Id: <20240430093724.2692232-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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

Changes in v3:
- shortened the comment introduced in renesas_sdhi_reset()

Changes in v2:
- fixed typos in commit description
- limit the comment lines to 80 chars

 drivers/mmc/host/renesas_sdhi_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f84f60139bcf..d9503f9f6e96 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -589,6 +589,9 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host, bool preserve)
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
 			priv->needs_adjust_hs400 = false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
+
+			/* Ensure default value for this driver. */
+			renesas_sdhi_sdbuf_width(host, 16);
 		} else if (priv->scc_ctl) {
 			renesas_sdhi_scc_reset(host, priv);
 		}
-- 
2.39.2

