Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5686C343D80
	for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775997; cv=none; b=QVMQhbuLYc96+UDHFgNr+jUOp80dTkrQXPyYhfi2Rd4CsPJ9WPUeJ5pPs1Mx0PNHm61ryGQCF4GuSj2mz0teqxJYFinEt+dr4ds890ECqn20w7dlCFQ9k9VspXX7WpfavtqQxWE1RjWrrOwcXCjc024IK5Q3zfNyAXm0oA+cfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775997; c=relaxed/simple;
	bh=0wrffe2ePvR9snVbGOn1yuDOZd87ewk/mhSsA9xTEEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bu9IsF5uo0+JvoenNCVCaLNGUyJ9UhfU/EicI8GigY2K1z1WuIu8/NHK++UB1J3gKzMCcQ120AcRIQCglmRjkozFoP8BqXNQ+Ssm+6TupDosx+p67ptYKJb3m5i1GobqllSAVF9moc9XvsG1gLJJ+1NpF4HZHGbAUjO+xNIk57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvaANm33; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvaANm33"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so14988185e9.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773775995; x=1774380795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utwObQp63pBMb8wBU24YfUsTgXDwwHCc0NNvyQURJJU=;
        b=ZvaANm33ItXdE4JaFEYHY+0mzt3UNgonmKHoCDZ92YQgeRcvuGNb5v9uXsZt1RmUM/
         1h2osNga3H3n7oQTpPgtGP6vWwA2gFpjsLilg5wcZIp9Y+V5Uihq0/GE+TKETc3pbA/s
         HJgkSxb5H66gTq0vqdHDX7vuafEqnDgSUv4/Csf5zVVuk2BnIONrp/9OqPlvB/0jAZb9
         EXg/krddBmJ6QW8wqfP76JAhpESTXoYK1ZrWU7dW0LHMZvNMrRHvoBD6ocXp2K7yDdGX
         0lXUOT3WiUm/lAw05vh+Wq9WLYQl2FGSnOyVVvBJkVbCFbQZ0jdXVbp3Cjui/HGnmYpm
         Jbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773775995; x=1774380795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utwObQp63pBMb8wBU24YfUsTgXDwwHCc0NNvyQURJJU=;
        b=RX2NSsOxGomMbHXwCnNrL0+/pPN3hj2PXdeqCmT5JKqAvEoYyQ5YtldKJ1iFcQqpek
         vDsDa+kcdfmA87mGCXVauZiM8WTuLIM8FeFJWPjZBa2SwO3ytcQEPtUU4xOoViWbUMnQ
         6zM7hKYkzJn6BNrukUnLeWKmXygHJRa4yUWKMN8cQo3jCjh6DvaCk3oQOEMs8nac6P2P
         vSrhunzcWxeTHFkyKW2y+9RlHwd5b4PJzGJcx30SLTkc7R5pNc9ftWxdz9XDNIo1gcuz
         5n+jhyKtepxTgC5Vhy9K57DbbRWw6OsiVOxt5OBcQyF4gDvVnTgt3WdfpgHKHGfxSinI
         Jnyw==
X-Forwarded-Encrypted: i=1; AJvYcCU9DZLkLgp32lGig6kwjOIig4YAUok6QvIU/eICokpi9c2lXxGPOygXMniq9h7RCYUomOXw7x8Gz0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBx4VAbPK7Cg4myqUjPWpuNXhl963jAUvYdjHXwtjDsC5x7vOJ
	VBTSY7lczcbEFfJovahBcjZ4rDE2MDQ3KiGzqzohOdtHsDydVDu/iuDE
X-Gm-Gg: ATEYQzxfZkN6dyjXDquaJIWVzNSneHLpsYanhW7pnphainjreu4qjRwvF9jeFGxydrU
	h3VF3MI78g1Cw7jHQshHRJl/URokV0wF6vsbs7NdnUDaTy6s+Rlqh/TLgtIb70jcToqYGRzADXh
	56o8YVJRz4OYeLVyJWLE3Y1yCA0dF1XISvfMbwXpNjl8P7nIOFUMrmLhgkPPaDduvoeKin1Fxyg
	StIG44ENr6XCsujYWqUmiczvq8K9w/r5LLoKLIeJYy2u4Q1coDMJAeiKBCoBUhT1HoJYTXArXp6
	dbyKVmZCwQpP3ml8okE4+gqoqF6ggU7oWqMDERa/t0Xtc4/VRloGyyQjjGHT9NS7nbaV4xah/Jz
	s04I9Iq7X/yPF1es7GUK9whBDL+sxCLvfb+/tNM1UlPtqfQF4vFOOPccpOVsqstHDIL2THG0s1S
	HV2/cZ3SGnj2WWpjqV3b31a1COeCK3GLNZ5vhp/LZYvxX4
X-Received: by 2002:a05:600c:314c:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-486f443845dmr15339245e9.13.1773775994499;
        Tue, 17 Mar 2026 12:33:14 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f41d0c5bsm16762645e9.0.2026.03.17.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:33:14 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v4] mmc: sdhci-esdhc-imx: consolidate imx25/35 data
Date: Tue, 17 Mar 2026 20:33:09 +0100
Message-ID: <20260317193309.14091-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared struct since they share the same flags. This reduces redundancy and simplifies data management for i.MX25 and i.MX35 SoCs.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673..9cfa26722 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -256,11 +256,7 @@ struct esdhc_soc_data {
 	u32 quirks;
 };
 
-static const struct esdhc_soc_data esdhc_imx25_data = {
-	.flags = ESDHC_FLAG_ERR004536,
-};
-
-static const struct esdhc_soc_data esdhc_imx35_data = {
+static const struct esdhc_soc_data esdhc_imx25_35_data = {
 	.flags = ESDHC_FLAG_ERR004536,
 };
 
@@ -391,8 +387,8 @@ struct pltfm_imx_data {
 };
 
 static const struct of_device_id imx_esdhc_dt_ids[] = {
-	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
-	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
+	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
+	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
@@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
 static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
 {
-	return data->socdata == &esdhc_imx25_data;
+	return data->socdata == &esdhc_imx25_35_data;
 }
 
 static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
-- 
2.47.3

