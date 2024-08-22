Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554B1D1749;
	Thu, 22 Aug 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361892; cv=pass; b=jL3/Aiav/1/0xShAy3sRrqZbJzBFjuKid2PsAWssNugj9OWTjlZTDMNO4EZ9osJcjENojDD3qYqzS7dmr6oG7FiCQRlHzbQqoerhfT6VuQTDFgALbzay07146HQVgJq0W1lNufoVJGfUEbHMKC7PwdSkmb8cgZR0So/fvs/zSaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361892; c=relaxed/simple;
	bh=x7zeP2P8fsE1d1NRKaYduEaIl3/F7W4Z9FaBV6GVowY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmYt4V8SEwAdq3bP7RC0cx6O4rOt7mzwkYfdjLkDXB75JZTko2LHJ1CHKh9a+CMekUczAoKhgMplJRtpnABYYhMoUb4cNEC9Tw1baYHptSFPgwwPwD1+XQFjJen/Ov1FlmXwN17erdQBEA+RIcuMWP6yQoJLy+z95EUCPMG86og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=aA0JDcHW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="aA0JDcHW"
ARC-Seal: i=1; a=rsa-sha256; t=1724361876; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OJ+Opr2MNMa6OF7bltAJ3JSr7BWWxKyeavOTVyhY5nDh1vh1khV/3QjYhq/IniA9XpLgibnAr+/XFpha9z8lOyDfNJ9uvFIuCxPRmbXcbuTwNzIClhr0oPzIdpB/xZoAdBTPTPs5ZdZKwVl8ddvayhRFBQQ3QMF24HeKGLCK+AQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724361876; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EN84kePymAZjqnNQZ6p8n/Xwq293EwgO6Eo9yZZ4dNE=; 
	b=iBQFgbownTY9umSPYnSciA13nmbXWVClZg0iTW6ayeXsg16JOmj9F0hmKalTCyaUoe4fexw3yq2h6gkhpw64srkONJ9Bn9yV13n64UwLUE+3WPVYcZas5+etdjFR+4LK0gRdFB69GHdDKql5a3KRwbUz47eZQdq+Ub0sgOHcAXo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724361876;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EN84kePymAZjqnNQZ6p8n/Xwq293EwgO6Eo9yZZ4dNE=;
	b=aA0JDcHW+zb01AnSXhG0p9126UPzOtcSUKpFJLu5owa1iGUdCO/mXbPFwKgjJIM8
	vpaIKfV/G9UfKVCXerruz7biS3VifbT+zRrw5RVCCL262Npwa8vT74siU/Kb+MVS330
	JWNi/PfqIWr3yCInfMlJNNo2HXC0RZQ6WkaxOLNA=
Received: by mx.zohomail.com with SMTPS id 1724361874628235.6533325594619;
	Thu, 22 Aug 2024 14:24:34 -0700 (PDT)
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
Subject: [PATCH v4 1/4] dt-bindings: mmc: Add support for rk3576 dw-mshc
Date: Thu, 22 Aug 2024 17:15:31 -0400
Message-ID: <20240822212418.982927-2-detlev.casanova@collabora.com>
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

Add the compatible string for rockchip,rk3576-dw-mshc in its own new
block, for devices that have internal pahse settings instead of external
clocks.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 211cd0b0bc5f..06df1269f247 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -43,6 +43,8 @@ properties:
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
           - const: rockchip,rk3288-dw-mshc
+      # for Rockchip RK3576 with phase tuning inside the controller
+      - const: rockchip,rk3576-dw-mshc
 
   reg:
     maxItems: 1
-- 
2.46.0

