Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7113A87A;
	Mon, 26 Aug 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706300; cv=none; b=X30MWgBZGtMcp7pQCStMJDOBQRjr4uqHJzTyWAXt4Orrb+Coi7ckmtI0Y40aFgnevWk8yBqLN5uKXYAHyCWb0d/2cWbVNf3Scp7bwiCeBo2VOtwfkciar/RfcPUhruQly/oHBJ4pRrHxi4yxvz4anxaCOxgEiLyK2vQVvGTw7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706300; c=relaxed/simple;
	bh=R9uLlhL/QJEfx9rXtl1B/tB/67HRfRDUS4gVLh6qgqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBuKRYo/zc5J5Qd7dhojK9c0BxAVXXOYx4c4XacW4DsHDeTGFGjqnuvaX/ztyRZ8HGLIImZxh6HvRJD/Mbhpj19WZifXwK/H1gtzvlUyawGZA88gMGZq7r+HG/gNYLjOg/OFd8s/53KOLieklIidiRjvTdcaTuUG2Gnn3WbrYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jM5zt9Uk; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jM5zt9Uk"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QL4tAC091840;
	Mon, 26 Aug 2024 16:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724706295;
	bh=/6K4TEyQTNUDOlIhMUrdVD+3bayAzvVcz0txO3nguNU=;
	h=From:To:CC:Subject:Date;
	b=jM5zt9Ukz49XUKoBBpTHyppEiHVOBpOymPjgc0qGpfpQTHBEBWkQ3CUlE+m7Zjx42
	 NSzq31gvWQ2iukyb+3rHWCs4pnTkmn9bKApu+nd+nJiO0OqhVTw1/bQhu23QBrxXlW
	 i0aX4h9EUkA4LGzbBS3wuvFkiBsiLVMs+XMQ46g4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QL4tc4027350
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 16:04:55 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 16:04:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 16:04:54 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QL4sZU089210;
	Mon, 26 Aug 2024 16:04:54 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add retry tuning sequence
Date: Mon, 26 Aug 2024 16:04:52 -0500
Message-ID: <20240826210454.3928033-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Due to failures to find failing region issues seen on some
boards, add retry tuning sequence to make the tuning algorithm
more robust. The tuning algorithm will re-execute up to 10
times if there is no failing or passing itapdly.

Due to the same issue above, add prints to the tuning algorithm
to make debugging these corner-cases easier.

Changes since v2:
- Use do while loop instead of while in patch 1/2
- Move initialization of tuning_loop to sdhci_am654_init
- Separate error path in patch 1/2
- Move struct *dev = mmc_dev() to patch 2/2

link to v1:
https://lore.kernel.org/linux-mmc/20240815201542.421653-1-jm@ti.com
link to v2:
https://lore.kernel.org/linux-mmc/20240821192435.1619271-1-jm@ti.com

Judith Mendez (2):
  mmc: sdhci_am654: Add retry tuning
  mmc: sdhci_am654: Add prints to tuning algorithm

 drivers/mmc/host/sdhci_am654.c | 54 +++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 11 deletions(-)


base-commit: 538076ce6b8dfe5e8e8d9d250298030f165d8457
-- 
2.46.0

