Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258500;
	b=e5BQqaHPDQvUANq1CG/rENGUOWsHNMIims9JSZbeHfIj9dBZhVABi+tRdUf+8QYPr4BT
	 IIQG2i+CG/NwWbdJ7ozo2Iqxo0RFNlcOXOAopCJ2FqoDqT6HVsWEaT/+SYAmXwh35wG8a
	 wnzS16khomtQlolN2a/epmgNIIo6Uj2ojmwaOF6nxuPjdvRHM150aRd9UwN+QiKnZqET8
	 YuMz/p5Hkot5WddBwMI8Iai+TrYWbEcakfBDu+RiP/9ofnx8TTZnslZXyw5ZbHyXD55S1
	 /OyrKlAnFuNoGrmWbAGQTRg+xdx4AE+/kzQORabLOc2V2piKsdE5pvNHDBfMlureKRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258500;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=cK/zJ1sJKQ5yQdh+zt2LnSGFJVOFWUPJvvgMgntohAk=;
	b=eKsI2+fiskvpBJFZAdbG/s6BgvaGME/ZIhAXzPTUao2oQW3mFX0O+6xPJErplNf/Y/Bn
	 foP8gm6SLI/jHkFKe4HrpOQXi6zNwFeU6CM3TC4He57wYevJ/p2s53p2jdm86sTWVNAgA
	 MAtkLXyHfOYBn8yCOKd+5aSkXrf3/J45GgaAC0T3QpP/goMI1Fpxnsy90g5dpgLV3OPjy
	 2IHWIzvemQXZihX6+c5DLznmlqAOkamKnWXm9RrV8EU5+tXrd1rbhRib27Z9WurNqkryE
	 RkJLIHf4fVbJfjD/tmbnCAV6/3Vt6cGXuLfRHRkl6GTe7EX0yo7MtSqSyHlGBMcKYqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="JR681R/z";
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE082606A326;
	Mon,  9 Nov 2026 21:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE082606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JR681R/z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258501; x=1825794501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RP9NoegeDXBjDaQf3T6siXXLnLMadN6eylhtNbINs/E=;
  b=JR681R/zNCTsAdUYpQePW2B+33ymU3H7SogI6oTTQAAAI2hUn0wc/bRY
   PjoGyWJqdLTZPXT1qOLlYmvT92bjg8gfzbkGoin0giTZfrqy1j/k9iQXw
   ZiXNOoKYS6vpdg25VHL32DQ1DqEyhUNMyTCvS9+jbm+Mna+fc8zT09m8W
   EZVrgudFkdcblcp/g/0xhNok0v5fuDaqWsaAnoT9Nu7yvnaoGMshnZsXR
   wrCGjFKt7LVzn/7lyG5O6j3T3fsrOWTJf1cqurkaLZkz7Yv9gJkpDFbg4
   UosfkB/B9nChL7BcMmjFcZd/nw19NHoNeozvyh/1ggYMzrkfWaoMDufxk
   Q==;
X-CSE-ConnectionGUID: z7AF6vW+S2uDvgslxF9VIw==
X-CSE-MsgGUID: znMVddaRTqacz/aQMj7X+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2891035"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2891035"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:20 -0800
X-CSE-ConnectionGUID: 9mzrnITSTCWp3mYwFFhN9g==
X-CSE-MsgGUID: g+I/rsvFQIuyAWnrJ/fJVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9824440"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sascha Sommer <saschasommer@freenet.de>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 06/11] mmc: sdricoh_cs: Depend on CARDBUS
Date: Mon,  9 Nov 2026 23:07:06 +0200
Message-ID: <20261109210714.3862-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sdricoh_cs accesses the SD controller through the PCI device of the
Ricoh RL5C476 CardBus bridge. An upcoming change makes the PCI core
ignore CardBus bridges when CONFIG_CARDBUS is not set, so the driver
would no longer find the controller.

Make MMC_SDRICOH_CS depend on CARDBUS.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Cc: Ulf Hansson <ulfh@kernel.org>
Cc: Sascha Sommer <saschasommer@freenet.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-mmc@vger.kernel.org

 drivers/mmc/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 79bfc425e7c7..6b18b66c10b4 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -692,7 +692,7 @@ config MMC_SPI
 
 config MMC_SDRICOH_CS
 	tristate "MMC/SD driver for Ricoh Bay1Controllers"
-	depends on PCI && PCMCIA
+	depends on PCI && PCMCIA && CARDBUS
 	help
 	  Say Y here if your Notebook reports a Ricoh Bay1Controller PCMCIA
 	  card whenever you insert a MMC or SD card into the card slot.
-- 
2.47.3

