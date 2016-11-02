From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [PATCH v2 0/2] mmc: sdhci: Fix sdhci caps register bits with corrections provided by dt
Date: Wed, 2 Nov 2016 10:26:14 -0500
Message-ID: <1478100376-602-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zach.brown-acOepvfBmUk@public.gmane.org
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
v2:
 * Fixed style issue, all branches of 'if' should have {}


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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
