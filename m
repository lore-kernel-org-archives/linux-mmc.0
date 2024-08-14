Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4914B078;
	Wed, 14 Aug 2024 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674904; cv=pass; b=BS4dJnRnd5/eXmoD8H7cE1T8ti2giE84IKql2gYyyZk4tGMzpPfIzi4TgKMK7wh3j9Wrk2lR1Qwkmw6mr7t6/bHl+5YlnLjlJRCUccWY2dbr2UZhw7pbvXHd9qWRnqbj5AjTZghNkcbe4MQLZabFFVbVGl9ai3neAu6m3L9Xp0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674904; c=relaxed/simple;
	bh=DmvcOK4DmoE9sNj6NlGdNpGPzzaf+JV/6TwlxsLg2cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaqWMFbCiF+GkzgQ03rmDl8vA3/wSxbTdlr8dOOVuidpdGcdlY7a0+H5E10UfQ3n03p5pN2UB5iLBnOKjp/5bg9ycji7BTOFAv0IeyI26XAPd9mYet4+rp2HRRt4x6m4BVs5pLutnRw4IB2R78g9SxQGdVhujAbAXtxSsLSJ2TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=kYVixVL7; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="kYVixVL7"
ARC-Seal: i=1; a=rsa-sha256; t=1723674875; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WTypK44+SJpXk4qCjsYwyIkFQFHwTM3T4c9Pjh5cTgZ0s604Dd+2gA6DLTPUur+8hgLINDLQv5aHi3OSWBuG2Sl//5TaUh6PEMsfJ9cHrhfJT74CsP2Kb/4SjlI5NUaCSt3cacptFaBl6Iufapri9a72ixn6Zu/HQm6QFAgolBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723674875; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hFyITHK4+31+bbEA7zU9AotjqyrzWu0tKY/WzA4cM1c=; 
	b=nYReGsz8YS04DwInIDXyvk/h1ouUl9XqAz+eWECAFZ3OsCO22lYGiR8BNOhDTQukbejlRGrTkLTtMSiLtDwOUpGmfNNiJbIiTcVFPdiUKHmh8iUaTbiJEDeBO5siOXvkfIOOCvmLzdOv6A/nRb/Svw/Xp7nwG48dV0/rxfm6Gag=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723674875;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hFyITHK4+31+bbEA7zU9AotjqyrzWu0tKY/WzA4cM1c=;
	b=kYVixVL7y+NXOSURTgR779V/sjfzp9QfbuVKa6vkNtrARhOJWMAgnQ5D4Yb/Rz1D
	E6W+E8vu1Lp7z+IuUX627U8gfwK0lrEELIIXlYbyRFI8jwpRGpWaCsEoi3mEEMmNmAJ
	g2pI0UkHb9BgJmlDa9SdUqUcWDo//GALOr0h2SYE=
Received: by mx.zohomail.com with SMTPS id 1723674873367688.1527891973695;
	Wed, 14 Aug 2024 15:34:33 -0700 (PDT)
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
	kernel@collabora.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
Date: Wed, 14 Aug 2024 18:34:01 -0400
Message-ID: <20240814223555.3695-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814223555.3695-1-detlev.casanova@collabora.com>
References: <20240814223555.3695-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Shawn Lin <shawn.lin@rock-chips.com>

v2 tuning will inherit pre-stage loader's phase settings for the first
time, and do re-tune if necessary.
Re-tune will still try the rough degrees, for instance, 90, 180, 270,
360 but continue to do the fine tuning if sample window isn't good
enough.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index b07190ba4b7ac..367633f4e8892 100644
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
@@ -277,6 +322,10 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 					&priv->default_sample_phase))
 		priv->default_sample_phase = 0;
 
+	priv->use_v2_tuning =
+		of_device_is_compatible(host->dev->of_node,
+					"rockchip,rk3576-dw-mshc");
+
 	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
 	if (IS_ERR(priv->drv_clk))
 		dev_dbg(host->dev, "ciu-drive not available\n");
-- 
2.46.0

