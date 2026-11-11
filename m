Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398978;
	b=b8lQuovkiyaVQUbiZqRDJKnT04vMKwYiqynd/cDJ3d6ZgwCNw0Ljd271uNREPIqbY/nq
	 zj2Bb8C3gecNqo3GCpogxx/8SBMBfRo0x2IyuW2CKT88pWfBk1rF/ueMbrMy0Ok5NUV6S
	 MEMrTY2zYbgu3zL+R9G3WtKgwru96reFtUbDqZnROLWLyVlkr4VgiPNJlehbSpbZ77qp8
	 Y1RdAsz/v48ISu1TuDpYepOZCgfFCU+oUSuLMXsPIhkY082dlmuMhIgZA3Z2upEPPb+VH
	 Wq34oe4bFHOGhNPytFg9GPk+Wduau1y5rJkiH5MeYeoHLHDG0DNikER3arjQVzqGajA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398978;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID;
	bh=9Zel7mapNneHNU1zsFcA6/Cil5Rqn8iobmE7NXg3s0g=;
	b=NiE607jZFiMfb8PQX+cedis14anTqRiM3pH/vQoAq30nZ4TloulUTKGMa3oeuf1IJPuQ
	 WnCNOBVFG7vvBzEKOujsJ9RQliHzQKYDbcnSxb9JfFMb65tcTJazl8j6e0nW/jqEdRk+7
	 5k/SvJnfYqtZIirSHsqaaBKtvV/YWnqkQv70nUPwcKK9Cx1TzIbfZPMVjdYBxMn+XSmpy
	 VTmZEflp5GqRdoRwYdAXL+BEYB5a2TF9zHn+h83CeCcqQl0GMa6Xf7dLlPQxG7oHGJOxQ
	 jqSPgiIvYQi75rxUvllKVyVJvXmzuNuRkcdmeRMrvlhm7BaszIfjvBaKtPsAUizJMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=TrB+SeYv;
	arc=none smtp.remote-ip=185.136.64.226
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC4606A32D
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9FC4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=TrB+SeYv
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20261111120927ff91cceaeb0002070a
        for <linux-mmc@vger.kernel.org>;
        Wed, 11 Nov 2026 13:09:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9Zel7mapNneHNU1zsFcA6/Cil5Rqn8iobmE7NXg3s0g=;
 b=TrB+SeYviLzQFkrb6weJdov/oWLhJArf3B/HcX1Xa22s9dHv7ZjpsTcGoLB4p1jwDriJHJ
 bdtp0J8uvxUSc/tfkv8BOJYy1gp1p8c9canfXMMiJ7dD0AlTlCbWGI0sbSZynFSLcojCtR15
 qAqgc5W9QBkqJb4bZ1HtSq/KOJlk3xdnadw+9HI4c72ciXDxEPyg8qqGwF1RLkZaZC24ptRH
 HnXF1XwFK8t4zt9zN6ZxQVA11hCOi1UYbvTF8T+bhbBaRiK+rZclNtWi3pTRZKQU3fiVhu4a
 m5XA8rmqzm4Mxi+XCcq+rIOS3u6nkF8ZXHeJmaesET8Ft1hIG/AsZPeQ==;
From: Michael Haener <michael.haener@siemens.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Luke Wang <ziniu.wang_1@nxp.com>,
	Michael Haener <michael.haener@siemens.com>
Subject: [PATCH 0/2] mmc: speed up secure erase on ISSI IS22TF128G eMMC
Date: Wed, 11 Nov 2026 13:07:57 +0100
Message-Id: <20261111120759.100830-1-michael.haener@siemens.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

Secure erasing a 33.5GiB partition on an ISSI IS22TF128G eMMC (NXP
i.MX8, sdhci-esdhc-imx) takes 5-7 hours, because the request is split
into roughly 10000 max_discard sized secure erase commands, each with a
large fixed overhead.

Patch 1 adds the card to MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME, which
brings the same operation down to about 6 minutes. It is tagged for
stable.

Patch 2 is hardening for the quirk: with qty no longer bound by
max_busy_timeout, the 32-bit erase timeout calculation can overflow for
cards with large ERASE_TIMEOUT_MULT * SEC_ERASE_MULT. None of the
currently quirked cards reach that limit (the ISSI card is at about
half of it), so it is not tagged for stable.

Michael Haener (2):
  mmc: add ISSI IS22TF128G to fixed secure erase time quirk
  mmc: core: saturate erase timeout instead of overflowing

 drivers/mmc/core/card.h   |  1 +
 drivers/mmc/core/core.c   | 19 ++++++++++++++-----
 drivers/mmc/core/quirks.h |  9 +++++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.56.0

