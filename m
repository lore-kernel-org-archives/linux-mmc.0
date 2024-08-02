Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5C1537C5;
	Fri,  2 Aug 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612912; cv=none; b=QSq3gKomy2qrtCEfx0YKPdHbdFf6AT8Py9pftAubPSjHlFgQ2cy9d5JCMZQTG83B7jdRcLuw8GdJAhJsdxxpFKxiMbDZvfXmci5KFR5mpdwnAApcZawn5vrec9ctsiaxrcSu1zywUQHTDlLTB34gcEB/mav92llsb/cYXxfsOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612912; c=relaxed/simple;
	bh=6jXRBP+uzUiPE83cF/CLBHqxDVEBgCZETPVHDDmT6Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksnCpQorNrIwc0Pqp0wOaH9OnhrMg0c+/s+uBs9OLIky7gXZDIs4M8HcncP+XeSUnwY7PRmlcMyae+6ruihpYfWAAxQpewvFEhF/3XultgeZcLpTUEuWhOMXIDRz23qMbn3ijB6nl5uR8snYPgdQs11uKQYK6+lHjKZzMVKCww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NA+GzsS7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NA+GzsS7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722612909;
	bh=6jXRBP+uzUiPE83cF/CLBHqxDVEBgCZETPVHDDmT6Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NA+GzsS7EkJZFPoDTZSueWdyLWxvbfYRwjPzfR31XwOSViWFa+ZrxLHcePl2b7x8w
	 Sh4gi+YgunY3lEnfKyLRyTHaGSgRwVcUKE00tRTNFc4OYuQP0R7iIL4QuVbAV5VGtg
	 zOGbO3BiYyFgncRPbHAiABcglhv0jjwePaR76aAiiZeKzxmOGTsU07gtGSmE1xe1I9
	 S8mUKFqT2iIShwHl+/UKAQxs+KCG8yeF7+xT5ZAP5XYp5h9yHepMTMHYhgXh2u5v3e
	 5ozVWba7GT4GRie7c/akqbFFdnakD/LsNJBSv9JLvj2/qhhJTlcOT+gxUwIXOvXTbb
	 s9oG/5fJYkl1A==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31AC7378221A;
	Fri,  2 Aug 2024 15:35:07 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
Date: Fri,  2 Aug 2024 11:31:28 -0400
Message-ID: <20240802153609.296197-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802153609.296197-1-detlev.casanova@collabora.com>
References: <20240802153609.296197-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shawn Lin <shawn.lin@rock-chips.com>

v2 tuning will inherit pre-stage loader's phase settings for the first
time, and do re-tune if necessary.
Re-tune will still try the rough degrees, for instance, 90, 180, 270,
360 but continue to do the fine tuning if sample window isn't good
enough.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index b07190ba4b7ac..c47b93d99a1b3 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -24,6 +24,8 @@ struct dw_mci_rockchip_priv_data {
 	struct clk		*sample_clk;
 	int			default_sample_phase;
 	int			num_phases;
+	bool			use_v2_tuning;
+	int			last_degree;
 };
 
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
@@ -134,6 +136,42 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 #define TUNING_ITERATION_TO_PHASE(i, num_phases) \
 		(DIV_ROUND_UP((i) * 360, num_phases))
 
+static int dw_mci_v2_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+{
+	struct dw_mci *host = slot->host;
+	struct dw_mci_rockchip_priv_data *priv = host->priv;
+	struct mmc_host *mmc = slot->mmc;
+	u32 degrees[4] = {90, 180, 270, 360};
+	int i;
+	static bool inherit = true;
+
+	if (inherit) {
+		inherit = false;
+		i = clk_get_phase(priv->sample_clk) / 90 - 1;
+		goto done;
+	}
+
+	/* v2 only support 4 degrees in theory */
+	for (i = 0; i < ARRAY_SIZE(degrees); i++) {
+		if (degrees[i] == priv->last_degree)
+			continue;
+
+		clk_set_phase(priv->sample_clk, degrees[i]);
+		if (!mmc_send_tuning(mmc, opcode, NULL))
+			break;
+	}
+
+	if (i == ARRAY_SIZE(degrees)) {
+		dev_warn(host->dev, "All phases bad!");
+		return -EIO;
+	}
+
+done:
+	dev_info(host->dev, "Successfully tuned phase to %d\n", degrees[i]);
+	priv->last_degree = degrees[i];
+	return 0;
+}
+
 static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 {
 	struct dw_mci *host = slot->host;
@@ -157,6 +195,13 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		return -EIO;
 	}
 
+	if (priv->use_v2_tuning) {
+		ret = dw_mci_v2_execute_tuning(slot, opcode);
+		if (!ret)
+			return 0;
+		/* Otherwise we continue using fine tuning */
+	}
+
 	ranges = kmalloc_array(priv->num_phases / 2 + 1,
 			       sizeof(*ranges), GFP_KERNEL);
 	if (!ranges)
@@ -277,6 +322,9 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 					&priv->default_sample_phase))
 		priv->default_sample_phase = 0;
 
+	if (of_property_read_bool(np, "rockchip,use-v2-tuning"))
+		priv->use_v2_tuning = true;
+
 	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
 	if (IS_ERR(priv->drv_clk))
 		dev_dbg(host->dev, "ciu-drive not available\n");
-- 
2.46.0

