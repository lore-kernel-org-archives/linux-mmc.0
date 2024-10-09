Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79A2D7BF;
	Wed,  9 Oct 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492954; cv=none; b=rIF8bXqTmZs5u8XHJSYmfOelXJKAIHo3VoiqVNVG3OFj6bpNvtFljRm7/F/6O9+W8/IoBBb2zw40dHIkqwbWadiJ6kNKZ2zrY5QAi1IhBF6Y/t7U0irHeWTGAgIFSJEwjtvO3EZhHcYDrmy+qQCXrDFk1uJW9QXOrKgXmrWbbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492954; c=relaxed/simple;
	bh=bb+bSDyH9Lcs+qmIkFBL8MyFo4XA2i/Veq8hx1dK2is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ne0eKECPvFGAUCZMrLEN1Xh1yqYMK7yPbWhtTEoG/w6Vl2BOo8J95LZdUbJ0x+I/9Mvztfkm6bMGWecpTUw7azKNzfavOULnCKPc7pCcm6y6dDlkJ4KhIlafyFQKvSlFM8dVyDDbZ1p1VIXxNPc112ZzyDanxFVXuISgaHoQbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=xFa4/rj3; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="xFa4/rj3"
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id 7F44B40832;
	Wed,  9 Oct 2024 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728492951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JtXZ99XjmGyXRMM84puxICow/S4XX7s6NgxgrAuapPU=;
	b=xFa4/rj3zQUefRtwUv05Pe4f1KVw7pUYTnimtXosAkTpR7wXqczLKWIhdU5XFjreBtAsrX
	laAzzUzyZUC1QBJxPqBv4gep7maqR70Pgi7f5WLt62n0PQJ5CtR48uqpz7tzMPXiQneNxD
	T1YeeU9Z4Tapvsz/BLI/fj5/v5Be9I4=
Received: from frank-u24.. (fttx-pool-217.61.150.182.bambit.de [217.61.150.182])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 44E4E10030B;
	Wed,  9 Oct 2024 16:55:50 +0000 (UTC)
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
Subject: [PATCH v3 0/2] Add mmc support for mt7988
Date: Wed,  9 Oct 2024 18:55:40 +0200
Message-ID: <20241009165547.5959-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 20f6a083-cb8a-4483-b34b-6595c1925ce0

From: Frank Wunderlich <frank-w@public-files.de>

Add MMC-Support for MT798 SoC

changes in v3:
- use mt7986 platform-data with the mt7988 compatible

changes in v2:
- corrected minItems to require all 4 clocks

Frank Wunderlich (2):
  dt-bindings: mmc: mtk-sd: Add mt7988 SoC
  mmc: mtk-sd: add support for mt7988

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
 drivers/mmc/host/mtk-sd.c                     |  1 +
 2 files changed, 25 insertions(+)

-- 
2.43.0

