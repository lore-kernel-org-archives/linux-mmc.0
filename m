Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987CF24E4A1;
	Wed,  3 Dec 2025 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762348; cv=none; b=uPiNwXDwu2sLsxd/hAJ6MQ2+E71XFMp41l1wiKitbdRq+JIEN97n5bqjupOA0spFWWg6tvkvf4hagAJ5jBNv6WwyC+rmCQDNfnrH7TBsJLw+tPWbi+eOLMZqzzFmnNftm6kSP4bLAc9VDUxYEMe5mTJCyG53xEPnzZ8oPC6RqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762348; c=relaxed/simple;
	bh=GVsvFJMJ9N1wsNH4BMhV4STieOC8bBaHmsMcDsgLe4w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RVYQhGW92mva1tLaCYNRtMWfaZ1J6ComljqBoRTq+HYE4NpskGiweoggbpdCN8g2MSMWEtnuYv5zL/3RNAbjV4l4lxevgS7qqEc76qItqX0HbOcqMy2CflWUJH/4cCiDp7kBtBAQy1K2y3kniBrYFymXDkX8Ozz9Zq6H38wB43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ertmZ7iC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ertmZ7iC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764762344;
	bh=GVsvFJMJ9N1wsNH4BMhV4STieOC8bBaHmsMcDsgLe4w=;
	h=From:Subject:Date:To:Cc:From;
	b=ertmZ7iCiPYCTgzNdCrDhswfqUjpHR4k3lTL1s7LIWWTrYW9XbnCZEqQID0zhiJ6r
	 Aan5ISTpWm6V7l4Hu0i55Cv8ReWTfaiwhy9Y4Vjg+uMxzp9WUiIxdNGthlol2IAuXD
	 NXEnaZP6yGstcII9GQUa1XqFCt+nMJfj0/2WlC635F0gWeinyZvZy/71aC6zrMl7Yt
	 wbzCW6lIHL1C/4ZkSbYKzyoPPIjX3fkZvEpWVhBijqeML3IJRhV18Q+6NDiwC+NOqD
	 UHn3KVabohseoxj4gT9PMkiNQ1QoNb7X3jOI0xsoS9k9qrXLbmQzn2sNWR8q2TZIy5
	 siGQOp4l4S/cg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3640717E110C;
	Wed,  3 Dec 2025 12:45:44 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Subject: [PATCH 0/3] Add SD/MMC Card driver support for Mediatek MT8189 SoC
Date: Wed, 03 Dec 2025 12:45:33 +0100
Message-Id: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrDIBBFf0Vm3YFoH5j8SsnC6tjOwkfVlEDIv
 1eS5Tlwz92gUmGqMIkNCv24cood5EWA/Zj4JmTXGdSg7lIqjaFpqUc0zmEIFuuScyoNvX84r70
 e6Sahj3Mhz+sRfs4nF/ouvd9OCS9TCW0KgdskIq0Njw81XGHe9z8w9pEFmQAAAA==
X-Change-ID: 20251128-mt8189-add-mmc-support-ff6df8f89e41
To: Chaotian Jing <chaotian.jing@mediatek.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: kernel@collabora.com, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764762344; l=991;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=GVsvFJMJ9N1wsNH4BMhV4STieOC8bBaHmsMcDsgLe4w=;
 b=uSJLBh6B+FOH+EPSJKMaFBFDHGGU0Q1u9uG3pq7ilcrCaZzR/IRrFpLBUB4FALTltdRD7PHvo
 JysB9LtdEwvBavezS+8USNHo/tASlNSB2b+ZSNLOl9ZyS6faqL1Be0h
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

This patch series adds in the Mediatek SD/MMC Card host driver (mtk-sd)
the support of Mediatek MT8189 SoC and its variants (MT8371 and
MT8391).

It has been tested with a kernel based on next-20251203 tag on the
Mediatek Genio 720-EVK board, based on MT8391 SoC, using both onboard
eMMC storage and a micro-SD card.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
Louis-Alexis Eyraud (3):
      dt-bindings: mmc: mtk-sd: Add support for MT8189 SoC
      mmc: mtk-sd: add support for SPM resource release control
      mmc: mtk-sd: add support for MT8189 SoC

 Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  3 +++
 drivers/mmc/host/mtk-sd.c                         | 32 ++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)
---
base-commit: e47d97576181b31291cf58e77d737d21def0e160
change-id: 20251128-mt8189-add-mmc-support-ff6df8f89e41

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

