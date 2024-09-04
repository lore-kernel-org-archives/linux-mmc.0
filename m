Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5B17BEB0;
	Wed,  4 Sep 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492318; cv=none; b=kfpgP2oiH34UvT5lVWyOKFc2HqyBmyQ8zafr6QGbYxgPUJDI1EszMFalJvdsMfsTDey+nQWM3POMkiPjKg11Q7Oi3o/lMbr+Py8RcltWVqLOI48cBfxHbENh44cM1nazaRUcNI1o0eDdVBBhLrWEXZ74ZlGJHPckZng75hzsbzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492318; c=relaxed/simple;
	bh=JOtwCUsHturT3GYfq1u9F6XNRGtwqDO/DpXSsCdEdcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T53vNa0p6OJbRtt68w/wFNWauBN1rXOC/Yd3hVSNzOnw/YnOzgH3FCZA3RlF6eURX4gmhnlc5aljYEwkNueGd5F92f9pPuopKAFtDBGyYuvQ3qa335Vh4MOExspZEXAzFmzBiAwOXvI7WpV39BsHsHMJmgb7pkS9LZ3IkPoAUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=x4a0c2KP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x4a0c2KP"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 484NPD07058814;
	Wed, 4 Sep 2024 18:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725492313;
	bh=Z9CBaxb6BhlmpBQUMp/B5L+E8tinjVbta8DMrOc5DlM=;
	h=From:To:CC:Subject:Date;
	b=x4a0c2KP/qaMbQaxJ39zLiLhqBS3PzQYf7h5sZnF9NZcALaKHEqFD+hugaPHgIEqp
	 r2kwIsJ0zYmlKdsHuqCtJ7TUrGQL65G8HvFX6OmSL29gUXMByPjtf+c9aX3F5tVOvN
	 267EtjGR5iy/b0CGFRZt8nXzjAcfZKZ6t7fi7jV8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 484NPDp5000875
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Sep 2024 18:25:13 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 18:25:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 18:25:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484NPD9N003973;
	Wed, 4 Sep 2024 18:25:13 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] Add retry tuning sequence
Date: Wed, 4 Sep 2024 18:25:10 -0500
Message-ID: <20240904232512.830778-1-jm@ti.com>
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

Changes since v3:
- Fix compile warnings

link to v1:
https://lore.kernel.org/linux-mmc/20240815201542.421653-1-jm@ti.com
link to v2:
https://lore.kernel.org/linux-mmc/20240821192435.1619271-1-jm@ti.com
link to v3:
https://lore.kernel.org/linux-mmc/20240826210454.3928033-1-jm@ti.com/

Judith Mendez (2):
  mmc: sdhci_am654: Add retry tuning
  mmc: sdhci_am654: Add prints to tuning algorithm

 drivers/mmc/host/sdhci_am654.c | 54 +++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 11 deletions(-)

-- 
2.46.0

