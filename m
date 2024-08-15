Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27E38DF2;
	Thu, 15 Aug 2024 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752947; cv=none; b=VjrtClvt29iJ69dnC/Y6klSD1dAxOdfmR/L3GJQ5kTMJsKdz9YO1e/MglO6qwVZ+htKuf9CS2gQgjVfjY5lQIeb9WE86WZZiIORTRTrli0Jtmw19k2BpmmjRP2aOqtB3KmT5vo35gv/ioEQcs8aZxwxcofjdmdEEhEsOuI84w8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752947; c=relaxed/simple;
	bh=gZOr70stSZcCpNwZJ0lX7VGiCGhIo4wCcO9paRQ6hsc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o37AGfUFcFCXS29vKsL/b3Urt+Proe7qxD6D0vlHgErTO+aJ0+1Ry1px9UBpgyANjtUKVqH291xyOPZSWqPhzS7ELMka3HQWCSb4R1yhBrlFuQ0RIFuKrgJPDGbJ21qwsfXCWB17eU3xwGgHB7lAGgiTTW5/WwhekszP4SWOxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iZ/5vnpK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iZ/5vnpK"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKFg33128456;
	Thu, 15 Aug 2024 15:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723752942;
	bh=wBSA03Z30RZrJkCn6j0lDvWqq+RHpOsrTZYZNto2U8c=;
	h=From:To:CC:Subject:Date;
	b=iZ/5vnpKbEYPsO/bFb4FGRJ5wmY726aV3Oc9O3m4YGmK0aPNzxFszyA9XnVkpFlGp
	 IrXCCejI5Nog1bsi+jP5pHx383OZDE2e0nOBqW/s7KcZQD+5r0myTb9Ol07fbypBK5
	 9yY9leVI/iB6SlC0Zju8lLlx6lqYVMEnJ4RsaDwY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKFgd9113238
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:15:42 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:15:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:15:42 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKFgoi018925;
	Thu, 15 Aug 2024 15:15:42 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add retry tuning sequence
Date: Thu, 15 Aug 2024 15:15:40 -0500
Message-ID: <20240815201542.421653-1-jm@ti.com>
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

Due to the same issue above, add debug prints to make debugging
these corner-cases easier.

Judith Mendez (2):
  mmc: sdhci_am654: Add retry tuning
  mmc: sdhci_am654: Add tuning debug prints

 drivers/mmc/host/sdhci_am654.c | 35 +++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
2.46.0

