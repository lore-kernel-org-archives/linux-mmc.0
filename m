From: Zach Brown <zach.brown@ni.com>
Subject: [RFC 0/2] Ignore capability registers when it comes to speeds and use DT binding instead.
Date: Tue, 18 Oct 2016 16:05:34 -0500
Message-ID: <1476824736-9337-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

The first patch add documentation about a new devicetree property
sdhci-cap-speed-modes-broken.

The second patch makes the sdhci use the DT binding instead of the caps
register for determining which speed modes are supported by the controller.

This RFC is an alternative to another patch set I sent up.
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1251944.html

Zach Brown (2):
  mmc: sdhci: dt: Add device tree property sdhci-cap-speed-modes-broken
  mmc: sdhci: Ignore capability register when it comes to speeds and use
    DT     binding instead when sdhci-cap-speed-modes-broken is set.

 Documentation/devicetree/bindings/mmc/mmc.txt |  3 +++
 drivers/mmc/host/sdhci.c                      | 31 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

--
2.7.4
