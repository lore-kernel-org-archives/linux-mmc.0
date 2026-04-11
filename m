Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB473A1C9;
	Sat, 11 Apr 2026 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936613; cv=none; b=eU1kLYsLPngd/kBBGdeOUOYS49LlzrVYkjoFM5F6TTd49KJStB7d23CotVyVVwybhXhl9VFUZpg3jHWWOc9lbfKU3egIps3xisBAjsnHE++NvvXBn+F2ipGYZuFRjnT1fIVgx9G/r3N1Rcd1Wds4A4Yx5fqPDex6NKSkR8B/teE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936613; c=relaxed/simple;
	bh=kdtLt0sIFnS9aemgEyIS6/dpiMMai5WYKBOMGt2JlLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dnvM4RV7Ig2d+CZiE3UH0tYcP6OtL+FmJBjq31YXIwW0w172r6dWMYHc3T13TOEHvpl3ykSRjYKWpNh0Jx3GmbnWzq0ZXEp9V8DLKVpugf/RHHNi+WcuKsrDK6VaX0q/yA+oMM5/CdkVa0kox0DMajfKqfPztnBIhwDCaKGltBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iA4k1y7Y; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iA4k1y7Y"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 52ECF26133;
	Sat, 11 Apr 2026 21:43:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Ovi5p-igYB8; Sat, 11 Apr 2026 21:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775936602; bh=kdtLt0sIFnS9aemgEyIS6/dpiMMai5WYKBOMGt2JlLs=;
	h=From:Subject:Date:To:Cc;
	b=iA4k1y7YhuL84Z4G+wEFK04MYsquX4omy5llG5DYAzvtdVLSZCU5MTUxehhlBiO2W
	 wDrHCQNxQfaEaYfXYNasgiKiepFloRgxLYP7iL8MYnXLgCAiB9kzETp6nFdjFRyNw/
	 FzXs/QN8K0CuIQ/u0jXdpF5/jS9XlqKq+1OAOdE3GAOW9harWR8/GRyjPdq5NlKvnf
	 Ay9rG+nqR2EMvhxb5lNa4u24SFoBR8/kvB4GJvxUU2EWnANEHM2hoooRLMtGxht+pb
	 T7A9r51JsmYEr4ZQxJIecLjkpuy0dZ7nv2BGYHp/buN926E3X0VlLX/KMKVXq7DBA/
	 U2AqeHNbEwjfg==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/2] Configuring DMA threshold value for DW-MMC controllers
Date: Sun, 12 Apr 2026 01:13:13 +0530
Message-Id: <20260412-dwmmc-dma-thr-v1-0-75a2f658eee3@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFGk2mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mj3ZTy3Nxk3ZTcRN2SjCJdQwNLgxQLIwvT1ERzJaCegqLUtMwKsHn
 RsbW1AP9qgAdfAAAA
X-Change-ID: 20260412-dwmmc-dma-thr-1090d8285ea7
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

In Samsung Exynos 7870 devices with Broadcom Wi-Fi, it has been observed
that small sized DMA transfers are unreliable and are not written
properly, which renders the cache incoherent.

Experimental observations say that DMA transfer sizes of somewhere
around 64 to 512 are intolerable. We must thus implement a mechanism to
fall back to PIO transfer in this case. One such approach, which this
series implements is allowing the DMA transfer threshold, which is
already defined in the driver, to be configurable.

Note that this patch is likely to be labelled as a workaround. These
smaller transfers seem to be successful from downstream kernels,
however efforts to figure out how so went in vain. It is also very
possible that the downstream Broadcom Wi-Fi SDIO driver uses PIO
transfers as well.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (2):
      dt-bindings: mmc: dw-mshc-common: add option for configuring DMA threshold
      mmc: dw_mmc: implement option for configuring DMA threshold

 .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml          | 8 ++++++++
 drivers/mmc/host/dw_mmc.c                                         | 6 ++++--
 drivers/mmc/host/dw_mmc.h                                         | 1 +
 3 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260412-dwmmc-dma-thr-1090d8285ea7

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

