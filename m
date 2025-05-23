Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24A293727;
	Fri, 23 May 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011642; cv=none; b=jrQTj6PMWrVVA6lcYF8QTyzasYFsvCj7zA8ucmeah2b3nSCgiYeMdOExeCBBhBHjyC42B2xl0oatR6cDaBb3Kmikkj1wvWaso3sgMRVSLbJSJcbShD8aBmF/KWT0i4GfUDnZ0Ej/Hk7JUoUidfDQUQ+Gvm/DuuoyNhyDrOz27+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011642; c=relaxed/simple;
	bh=i3t0IUDYdMqNRHkeuylaDNHAP+Nvjisva2/VRvRt8NE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nKsFvzKbX0BKSz8NwJ4fNwHHjvTHkb85szDCgsJeFMiqWqiKUFEaNUUYV+zGFnB8P47d7xBEVNJdsQZ8eVtIB9DYgu/wdPrSt+rXYt/hL9N8yQmfMTe4h+PTiS7OZk+yMtk90PuxEZ0OCgeWZXDnt2HCs3g6unQW7DdO1vyw4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id AA250343270;
	Fri, 23 May 2025 14:47:17 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 0/2] sdhci: spacemit: improvement of register defintion and
 HW busy detection
Date: Fri, 23 May 2025 22:46:30 +0800
Message-Id: <20250523-21-k1-sdhci-v1-0-9f293116a7e7@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEaKMGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyMjXSND3WxD3eKUjORM3WRLC/O0FDPzZAujNCWgjoKi1LTMCrBp0bG
 1tQBCyBmVXQAAAA==
X-Change-ID: 20250522-21-k1-sdhci-c987fd67c82f
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=823; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=i3t0IUDYdMqNRHkeuylaDNHAP+Nvjisva2/VRvRt8NE=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBoMIprnXU6M8hZdaqEj/WahC5VcqNKXc+m+8OvG
 VfgbLiDelqJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaDCKa18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277Y2oD/4p6d7BnMcHe4fkwD
 7FOKu/nNqIs/57gLLADV+70aYR6vLCA/AAvJTz9yiuhaCgWbn5gRJYijOm2/tCtcYz6f6+fJ8sy
 bbThP7wiS+5nXMDym0HewJibE/2uypcYqEi8SMIAJIVc4vnAh9PFLDQhGiqpMdlBLUCXnuJcwFC
 MLHEQDsBf3lR0Yuivx4aPHlHTD7dH1Xnm6cIuCdE588VueI6lPutST6f3uz5wIRJt1PczODZtd8
 QVzwAh7tFpOrosG2n+tOLXF3VMwBIz0WSiH7XGIKmrGhJNUZhD9WOSRz4ZxJJ2V1Utj+VP7IQoo
 bgJRIYeGqqN+TBG06QsCDArZx8doYOUyT3cB2pZwJiw4NhO35vmhyeL5yII252t2aavWsGRFD4P
 v/6Pjv4uwfvVgh2WWRjzsK5DVwa29nD7F1FVP+dWRe++3I8ClmNSa7eUduLM45YCVkzLRV6gwoS
 N/VdMfjdY2FxR2bRlgPRW8l/2fow1UN+f8G3+A4mjXWBepPjqWLEHTbYti/PDf1AbE4W+czBUjL
 ykj3Y1RfjlIKTrjsN94ketxjxqAXiNj+cHbT609lnePOc+R/Wmr+CT4Uu4Nak9k7QC8dUQbwvLL
 fynLNhak/Xlm00iENx1jp3+cb3pmp5hb3R2RHjlBYErD4Ul7FNETaqQBI2MvgFylK4bg==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

These series address two comments from Ulf during the review cycle
of version 2 [1].

- improve register/BITs definition to make them less generic
- drop MMC_CAP_WAIT_WHILE_BUSY flag to disable HW busy detection,
  this is tested on Bananapi-F3 board.

Link: https://lore.kernel.org/all/CAPDyKFoDWS6DWdKOaxTDEYeKv3hjVDoR7XGi19nESVssc-RG8g@mail.gmail.com/ [1]
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Yixun Lan (2):
      mmc: sdhci-of-k1: make register definition vendor specific
      mmc: sdhci-of-k1: disable HW busy detection

 drivers/mmc/host/sdhci-of-k1.c | 140 +++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 68 deletions(-)
---
base-commit: f7f05c5ea4af0f28cccfa49fe1af65e85dba5ef6
change-id: 20250522-21-k1-sdhci-c987fd67c82f

Best regards,
-- 
Yixun Lan

