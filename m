Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762180;
	b=BDcsXhNwJySJQIigoTW6ZV1mjm+iSB032iMkWppNh4/+ogDrCySbq/wyAucwyKUSCbMO
	 iotxYVYh0nQ2ZENqszYfmndfkCcIl2z0ykAu3MIJwzkzAm8scZXlgwBWPuU6uy1yK9+zP
	 to0v0SQI8o508FVsc1D65Gm+R0fYbne4ZTpgZSEsr4DkDPuvkqv6IizcNW9m+oGVo23tU
	 5kXuXy3zKohwIAsDjefJIrIEKCDKPAlFtxMJ8XpiUjqwDaZuTWdEDIMreijGgpJ0sRL+r
	 mp0Jk47Kavzf0bSeK47dQT6bbb78XNuZ/GA5h3ioJ1jsmFtGnGxQMLYwmLHLtzz57kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762180;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Organization:
	 Content-Transfer-Encoding;
	bh=g3YFHw/tSEqLXgBqxpE4Iab2b4xURFYtdJJcC7WJWIU=;
	b=bwj10Wag+FJQCtNhhzihjet30E/W7ry9CAeGrXytgm2PjvDmRgLzFdvES44HJZLARI0i
	 u3aYdU8gaQgOL0GRKws8er12zMZ1hjDLcCgZu8siQnbS6ono6oCM62ffaVfLX9Cn/copl
	 7s0ki4SoGDmQf3ioJHgzBQZzbXS/6ExoL8k6b6z3ogdDiw/DKGygYGqwmatREED8Y/Uaf
	 WmfB04YEte2KmNGWxWMDJrekkl63Vih9qCB02xbcyJHEnwSmK0yHR7lswI5sWSOv6/IhR
	 AC8+tfxtr7Wb6nAXMm84Z6tq8T9VXEuDhV35mBrmfvG5IBrpC04LzcjnKEOKbjTWXXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XSqQePbn;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B72606A321;
	Fri, 27 Nov 2026 06:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B72606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XSqQePbn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795762179; x=1827298179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wMVVDYYiB7wfceZ8fdWQGXCrFPFCMsX5gelPJcZRVFI=;
  b=XSqQePbn43eu36TvyNYsCBHSQzzcbpOSr10GK5WHlQm1PflBGaDgDmkY
   nRjhMe8yIg98UK8IfYeb612N1vYy/RvbkffGywfYcjCF1vtthP7DT2BW+
   fPaZGG74JWSOE4KMYRs+Ce2CMQZplRhClNRsF9I3hoPh0sBB7MwRnZsO/
   XtAAYZ2MfLG1Ocjbwn3zyyGji41FowA9OCScx6QSHVM2gy4KgrzW+G1+F
   BQ4x9SUBb+/Y8SDiGplnqBrWWywlACElnaQjI4HSuPLkNWBSvbOQd1UBy
   xewgD83eDNV3q+NhRIbgY/ihHGNJAlChWfiqr9oUIq19FsJboYmet+A5n
   A==;
X-CSE-ConnectionGUID: 52efiIu6TeqLFN1oDsBmtw==
X-CSE-MsgGUID: 8VntYjVlS2iOLZ552UrCHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4557174"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4557174"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 22:49:38 -0800
X-CSE-ConnectionGUID: k15tcmmzQoCbF53pndWDHg==
X-CSE-MsgGUID: +ubeb3rhSBOMH6yjgJd54A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12940761"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 22:49:35 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Tabby Kitten <nyanpasu256@gmail.com>,
	WisdomWebMan <wisdomwebman@proton.me>,
	linux-pm@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: rtsx: Avoid wakeup events from runtime resume during system sleep
Date: Fri, 27 Nov 2026 08:49:22 +0200
Message-ID: <20261127064922.13791-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Userspace such as KDE Plasma writes /sys/power/wakeup_count before
entering system sleep, so that the kernel aborts the transition if a
wakeup event is reported.  On machines with a Realtek PCIe card reader,
suspend then fails:

  PM: Wakeup pending, aborting suspend
  PM: active wakeup source: mmc0

During a system sleep transition, the card reader gets runtime resumed,
for example by mmc_claim_host() in mmc_queue_suspend(), or by
pci_pm_suspend() and pci_pm_freeze().  rtsx_pci_runtime_resume() then
calls the SD slot card_event() callback, which calls mmc_detect_change(),
which reports a wakeup event that aborts the transition.  Plasma writes
wakeup_count before hibernation too, so hibernation is affected as well.

The rescan is not needed then, because the mmc host class .complete()
callback always triggers a rescan at the end of the transition,
including when it is aborted.

Skip card_event() while dev->power.is_prepared is set.  The PM core sets
it after the PCI device is prepared and clears it before the device is
completed.  The PCI device is prepared before, and completed after, its
mmc host descendant, so every skipped card_event() is followed by that
rescan.

Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
Reported-by: Tabby Kitten <nyanpasu256@gmail.com>
Closes: https://lore.kernel.org/linux-mmc/a242799a-d427-48e1-85ef-923f34df843a@gmail.com/
Reported-by: WisdomWebMan <wisdomwebman@proton.me>
Closes: https://lore.kernel.org/linux-mmc/MiymQuzpi87stsM7XA5bfyMV6n_W41wNq15OMA_RnicheHtlyXzpdRw6_hg8wwrkFdSclRgrh6ZqKLg1xpBSUA7cBxO6sX0eIPHg3Mx2tw0=@proton.me/
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


	Note, this patch has not been tested at all, however WisdomWebMan
	offered to do testing.


 drivers/misc/cardreader/rtsx_pcr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index c6e602523538..4b9585c961df 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1800,7 +1800,13 @@ static int rtsx_pci_runtime_resume(struct device *device)
 
 	rtsx_pci_init_hw(pcr);
 
-	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL) {
+	/*
+	 * card_event() triggers a rescan to catch card changes made while
+	 * runtime suspended, but mmc_detect_change() reports a wakeup event
+	 * that can abort a system sleep transition. Skip it then: the mmc host
+	 * class .complete() callback rescans anyway.
+	 */
+	if (pcr->slots[RTSX_SD_CARD].p_dev != NULL && !device->power.is_prepared) {
 		pcr->slots[RTSX_SD_CARD].card_event(
 				pcr->slots[RTSX_SD_CARD].p_dev);
 	}
-- 
2.53.0

