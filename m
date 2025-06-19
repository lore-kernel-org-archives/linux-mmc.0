Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42728A1F8
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323819; cv=none; b=rbGqW++cudsYkT1PCuwzIy73STOGC/OKTTYh9I4AAS+JrwpxCnAwww/qhHys0WdlqM6FyCmIy+lb1/oEHQGZA+RL96HtlbE9yMv4Ojjqcb6q25XS+cPj48YKZbthqi6nNCME/vodmzXtMe7RhjGXtm2cNEdkDr/XznG+WDSSwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323819; c=relaxed/simple;
	bh=yNEPU1S/bdZoR4vLQduYuFl/vEFuKDDk8Eg346KjKHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mT0WfAuvOGUb/4+9GrsbxijMuPT+zjcLq0fVVqog4RCS6agK4u3orfnFcZSRI91xQnIWZRM53NkfMwaPmLqnQfC64EC9K/pBZCnDMeYz8zov7ulAjIp5Ou5V1lRZm8QNjFKhhPc+K+tTtvL6+E2EJmN5WWY2YpELJhLZkp+dGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=GstEpcqU; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="GstEpcqU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1750323817; x=1781859817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yNEPU1S/bdZoR4vLQduYuFl/vEFuKDDk8Eg346KjKHs=;
  b=GstEpcqU+sQHGD8VIQy8AnNvYV0m5MEyyzlUPtbzyjb5oyX+BIO5H50r
   Zf2HyPaURY5yeOy3bzCTKfgRTEZSiL+F7RLWI3MAGjG9a40DlLdjm8pXo
   yLsEtU9au+QP6x5lzipLN889VAou8GLxHs3Xkcd4M4hQH2Pkl58VbDqd0
   tKaN6Uxp4yewlmw55RsHGwrXDlhzXISE+uTT4dsFP9w7JOekxoLD0WZdB
   4CxQuIBwwSet4HamSPLDg9VIgpxIU98InVj7qgx2BgBJ2k3VHzsASdMpP
   QTN/5GoTKzhuPH4Fomg6iM5dZM0Dm25k/17fFFF66h+fEejRgu1fzmFQS
   g==;
X-CSE-ConnectionGUID: iBkuH7xZSySAGmQsDnBvlg==
X-CSE-MsgGUID: tUelXmNxQtuRkQd42ZTIxg==
X-IronPort-AV: E=Sophos;i="6.16,248,1744041600"; 
   d="scan'208";a="84859486"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2025 17:03:31 +0800
IronPort-SDR: 6853c3ed_DTLRR5Up+UXBZt1H5jiIOFTqmApPh2c9uLiEbSnuzwLjIsa
 NMr5szGdysBhX3x0LGer4AcCCPqoFKobpIdsMaw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 01:01:49 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2025 02:03:30 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Sarthak Garg <quic_sartgarg@quicinc.com>,
	Abraham Bachrach <abe@skydio.com>,
	Prathamesh Shete <pshete@nvidia.com>,
	Bibek Basu <bbasu@nvidia.com>,
	Sagiv Aharonoff <saharonoff@nvidia.com>,
	Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 0/2] mmc: Fix max current limit handling for SD cards
Date: Thu, 19 Jun 2025 11:56:18 +0300
Message-Id: <20250619085620.144181-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series addresses a long-standing issue in the mmc driver regarding
the setting of the maximum current limit for SD cards.

The current implementation, which dates back nearly a decade,
misunderstood the intention of the SD specification. To be fair, the
relevant section of the spec is notoriously confusing and difficult to
interpret. As a result, the old code almost always limited cards to the
default low power setting of 0.72W, regardless of the card’s actual
capabilities.

With this change, we will now correctly set the maximum current limit,
allowing SD cards to receive enough power to operate at their true
potential and unleash their maximum performance.

Avri Altman (2):
  mmc: core sd: Simplify current limit logic for 200mA default
  mmc: core: sd: Fix and simplify SD card current limit handling

 drivers/mmc/core/sd.c    | 43 ++++++++++++++--------------------------
 include/linux/mmc/card.h |  7 -------
 2 files changed, 15 insertions(+), 35 deletions(-)

-- 
2.25.1

