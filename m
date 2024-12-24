Received: from mail-m127173.xmail.ntesmail.com (mail-m127173.xmail.ntesmail.com [115.236.127.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA0F1917F0;
	Tue, 24 Dec 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033774; cv=none; b=Mo/N+ppZ3pm7X4n5/NGXwJIGcxrFh+vPdfUpz5GqsMdShNUU00jSdxw9wcHg5l61WAQ315u8jDKfiUkTRd8TrpVDr5slCfFl76nYOb1h4ZSZN1og370dZc4rCQ8AO3DVUMd7qgrijLMBuwIQweOmiupDMfKQm3Qq98Jxr9WGWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033774; c=relaxed/simple;
	bh=wt6pcLM6vYVhlnsbSkC+CukL2UdqKSRndcgFfg1xVmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U8ybn7RDeGLrqbK6gYl8YkEXi3DzKUBpGkRK4ea7u0PyqrnRJhrITRn2jmRIXkuvM9rSNXe3iGZXZ3Xirq3UDPPz6SbxeqqL6JSYactKp/ndvb12tpu7UFqAj8tWxRgFzstBDq/K0lSQz975Cxy7c5DNlAixhC7a2HwByZh3L0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RLV+8yjf; arc=none smtp.client-ip=115.236.127.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RLV+8yjf"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aad4eef;
	Tue, 24 Dec 2024 17:49:28 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 03/17] dt-bindings: mmc: rockchip-dw-mshc: Add rk3562 compatible string
Date: Tue, 24 Dec 2024 17:49:06 +0800
Message-Id: <20241224094920.3821861-4-kever.yang@rock-chips.com>
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
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktOSlZPGB5OGEMeTktIQxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEtNT0
	1VSktLVUpCWQY+
X-HM-Tid: 0a93f812488403afkunm6aad4eef
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6TQw4QzIcNkosFlYCLDIv
	DFYaFDhVSlVKTEhOS0hITE1CSkJMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDQ0I3Bg++
DKIM-Signature:a=rsa-sha256;
	b=RLV+8yjfPEqclnGQKP48Duwe2uNc5Hxwjo1n5ZycnicSBvaYJRm9G0xkcQN4sHPsO5Q3W3L5kRsUM7A3HbY49oluqxpdeUSYBd8uoXYbd6AKEQXtZKt6E5etHUlEKvAjyud1bq3x+zMw2Rshqih8d+IU+OIWudMiC2hLVIetnUw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=VoKJ6FOgCFP1HuVMBu37S6FxFo809cHz971Ja0kvKBU=;
	h=date:mime-version:subject:message-id:from;

Add RK3588 compatible string for SD interface.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 06df1269f247..772f592291bf 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -38,6 +38,7 @@ properties:
               - rockchip,rk3328-dw-mshc
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
+              - rockchip,rk3562-dw-mshc
               - rockchip,rk3568-dw-mshc
               - rockchip,rk3588-dw-mshc
               - rockchip,rv1108-dw-mshc
-- 
2.25.1

