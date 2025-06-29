Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3091E25E8
	for <linux-mmc@vger.kernel.org>; Sun, 29 Jun 2025 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751195207; cv=none; b=adqp0enZPcHcbbrUcPNKFUBQa/TKpU37dFHFjGahuvegBTOAprShhbH0yqQTiUmBSmmwAP0dtVZjfk7nZFrLAQFR5+7WrmMTMAQIEfw0+yxwCHk1jm89PT+eKyWM6awVXIHWEIM4x0fpS1w7SuoVJ/G1j1xaVPUMFnAfkiyZiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751195207; c=relaxed/simple;
	bh=uEP3bU7+blH7Agc262RuzQL7vLxDzdMwl4GsCIiOp04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XSS100DskW1NS2Yh5EKaE33QJA0cmSpnU/fazDdqXeyaYPWvWCw5EPG9sr0Aq3r36/FxrtQRztoHWJIreKvbHf0gPWx/jolMqAzYDVueuqELflWO0f5iCGMgMac5BmwfQX37/7N1wHlRIlk2slK7SPratUM50zYvIpUSG9hykUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=FdqshpI4; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="FdqshpI4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1751195205; x=1782731205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uEP3bU7+blH7Agc262RuzQL7vLxDzdMwl4GsCIiOp04=;
  b=FdqshpI4Ltx5aJvT7/b6DIFknb1HIJzUdLdzG/id+mCJ16Qy6zHMtzjh
   yxiuUhqH4Dus/TWaTVdNE6d2mXUsIe1ouz2W1PI1Kq+C7O40MrHpS3BaD
   kysvw7hrH9z6bGsp5g4c0ZMfqPvqJEVcpqOddbTtGRqlw38YosLMUTho6
   o6Tx0EsdYRN6fceZOTDaYz44fQjw5hNuoJfhKN59Q3htDu1+oupFb3M+G
   Dhv/9LIVrtdAzHU62qLwMNJeZTIfjMrMVQxYN6G6MG7rw92H4ewzg4CM+
   //HPb0sFWxq56HOjV8HFa96810DV9forHVrhfdTsB7YgkZx6KgA0WLtlz
   w==;
X-CSE-ConnectionGUID: ulykuJApQzG4MRFhHQgitA==
X-CSE-MsgGUID: 7xFYfzzQRBSqC9Od6nMrSQ==
X-IronPort-AV: E=Sophos;i="6.16,275,1744041600"; 
   d="scan'208";a="84921910"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2025 19:06:38 +0800
IronPort-SDR: 68610fb8_W5QjACd0PgqRSK8/yRSTTVa+tJfP+ONOLohkhhisVblB8qQ
 HpM8SP6luUPMuJygCAd0/y9a6bwy1uzSzUPBEIw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 03:04:40 -0700
WDCIronportException: Internal
Received: from unknown (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.49])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jun 2025 04:06:37 -0700
From: Avri Altman <avri.altman@sandisk.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Avri Altman <avri.altman@sandisk.com>
Subject: [PATCH 0/2] mmc-utils: Improve version reporting
Date: Sun, 29 Jun 2025 14:06:23 +0300
Message-Id: <20250629110625.112762-1-avri.altman@sandisk.com>
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

Avri Altman (2):
  mmc-utils: Add option to print version
  mmc-utils: Makefile: Make version string to show commit date

 Makefile | 4 +++-
 mmc.c    | 8 +++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.34.1

