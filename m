Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6713210F
	for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228359; cv=none; b=WQLU8/ibFvYH4uPL07TPDbj2RwOQPQbhaAoJ+dVtPW/JxN5isBqcmPhZpckBx1nkLxCqAD/Sy3b15uloN/Zh/23AFuFiZM+7JA7uYoY1jZLbzyye/Tj1Txo/IMrvd85l46hBhzxhlHm9u7ED9Zg5wSQK6s606jfh1SKvE2L2nm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228359; c=relaxed/simple;
	bh=Sis22ELjzPwmPuk4d2xgE86eci0pvQ/cxuvtiNG0wyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BS4Z/O8cUT8qvVIn62S3T6LES3TWeLHV6bWo7qEJq00ec0iq5vxQWFSi4nYfqW+v+KpyQR+REVS/LgjBkVzhxwIirp8WBRn69u0Q0khOthrHnteqomHb2nkrMtoivakDlICQ1V3Nao1ZvEK/cW2MWpV97m69Ope08brEnwAnlV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HxnFnj0W; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HxnFnj0W"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719228357; x=1750764357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sis22ELjzPwmPuk4d2xgE86eci0pvQ/cxuvtiNG0wyY=;
  b=HxnFnj0W6+QsFrp/Y0v42N7e2DeZu2p2HW5neeaIGY6+CX4E7ApXuS3r
   GAf/uX2aVCCqRX6Ll+4Tlctj7gDm8JSAaaORWx/be2jplkt+EOteEbWPN
   U0hLWlBlQt05Brr+N82CxDnI/2aqFI9xwWBS2rul8zYcqpbaKe+/KzslK
   r/IDh576ud/ZZzxB1+humaAFAExbNvdwq3A7eAVZ4RN1e5WAnQkXf05I9
   F44SBOcyATbdmMUfd8Dm/yCDxn8tCY9M8/VHw5tD9ZVS6Ox/vCH8wy6RO
   vZ/NX/IsZAN1Jjhd6lV4fIW3J+3dOe5R5hUX1QmMXbFlvQYWy3cpjIJJH
   Q==;
X-CSE-ConnectionGUID: LC4aEYxjTs+3iNM9gtfSXg==
X-CSE-MsgGUID: dUTCn2CyQzWGkIE3DEp5aQ==
X-IronPort-AV: E=Sophos;i="6.08,261,1712592000"; 
   d="scan'208";a="19566379"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2024 19:25:56 +0800
IronPort-SDR: 667949ff_kJfDwhV5c+kEOQr5mMo5WdCPkzEidjFfIBkNCFR68zycVem
 1/A4TGAkVmWxJF4sHOHm9qrLuYo7tHy2HUDYaXg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2024 03:27:12 -0700
WDCIronportException: Internal
Received: from bxygm33.ad.shared ([10.45.31.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2024 04:25:55 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 0/2] mmc-utils: Elaborate Documentation
Date: Mon, 24 Jun 2024 14:25:40 +0300
Message-ID: <20240624112542.25657-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is an elaboration of documentations to pair up with the recent
addition of mmc-utils man page. It adds a public page:
https://mmc-utils.readthedocs.io/en/latest/.

Shamefully, I recently became aware that Marcus Folkesson already added
a man page quite some time ago, so this time I double-checked that
Read-the-Docs doesn't already have a mmc-utils page.

One thing that can greatly improve this page is an "examples" section.
A good practice would be for field application and validation engineers
that uses the tool daily to share their use-cases and practice.

Keeping the documentation page updated, I created a github repo to
mirror mmc-utils official repo and can be imported and re-built - 
https://github.com/avri-altman-wdc/mmc-utils.

Avri Altman (2):
  mmc-utils: Add documentation section
  mmc-utils: Add Read-the-Docs configuration

 .gitignore            |  1 +
 .readthedocs.yaml     | 17 ++++++++++
 Makefile              |  5 +++
 README                |  6 +++-
 docs/HOWTO.rst        | 67 ++++++++++++++++++++++++++++++++++++++
 docs/Makefile         | 20 ++++++++++++
 docs/README.rst       | 76 +++++++++++++++++++++++++++++++++++++++++++
 docs/conf.py          | 53 ++++++++++++++++++++++++++++++
 docs/index.rst        | 17 ++++++++++
 docs/requirements.txt |  2 ++
 10 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 .readthedocs.yaml
 create mode 100644 docs/HOWTO.rst
 create mode 100644 docs/Makefile
 create mode 100644 docs/README.rst
 create mode 100644 docs/conf.py
 create mode 100644 docs/index.rst
 create mode 100644 docs/requirements.txt

-- 
2.34.1

