Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335D1EBFEC;
	Wed,  4 Sep 2024 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481925; cv=none; b=tlaTDQn7zThVrF1VJw6Yg3/ST8kwtE1RstTTGBEpOGI7BiEz67p2FconAipuPdH4Qk0rrLum76jzMh+5GQTmUYxS+DHFStFXxrsZqn0wQAGbGgthUiQkmn4hC5rSSu6QdzV5BX0okfGBfWPVDhPSDtZyCsvC7p8MyfvOvzWaHVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481925; c=relaxed/simple;
	bh=gqJFPZ5TBT3uU2PefWaM8pDxQC85HpNqtSQ8CnSk3Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfctCokpr1qwIOXn05FhgA7pWAqGwf8XNpgyWi1/9LjRRGUSxylujzBICSZAkPnPRj7kBzPK092zAhUP6Y0OZS1+QUDulbhT/yitWDpByS3y3pX+e26lKIHe8peoeO8NwfW3Tl59w3JaFLnH1zLdvksRJK3AFplX7u789r+PIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c2s4C/xz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c2s4C/xz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725481921;
	bh=gqJFPZ5TBT3uU2PefWaM8pDxQC85HpNqtSQ8CnSk3Ug=;
	h=From:To:Cc:Subject:Date:From;
	b=c2s4C/xzjyixldE8BZdQJTeIqZln2iWf5pEFZX6+fZsDXYFH5iZhLq13RzUKnVn/x
	 kXsTO19oOZWCK2/oeVGo2JU+RXpdBR52VzZ96TSAqZJwNkNEA3jd2i+PvDT0l6GHvQ
	 4TPmPBt7jue6y7+JbI0A6IWg7wmV3+QfNv5dbkralZFxooOlHRVbIG9lHZzizWaUB0
	 4yOLxpG7oXmZXRx34ZGcRP5buUZVocZYJM3Iga3OPSucvtblV1lNWhRJHxEv6IUdgJ
	 B8z11h67lMbIZjsORsGibnPUSCbmo799jPeyNaT2hMixFgp9bRLuoCU3IqH2Mx0RJx
	 IqVs8SiVcUxgA==
Received: from bootstrap.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 59DE117E0AE5;
	Wed,  4 Sep 2024 22:32:00 +0200 (CEST)
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
Subject: [PATCH v4 0/1] dt-bindings: mmc: Add support for rk3576 eMMC
Date: Wed,  4 Sep 2024 16:30:57 -0400
Message-ID: <20240904203154.253655-1-detlev.casanova@collabora.com>
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

Changes since v3:
- Rebased on mmc tree's next branch
- Improve power-domains requirements
- Removed Reviewed-by: tag

Changes since v2:
- Move the allOf: after the required: block

Detlev.

Detlev Casanova (1):
  dt-bindings: mmc: Add support for rk3576 eMMC

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 37 +++++++++++++++----
 1 file changed, 29 insertions(+), 8 deletions(-)

-- 
2.46.0

