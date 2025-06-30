Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95E19A2A3
	for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2025 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268273; cv=none; b=uHP4B5jhpJFgMzpkWnI/pe+vFvCMxNhBxxRAm8iKJ7zqaRy1o+dHXzrD1vOp3Tr2t4MA5fvSoqe4SUPaASNlWDrefGcKn9BfDvRjy2YzCbg9qT9LRTES9dRIGZ9A1QPMEFCzMKjiYzFoIVXU3keglFHw86laT+AVWWz9rw2Xo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268273; c=relaxed/simple;
	bh=OWrcL8ij4I5eq+sPspj9j6hgd019GvgIX3GwkQbvKgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=H3sZE3iAjsqdBN8fywyN4ZZdBoKIUMBLtXp3zV59OHKAFGzCuL8ijKlccDFsYt9E8LZh9wUkOBguhsrmeL/kf2YDKw4yskiWrm91CaTKOEsM5apKXSuAiAXkuGjSJpZqiC9nYBIBBhoz/0IWsSePQ135X3FyPrHUyB3UQF3Hn/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=FvrTSnVc; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="FvrTSnVc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751268271; x=1782804271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OWrcL8ij4I5eq+sPspj9j6hgd019GvgIX3GwkQbvKgg=;
  b=FvrTSnVcHUb/yg/ES85izsRwh/52SC8cX61BFYDvselVuv57NRM7jVWN
   Oc0oMGOGDii3B/R5wAUhL/8h4tE43EhP/bthj3ut9JzXrLkKwfWzfj9Wi
   9aj3QJEbSTsKBAUtkJrf1ixv6O0Y7YtJwz/u1h0qHwgpiqzE0i5AiEGTg
   ld3nTbKeU1xopxwmQPiT6D3Duo2ZSYIYoz1QIMftW18+ioJ3+9vFscciR
   rySDLxtRZ58VOKlmx++YzGdlL4+Yj/m9o4a6v+c+zo9PyC+M4VGouzCI7
   QObi6g/p9R811QUSCutvcuDSJHIKrTHCOUJFexq72ebH2fBHQAFYr8kwz
   g==;
X-CSE-ConnectionGUID: 35N908jpSTChLsvMGiynjA==
X-CSE-MsgGUID: WHBeJs2dTGGtVTBnrOuCsg==
X-IronPort-AV: E=Sophos;i="6.16,277,1744041600"; 
   d="scan'208";a="85476331"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jun 2025 15:24:25 +0800
IronPort-SDR: 68622d21_yIUSpZ8JBvL5sl61UwJ61Hcq+IU3R5KEjliVXzPTDujg2of
 93rhpgTdT/7g+5lj8BgDhLrqXbLKpXdIvSaNwBQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 23:22:26 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jun 2025 00:24:24 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH v2 0/3] mmc-utils: Improve version reporting
Date: Mon, 30 Jun 2025 10:24:17 +0300
Message-Id: <20250630072420.114967-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series improves version reporting in mmc-utils to make it easier
for users and developers to identify the exact build in use, which is
especially helpful for debugging and support—particularly since many
users run pre-built binaries.

These changes should make it easier to track and support mmc-utils
deployments in the field.

---
Changes since v1:
 - Add a 3rd patch to print the version at program start

Avri Altman (3):
  mmc-utils: Add option to print version
  mmc-utils: Makefile: Make version string to show commit date
  mmc-utils: mmc.c: Print version at program start

 Makefile |  4 +++-
 mmc.c    | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.34.1

