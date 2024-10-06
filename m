Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392FE184537;
	Sun,  6 Oct 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228898; cv=none; b=YavWXySw4RX+jTg2p5aZJS3BLePoPzDUB1F7VRlFCATKd1/Um8VxfevmJ0dxXFZU/jBQbPcoOtcRWJmJzh3Jqp/rgUoVn9wtEoEBlPwr5lkej4pqZnc4T7cfYm+jmjb5mdh70v27m2igJsgwpLx2dnK4yRu/54dkNfNMHcJRzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228898; c=relaxed/simple;
	bh=lKFDKeSsfS9rSww4p/gyN9l47EmCXOXsYZxcg21veGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=REKpbVjBeKoDOhRNO03yJz9QYBX8KIbK4Ac0FNFqXV/iu8bQc9A7vL2ay1ZZEYzR7B5PjVq+GxmHlsaiNy1DQNc/9dkLMBFjbYNnJjQmyRQexX7JUq9/cNma/e6UFq9O3EjBBCgR9M/Taa3JEjY8BPL2lUaOWOgJwpR/zokOFyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=plBxpYlw; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="plBxpYlw"
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id DA73A3FEA0;
	Sun,  6 Oct 2024 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728228894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8a24Wv8+IF6YtpnxD3MAY1GU/+RJAr6bKEjkH7W3iMA=;
	b=plBxpYlwni/+QKRwhvtDms/ca6FJXKkSf1piZBiOQdpOegHZyj6vnztjuo29vkmKdGRHxN
	Ftmc96qyYOquQj2f3wyqFVW0+i8vE330iKQBkYn7/8G6gixsImuS0SaqQhlW1FT7xNP2lB
	wRdNXMHbjN8uq7e3OajHEdGGzj27ZF0=
Received: from frank-u24.. (fttx-pool-217.61.153.101.bambit.de [217.61.153.101])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id B75F1100546;
	Sun,  6 Oct 2024 15:34:52 +0000 (UTC)
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
Subject: [PATCH v2 0/2] Add mmc support for mt7988
Date: Sun,  6 Oct 2024 17:34:44 +0200
Message-ID: <20241006153447.41377-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a14421cf-f9da-47e1-aaa2-7eacc01207e4

From: Frank Wunderlich <frank-w@public-files.de>

Add MMC-Support for MT798 SoC

changes in v2:
- corrected minItems to require all 4 clocks

Frank Wunderlich (2):
  dt-bindings: mmc: mtk-sd: Add mt7988 SoC
  mmc: mtk-sd: add support for mt7988

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
 drivers/mmc/host/mtk-sd.c                     | 14 +++++++++++
 2 files changed, 38 insertions(+)

-- 
2.43.0

