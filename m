From: Zach Brown <zach.brown@ni.com>
Subject: [RFC v3 0/2] mmc: sdhci: Ignore capability register when it comes to speeds and use DT binding instead when sdhci-cap-speed-modes-broken is set.
Date: Mon, 24 Oct 2016 14:04:08 -0500
Message-ID: <1477335850-14945-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:51628 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938826AbcJXTE1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 15:04:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

The first patch add documentation about a new devicetree property
sdhci-cap-speed-modes-broken.

The second patch makes the sdhci use the DT binding instead of the caps
register for determining which speed modes are supported by the controller.

This RFC is an alternative to another patch[1] set I sent up.

[1]
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1251944.html

v2:
 * Removed separate OF parsing function, relying on mmc_of_parse to be called
   before read_caps
 * Moved check of sdhci-cap-speed-modes-broken into sdhci_read_caps.
 * Added SDHCI_SUPPORT_HS400 to list of bits to clear in sdhci cap1, not
   sure that's all of the them now, but I think so.
v3:
 * Read "sdhci-cap-speed-modes-broken" only once.
 * If caps are provided to sdhci_read_caps the speed bits are not overwritten.


Zach Brown (2):
  mmc: sdhci: Add device tree property sdhci-cap-speed-modes-broken
  mmc: sdhci: Ignore capability register when it comes to speeds and use
    DT     binding instead when sdhci-cap-speed-modes-broken is set.

 Documentation/devicetree/bindings/mmc/mmc.txt |  3 +++
 drivers/mmc/host/sdhci.c                      | 25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.7.4

