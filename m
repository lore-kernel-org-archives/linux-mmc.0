Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5E13632A;
	Fri,  2 Aug 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612910; cv=none; b=EJlog4ayWRIKM1va4bhHiblnRxPACC45IoVmTKHxRiNG7T9tQBYvreaRdxW05mbOV2KFXucLf0Zus/OJ5D3tNWHNAXwmuEd8Qb45TXoHWvUpGSmrz1pacUc0HcpsJATxF9aPx+R2oQE72fYeE4DR5gPbLOv0L6F4x1iVX5byy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612910; c=relaxed/simple;
	bh=jOKejuFSI0ocJibzterhxRI6kfUg7oPe9uQyDE1Jcuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akWNKz8CMg/7c/JzwwB4FKvRF8zTffoVQda0iO4fhS6dn87R1As7/xdQp+kDavQUak29aNc42iqlKNMHsPtD0Tz3kY2/beH7cx83d97SxMnc2GdCsRHXKEL6+OuzZF7jXuZB6BI0v6Usgd1KXBkiGabdmlZ2EN1TZiliG30Z0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fU5f7jpH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fU5f7jpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722612906;
	bh=jOKejuFSI0ocJibzterhxRI6kfUg7oPe9uQyDE1Jcuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fU5f7jpHZiCqmXKjm6eioVwx5zs6v6QO8kPVDatiedSdLlPC3BdGUo70zwDTXY3Ss
	 1rSch4obdF5cbuN/8mlP8dNWMPZBHNvwQjx/iHOiXI1GZRDSrJwxX6MctFNlF83xwx
	 7emxEu0uHmakYAMdmDpxXzCLScrv8SCcWgGNi6thRrLpDNjW06l9lgusXuuFGpbEkN
	 OGiDYGfYJeBpJFtBM/sx361MZCeAJd1ZLsM14qCMIKUfPQWmAdacdgKEXx/RcdxU0y
	 qL2AV1xVQ7qdrBQJAJKTmsTNj6H2LWzfmqLQgVJE92a/Txcrs/RCsBIJATk2TKwQcW
	 gSWHKee63G86Q==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 21E823782219;
	Fri,  2 Aug 2024 15:35:05 +0000 (UTC)
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
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 1/3] dt-bindings: pinctrl: Add rk3576 dw-mshc bindings
Date: Fri,  2 Aug 2024 11:31:27 -0400
Message-ID: <20240802153609.296197-2-detlev.casanova@collabora.com>
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

Add the compatible string for rockchip,rk3576-dw-mshc and add support
for the rockchip,use-v2-tuning flag, a new feature of this core.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 211cd0b0bc5f3..dd8d1e773bb38 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -39,6 +39,7 @@ properties:
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
               - rockchip,rk3568-dw-mshc
+              - rockchip,rk3576-dw-mshc
               - rockchip,rk3588-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
@@ -95,6 +96,16 @@ properties:
       If not specified, the host will do tuning for 360 times,
       namely tuning for each degree.
 
+  rockchip,use-v2-tuning:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present, use tuning version 2.
+      v2 tuning will inherit pre-stage loader's phase settings for the first
+      time, and do re-tune if necessary.
+      Re-tune will still try the rough degrees, for instance, 90, 180, 270,
+      360 but continue to do the fine tuning if sample window isn't good
+      enough.
+
 required:
   - compatible
   - reg
-- 
2.46.0

