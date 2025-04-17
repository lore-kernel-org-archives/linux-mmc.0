Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB260259CB9;
	Thu, 17 Apr 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914427; cv=none; b=ncPnUpK85J3NrnT1oirWAZTNKH584wV/96/hUoVl0RRywQqoPrPO63Zd2JhzYm87b6PWiQZCA2VV2t3TNUD3g7yAUGi2nkijuhYgNwW8bEmhDoX73Bi+5w3ApihDnZv0m5tywSR4UxUj3cGqyan1/+UHhRultGv0N2us5JsC0CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914427; c=relaxed/simple;
	bh=Tmk+mzEJSq3mj2aUVGUL+sKaA99E1w6Lryap8wVtALs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y7zphvWR/4RVCD1AgarMSlqBVv04nqKN4S/eFxdOTOMvWUmtnDkKdragyPsQupuR3C66/Ti4NvmIEyJOej46FmlPLUlM20r4FhawH6e3F6vwQWW9vkVQ8lky47SALLDCh+X++SfSRlS4c/AuThldO7JNL60TMrs6cGwpnVAxwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u98Q6GXQ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u98Q6GXQ"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HIQqBi082707
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744914412;
	bh=o5fcwYiVSrfnvYIPjwZFdGzKvA+Rhq/XfUgxUYDtTFs=;
	h=From:To:CC:Subject:Date;
	b=u98Q6GXQtX/VUJBQxXjKzS3j2CJL5fL2JaJY/f9LePPiCwGF0aw0exUeDT4PJHLqB
	 eMWYodLZaH4SV0Q9yaf4VHcbGf+kMvkWZx8qcHnVQ0d0hri5bA/q/VLsehPh34qKOB
	 jeOeGE9RYIc/PIF5bPPUmwVf+f+Zk7PBJ5akPkUM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HIQqXF062730
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 13:26:52 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 13:26:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 13:26:52 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HIQqh5078217;
	Thu, 17 Apr 2025 13:26:52 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>
Subject: [PATCH v2 0/2] Fix V1P8_SIGNAL_ENA
Date: Thu, 17 Apr 2025 13:26:50 -0500
Message-ID: <20250417182652.3521104-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There are eMMC boot failures seen with V1P8_SIGNAL_ENA on Kingston
eMMC and variouse types of SD cards on Sitara K3 SoCs due to the
sequencing when enumerating to HS200 mode. Since V1P8_SIGNAL_ENA is
optional for eMMC, do not set V1P8_SIGNAL_ENA by default for eMMC.
For SD cards we shall parse DT for ti,suppress-v1p8-ena property
to determine whether to apply the quirk.

This fix was previously merged in the kernel, but was reverted due
to the "heuristics for enabling the quirk"[0]. This issue is adressed
in this patch series by adding optional ti,suppress-v1p8-ena DT property
to apply the quirk for SD.

Changes since v1:
- Drop patch for High_Speed_ENA
- Add ti,suppress-v1p8-ena for SD cards
- Add binding patch for ti,suppress-v1p8-ena
- Update cover-letter/patch descriptions according to new changes

[0] https://lore.kernel.org/linux-mmc/20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com/

Judith Mendez (2):
  mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
  dt-bindings: mmc: sdhci-am654: Add ti,suppress-v1p8-ena

 .../devicetree/bindings/mmc/sdhci-am654.yaml  |  5 +++
 drivers/mmc/host/sdhci_am654.c                | 32 +++++++++++++++++++
 2 files changed, 37 insertions(+)

-- 
2.49.0

