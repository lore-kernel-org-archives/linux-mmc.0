Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BD126BF1;
	Fri, 15 Aug 2025 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222697; cv=none; b=Yw2KiCHUhLcpTfy/Q6SUKC7jKvkf+g+VO4mLaJ8IWRLlsB6e6j/Jr1AXmeFmLercWc8Ea1DEbXKOaIacmTNIZ9BBOX+lhEhqBaKxtobSpn4S8WIY4DUFeiGgWvuMiboeBYMXBdeNE6aWmp74GFYjeaIH2b/UobXhUcnK/UYpy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222697; c=relaxed/simple;
	bh=8xKVhyGS8jiY1CWvQdpglzWFsCjq0Bxftl0YAxiHpa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKz2NSX4heQM6PKiomh8Wd5sdPyaoC9h8p1b4A8seNWpChuGpc2oSz1kWhh1YJnUa7AWNcb7aeqaNgiWG4YBSMKxBgAsNXjDhVe94zJEoC++3UyttohwS61xAQA6t2lRWmugzIQ+QqkNSMcHEobrsSdOuYzkzoKo5Nj0vgmKCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTW5noZs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTW5noZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E521C4CEF6;
	Fri, 15 Aug 2025 01:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222697;
	bh=8xKVhyGS8jiY1CWvQdpglzWFsCjq0Bxftl0YAxiHpa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTW5noZsOjqeIGheWEuVCO0N3Rh5dC1qRU5EQSsi5U4tk+wyr3xlxEdlphZmHbpj2
	 wlLH5OV0vGtNR5cTyXDs6+pqyr6EXJ2N+Gn0CEg3ugxjmqP5dsPTl1ONj6w3XNhiFq
	 uLkavaS/H2o8hkkz6wuF6o0c33WNEeUcKPzCIM1VVofZULLz+7r9pLYC2omyNmO+ez
	 YIMWAJ60y1GDMYw2Mn02hWtQJOFw5PVnOAlz1+KGD+PKk3JWpXZgE78yH4fE5sJBD0
	 HljFOfjHh1+dScnTyVdFYpJPTMtSxu3k1COB6tudPbWRTmR0vlfZL7cM9og2M3L3NM
	 rRdfPuHSVWgvQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/38] sdhci: add some simple inline functions for !CONFIG_PM
Date: Fri, 15 Aug 2025 09:33:36 +0800
Message-ID: <20250815013413.28641-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250815013413.28641-1-jszhang@kernel.org>
References: <20250815013413.28641-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In next commits, we will switch to the modern PM macros.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/sdhci.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 58fcbeaf281e..5b699af04bfe 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -880,6 +880,13 @@ int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
 void sdhci_runtime_suspend_host(struct sdhci_host *host);
 void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
+#else
+static inline bool sdhci_enable_irq_wakeups(struct sdhci_host *host) { return false; }
+static inline void sdhci_disable_irq_wakeups(struct sdhci_host *host) {}
+static inline int sdhci_suspend_host(struct sdhci_host *host) { return -EOPNOTSUPP; }
+static inline int sdhci_resume_host(struct sdhci_host *host) { return -EOPNOTSUPP; }
+static inline void sdhci_runtime_suspend_host(struct sdhci_host *host) {}
+static inline void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset) {}
 #endif
 
 void sdhci_cqe_enable(struct mmc_host *mmc);
-- 
2.50.0

