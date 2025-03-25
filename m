Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FBB25485A;
	Tue, 25 Mar 2025 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900833; cv=none; b=TWE3494UXM+SIS4JUKtQdxyRYMR2tZU1wX27Vxib0ps+HmQcu9HAGoizfQyT1z4EqERXDXigHFUHnoIJYJLOcv+SDbg0BaZa9IYxZSLGUlN7BPB/WVqubpCIhhiSuZAo8dZYlpd35LcJ/0Yja6MhfrLDaw/hapP3Q1KzrQE39ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900833; c=relaxed/simple;
	bh=L6stbKrSJItr4b97Xxhs4L11+kqiuh6UY41CNBNHrRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlOceW0FSm9UFt7skJSQFg+G8jstHbgqwSogvA7e45hGIgQuf3aTAz3NXZWdtfdTuwRhMyW8vYNjIC661gim5j83S4OQwZlSX357lVEb5uwmKW+AAymLjh6XnIE1rh5eRZAX9TyR9gH+BrXTG3q4tRgfzpns1IS8Kl9PxQkJP0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cKKkKRJU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cKKkKRJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742900830;
	bh=L6stbKrSJItr4b97Xxhs4L11+kqiuh6UY41CNBNHrRE=;
	h=From:To:Cc:Subject:Date:From;
	b=cKKkKRJU324QW2eljbzVlG3gkBQzcjDClqBQy9fPsTZLmOuzG8KhOm+D35N5Lq3be
	 mhbyotG5G7LzurKTTOxhZJmtW/zzwxu0rcZr96XgHC2BQL/AXP28vXR7a68z1s7ZTj
	 KkKkcTMQzunPKU7KIP1wnbgndCQxjyPG3dNJom383RC7pb2wNDHGMuC/K+ZAoW0i/Z
	 vnC/uBtuM29bkJBnLA5G12TJsDqxlt6ysOeLDM7z1iTk+XJLQyIKPdbKSryRsYhFP7
	 ut5N4QXYTjVD9U22cL30Q8hIYkq/9+HeWI/7lMaMI/SH1xJxT8/4YaNsNf3ujMz5WL
	 e85Ed0TLJjZ5Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A01B117E09D6;
	Tue, 25 Mar 2025 12:07:09 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chaotian.jing@mediatek.com
Cc: ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	axe.yang@mediatek.com
Subject: [PATCH 0/4] mmc: mtk-sd: Cleanups for register R/W
Date: Tue, 25 Mar 2025 12:06:57 +0100
Message-ID: <20250325110701.52623-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds missing register field definitions for the MSDC patch
bit registers and aggregates various register writes into just one,
greatly lowering the amount of register reads and writes especially
during the controller initialization phase, other than the tuning
phases and set_ios for mclk setting.

While this will have a performance gain, that is completely ignorable,
hence this series' only focus is a cleanup and an improvement in the
readability of the register settings (as those now have actual names,
some documenting, and no magic numbers around).

This series brings no functional differences.

AngeloGioacchino Del Regno (4):
  mmc: mtk-sd: Clarify patch bit register initialization and layout
  mmc: mtk-sd: Aggregate writes for MSDC_PATCH_BIT1/2 setup
  mmc: mtk-sd: Do single write in function msdc_new_tx_setting
  mmc: mtk-sd: Aggregate R/W for top_base iospace case where possible

 drivers/mmc/host/mtk-sd.c | 207 ++++++++++++++++++++++++--------------
 1 file changed, 132 insertions(+), 75 deletions(-)

-- 
2.48.1

