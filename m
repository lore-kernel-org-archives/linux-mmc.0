From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 01/14] clk: Introduce new frequency boundaries properties
Date: Thu, 17 Jul 2014 11:08:41 +0200
Message-ID: <1405588134-2396-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41322 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753943AbaGQJKF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 05:10:05 -0400
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Introduce the properties clock-min-frequency and clock-max frequency to be able
to set constraints on the range of frequency usable by the clock, even though
the hardware might be able to program frequencies outside of thes bounds.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/clock-bindings.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index f15787817d6b..da247fd29064 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -19,6 +19,8 @@ Required properties:
 		   clock outputs.
 
 Optional properties:
+clock-min-frequency: Minimum operating frequency of the clock in hertz
+clock-max-frequency: Maximum operating frequency of the clock in hertz
 clock-output-names: Recommended to be a list of strings of clock output signal
 		    names indexed by the first cell in the clock specifier.
 		    However, the meaning of clock-output-names is domain
-- 
2.0.1

