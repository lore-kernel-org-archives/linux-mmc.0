Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F418E20;
	Fri, 18 Jul 2025 21:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873211; cv=none; b=sBu2lsjoly8pE3v+hVIdcQYc2pWSRjJNN3snsoWTXJpBldg6n3kFUJ9dzPYiAFNOtXNTcz412L6ZOROF5kJguAJJmQqjCfgTlhN9YDLK2m9bgzjiAFFZzIvDvLHrox7xzAaCyMSiQ02zrtX+Wov91nqjyO0rC4JCEp/V1N/3UUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873211; c=relaxed/simple;
	bh=wgoMK2L/RCBs8zdhzxyuzklUZpBH98194Fs6KY5ehK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a6e66jy87qKdpwH1hI9crKOoXk+2c4YX+VvsJPOMLJbKnR/WJVOFX9gDjwxmwTg+yW+aS/7M44fIpgrZ2yhocisunJrRRhJvT0QtAExETu+ypHTpIFZiDXeqgZ9aBryM/koJVtShM693vtLgoAk+sHtkguJ2Uv1L3/55RQGAiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=QxufMW18; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="QxufMW18"
DKIM-Signature: a=rsa-sha256; bh=EvoIQyY24ZpCCLLhJ5n7Fa8bgfcoLCuVdo6XvBEe5QM=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1752873184; v=1; x=1753305184;
 b=QxufMW18Y46MpZ4p0U07EcppebLZCyZ6p9NKwwiBGNP3WoOb0sM+0fVEk36UV98xHCh1eUKx
 QU5KCiwncmwCFfoxJ0zKktXXDUTUbUVDILlJsrurtPxDummmdIxbo9I/wDWYzTsjyc6X5a+4umw
 wXjrc8hQ2fdHhnhkeitnnSeAb9fNHGvbuf96MxAkYlL1Ai7mcrG0pSaG4CLUNa2WrB9UtEEzCXi
 QPobOaHrCZV/d3EDEffBoMlKsfDyWTs5y0EOVkeS0IRHIMln2QelR9xMGQmTAp13h/LbQddrw4l
 lCNwLyfCSukRnxemGOZM7mS4dHMldxdb84XKkuXu5K8yw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 3c867c5d; Fri, 18 Jul 2025 23:13:04 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH RFC 0/2] mmc: sdhci-pxav3: pinctrl setting for fast bus
 clocks
Date: Fri, 18 Jul 2025 23:12:37 +0200
Message-Id: <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMW4emgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0ML3YKKxDJj3dKMYt0US1OzpLTUFEPjNAMloPqCotS0zAqwWdFKQW7
 OSrG1tQDf1EHsYAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=wgoMK2L/RCBs8zdhzxyuzklUZpBH98194Fs6KY5ehK4=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlVO+57Trv2wb7w5x4+rwniL39YXK2pFrRy3rPmfIDmo
 cpnRs16HaUsDGJcDLJiiiy5/x2v8X4W2bo9e5kBzBxWJpAhDFycAjARvk0M/2wO7po4Z9rmJ/8n
 7G3uUPfr0WQ9dnfF0Z2FGzVi9eas7O9iZLi7g/vIjeOzoyWTVves3VG6Y5GB3NnVu3IndqqvtP6
 qKcwDAA==
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
Duje Mihanović (2):
      dt-bindings: mmc: sdhci-pxa: add state_uhs pinctrl
      mmc: sdhci-pxav3: add state_uhs pinctrl setting

 .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 45 +++++++++++++++++-----
 drivers/mmc/host/sdhci-pxav3.c                     | 30 ++++++++++++++-
 include/linux/platform_data/pxa_sdhci.h            |  7 ++++
 3 files changed, 71 insertions(+), 11 deletions(-)
---
base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911
change-id: 20250718-pxav3-uhs-d956bfed13f0

Best regards,
-- 
Duje Mihanović <duje@dujemihanovic.xyz>

