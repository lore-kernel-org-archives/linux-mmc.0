Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876932882C2;
	Fri,  6 Jun 2025 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207700; cv=none; b=AUHyUzpxR/ZDTBAGuP6AtGAYKsu+i5DECNifXywVhLqC13mlQPMfVTNOSJMMNqOCRkuWh5mdAiz2QE0NZFJxQtlMyMHjsmshONd+EbDUkjx15Gf3jUyymX6RX/BFqu5pBx33EuoyPUbsLW6flfuUmiZJYsFrbsyeyGDvSp6ndxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207700; c=relaxed/simple;
	bh=KHL+vq1ykP4Zr71+2wspAda7WJt5Gxkzpx2CSZ9kO9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qohQzrYznpKB87cwS/xNOsjylNa9v6yjvsUZL3UVH3nyRnP/umX1pK9x8Pk2iMRw/G1fR1/AYtrVdgAl9lGqtek/uHHCOGbsESd9QHuGYgvJnp3Np2PLc8UUikw662EQ0vlCzrclOMvc+eYkoXQt6d9OirB3dXa90adGyWZ3BlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsDNoJLw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsDNoJLw"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2c41acd479so1204044a12.2;
        Fri, 06 Jun 2025 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749207699; x=1749812499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWmLMoecq6/e0cg6wm8bQxLR4skzTvI3htWCIwVFePU=;
        b=HsDNoJLww2ivpKAAa+btsAnHF9UjnL7riqYVvUJ0iPQF+6wsI55nZ0/I7BgWmKfzeM
         0r3K731cs8nOQvunheSQi09FrAfRzNSzxeAtvv/clkHbsFXBzlR/tQsSAS9+NZNdsIVK
         CUfNV6n0ttiMwh5yO+jMjEhM4frruNVBMWJnc3OJI5RljMfCsYMXtVBfwroPeEBACF11
         539S/0J4Ov4cpcCbIq57kO//5RxiEB9a9xFO8s4k4wNCrkFyRIipnQ9Dh+Jq+e4ccsZo
         wMohAK3uBvYo7vYG4TuCc+4oS42BsNkGGdDIw55uNq3mHYjAdGrEXnxvi5iEA5XRM/Pf
         b0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749207699; x=1749812499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWmLMoecq6/e0cg6wm8bQxLR4skzTvI3htWCIwVFePU=;
        b=BVgVZ3hX7nAKLwpvd2nlOrFlmKVO6U/66C46oi9GRmxCUQRCYhI27xXOXAFckq7PSV
         VOBn9cuWnBzTw1VX58YArBsp3X5XBDGnIFDuuDxuZ8aaPMcTnCB7QCphVJRMEowhhlaA
         T7RhxLbku5IghTzGvRlp8wLIgQNA3soHhf8PJuUjaJ+3gTwegVkncypMI2vAhFffqbCY
         hwOQ36VzmKOsJJ4LK+20r4of9EUe4sxEaH+/p+/D+gP7kkx8Mozj/j6SUhHulXaXZkC2
         9LYLI54ABCGFP2Reqy2YQH3/y+TpkeI0OZ6Zq3N+9G5BQQP2RJES4u9M1pyAmVURFG33
         B2VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvDOMdknXSkaFNmn5JfBXH50Gbxb4pwnnpbxt6h18gfrZo9bbT52yXMF0cIa90vY9RokOKqPNgcqkvHGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIV6VNg08p0pcXr0f6FUUBd5QMssIWFvuPekIC8r/60VfPShlY
	O/YJa5j6aaImM8rd8UsAE55Hop9JpZt3+0i10cwuQoD/Ahz4GeuLn6Rt
X-Gm-Gg: ASbGncuCIM822lX1jFT8bq+eZuVIPvWFfIJuad9yxHEwuOdG1JBPpymCHAtYYhn3TGd
	FlqlJoB+8asQNHo1ylmGD+ujbTyFWFPYMNoh/Te8cX0gXJczFRSA5ncum6h6vNxJtEL4V1VrVjH
	GQiNdgAgMQfxflB0Ae2g0nKDj4Icz5qF+O8sTy+oZNKmvcpvcGk0W4tdYsByYnOdiwOJDoKx3Ip
	frTRgaR/um4yTgUuz3u9ERKfZfRIpXEbVqD4BnH5vHsmVzR92TLqrU3z85RUF6miKbTTEmJhW8e
	XVahSopyekLwBv7CsGgn9n5SkkXMk/e2v2dWitLrklVpIhOJ6optb/DCMT4=
X-Google-Smtp-Source: AGHT+IFAUQhEkDlOyYk2aG68k7uex0e+ILlWBeTf0nUkHdxjc8cUiLrqvftQtwJvjxdf49NnYncSHw==
X-Received: by 2002:a17:90b:53c4:b0:313:1a8c:c2d3 with SMTP id 98e67ed59e1d1-3134767ec1emr3814127a91.22.1749207698474;
        Fri, 06 Jun 2025 04:01:38 -0700 (PDT)
Received: from victorshih.. ([2402:7500:477:464b:b7fc:d546:e798:4fbc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603406aa9sm10095565ad.188.2025.06.06.04.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 04:01:38 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V3 2/3] mmc: sdhci: Add a helper function for dump register in dynamic debug mode
Date: Fri,  6 Jun 2025 19:01:20 +0800
Message-ID: <20250606110121.96314-3-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606110121.96314-1-victorshihgli@gmail.com>
References: <20250606110121.96314-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add a helper function for dump register in dynamic debug mode.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f9d65dd0f2b2..70ada1857a4c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -900,4 +900,20 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+#if defined(CONFIG_DYNAMIC_DEBUG) || \
+	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
+#define SDHCI_DBG_ANYWAY 0
+#elif defined(DEBUG)
+#define SDHCI_DBG_ANYWAY 1
+#else
+#define SDHCI_DBG_ANYWAY 0
+#endif
+
+#define sdhci_dbg_dumpregs(host, fmt)					\
+do {									\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);			\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor) ||	SDHCI_DBG_ANYWAY)	\
+		sdhci_dumpregs(host);					\
+} while (0)
+
 #endif /* __SDHCI_HW_H */
-- 
2.43.0

