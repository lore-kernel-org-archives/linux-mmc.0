Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920A3EBF2F;
	Wed,  6 May 2026 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077058; cv=none; b=dU3GKNxzpjZu16NEQKVdyf5juKxswHO/8WlIetD0sqP309m/NtInWodCBhXXP+iLGwb73jydN2/jtoErd0d4wg5eWuSy4Xb4mVhmaqh3iQ3/VbxysaMJkgClIRgL7X+AsqPF2W79l7sEiWGp5nqridY17lPBQYQf/PS/d7Kze6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077058; c=relaxed/simple;
	bh=FTgeTsPxFPNtV8jSGk8PNLDBJoFpKTLAXzx0fS9uM6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eji0rQoGHY891d80jiUcIagPG1QeuHYQMzRqGzmfXtaBNo7d/Ark9pxD0DBsiRU4vQkNDREGo3wFS8wEc9e/rGPVwnPQ3ESc24HSP1idfVIes1jegVXL8OLkTsUu8UC5fxW9fijVwxIWUKnfx/eiwD4FTtAxTOtcH4o4M6jeG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B0BC2BCB0;
	Wed,  6 May 2026 14:17:34 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	arnd@kernel.org,
	netdev@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	olteanv@gmail.com,
	wei.fang@nxp.com,
	frank.li@nxp.com,
	shenwei.wang@nxp.com,
	nico@fluxnic.net,
	adureghello@baylibre.com,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: [RFC 0/4] m68k: coldfire: fix non-standard readX()/writeX() functions
Date: Thu,  7 May 2026 00:11:41 +1000
Message-ID: <20260506141629.3233399-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This odd collection of patches is aimed at fixing the non-standard ColdFire
set of readX()/writeX() IO access functions. Instead switching to using the
asm-generic definitions in include/asm-generic/io.h. The difficulty comes
in trying not to break any drivers with this change.

The implementation of the readX()/writeX() family of IO access functions
is non-standard on ColdFire platforms. They either return big-endian (that
is native endian) data, or on platforms with PCI bus support check the
supplied address and return either big or little endian data based on that
check. This is non-standard, they are expected to always return
little-endian byte ordered data. Unfortunately this behavior also means
that ioreadX()/iowroteX() and their big-endian counter parts
ioreadXbe()/iowriteXbe() are currently broken because they are implemented
using the readX()/writeX() functions.

Patches 1, 2 and 3 in this series are specific driver changes that can be
made independently of the final ColdFire readX()/writeX() change.

Patch 4 is the actual switch to ColdFire building using asm-generic
readX()/writeX(), but also contains three driver fixes that are not easily
handled independently.

Looking for comments on the approach taken here, or if there is a better
way forward?

Note also that I don't have access to all supported hardware needed to
fully test all these changes. I have tested what I have, a bunch of the
standard Freescale ColdFire eval boards, and inspected generated code
for differences.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/io_no.h             |   68 --------
 drivers/dma/mcf-edma-main.c               |   14 -
 drivers/mmc/host/sdhci-esdhc-mcf.c        |   24 +-
 drivers/net/can/flexcan/flexcan-core.c    |    1 
 drivers/net/ethernet/freescale/fec.h      |   15 +
 drivers/net/ethernet/freescale/fec_main.c |  254 +++++++++++++++---------------
 drivers/net/ethernet/freescale/fec_ptp.c  |   78 ++++-----
 drivers/net/ethernet/smsc/smc91x.h        |   12 -
 drivers/spi/spi-fsl-dspi.c                |    2 
 9 files changed, 217 insertions(+), 251 deletions(-)

