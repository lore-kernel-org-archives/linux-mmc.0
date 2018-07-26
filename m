From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/2] dt-binding: mmc: rename tmio_mmc.txt to renesas_sdhi.txt
Date: Thu, 26 Jul 2018 12:28:56 +0900
Message-ID: <1532575736-20138-3-git-send-email-yamada.masahiro@socionext.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-mmc@vger.kernel.org

As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
MFD glue") said, these MMC controllers use the IP from Panasonic.

TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
The common driver code was split and expanded as 'tmio-mmc-core', then
it become historical misnomer since 'tmio' is not the name of this IP.

In the discussion [1], we decide to continue calling these variants
'TMIO MMC' at least in Linux driver level, but let's stop exposing
this unfortunate things to other projects.  DT should not be oriented
to a particular project even though it is developed in Linux communities.

Also, remove the first paragraph, "The tmio-mmc driver doesn't probe..."
entirely.  The DT-binding should describe the hardware.  It is wrong
to talk about Linux driver internals such as how the drivers are probed,
how platform data are handed off, etc.

[1] https://www.spinics.net/lists/linux-mmc/msg46952.html

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../bindings/mmc/{tmio_mmc.txt => renesas_sdhi.txt}           | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{tmio_mmc.txt => renesas_sdhi.txt} (86%)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/renesas_sdhi.txt
similarity index 86%
rename from Documentation/devicetree/bindings/mmc/tmio_mmc.txt
rename to Documentation/devicetree/bindings/mmc/renesas_sdhi.txt
index 839f469..a27e091 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas_sdhi.txt
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
2.7.4
