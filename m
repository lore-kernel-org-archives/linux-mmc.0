From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH 0/2] mmc: sdhci: Fix sdhci caps register bits with corrections provided by dt
Date: Fri, 28 Oct 2016 10:56:09 -0500
Message-ID: <1477670171-30015-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

For various reasons the sdhci caps register can be incorrect. This patch set
introduces a general way to correct the bits when they are read to accurately
reflect the capabilties of the controller/board combo.

The first patch creates sdhci-caps and sdhci-caps-mask dt properties that
combined represent the correction to the sdhci caps register.

The second patch uses the new dt properties to correct the caps from the
register as they read during __sdhci_read_caps.

Changes from RFC:
 * /s/registers/register
 * Moved sdhci dt properties into new documentation file sdhci.txt

Zach Brown (2):
  mmc: sdhci: dt: Add device tree properties sdhci-caps and
    sdhci-caps-mask
  mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the caps read
        during __sdhci_read_caps

 Documentation/devicetree/bindings/mmc/sdhci.txt | 14 ++++++++++++++
 drivers/mmc/host/sdhci.c                        | 24 ++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt

-- 
2.7.4
