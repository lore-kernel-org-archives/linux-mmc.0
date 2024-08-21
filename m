Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD216DC05;
	Wed, 21 Aug 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268280; cv=none; b=HS+pYwdRVWCcpASJ6G/RCZaL6ZQzO+YKOFgi3moF+q8E0GkhF73y73jyahFXZOC/JtDambhyQfziFCUmrgS7Pp9rnZKgJMo0syVL8tNlQyyrPei7nLNMzrrLAhlGyvG0ZaZYibTOjxzuPna7lWjWG0CAapFiQotQ5b0SmQd6GoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268280; c=relaxed/simple;
	bh=jW1SVmSq1KmIqnk1spm4tkWMsycpuAqxRaBDM54x2Y4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eMNYAfroPfdqmmNFkz837b/khhmoQJdDfIGBXI/lsyuD6O/NXrD5dCjawEKHtOXKV5UejtSzwlNS+GjLMWjQ/2RTz3T3DVW50hAfA4mY38OAiIr2c7gvA4jbQflo8ycbGM1ICo0Ug1T0l254l4EZPaVfFzBgJVgk7X+Ro0xbqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cCpjlf3D; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cCpjlf3D"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LJOZTe047919;
	Wed, 21 Aug 2024 14:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724268275;
	bh=Aac56d/iY/IMMEsCvkbysjGjI/E0HX+SRt6b1aEl6Rk=;
	h=From:To:CC:Subject:Date;
	b=cCpjlf3DoGQN2QA6oIC5OjKjF0RY8iCYAmK/aM9ro92wRMSzB2OsaDRp0J4qvXcvf
	 Is+qqzB6gxC5jCq257tT1eAjNu1PKHtowk66deu7X2A8Tta7FYGqH/hoOP8nwNlB+H
	 CR8lBgVqykHPS56GQKpOAGugo797nM7Bu9oFkZJ0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LJOZ4U019654
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 14:24:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 14:24:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 14:24:35 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LJOZqi057194;
	Wed, 21 Aug 2024 14:24:35 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Add retry tuning sequence
Date: Wed, 21 Aug 2024 14:24:33 -0500
Message-ID: <20240821192435.1619271-1-jm@ti.com>
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

Changes since v1:
- Change prints to dev_dbg
- Change logic in patch 1/2 from using recursive aproach
  to calling a function iteratively for retuning

link to v1:
https://lore.kernel.org/linux-mmc/20240815201542.421653-1-jm@ti.com

Judith Mendez (2):
  mmc: sdhci_am654: Add retry tuning
  mmc: sdhci_am654: Add prints to tuning algorithm

 drivers/mmc/host/sdhci_am654.c | 59 +++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 12 deletions(-)


base-commit: 538076ce6b8dfe5e8e8d9d250298030f165d8457
-- 
2.46.0

