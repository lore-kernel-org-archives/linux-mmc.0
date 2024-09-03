Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E42BB09;
	Tue,  3 Sep 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375398; cv=none; b=BBGKFkUNwA0sgADKcII8OJ8XQ2mhynEOp4UKSPgUA2gT3kLgeNJ+PQQa5SOqy3Gr7TyA5N+dZMLYuwMC2F5pLe1IpoEqUUdI7eFGWEAoz5Y/CjTFC9AooWvgY7k0MuzFxBwXDmo0HN4X5xUiL7dNOTWeEsMcux+ArQCEhIc2vcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375398; c=relaxed/simple;
	bh=2MvB+hInrumPGngUefgZ+NofqJXY4x2Qf0kBZ97xpGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZF/Q7wpZH5LYtR1jO/roKuUSmAR2p8HNQlzs6JmL9Yb553VUjD2xn3Fgl3HapfqOZPykpWZtSFHdUt6H8H3fBIHX7wYwS50qf83ReoW/cyyzWSp876u9+oqfgivCV/HFzK7fZeKytaerMP2X3a1eNRS9HAa5mchyG4KvWjqTgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bL1Cj4OK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bL1Cj4OK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725375394;
	bh=2MvB+hInrumPGngUefgZ+NofqJXY4x2Qf0kBZ97xpGA=;
	h=From:To:Cc:Subject:Date:From;
	b=bL1Cj4OKKtftt/waPU8nhypkJntsMaeloWwo2qTHeUdn8AYiCFtFIp/2H8wMWW1df
	 OHYmyj7/fJ1S3L7DtHhnOBy0jqBxKFEmb7anI9CKu1FIV1GM08Vi0Zd5+5K1X0Kte1
	 JbI/Q4umm1ljuU/Kmqn7m0P4pInWtohUaUCLw/EcvJNKEKXaHEBwEOkaV/foW2FDej
	 +tZV9BMGaGkkx/fMWnAaY5xm3uAKx4aOnhN3I2FRDkJEC1UAoF/yN5vQchwbz/VViU
	 jvdev0T4i8DCzvAWb/PdbHNEdxO+l0eGOg/f/KkWJPc+VW34imaJ0cwarTCFVjGkNz
	 sCaMquhRuaAVA==
Received: from bootstrap.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9CFF817E10B5;
	Tue,  3 Sep 2024 16:56:33 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/1] dt-bindings: mmc: Add support for rk3576 eMMC
Date: Tue,  3 Sep 2024 10:51:35 -0400
Message-ID: <20240903145615.9302-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been extracted from the [0] patch set to be rebased on
the next branch of the mmc tree as requested in [1].

[0]: https://lore.kernel.org/all/010201919989e3de-60b56341-85e0-4869-89d1-362407c4f2ec-000000@eu-west-1.amazonses.com/
[1]: https://lore.kernel.org/all/CAPDyKFoJoqwNTKvpK93QtK1wA9vzVUTzCrP32s_HEZcrujN2Mg@mail.gmail.com/

Detlev.

Detlev Casanova (1):
  dt-bindings: mmc: Add support for rk3576 eMMC

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 34 ++++++++++++++-----
 1 file changed, 26 insertions(+), 8 deletions(-)

-- 
2.46.0

