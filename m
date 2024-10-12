Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8818593E;
	Sat, 12 Oct 2024 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728743926; cv=none; b=LJuEWlFJkv51mASGZbEurbrW4zz9WE5KNpRY4Tia6AEbc6PySCJwaWQwAI/n5x52jSgrkrW3TgNhwodltAsKPc0dm9pGAvVboTlv08QOCWCXwBTN10+RiLHyGmj83vMW3KUkvKDGa2rcah8vtuquvuD5IiBTHy9sgzybfzpY5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728743926; c=relaxed/simple;
	bh=E/+KjG8sCuY6D5UzoBXb8fqpQoj1SxF0OV3nDEoquZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=My7uM9lhSIaW49qDD8NXM15fvo52f2tDw66v9q/pn308WQ3DMgZs9mARO6NEJ76q4L6BQmAddlGiCNI3YD2ib1y80y+18H4aDeMSGBGXSdh8sa5MQd7aPc3OZ49hxDtHvcdKM5onytxffX+aoB2GtoYf7f0htJs/x8RurG/ZCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=On5QsgKL; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="On5QsgKL"
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
	by mxout4.routing.net (Postfix) with ESMTP id E8F45100292;
	Sat, 12 Oct 2024 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728743916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0h2d49jGEJ8TqYqr97bccjBuIfL/jaq+AJ2XRu1lnHk=;
	b=On5QsgKLCEt3JoWgchtFpx3tF/Dr17vsxIBTjMAJ6Me7r4fUac1tUKt+YdeNM8NvZfszgC
	WBYeYw5Vhx0l6y7NLLLZMcVt/XALYZRW2WWJi1b7rITiqFzDYHdfqWuJrTOYranRL2XU4D
	CiyL4jDT8dlvgGZaFoXjkGDS/++bzkQ=
Received: from frank-u24.. (fttx-pool-217.61.155.16.bambit.de [217.61.155.16])
	by mxbox1.masterlogin.de (Postfix) with ESMTPSA id A62254012F;
	Sat, 12 Oct 2024 14:38:34 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	daniel@makrotopia.org,
	john@phrozen.org,
	eladwf@gmail.com,
	ansuelsmth@gmail.com
Subject: [PATCH v4 0/2] Add mmc support for mt7988
Date: Sat, 12 Oct 2024 16:38:21 +0200
Message-ID: <20241012143826.7690-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f9b58133-ca2e-4d2f-bc1b-1157f73252bd

From: Frank Wunderlich <frank-w@public-files.de>

Add MMC-Support for MT798 SoC

changes in v4:
- drop minitems because of dt_binding_check error
- explain mt7988 compatible with mt7986 platform data in commit description
changes in v3:
- use mt7986 platform-data with the mt7988 compatible

changes in v2:
- corrected minItems to require all 4 clocks


Frank Wunderlich (2):
  dt-bindings: mmc: mtk-sd: Add mt7988 SoC
  mmc: mtk-sd: add support for mt7988

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 22 +++++++++++++++++++
 drivers/mmc/host/mtk-sd.c                     |  1 +
 2 files changed, 23 insertions(+)

-- 
2.43.0

