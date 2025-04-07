Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F623A6
	for <linux-mmc@vger.kernel.org>; Mon,  7 Apr 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014803; cv=none; b=AOIlPoc2pm6j8mDsDconN8DnpBlejmMhLflsjyBB8EKwjaERN0l2QJzrt7bA2P4kz6/YnX9AhZIlQiMwDpyQNya40u7rkjhKW5hNufgdkDujpzlBfbzIa6MlXLPwgx1xIkSmlYcxpSDnn43Ii4RXhlSfIZ28u4cQf6C1SKk7sXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014803; c=relaxed/simple;
	bh=6t6QNAyI577LpEQPqYiex0iX+hhdoQeCKZLha2Z7NlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdffkihOAB/yblt8uBfL072RUtEpbaTgO6O0ygf+s2di/BGlQSxgoy36DZh6aR4+5pwxaUW/rgtJRWJRrlFN5fV3Fz9YAvagG5zE5EiUEtMBYVli83EyclqJL3czjZ7+lk1KTyk1984R+Jv0frTZCLgw3x/FFvD3CAy0w2/C62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=bkNW/Qkv; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="bkNW/Qkv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1744014801; x=1775550801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6t6QNAyI577LpEQPqYiex0iX+hhdoQeCKZLha2Z7NlU=;
  b=bkNW/QkvOBRH1wIgpOdrF2JDFb9wXinaIVXh/vyz0EO4GyxIMieT/bJg
   EFD8ZGw9vmv2DaxWpw2rnEDwjlEGHBRHybb2mXRe/D88HsP8KszXKjWEe
   HqY5i5UPmzPc0KoH9aBPHylDhS8+oiPkZywNUUy2xhAsPIYPayMwEsuxm
   vKa3GEAVUfeG/aF2zAUD4WqwIS0cYHXwkIeLMBS8OGD0apoQ3f7uBXBem
   Qv4weLkDE6721EPxBsu+ZrCIrI2cpMciuQVxp/rTSIXabjhUKaejAUU0g
   J348zidz13w0amlTdcw6qUmHf63Y+IPb9t0sXUpuNcTnKUmAH9Us1RxHv
   A==;
X-CSE-ConnectionGUID: lTJV7pDjRNmYFoU64HxIfg==
X-CSE-MsgGUID: iwwOzQAaQuqMN9coflDFKQ==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="74116701"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2025 16:33:06 +0800
IronPort-SDR: 67f37fc3_bkfPKpbJG9aBSf4OW7zrXplffbgSlzmLBrpX7KeqpFxzDnQ
 x1wQlFcXl9sAzkULMHZBqu2d5UL9uKveLwWohtg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 00:33:23 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2025 01:33:05 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 00/10]  mmc-utils: Secure Write Protect Mode Enhancements
Date: Mon,  7 Apr 2025 11:28:23 +0300
Message-Id: <20250407082833.108616-1-avri.altman@sandisk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces secure write protect mode functionality.
The first six patches are cleanups, while the last four patches add
support for various aspects of secure write protect mode.

It essentially adds the last 2 missing RPMB operations: Authenticated
Device Configuration read and write requests.


Avri Altman (10):
  mmc-utils: Initialize RPMB frame_out structures to zero
  mmc-utils: Reduce scope of nargs for RPMB commands
  mmc-utils: Pack rpmb_frame structure to avoid padding bytes
  mmc-utils: Add byte offset comments to rpmb_frame structure
  mmc-utils: Add SECURE_WP_INFO field in ext_csd register
  mmc-utils: Refactor RPMB key handling into a separate function
  mmc-utils: Add secure write-protect mode enable/disable
  mmc-utils: Enable/Disable write protect
  mmc-utils: Secure Write Protect Mode Read
  mmc-utils: Doc: new secure write protect commands

 docs/HOWTO.rst |  14 ++
 mmc.1          |  39 +++++
 mmc.c          |  62 +++++++-
 mmc.h          |   1 +
 mmc_cmds.c     | 379 ++++++++++++++++++++++++++++++++++++-------------
 mmc_cmds.h     |   5 +
 6 files changed, 398 insertions(+), 102 deletions(-)

-- 
2.25.1

