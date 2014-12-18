From: Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 1/3] mmc: dw_mmc: dt-binding: Add tuning related things
Date: Thu, 18 Dec 2014 15:01:01 -0800
Message-ID: <1418943663-10012-2-git-send-email-amstan@chromium.org>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:40039 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbaLRXBV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 18:01:21 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so24893igj.4
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 15:01:20 -0800 (PST)
In-Reply-To: <1418943663-10012-1-git-send-email-amstan@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tgih.jun@samsung.com, jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, addy ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Mike Turquette <mturquette@linaro.org>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Alexandru M Stan <amstan@chromium.org>

Add ciu_drv, ciu_sample clocks and default-sample-phase. This will later be used
by tuning code.

We do not touch ciu_drive (and by extension define default-drive-phase). Drive
phase is mostly used to define minimum hold times, while one could write some
code to determine what phase meets the minimum hold time (ex 10 degrees) this
will not work with the current clock phase framework (which floors angles, so
we'll get 0 deg, and there's no way to know what resolution the floors happen
at). We assume that the default drive angles set by the hardware are good enough.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
Suggested-by: Heiko Stuebner <heiko@sntech.de>
Suggested-by: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index 346c609..5edadc2 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -42,11 +42,13 @@ Optional properties:
 * clocks: from common clock binding: handle to biu and ciu clocks for the
   bus interface unit clock and the card interface unit clock.
 
-* clock-names: from common clock binding: Shall be "biu" and "ciu".
-  If the biu clock is missing we'll simply skip enabling it.  If the
-  ciu clock is missing we'll just assume that the clock is running at
+* clock-names: from common clock binding: Shall be "biu", "ciu", "ciu_drv" and
+  "ciu_sample".  If the biu clock is missing we'll simply skip enabling it.
+  If the ciu clock is missing we'll just assume that the clock is running at
   clock-frequency.  It is an error to omit both the ciu clock and the
-  clock-frequency.
+  clock-frequency.  "ciu_drv" and "ciu_sample" are used to control the clock
+  phases, "ciu_sample" is required for tuning high speed modes (if no other
+  custom tuning method is defined).
 
 * clock-frequency: should be the frequency (in Hz) of the ciu clock.  If this
   is specified and the ciu clock is specified then we'll try to set the ciu
@@ -75,6 +77,10 @@ Optional properties:
 * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
   specified we'll defer probe until we can find this regulator.
 
+* default-sample-phase: The default phase to set ciu_sample at probing, low
+  speeds or in case where all phases work at tuning time. If not specified
+  0 deg will be used.
+
 Aliases:
 
 - All the MSHC controller nodes should be represented in the aliases node using
-- 
2.2.0.rc0.207.ga3a616c

