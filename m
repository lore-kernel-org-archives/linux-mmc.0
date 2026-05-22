Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02734DB74
	for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435123; cv=none; b=kEm+SMW9iFeYytEfRZwf28yA15gq1U7zLYGAqxruNo57lyRpnXyyr8aNYOKQk5ewVVj1doOxQMrJiXU0U8XiHPOeKdIymXveOm0ygBUKnIw/LqfUT8m+OA6NXsjXDwHEQIpr2uGnLeHAeAy+5HlpeAVYANXSbZa3N6OiWRE/tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435123; c=relaxed/simple;
	bh=g8HCOvznuaCizoSItkBM2k6rEBvIxm+DYP4utVV7Lx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoBy+wwc19MkEdYKowhNRgyPshI86QvMHNF1PRgZAMfT7TQlBUcPnpQi/D36zZkhBoQAUsYSqw8zGE99iyGjZIlDX5QRpI3bvw4XyVGln7h19NEPUwQS4hITq3CZzjtksjET/acP3081VZk9pwDVKE1CgT58Z3YvQaB9fia3uZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWPKw198; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWPKw198"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso2038813e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2026 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779435120; x=1780039920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE15t8Mxev7j1oSU8fnkqi5IApdtNWy6ugDPzn+jf08=;
        b=nWPKw198p58eshuOYr76VlN6fKIvnjzuyfTgDyuDmrwbrJGpmcSfHCNOxNnlwKhcFQ
         4IjGPppP4X2P4goZJKkTdLk0yEO9QOBVl98mk+j4TmV7WhcaXPfBjR9AM+2oR9s79vDm
         cy12sbqivBJ+sTcdvgJIdtNO22LJJH0ZuhRdaUwRGixI7jDzTFInWj2h/SzetB481r4x
         hyzS9MBf4vWEzlxNmh/dpqmsN4NZ7b+LMIiPdR/UVZ02EaEsvIxo7cnC9ajH4Sg2p+hA
         WnavkNx0Ktdh+cB1eAziftvu/Mpf/O0ZrOPXPzuBLcap9wwCbEctRUxuE6co29gbmw3F
         /ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435120; x=1780039920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dE15t8Mxev7j1oSU8fnkqi5IApdtNWy6ugDPzn+jf08=;
        b=St6bGH2Jn2hgdP8WpFtR/VjZs9k+1y3x1Sicr5By9EFQksfUaN1TDMndAjCDJmusFX
         Vcz2CGVgGFZnk9Dk5bRbKw6Rj3NRNRDJHfGrFyPO0Rflfd6hTYVW6qnWLGRofVS5UfjA
         UFZv0PLeF+Ez1Cu0Bd+5vD3hZzGRg67wc+GeWYOQjcyKkMEC0m3NkCB8Kajo2K4Ribjl
         0dSAP+faItarXUdT7ByJdZgwb8n/msDMX/X+ufK71IAIeIoTZJE49PLAM7FKCJ+o4b6f
         QOXWTZUkMahtxDDpMC7JUMg/4CXlrVoGzCbLrsMOdTIAFd5hXs629TaBYFo4RFnm5wbk
         1fpA==
X-Forwarded-Encrypted: i=1; AFNElJ8D1eEjWzSI9E3pocFswZPEfcV5kHIhOisiunCIXW+m/94qucuFUQLVhY8HyhouJY4OgJsTClcKYlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCGkc51mo+IY+ugAdmwLxib17hIcTYQgQVpbMMf2/dLLpeZaj8
	Br+J8RP5+oq+8HWgOMh8Qm2e4wghceOM8mhFLMHgIvKPqnTl3lX8MlNuaGoc3Q==
X-Gm-Gg: Acq92OFegD5KqjYXbvO3nu9CcD4RFQXAg+gzQJuVeidzIY6i+L6pOsACKBi3BoIB0jh
	wOcBhuoCndF+CQN+Qi9YB4L14G2C2XAdeCwSM+Pz0gISsLqbi5r6qCALGpd2ha2P+m80LRnFs35
	HOvQ0FF5xtfkRvAUlKYUafu20YkMNua4uWn1w6BNIF1KXUBmfdqTKJ8/Uedfkup0w8PoFQ9FZKN
	NF88Ctg4nKqq+BoNmN0PDXH7+uDWWLdJ35XSZwt1yqIF7tCcGTLNzi9wB+WQ9hJE6NVVqHF478v
	OCBKmGpmMQJwtcLDwOUadyjd78DsjLwlZVbAGJeAnCAjtVivFYw9gAExC7457oPcOx2brnJgMMe
	ZNkACEuikuGAsSAL5mC+goTARhnBQsrxZXaAIbgjGQRdAT89IhppbMp7xthVQ2Ggxd9CS7ZrrbX
	3hjQK4oYygq1HBASoeVYHEzoD6i8DDNskpHKrN1iYPE8voF9dGLHg=
X-Received: by 2002:a2e:bd87:0:b0:394:1192:5e1f with SMTP id 38308e7fff4ca-395d8d3c7f2mr6687951fa.22.1779435119905;
        Fri, 22 May 2026 00:31:59 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc0a4e3sm1818751fa.22.2026.05.22.00.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 00:31:59 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
Date: Fri, 22 May 2026 10:31:31 +0300
Message-ID: <20260522073133.409844-2-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522073133.409844-1-a.shimko.dev@gmail.com>
References: <20260522073133.409844-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_disable_unprepare() function has internal protection against
ERR_PTR and NULL pointers (IS_ERR_OR_NULL). Remove the redundant
IS_ERR() check for bus_clk in dwcmshc_suspend() and in the error
path of dwcmshc_resume() to simplify the code.

Note that the clk_prepare_enable() call in dwcmshc_resume() must retain
its IS_ERR() check because clk_prepare() only handles NULL pointers,
not ERR_PTR.

No functional change intended.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 0b2158a7e409..c1ed7f28d75b 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -2564,8 +2564,7 @@ static int dwcmshc_suspend(struct device *dev)
 		return ret;
 
 	clk_disable_unprepare(pltfm_host->clk);
-	if (!IS_ERR(priv->bus_clk))
-		clk_disable_unprepare(priv->bus_clk);
+	clk_disable_unprepare(priv->bus_clk);
 
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 
@@ -2608,8 +2607,7 @@ static int dwcmshc_resume(struct device *dev)
 disable_other_clks:
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 disable_bus_clk:
-	if (!IS_ERR(priv->bus_clk))
-		clk_disable_unprepare(priv->bus_clk);
+	clk_disable_unprepare(priv->bus_clk);
 disable_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	return ret;
-- 
2.43.0

