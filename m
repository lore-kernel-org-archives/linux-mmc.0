Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9C19AD89;
	Wed,  2 Jul 2025 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450512; cv=none; b=XNMWXI05kMmmLFv3hsIcpp15PuI5ETS2XoLTP3EOHQUxsok2lUib99Et/KfYAc9W9DrztWMM4tb8t7zu7ol8PDQLSuZHDk7+K/S9Lvq43tblIuRGKoItmygWIDwgGaYHtRH5ZqNXIB2M5Z3x+WFxXmdKs0Z93kiSdQbd3lUQzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450512; c=relaxed/simple;
	bh=eNKdiGfqO/VuWb4nuKPgERe+wyH9DEVM80fafn4TfEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0oLk+x72s9ApHeMZ5dgir3fytaJe6TCNQKsUhXFlKjV/3/I8tW3Ag1sYP/lvKY2HGpBAkZBGqoAV4LPybkPhdP8hlUZVzbiMU0Z+uSOzTBdFKJJl5tcxzyGQqWAgBv6C8p/YnKkd68E/6S5tnHO4LqE9iev2Bki7rCgVl5Nh+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=bRQvynVU; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="bRQvynVU"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1aaa9ed2b;
	Wed, 2 Jul 2025 17:46:28 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	catalin.marinas@arm.com,
	geert.uytterhoeven@gmail.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	bst-upstream@bstai.top,
	neil.armstrong@linaro.org,
	jonathan.cameron@huawei.com,
	bigfoot@classfun.cn,
	kever.yang@rock-chips.com,
	mani@kernel.org,
	geert+renesas@glider.be,
	andersson@kernel.org,
	nm@ti.com,
	nfraprado@collabora.com,
	quic_tdas@quicinc.com,
	ebiggers@google.com,
	victor.shih@genesyslogic.com.tw,
	shanchun1218@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v2 1/8] dt-bindings: vendor-prefixes: Add Black Sesame Technologies Co., Ltd.
Date: Wed,  2 Jul 2025 17:44:37 +0800
Message-Id: <20250702094444.3523973-2-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702094444.3523973-1-yangzh0906@thundersoft.com>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkgaVk4ZGkNNTBofQ09OGFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a97ca87d4b509cckunmee1cabff3eba7e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MVE6Pzo4LjE4NE8PHSE6HQE6
	VjIKC0tVSlVKTE5KT09CTkJKS0hKVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQUlPS0k3Bg++
DKIM-Signature:a=rsa-sha256;
	b=bRQvynVUXniiVJyyH/q9DnWCaWegCDyqvNxnpqcOsl2JGrj4Lp17augQtBgTZqfrea5swTq0A7M/4pQt89ZzyIlff4KcZcrt4pvdvzrIrSyWMezcOqVZY1eHYXD7auzMGNh7585V6XitzXFdlqGw0EGjlU2k3TaBYmrQv3o4sUA=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=XEabmgEszbyuyR1aOE7h10DY4QzFMJFpCj2YxqFGf80=;
	h=date:mime-version:subject:message-id:from;

Black Sesame Technologies Co., Ltd.s a leading automotive-grade
computing SoC and SoC-based
intelligent vehicle solution provider. Link: https://bst.ai/.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..3c2031417232 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -222,6 +222,8 @@ patternProperties:
     description: Shenzhen BigTree Tech Co., LTD
   "^bitmain,.*":
     description: Bitmain Technologies
+  "^bst,.*":
+    description: Black Sesame Technologies Co., Ltd.
   "^blaize,.*":
     description: Blaize, Inc.
   "^blutek,.*":
-- 
2.25.1

