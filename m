Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC768836
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843691; cv=none; b=OfyV0TBG+6mI6geZZXy/XxCkabdHmYu6ntHizTgkk2FlF8D+Dlxa1j9Mu4PGGaC6mDFug+J0/aQwpqKLJjIMWkBiz1ktYTBUT+gkrnuutqOkXE9eV2V0MpLWCqWWa6sJVhLtw7unPjTWVLVax5z49czzwUkE/uPdyOTBtPORqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843691; c=relaxed/simple;
	bh=j6U6vsHpRSnRETRgTvNlHJmExKFzWrBH1r/Ekel6Wxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Krto6rkHFookmetGE2Pyp2klVt0e+UD9uqARDh4wWYlFaR5GQTa5DBirOrmYnHY1HdBVIMkm14kqNtaZPHXoTkkyz7XKg1FDgC5kLNFIW/LmjNpLXhOOEU2JWT85gVsurjJukNJUsMLfZywDPYqJIK/Deyn9qnwEWSRDJDyeWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=SBtGzYWP; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="SBtGzYWP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1745843690; x=1777379690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j6U6vsHpRSnRETRgTvNlHJmExKFzWrBH1r/Ekel6Wxw=;
  b=SBtGzYWPhxScvofLawDvrnCysFAm7uWq+A1Z6ViHrMwL++AcqRLPM4H+
   y/uK8eMtrR5V2bPoc/Uhf5XPloCDqZWmpY+1bfxeg+LZi332vvRft02Rp
   OAqTFXsY5sm3nCRr4AKNrU0VJW0LQFZf6519qutx+4HkD7piDf56ik3/y
   hHo7D7/3TjKWCDgmujIgaNbgdSlmw6UkpDs72xZpu6t8W+6/56UoozVsr
   WDHwadrgCk/zvobGAdq7a8W4e5+H96HXdiGfYJ9UvfjTI4+2pHzDYlRlV
   pWT4TgEIfYQBHMOVwCMCumw0iY0vGwWz73v6KJNzQHjTTfdZYFHe3Zsi5
   w==;
X-CSE-ConnectionGUID: b30uymjjTCuxveaOW2QPqQ==
X-CSE-MsgGUID: YZNo5ScmTxm3Vyvsn0dKwg==
X-IronPort-AV: E=Sophos;i="6.15,246,1739808000"; 
   d="scan'208";a="79597944"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2025 20:34:44 +0800
IronPort-SDR: 680f67c3_D1o/nJcn9EP/n+1OQE4x2OPDkOEetheExn7N/gFUjbmBMTT
 FqOs2CeaZtZzCc9QRN9P74fSTJnSn+jZC5l4sig==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 04:34:27 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2025 05:34:43 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 0/4]  mmc-utils: Reuse the 'help' section for command usage handling
Date: Mon, 28 Apr 2025 15:29:47 +0300
Message-Id: <20250428122951.317055-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is this custom in mmc-utils that has existed since time
immemorial, to add a 'usage' print for each command, should it has been
called with invalid arguments etc. Nonetheless, the `help` field of the
`struct Command` exist for each command and is much more informative.
Let's use it instead of all those per-command usage prints.

Avri Altman (4):
  mmc-utils: Remove unused adv_help member from struct Command
  mmc-utils: Simplify and streamline print_help function
  mmc-utils: Introduce a generic print_usage function
  mmc-utils: Start to use the generic print_usage function

 mmc.c      |  98 ++++++++++---------------------------
 mmc_cmds.c | 139 ++++++++++++++++++++++++++++++-----------------------
 mmc_cmds.h |   4 ++
 3 files changed, 110 insertions(+), 131 deletions(-)

-- 
2.25.1

