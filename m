Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E413C90E;
	Thu, 11 Jul 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685931; cv=none; b=SvINjVSqgmFzsBCiqhsPhMIE8zRZC2fAwjSHw2DNHJNWEN6tfKRtk+y1JnRLhmHp+eeU7CMrdq1KloCzc4YkrGkcJ0E3p/rpPCLR5GxyseIt15IcOGQs1ewyDSgz21uDEMAisvc9mHJHb00rQSI63z9wrcwq7NoexGbBkUimJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685931; c=relaxed/simple;
	bh=Pzi4xFSDzIRrUXKxpVsB3bYPtOAlT6ekdmSgaX69xZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9rx0ro/afu2Kc2dUR9Nymn7nHjTzz/b0u39DhKOy98ojaArbaklRi2NsZ5eDo2s8dWVEDTEQU0z6ja4b2eLk6QVvNXdF9/dzN1TGCoNpDgW7TTKEsxSpUKHPSciF8hoLmuf/FCkJwEmUkv/Wa4RngMGzNQuiTRy6E7gyZB+wUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kv5X8Wbs; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kv5X8Wbs"
Received: by mail.gandi.net (Postfix) with ESMTPA id 5DD7B40005;
	Thu, 11 Jul 2024 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720685920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=osTRi2KSbmV+Tob6/3aGnNAqMqlljsPQGyTbLqh2kKU=;
	b=Kv5X8WbsXzm/9vkM2YTJnvUYCKj4GzYDknk9g++tN/jF8MH+IPbbp9J3CephSTOcdGLGgM
	wSMPppr/N8+zGDirsK3lcpPEW75y5FkML5gGuKZOZi3uLFi0jHOXderidFDTt2l1T8pNfC
	4vGR14cAzte2sVYBjPB/jMHdv7lSs8y1uhgoU1jD/HC6fo5uPSOkqbPjEXwRfqAPWLb6r0
	wKUCg4htgx5DnJaJGguHNSJTcGnxDC+ziPLilbtWHVMaWZHtShLcAfL4CN3mpX/js48ih2
	YHTPpmXX7OB6cE6PmNepU2dUhjOIrBs9ieCtbrYBPU9sRZSl2n55n9H4yjxYfg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 0/2] mmc: davinci_mmc: Fix v6.9 regression
Date: Thu, 11 Jul 2024 10:18:36 +0200
Message-ID: <20240711081838.47256-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

v6.9 introduced a small regression by removing a needed size check
while inserting the use of the scatterlist memory iterator.

The first patch fixes this regression.

The second patch improves probe's trace to report every supported bus
width

Bastien Curutchet (2):
  mmc: davinci_mmc: Prevent transmitted data size from exceeding sgm's
    length
  mmc: davinci_mmc: report all possible bus widths

 drivers/mmc/host/davinci_mmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.45.0

