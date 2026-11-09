Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258449;
	b=LNAuBXqb1zFH2iTlmOiT1nYzlC+G5AH9TGOcvFL99naAkI8el0XbQbBUjV4vUmnJouNK
	 6XL6O9geX/mOatpDJwaJ8Ge86o7fhYBrn6/iAlVJk/3SC3od25v9ohT5duKPccxBE3jP6
	 7ZhRdrYxD5BdwsbweVwoyDaqxjb/0ctsV3KK2Jxp2RytH5610bNjmIoxXwzH7o7bDME8L
	 FVrTGPdZO3SFHUKr0O/D3E/Z/zC4JtKDAUDDAKcqGUe++WZvL2eB6tuO50NYlEkoXEt6F
	 3UpxLMyPWOQ54ki+V4nrEoMXVpRdykEf2GnlzxZSByUdwBR77xvoLwmGYxWOxVFIJJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258449;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Pi4d1jhVjeIsKSNz4TOd+Xp7PZN8pD3GR0ZnU4K+Xp4=;
	b=WvYBzVzTPTDRwcLnv0DMC8KKHo6VK2Xo38BvkEHFIsiXf7TfSoqgYOg39uUtEq/dmv6f
	 OcKch4boTZAd0onNIwlW2SoGadW0AqXs0u6JoFtGjPCgMaMRM+ZvaT5zqEyIWRUp1DBkZ
	 w0Ob1R1rsjl7QbJGjKFMRWTGwuegXJ5Rt5MFumF4SZue1pxvJLpDMFs/tlD2eORa00ksf
	 pf5phfwzX0HWsvS8WZH2mBlU853WqRVrWo1Y5FMkV7LfOGMPb+YDNpCwYPmgRdznmmcTx
	 q4RuUkl2TcXnahC4jWSbXMixB2jE6WfzgpZ5qpG0dZZRFXFkYwgmagaUIbD4kiLNwEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TUcycrNm;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5295606A31C;
	Mon,  9 Nov 2026 21:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5295606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TUcycrNm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258449; x=1825794449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ivcJLgWRf9WaB/XC5kG7Xryo9Ff6vIdKf+WqsmnlQjw=;
  b=TUcycrNmlY6jaP053PF4xomCKcMkS0lreBllegGzELG6edwlVcPTE9tK
   rjyBbPsToqIPlDp7N2E8zTW6VkpwDENbFB3x38LO1SC+lG7rF2hUmPD+D
   OcBEQVDwVYALM7/w/SQIT2WxlO8XgcbI5uPDSgL0vW3AR5m8JLj0h93bn
   +pTqBkJEVFwyBAAUavRY4QcABppxsWscgUj4maSgipzjeRYlQuNoaLQt6
   4huPyM1spORavQzkuhX9AGIEzHyfVyD7vwVTGM6ESig5FpF5Z67ctm06C
   HHr/tQ5lSr2FYFJ60cxlpPyN/b+pqNIS7zhEn2M4B2qOHlq8sQD2LY4dA
   g==;
X-CSE-ConnectionGUID: gGWZiWGKRTqhneh5qzHDnQ==
X-CSE-MsgGUID: Et8s3/ZVSu6Win8Izy0vAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3029279"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3029279"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:28 -0800
X-CSE-ConnectionGUID: RlK6+in1QtO9oHc7LF6exQ==
X-CSE-MsgGUID: TXhYDmvJTZWeBVqp0INsFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8399041"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:07:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alex Dubov <oakad@yahoo.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux1394-devel@lists.sourceforge.net,
	linux-mmc@vger.kernel.org,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Sascha Sommer <saschasommer@freenet.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH 00/11] PCI/CardBus: Disable properly when CARDBUS=n & fix some issues along the way
Date: Mon,  9 Nov 2026 23:07:00 +0200
Message-ID: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
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

Hi all,
 
When CARDBUS=n, there are still leftovers in the bridge setup code that
add annoying corner cases by confusing CardBus bridges with normal PCI
devices. This series attempts to truly disable CardBus bridges when
config asks to do so as it seems the most reasonable way to prevent
those corner cases. That is, this series removes ability to select only
"partial CardBus support", full support for CardBus remains in kernel
and can still be enabled with CONFIG_CARDBUS. The alternative to this
would be to sprinkle pci_is_cardbus_bridge() everywhere to work around
the corner case is not reasonable given CardBus is quite old and rarely
used legacy technology.
 
Disabling CARDBUS also implies the entire Multi-Function Device is lost
because CardBus bridge at Function 0 gates enumeration of the rest of
the functions that are not CardBus related (multiple drivers affected).
This is intentionally not addressed with Kconfig dependencies; see the
changelogs for the rationale. Towards the end, part of the patches are
marked as RFC because they might have an impact on existing configs for
that reason.

The series first fixes a few issues in PCI core and CardBus integration
(4 patches, the first one is totally unrelated to CardBus but CardBus
integration will use the same label in a later change). The fixes can
be applied on their own if needed. After that, there are some
preparatory changes and the main move of CardBus setup into
setup-cardbus.c. Finally, the series moves a few CardBus specific
quirks and the resource name getter into setup-cardbus.c to keep them
out of the other PCI core code.


Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux1394-devel@lists.sourceforge.net
Cc: linux-mmc@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Sascha Sommer <saschasommer@freenet.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Ulf Hansson <ulfh@kernel.org>


Ilpo Järvinen (11):
  PCI: Free device name when pci_setup_device() fails
  PCI: Use Header Type in __pci_bridge_assign_resources()
  PCI: Use Header Type to detect CardBus bridges in
    pci_resource_alignment()
  PCI: Fix off-by-one in CardBus resource names
  PCI: Move pci_read_bases() wrapper with BUILD_BUG_ON() to pci.h
  mmc: sdricoh_cs: Depend on CARDBUS
  pcmcia: yenta_socket: Always select CARDBUS
  PCI: Move CardBus device setup to setup-cardbus.c
  PCI: Move CardBus legacy mode quirk to setup-cardbus.c
  PCI: Move Ricoh RL5C476 MMC quirk to setup-cardbus.c
  PCI: Move CardBus resource names to setup-cardbus.c

 drivers/mmc/host/Kconfig    |  2 +-
 drivers/pci/pci.c           | 25 +---------
 drivers/pci/pci.h           | 23 ++++++++-
 drivers/pci/probe.c         | 27 +++++-----
 drivers/pci/quirks.c        | 45 -----------------
 drivers/pci/setup-bus.c     |  6 +--
 drivers/pci/setup-cardbus.c | 99 +++++++++++++++++++++++++++++++++++++
 drivers/pci/setup-res.c     |  2 +-
 drivers/pcmcia/Kconfig      |  2 +-
 9 files changed, 144 insertions(+), 87 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

