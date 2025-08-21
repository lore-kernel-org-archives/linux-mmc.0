Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E8830DD1C;
	Thu, 21 Aug 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775253; cv=none; b=U3D2oFDjIXssHdCMwDZqnXBQ8/WLWCPR/3gOBksM+X5CiVKc0YSczn0jiK6NGD3rx4nR1mbH/ctTYSpgj2DjFVXt9RgwH5BjOijF+bl/xTGd5tAxhC2O2PlwnqowYWUpf+OZsUqt1fY1zY32Rw+CS4JaPVT1oBDCB39PQyySStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775253; c=relaxed/simple;
	bh=cIC7s5NmpQyvXwv7gG+89a1BknGeLYatlzWDzXINP2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bdo3Iax4pnyn3KubkA2HNic9SIZmqgbcqOL5MbD2GB9fh9WHpVlYmiZpjBgSvauSvyousDqD45myLw9TICZ1NZnJdkDEPpQGSBHghmLfJMzxNjYqmX41hliIoz/Xcqj6zK5gP9KJNutnwhakFHVXh5Vq+tz1mNy2nhvNdWCawX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=j5PPxBiT; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="j5PPxBiT"
DKIM-Signature: a=rsa-sha256; bh=b5NI1TT88MTAqiLI8nYID5mlHscCtsllJzEYglqt6qE=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1755775244; v=1; x=1756207244;
 b=j5PPxBiTvDOwFSaeA6BirgHVzTLFljn+kg/Yp0fmSaLTbb7hWNS0gSQ/zoFItiTdnUh0on6B
 r6TskX44OIyqecm+C4KPRrkvYhHnfQx6Jpj89dCXknB4RqC6qNlGDADHLZ0FEcZirV13uKit+uW
 cxA/RGCM+CS/o2HUgw1NITrcuiVBux9jOwCUqlGa1G3ewBJWq9D7nmczcxw4+e4JslYjbXvSPzK
 7uOXC4KSP28ONaWWh7cKWey61eYwQHxbHFMRS4JloIB10y5hC1qdIP857X/cec+/huGJwrSziTC
 kMgSX3Uy7piMEjQBOWE0p4epRS5ETH2L0aVgRo8n52xjA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 95b49b87; Thu, 21 Aug 2025 13:20:44 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH v4 0/2] mmc: sdhci-pxav3: pinctrl setting for fast bus
 clocks
Date: Thu, 21 Aug 2025 13:20:34 +0200
Message-Id: <20250821-pxav3-uhs-v4-0-bb588314f3c3@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAIBp2gC/3XOwQ6CMAyA4VcxOzuzbmygJ9/DeICtk5kIZJMFJ
 Ly7g4sc8Pg3zddOJKB3GMjlMBGP0QXXNimy44HoumweSJ1JTTjjkuVQ0G4oo6B9Hag5S1VZNCA
 sI2m/82jdsFq3e+rahXfrx5WOsEz3lAiUUY6ZBC6VBauupn/iy6XjbXT6NIwfsmiR/4SCwVbgS
 SitBp3xQuf5X0FsBbUVxPKDZcIiioJVbE+Y5/kLLnA3Ty4BAAA=
X-Change-ID: 20250718-pxav3-uhs-d956bfed13f0
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1603;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=cIC7s5NmpQyvXwv7gG+89a1BknGeLYatlzWDzXINP2k=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBnLGbl5y9n6WA8cuWx1O+DC1KXfWFpO3Y5UE+bg3KU8y
 1ZuQnlyRykLgxgXg6yYIkvuf8drvJ9Ftm7PXmYAM4eVCWQIAxenAEzE9R4jw9R6U/s87228rjZb
 PbcY26sujd90bDuTTqfR1VtPzvoeMmdkWL3/eeqWiLyFM2Ya1GubvjgcKnYz9P70kkOX33IkdAf
 XsgMA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Hello,

This small series adds a pinctrl setting for fast MMC bus clocks to the
pxav3 driver. On bus clocks above 100 MHz, driving the data pins at a
higher current helps maintain signal quality.

This series is related to Marvell PXA1908 SoC support merged into v6.17.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
Changes in v4:
- Address maintainer comments:
  - Fix if-else braces
- Rebase on v6.17-rc2
- Update trailers
- Link to v3: https://lore.kernel.org/r/20250806-pxav3-uhs-v3-0-2f03fee380b0@dujemihanovic.xyz

Changes in v3:
- Address maintainer comments:
  - Refactor driver patch
- Remove RFC tag
- Update trailers
- Link to v2: https://lore.kernel.org/r/20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz

Changes in v2:
- Address maintainer comments:
  - Newline between properties in if:
  - Don't try to lookup pinstates if pinctrl is NULL
  - Only change pinstates if both are valid
  - Replace dev_warn() with dev_dbg()
- Link to v1: https://lore.kernel.org/r/20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz

---
Duje Mihanović (2):
      dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
      mmc: sdhci-pxav3: add state_uhs pinctrl setting

 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 29 +++++++++++++--
 drivers/mmc/host/sdhci-pxav3.c                     | 41 +++++++++++++++++++++-
 2 files changed, 66 insertions(+), 4 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250718-pxav3-uhs-d956bfed13f0

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

