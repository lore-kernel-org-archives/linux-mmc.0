Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3726A095;
	Fri,  1 Aug 2025 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057690; cv=none; b=SVX6sB67d7iwHuhUztJqaaryCcSivrUKW+jUxOwEumbq6vaSAFXuq+hOy2W7L8zTvVO1Xjd3tmDEN3fVGnqoWVwZdG8ldlV1gSEHJQlUzrDQL1yWnL/DmD7ZV3u7mKeNcxYZ4cElTsb9Td/ExtY5ACJdL+06NZiwZBbxOCSeaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057690; c=relaxed/simple;
	bh=5LSakXMhRgZECB7vEp/4cohPbSrDyK93lA3vWzIivaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uyb8aAJ4Umj3yGBwAiU+3ghZEK2QEures9yl/MC6BuYc8Iu0DRW+fwGYx52qRPd2N/Smmfd21sI3t6MDoBtCAW5p5jBnDgmN9eaeBSU2zS20/C9NM5pPHNEG7FhGpfZ5FIsDgJJiXuo1CK0gHYHWNR6p4+Txu5IWgH9XPH45ZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=Y3PbJk9Y; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="Y3PbJk9Y"
DKIM-Signature: a=rsa-sha256; bh=y6QtmCaO8/r48Kdfs8oIgYVHptog7txRzNSieCu7rZA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754057669; v=1; x=1754489669;
 b=Y3PbJk9YGG3iEuwuu41fZDrB+wNpuy7p105l8d5Dv31akuCKvpFAlobvI0VQhqbeXqychovA
 ydUO3ebLmXzynQnRcD+OiyR3Z6saB+uljNpmVo2P9s6hbBZp6do2UNzy1W4QG7yavWnPPtn6FgW
 0k9+7hMq4I5OFzOllwAzWhiskZ8U0GhHbP1t7ONTzkKfHYySMaC6IYiD9eXUg3NSdu5t/E57sPw
 McY9endaen6QR+cNLOboWU8HfsTSO8KfgS8L5lPVK3WArEr25TJQFCEXYMEMqPNdO5PJNa9ANqH
 coAo5ErnqdCA8FJNIy0s483wdiC+9Lu2l52KteHIUSvuw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 0cca0676; Fri, 01 Aug 2025 16:14:29 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH RFC v2 0/2] mmc: sdhci-pxav3: pinctrl setting for fast bus
 clocks
Date: Fri, 01 Aug 2025 16:14:14 +0200
Message-Id: <20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALbLjGgC/22Oyw7CIBREf6W5azFABR8rExM/wK3popaLXBNLA
 5a0Nv13CWuXZ2ZyMgtEDIQRTtUCARNF8n0Guamgc23/REYmM0guFd+LAxumNtVsdJGZo9IPi0b
 UlkPeDwEtTcV1h9v1Ak0OHcWPD3PxJ1GqP6okGGcSd0pIpa2w+mzGF74pP/CJuu00f6FZ1/UHl
 cVdXq8AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=5LSakXMhRgZECB7vEp/4cohPbSrDyK93lA3vWzIivaY=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBk9p4/M5VkVv8TwRoDlv4WP/76S8siJ/V39Y4+Xt8g/x
 orzKRYVHaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjAR2WUM/50V3y1adrH+t7ND
 p2z9mY//pHiD+L+7TXA13FLRPMGzMYvhn1IP15T3s6V1V8n6H0k88fYCy/lStaqfTydcV7VUqvo
 rzAQA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Hello,

This small series adds a pinctrl setting for fast MMC bus clocks to the
pxav3 driver. On bus clocks above 100 MHz, driving the data pins at a
higher current helps maintain signal quality.

This series is related to Marvell PXA1908 SoC support; the latest
version of that patchset (v16 as of now) can be found at
https://lore.kernel.org/20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz

The series is RFC because of the following:
* I'm unsure whether setting pinctrl-{names,1} to true in the top level
  of the binding is correct.
* Other mainline MMC drivers select between default and UHS states based
  on the signal voltage. The PXA1908 vendor kernel does it based on the
  bus clock. I followed the vendor kernel, but do not know whether this
  is bad practice and therefore the other mainline drivers should be
  followed instead.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
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

 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 47 +++++++++++++++++-----
 drivers/mmc/host/sdhci-pxav3.c                     | 31 +++++++++++++-
 include/linux/platform_data/pxa_sdhci.h            |  7 ++++
 3 files changed, 74 insertions(+), 11 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250718-pxav3-uhs-d956bfed13f0

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

