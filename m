From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] dt-binding: mmc: rename tmio_mmc.txt to renesas,sdhi.txt
Date: Mon, 24 Jun 2019 16:03:45 +0900
Message-ID: <20190624070345.20373-1-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <simon.horman@netronome.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
MFD glue") said, these MMC controllers use the IP from Panasonic.

TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
The common driver code was split and expanded as 'tmio-mmc-core', then
it became historical misnomer since 'tmio' is not the name of this IP.

In the discussion [1], we decide to keep this name as-is at least in
Linux driver level because renaming everything is a big churn.

However, DT should not be oriented to a particular project even though
it is mainly developed in Linux communities.

This is the misfortune only in Linux. Let's stop exporting it to other
projects, where there is no good reason to call this hardware "TMIO".
Rename the file to renesas,sdhi.txt. In fact, all the information in
this file is specific to the Renesas platform.

This commit also removes the first paragraph entirely. The DT-binding
should describe the hardware. It is strange to talk about Linux driver
internals such as how the drivers are probed, how platform data are
handed off, etc.

[1] https://www.spinics.net/lists/linux-mmc/msg46952.html

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
 - Rename to renesas,sdhi.txt instead of renesas_sdhi.txt

 .../bindings/mmc/{tmio_mmc.txt => renesas,sdhi.txt}   | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{tmio_mmc.txt => renesas,sdhi.txt} (87%)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
similarity index 87%
rename from Documentation/devicetree/bindings/mmc/tmio_mmc.txt
rename to Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
index 2b4f17ca9087..dd08d038a65c 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
@@ -1,13 +1,4 @@
-* Toshiba Mobile IO SD/MMC controller
-
-The tmio-mmc driver doesn't probe its devices actively, instead its binding to
-devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
-driver. Those drivers supply the tmio-mmc driver with platform data, that either
-describe hardware capabilities, known to them, or are obtained by them from
-their own platform data or from their DT information. In the latter case all
-compulsory and any optional properties, common to all SD/MMC drivers, as
-described in mmc.txt, can be used. Additionally the following tmio_mmc-specific
-optional bindings can be used.
+* Renesas SDHI SD/MMC controller
 
 Required properties:
 - compatible: should contain one or more of the following:
-- 
2.17.1
