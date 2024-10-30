Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E431BC3F;
	Wed, 30 Oct 2024 01:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253287; cv=none; b=D1H6BMhueM0njfkYPa03jhZr2DcpquxV/IiVnig51Ed2ZNxSKXrapC56/MGceQeWY+elBfFW9WJ1AiqaTHykW0bpDZMrXmQxGkDqBLHkvXtfrWacYhkG146w1tl46XSrad5vP36vM0YDvD+e7S8RddJ6dhTlMUJZBwZoKSBbsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253287; c=relaxed/simple;
	bh=qpOOOXWMQa1lDZwHHMx3OdFflw+w+2pzxfyq06gqboM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciaQ10FxSXw8U4A516ZkuERe1IbLlu8lxF3siFw8lDaLEmNACUnvzsSDb9sgFovIxrdpNtfJf20NXsRB6JPczhf5EzMMEjqIxs6Nyts3OVdcuse1p+rlTNWV7v5kF+81A9uw/HbgOz703n6nUEH4ip6gNhrOBNprvlZT/i9zaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2D1Bm2w; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2D1Bm2w"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so3664805b3a.1;
        Tue, 29 Oct 2024 18:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730253284; x=1730858084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=avMnOGtv+fjDKb2FHdKpORq82ypriAfOKWgYRnhbdSM=;
        b=O2D1Bm2wEBWTUxDaA7sjuuIhks9x9+nr7E0CBSjZXdNS+EF/YU+ox4kkzzOIz3krA9
         MYRYwxpH95njrolqjPs4ANMBPbekGuYtqwkJdCRc8h6UZhTJS64h6CVD5eRZUYjD1cAU
         R6w78M/z7Fb1k50f2pv2BR8723eSX/SmS5oWM3d2JnpuMGZl+TXLBfjGB1Avh2rcJppD
         iHR56cLlNwAnfhgmCWQN3ZLehtOQHNrifRTW3+3+cdE/Ock+//AYEsF4prwNlHii5SgT
         oZWAzlFEJMlES6oNonSh8/9Y3JUpiu/7I69IymyubNoAjBYh6EuutfeFVbSWwQ0oRjb4
         egpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730253284; x=1730858084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avMnOGtv+fjDKb2FHdKpORq82ypriAfOKWgYRnhbdSM=;
        b=vflOjkTn/UJjpidgE/govZ0Yb1d60AzqL240vSvHhphWkAOpv4WU3E02nxX2WG4gNH
         UvYClWYzCLdAdVRuH/m0etKAiMpy5Y4zXxX/gqsgFP4ErIkg5GKxrIRA6hQBsFVAP/yn
         K79sc2ap+EwAE+dx0gGKQv+qN4Jdt+mKfvnQ2RaCRuNmQmDPu7vexNJuX4q601Z5OE+L
         7wIbAIuHHMwqeup4H3L2RFJ2n1M26OSXeSPZZ2DW1XiodYPk2S2SS8jZHmQ2P3pU4tco
         QK85A4m70FeFcYi1SrIaUS9ATeSnvfOn+k9PPgv/DURI/QadNoae2rWF5g/Aeuc1DxQY
         UxKA==
X-Forwarded-Encrypted: i=1; AJvYcCUIQVEWuVDUUq6hUZPXy4+56k1xL9jCLJ74yMjhWn0NQoMtJj+GP1/CF+Hhi+I+PEVlIGaSeV8SFBxU4iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsjU8It9bF2KfL7DINJBVJEaCGHXdqPBZ1e/gexKWorewA7L6/
	VigAL7h0UR5c494Y9PJWW9zS4fxg233k0yLmhwm21OnapMDaQ5C7
X-Google-Smtp-Source: AGHT+IG9wAHbREcAEMMe0SYlXgOMatkkrJkfcotPYGghnPUZpulpvkceQM8lNQX+WPxyEzVUETMmjA==
X-Received: by 2002:a05:6a00:4fc3:b0:71e:410:4764 with SMTP id d2e1a72fcca58-72062f83b02mr21342350b3a.8.1730253284161;
        Tue, 29 Oct 2024 18:54:44 -0700 (PDT)
Received: from arch-pc.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a219d9sm8549476b3a.171.2024.10.29.18.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:54:43 -0700 (PDT)
From: Ben Chuang <benchuanggli@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ben.chuang@genesyslogic.com.tw,
	benchuanggli@gmail.com,
	greg.tu@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	victor.shih@genesyslogic.com.tw,
	dan.carpenter@linaro.org,
	takahiro.akashi@linaro.org
Subject: [PATCH] mmc: sdhci-uhs2: Remove unnecessary NULL check
Date: Wed, 30 Oct 2024 09:53:26 +0800
Message-ID: <20241030015326.2289070-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The "host->ops" pointer points to an offset into the "sdhci_ops" struct
so it cannot be NULL. Remove "host->ops" check in "if" statement.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410271835.tqz9s9JV-lkp@intel.com/
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index c488c6d56015..b0e4ab852a94 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -413,7 +413,7 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
-	if (host->ops && host->ops->uhs2_pre_detect_init)
+	if (host->ops->uhs2_pre_detect_init)
 		host->ops->uhs2_pre_detect_init(host);
 
 	if (sdhci_uhs2_interface_detect(host)) {
-- 
2.47.0

