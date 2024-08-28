Received: from a7-49.smtp-out.eu-west-1.amazonses.com (a7-49.smtp-out.eu-west-1.amazonses.com [54.240.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FEE16D334;
	Wed, 28 Aug 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858695; cv=none; b=e3U5VipY/S0IOXYblZjkpgDdGosgwCcRu2SfQWtlaK20upuiTOAZjArhjtSD/5fx20BlCmY/ZqtLCps1KM9XhSZJlfsDrmDyXugwlPku/ZtgQjMCe78vdzixv4uppHq8PpUGnpGdZaXQEhZXiVVzBDPLaQGPi5MCd2NnELDngOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858695; c=relaxed/simple;
	bh=YxFusZ1OLLxvSk44tX+mNzNkWdmB65BrCS5p7PaYt5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnG05gt/W0CWS6KIly1bHAym5ZiYDXvIvI3hVxidzD54F2OEjjmMoL2I9Qao+Z24lLLs5I3HHPrnls+NFr1x+uHQj1wx+enE2NN6zk5XCgZLBKorYAu5RettSj3SruXQW6SEfpJEujn0DDX7WzP73YlHE8/DbF4NQUgbqDiJHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=COcuZX99; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=b+W4w6vw; arc=none smtp.client-ip=54.240.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="COcuZX99";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="b+W4w6vw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1724858691;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=YxFusZ1OLLxvSk44tX+mNzNkWdmB65BrCS5p7PaYt5s=;
	b=COcuZX99qSzTc4lHLiO6tRoSuUWnCW1NpsSvZSnzPKPv8DEjHaiblQNdGRkOV/D0
	zpimbqvlF4YBeLNOnQlsYiTSDUSyaPlJ5HtBXmALh7DizdVmafiexMeutjnS6BdxzIp
	304walO+s2DAnuq9Anhpy1xHuVdhJLwo7plLevFPju3xGffne3LutLoXNckeXz+Dlj8
	bAp6EbC04BtpU2Qq+tlHx3iDMJIZna59U3G0DWClfsAxF1iGA3m/Gc1/Bql9Wy06T49
	vWzzH5KZKqY9U0fa0+e3fur22Iob/+lQkXp8xMPGUYuyN615cIGNV/ETUI3ANc2XtYY
	+VhaZa55mQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1724858691;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=YxFusZ1OLLxvSk44tX+mNzNkWdmB65BrCS5p7PaYt5s=;
	b=b+W4w6vwJi+Dl9pLz8IY8EfvTUfslF+mezD4omzeaas6oaDoa7TpEjUHAre0/kws
	M4vivSykEVSOLlFHZGEjFny3HOg+z+r2v+ngjGAytxYjp1wOUtky7fCigATUur5BeTr
	8Oc+xHZeoHft8Nyd/eL3J3FfViNiGl4LUahZmb7M=
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com, 
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v5 0/3] Add dw_mmc support for rk3576
Date: Wed, 28 Aug 2024 15:24:51 +0000
Message-ID: <010201919996ef8a-db8bbe89-3c18-4dc3-bd0c-6498f09d978a-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.08.28-54.240.7.49

The SD card controller on the rk3576 SoC stores the phase settings into
the dw_mmc controller, so the code has to be adapted to implement that.

Although the feature can be detected through the USRID register value, the
decision to use it is based on the compatible.

The compatible for rk3576 is added in its own group of compatible to mark
that all devices compatible with rk3576 have internal phase settings and
don't have the ciu-drive and ciu-sample clocks.

Changes since v4:
- Drop commit that ignores phase above 270 degrees
- Use a bool instead of int for internal_phase field
- Fix pahse typo

Changes since v3:
- Remove internal phase auto detection
- Set compatible in own block, with own dt_parse function
- Add internal_phase variable
- Use function to set clock parameters based on internal_phase variable
  instead of multiple ifs
- Use different commit for skipping phases higher than 270

Changes since v2:
- Drop rockchip,v2-tuning and use compatible-based detection
- Fix coding style

Changes since v1:
- Renamed use-v2-tuning to v2-tuning
- Rewrite v2-tuning description as the hardware feature

Detlev.

Detlev Casanova (2):
  dt-bindings: mmc: Add support for rk3576 dw-mshc
  mmc: dw_mmc-rockchip: Add support for rk3576 SoCs

Shawn Lin (1):
  mmc: dw_mmc-rockchip: Add internal phase support

 .../bindings/mmc/rockchip-dw-mshc.yaml        |   2 +
 drivers/mmc/host/dw_mmc-rockchip.c            | 217 ++++++++++++++++--
 2 files changed, 204 insertions(+), 15 deletions(-)

-- 
2.46.0

