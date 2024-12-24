Received: from mail-m127158.xmail.ntesmail.com (mail-m127158.xmail.ntesmail.com [115.236.127.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3EB1BEF82;
	Tue, 24 Dec 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033778; cv=none; b=CbHjNFkDHwQIyUhi5cWJZj1EX9rSfizrIOKUTIKY0GhRDB9MunRhEf0AG1kNVLlKhLwbKd/bWVdyxCRXm0dT1kYLU8Wr4ycddLgH0L/3Uh6wgYVv7b7ZKuU0LWAXIoWz7mF7K0P2I3ZBBgeE6MZVnLwagt73ldqKL5oYKw91RB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033778; c=relaxed/simple;
	bh=nwOrRzYKRAawu2Q/5xarfry/s0Wnu6iKpKIqeTi+AzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y53mwQKLH0uePcI4b+osBIfvW/4CuK/QkF0a9siup7UdlkGo2vE6+DcNLf+8dEqO1n3nUMcqLd9Sv86Q27zSeVAEOw81b+qgI89yIWNiX5PPTESO0p9p6yf3wMDI0GbA0nyxZERuDUBve/cXIbFiQ/A4bC/eH2rcGz4KrIXL1vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UW7X+Yjq; arc=none smtp.client-ip=115.236.127.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UW7X+Yjq"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aad4ee8;
	Tue, 24 Dec 2024 17:49:26 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 02/17] dt-bindings: mmc: Add support for rk3562 eMMC
Date: Tue, 24 Dec 2024 17:49:05 +0800
Message-Id: <20241224094920.3821861-3-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094920.3821861-1-kever.yang@rock-chips.com>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0kYTFZKSEkYGUhIGkNNT0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93f812434003afkunm6aad4ee8
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nxg6Ayo*STIOTUozS1EqLDUz
	EBEKFCJVSlVKTEhOS0hITE1MQktMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUxINwY+
DKIM-Signature:a=rsa-sha256;
	b=UW7X+YjqDvlBxMNOu0sjqZY8HpN2ytS3XGlGuLaq57xynPQJOnsuJoZA3VpTSP8y2QQe8Vcj0FXLDp8zYndIQ0L+jFeCIGjKy6G4rHMI3KRlW380htcLRuCvp3KH7iSZtc0fAl0LfNzAC8bo20Eyocv1KhB6cZYs8NN4Q0nrUs4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8Vy2jX1P5CcfS+k88EOexLOM32haPI+pYQW5JzkIYwM=;
	h=date:mime-version:subject:message-id:from;

rk3562 is using the same controller as rk3588.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 .../devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml      | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index c3d5e0230af1..33f4288ff879 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -14,16 +14,19 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: rockchip,rk3576-dwcmshc
+          - const: rockchip,rk3568-dwcmshc
           - const: rockchip,rk3588-dwcmshc
       - enum:
-          - rockchip,rk3568-dwcmshc
-          - rockchip,rk3588-dwcmshc
           - snps,dwcmshc-sdhci
           - sophgo,cv1800b-dwcmshc
           - sophgo,sg2002-dwcmshc
           - sophgo,sg2042-dwcmshc
           - thead,th1520-dwcmshc
+      - items:
+          - enum:
+              - rockchip,rk3562-dwcmshc
+              - rockchip,rk3576-dwcmshc
+          - const: rockchip,rk3588-dwcmshc
 
   reg:
     maxItems: 1
-- 
2.25.1

