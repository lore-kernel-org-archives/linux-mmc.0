Received: from mail-m1973177.qiye.163.com (mail-m1973177.qiye.163.com [220.197.31.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604F229B23;
	Thu, 27 Feb 2025 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657296; cv=none; b=bCFCIwwZ+gMUb6cfyV7aEaHnbTIQXR8eHNc2FlngMIHXzmwyPVN2UDTB0iyheGLN7P2aTf3nzAIQ4sO1m4sh7SlE9n2FZdR87BPvQ574T3Qvxq5XeScDV2jeLcxU+ZpcVWiIo+OCbbLvfnQ0TYEEA+aDBco2NuNXg7ZFOVKe6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657296; c=relaxed/simple;
	bh=mvcA5sV3+oNGQiv5fRK8feC9e7FFzhZHTWYlL/1AySM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7Lx8H4co6OmG+UNjClMd3r9kvAMhmLEyyOBDD7jnKLWUbFRcGFsFcEB4owFMxIU0Hlk0JssgGbAo2KC+LaTUboXPdug/FgobK+s1F++oEB/nOA861+AmrMHrvV3gyEbnvwBeYf/CcystVICPXGaO0YSO7KRHF2m7qCqjNmuAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PHIrBApM; arc=none smtp.client-ip=220.197.31.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PHIrBApM"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65f97d6;
	Thu, 27 Feb 2025 19:19:24 +0800 (GMT+08:00)
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
Subject: [PATCH v3 03/15] dt-bindings: mmc: rockchip-dw-mshc: Add support for rk3562
Date: Thu, 27 Feb 2025 19:19:01 +0800
Message-Id: <20250227111913.2344207-4-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227111913.2344207-1-kever.yang@rock-chips.com>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlDQlZKShlOT0xOGk5LS0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a954721fd0c03afkunmc65f97d6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6Dzo*FDIQHQ04Ek0#Hkw6
	QzdPFB9VSlVKTE9LTU5OSk1NS0hKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0NJNwY+
DKIM-Signature:a=rsa-sha256;
	b=PHIrBApMVXT9zti3L8tS1YLRYOuXmNkqOv8CKgjzyZcMB2nKS14j24mRLttFqUhQ8OZ7pQBHwVda2BLXnWYFWGRnLqtm/eaNYyJFFFOFum/rZSoaajES1k2BaoKN4YRLAqHojmYeTjq49UdCh1c7xGaMb9zLYHt1st3vbvkzOSY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=gvHFJXiZUej2/rw2Y0TEZw4Mh/rNQelI7yzxW1da/8w=;
	h=date:mime-version:subject:message-id:from;

The dw-mshc core on Rockchip's RK3562 is the same as the one already
included in RK3288. Extend the binding accordingly to allow

	compatible = "rockchip,rk3562-dw-mshc", "rockchip,rk3288-dw-mshc";

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v3:
- update commit msg

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

