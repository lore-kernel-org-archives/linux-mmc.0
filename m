Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E861D278A;
	Thu, 22 Aug 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361897; cv=pass; b=hSKAW6QDk2fl4EhyyHYsjzlHAfVFnLFq82FfT9led0sGWpfDOjyqrpAZsTjE4i+NEdVFE6Iy7NxijZqrOytxRRvCuitMz6QEDwWU0kT41iVwmyKJuxLvWykqb2gzwNyeWkXQZYm9o1kOAtlyeLtm9yEa7AIrOvL0a4E4CYd5Qac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361897; c=relaxed/simple;
	bh=H5n6yyNbYHJ3kr5/Ml70aTWW0+/x3U/i3fEJWODYXlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HScBbinvPHL1w6iMtNXbtCkljX+W1iROng+r/jkETDvKbDhO343JwzD7Tlw13tyQLcTSyjybFEFsHXSSQN7GweVWkHRkgoZJHFfbvGLWftqL8ygv/bQ7qEeAuczmn8AQ23/2iC0ssOxYlBci0Vi2Sg86hCZS3soApxYgyQUh2p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=HCFZMrZt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="HCFZMrZt"
ARC-Seal: i=1; a=rsa-sha256; t=1724361880; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IkA6hN8H3x2DF8V9mxRMupij6TobJMjfLmiPNg08ryAd5kADu5/UZ1Kq23geHJW2uvz4I90LrplXAx5OaIbzAf0iEpxGjwgaphkYAxTfi/khZyjL+UGqyJJoQODwEID4d+QbTp2rApd7MB9TMjZX71NUWtkfvZ2oNXxGLCyRv2M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724361880; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NS4CxkTiArEGKDo4R2GEQhehc7xfiMhtmReWN/dqCBE=; 
	b=W7A44DjJT7euWf/KcWxrCSLeyNmpbGam22WBNLfcKAiIPveOukKa4l8rFL/BzT7IpgWYDNz1pNITqzrmFoqmAn+NHFQnP9Luz7R0Cy/Bb9KZ0Asi+Dt9200UJw1ZoHgOtrqLLL9Wvr0thlLCQ7+ZigYhc7K3P+qoH6OjVC1fmck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724361880;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NS4CxkTiArEGKDo4R2GEQhehc7xfiMhtmReWN/dqCBE=;
	b=HCFZMrZto0mO1j4cXzVGozhYhFRFwk5rbDtiJ75nef5dQ0jIS5oe4KxziD7LiyiT
	lDZ1F2EWXkHbShrhkcbjpBW7nPr4HIq664YeaZv+W7vrdiLIyfwGWRo/KdCjRmhCkC0
	nS/03nNlDYiMLXh7exM8abOs+8Oo7JoTblQ5eSfc=
Received: by mx.zohomail.com with SMTPS id 1724361878947371.4122073368609;
	Thu, 22 Aug 2024 14:24:38 -0700 (PDT)
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
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v4 4/4] mmc: dw_mmc-rockchip: Add support for rk3576 SoCs
Date: Thu, 22 Aug 2024 17:15:34 -0400
Message-ID: <20240822212418.982927-5-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822212418.982927-1-detlev.casanova@collabora.com>
References: <20240822212418.982927-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On rk3576 the tunable clocks are inside the controller itself, removing
the need for the "ciu-drive" and "ciu-sample" clocks.

That makes it a new type of controller that has its own dt_parse function.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/mmc/host/dw_mmc-rockchip.c | 48 ++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 1458cb5fd5c7..7c8ccf5e71bc 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -410,7 +410,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	return ret;
 }
 
-static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
+static int dw_mci_common_parse_dt(struct dw_mci *host)
 {
 	struct device_node *np = host->dev->of_node;
 	struct dw_mci_rockchip_priv_data *priv;
@@ -420,13 +420,29 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 		return -ENOMEM;
 
 	if (of_property_read_u32(np, "rockchip,desired-num-phases",
-					&priv->num_phases))
+				 &priv->num_phases))
 		priv->num_phases = 360;
 
 	if (of_property_read_u32(np, "rockchip,default-sample-phase",
-					&priv->default_sample_phase))
+				 &priv->default_sample_phase))
 		priv->default_sample_phase = 0;
 
+	host->priv = priv;
+
+	return 0;
+}
+
+static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_rockchip_priv_data *priv;
+	int err;
+
+	err = dw_mci_common_parse_dt(host);
+	if (err)
+		return err;
+
+	priv = host->priv;
+
 	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
 	if (IS_ERR(priv->drv_clk))
 		dev_dbg(host->dev, "ciu-drive not available\n");
@@ -435,13 +451,25 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 	if (IS_ERR(priv->sample_clk))
 		dev_dbg(host->dev, "ciu-sample not available\n");
 
-	host->priv = priv;
-
 	priv->internal_phase = false;
 
 	return 0;
 }
 
+static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
+{
+	struct dw_mci_rockchip_priv_data *priv;
+	int err = dw_mci_common_parse_dt(host);
+	if (err)
+		return err;
+
+	priv = host->priv;
+
+	priv->internal_phase = true;
+
+	return 0;
+}
+
 static int dw_mci_rockchip_init(struct dw_mci *host)
 {
 	int ret, i;
@@ -483,11 +511,21 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
 	.init			= dw_mci_rockchip_init,
 };
 
+static const struct dw_mci_drv_data rk3576_drv_data = {
+	.common_caps		= MMC_CAP_CMD23,
+	.set_ios		= dw_mci_rk3288_set_ios,
+	.execute_tuning		= dw_mci_rk3288_execute_tuning,
+	.parse_dt		= dw_mci_rk3576_parse_dt,
+	.init			= dw_mci_rockchip_init,
+};
+
 static const struct of_device_id dw_mci_rockchip_match[] = {
 	{ .compatible = "rockchip,rk2928-dw-mshc",
 		.data = &rk2928_drv_data },
 	{ .compatible = "rockchip,rk3288-dw-mshc",
 		.data = &rk3288_drv_data },
+	{ .compatible = "rockchip,rk3576-dw-mshc",
+		.data = &rk3576_drv_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dw_mci_rockchip_match);
-- 
2.46.0

