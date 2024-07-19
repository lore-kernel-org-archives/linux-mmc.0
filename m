Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285A46434;
	Fri, 19 Jul 2024 05:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367229; cv=none; b=DFvsDZZYRW0Rho5bVOd6LU5ANP+38B6sPgUUQdbN2hjN/63eXwSXAkJ5Nm4ODGAZpKOuaXMEGt6nWGdBZJPMJ7CO7jbFVvcbxFdwxu8UBiECDQgaKPJGK9RoSi1xuvcnB4NtQ5puY9XtwBznia2EnlfBJe/dQRooyQRHpWIWJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367229; c=relaxed/simple;
	bh=IXINu2CBzjud7p80mQWRPpw54y7xsaLZ0272piMASJo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H3a1IvLwovKWT/Q1uzdYHfDQ2PVZLQJXUGl6K3mZuctx8nvy+/KoC6HN99bwBWxJNdgrU7MS1LPtL7X73TDFdBdGzi9Q3Ldw5LhptB5MPdzFfSj/hd8Pxf1wTd4clfmZUqKRCg4XlfVvZjVnf3MGjAoakW1t7Evxg6MzupAm7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=F5cZU+8P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="F5cZU+8P"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J5XLzuC148356, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721367201; bh=IXINu2CBzjud7p80mQWRPpw54y7xsaLZ0272piMASJo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=F5cZU+8P2C8qkfWRyfrhOyQUv6Y+lo+RlmV7+2ChqoHC6Wq5xyoH9ZRS6H3/p+A2K
	 bXhx2RHyAF63pZYwo78xes0FdmB4EZ2DirpGCiZf5c84ChZ0aU8ARViJwIResSkVrR
	 mUjYIoF6i1hpckry3SLKrnPmqUvou6yA6lNstkaznuQgazjVtkqiYdYHFG066bVcD3
	 P8suTuGs+Et89gzRZ/TKVfxSQ1yZ0VUREoGV72XJ5wq97sw2zv/iykQ3HBW9wL3LCn
	 HZz4iPtw/BEfFTEea/mJjku3fefkgKcE84BRrWcG05WJfhvmYzFLjWO5xk71Oli6Gb
	 rSob1TUkMmsag==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J5XLzuC148356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 13:33:21 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 13:33:21 +0800
Received: from localhost (172.22.81.102) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 13:33:21 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <ricky_wu@realtek.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ricardo@marliere.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
Subject: [PATCH 0/4] Add support SDUC for Realtek card readers
Date: Fri, 19 Jul 2024 13:33:10 +0800
Message-ID: <20240719053314.1636649-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Summary:
this patch is for mmc to support SDUC(Secure Digital Ultra Capacity)
and add Realtek Cardreaders to support it 

About SDUC:
SDUC is defined in SD7.0 spec, it support the max capacity is 128TB[1]

Roughly implemented functions by this patch:
1.Mutual identification of SDUC in ACMD41 initialization (5.2.1[2])
2.SDUC card user area capacity calculation (5.2.2[2])
3.Memory read/write commands sequence (5.2.3[2])
4.Erase Commands Sequence (5.2.4[2])

patches:
patch#1: Defined functions and modified some type of parameter
patch#2: For mmc to support SDUC
patch#3: Add Realtek sdmmc host to support SDUC
patch#4: Add Realtek card readers to support SDUC 

Reference:
[1] SD Specifications Part 1 Physical Layer Specification Version 7.00
[2] SD Specifications SDUC Host Implementation Guideline Version 1.00

Ricky Wu(4):
 mmc: core: some definitions and type modifications for SDUC
 mmc: core: add SDUC init rw erase flow to mmc
 mmc: rtsx: make Realtek sdmmc to support SDUC
 misc: rtsx: add Realtek card readers to support SDUC

 drivers/misc/cardreader/rts5227.c |  1 +
 drivers/misc/cardreader/rts5228.c |  1 +
 drivers/misc/cardreader/rts5249.c |  1 +
 drivers/misc/cardreader/rts5260.c |  1 +
 drivers/misc/cardreader/rts5261.c |  1 +
 drivers/misc/cardreader/rts5264.c |  2 +-
 drivers/mmc/core/block.c          | 13 +++++++--
 drivers/mmc/core/bus.c            |  4 ++-
 drivers/mmc/core/card.h           |  3 ++
 drivers/mmc/core/core.c           | 38 +++++++++++++++++--------
 drivers/mmc/core/core.h           |  6 ++--
 drivers/mmc/core/host.h           |  5 ++++
 drivers/mmc/core/queue.h          |  1 +
 drivers/mmc/core/sd.c             | 47 +++++++++++++++++++++++++++++++
 drivers/mmc/host/rtsx_pci_sdmmc.c |  6 ++++
 include/linux/mmc/card.h          |  2 +-
 include/linux/mmc/core.h          |  1 +
 include/linux/mmc/host.h          |  1 +
 include/linux/mmc/sd.h            |  5 ++++
 include/linux/rtsx_pci.h          |  1 +
 20 files changed, 121 insertions(+), 19 deletions(-)


-- 
2.25.1
