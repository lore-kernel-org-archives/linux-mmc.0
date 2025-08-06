Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1101C3027;
	Wed,  6 Aug 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754473471; cv=none; b=EgW9EF9IoVjiOqpUGr9xOw8BF4hFcHXgIz5dcPPFfo73RBj9ql3cpQeoZsCuCr1YjdaD0OaKQpJE9a+J9J8IsGaKrm78XwYic3z+gW0r4sZo8XRk/iwjvP8rkmSRJS0QYRNgUhpPffGSoMhJNKjjwYvLZP4jQF9KRlH9sHnA0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754473471; c=relaxed/simple;
	bh=FtOtGKaRTRC/oyJoG1gUBX7YVLK7Bsb9LiRigwuWFxU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vDjEKCVd9f7rK0NoVromzVZu3BrhC+nqTUeemgTFInyyimwajAePF6b8YCXkm0P/sH9AaZOyKjVZkji/Hcz7OL6oljfaf59ffY5wk7U2VcwG9fT2EhmmLabqa9tSpEUyaxdJ6814BmoIzCvg1pUigoD79s5bsXTuKW0rAKjQe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=EdB5gs+k; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="EdB5gs+k"
DKIM-Signature: a=rsa-sha256; bh=QHl8Wzj/uqBwnumJOCDGSmLhk5tflD1ODmw6Mh2NOQA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1754473444; v=1; x=1754905444;
 b=EdB5gs+knki6UTebyYR2nzHvmqostr4TTdljTpn8aTK97Wre0iNqiF+FpOogXJ3zgGAq34wo
 +uSxHp+XiM3+fr2BhFJCti2L0/aRG+lMs8hNzrqtpl8GphN5y8Pjf2EQBdLlsf3MHg/pHFZGX2a
 +tVtABKQEinprZywmBq4uDgKDc59982K273ooI+VsxkdDEUX9wLjaozT6ZA4r392vyvTMDGGzlS
 eUTlPg+ETrYnneZXqtJMvOcWwMVeCYzY6hEcBDuugBypml2IoA+4y12tIZH0+r+uRV76b4RSVw+
 7itUoDpXk/+E9vDHxmzqLEQvzSQFeLA1OTotWKnAOK2Kg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 400c2629; Wed, 06 Aug 2025 11:44:04 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH v3 0/2] mmc: sdhci-pxav3: pinctrl setting for fast bus
 clocks
Date: Wed, 06 Aug 2025 11:43:52 +0200
Message-Id: <20250806-pxav3-uhs-v3-0-2f03fee380b0@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANgjk2gC/23NQQ6CMBCF4auQrq3pFAroynsYF9hOZUykpJUGJ
 NzdwkYXLP+XyTczC+gJAztnM/MYKZDrUuSHjOm26R7IyaRmUkglKqh5PzYx50MbuDmp8m7RQG4
 FS/e9R0vjZl1vqVsKb+enjY6wrntKBC64xEKBVKUFW17M8MQXpecukj6O04etWpQ/oRbwL8gkN
 FaDLmStq2pXWJblCwwW+djsAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=FtOtGKaRTRC/oyJoG1gUBX7YVLK7Bsb9LiRigwuWFxU=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmTlR+zTjs1yzBaaOb75MJ/sm8P/D7q81v+/SfGGSEB1
 TcLw9fGdJSyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBEPlsxMuxX19se5cTAtTr7
 YKnZvYqny1/3Jl1gr7LpO+fca2rgcpzhr2igxuSuDek79ln/F98SdTRv0i9N42vbinZ9tbs69VS
 aGQ8A
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Hello,

This small series adds a pinctrl setting for fast MMC bus clocks to the
pxav3 driver. On bus clocks above 100 MHz, driving the data pins at a
higher current helps maintain signal quality.

This series is related to Marvell PXA1908 SoC support; the latest
version of that patchset (v16 as of now) can be found at
https://lore.kernel.org/20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
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

 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 47 +++++++++++++++++-----
 drivers/mmc/host/sdhci-pxav3.c                     | 40 +++++++++++++++++-
 2 files changed, 76 insertions(+), 11 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250718-pxav3-uhs-d956bfed13f0

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

