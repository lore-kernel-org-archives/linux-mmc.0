From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/8] mmc: dt: pwrseq-simple: Invent power-off-delay-us
Date: Mon,  8 May 2017 18:21:10 +0200
Message-ID: <1494260477-25163-2-git-send-email-ulf.hansson@linaro.org>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:33978 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdEHQV0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2017 12:21:26 -0400
Received: by mail-wr0-f175.google.com with SMTP id l9so48815980wre.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2017 09:21:26 -0700 (PDT)
In-Reply-To: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Xu <xuwei5@hisilicon.com>, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org

During power off, after the GPIO pin has been asserted, some devices like
the Wifi chip from TI, Wl18xx, needs a delay before the host continues with
clock gating and turning off regulators as to follow a graceful shutdown
sequence.

Therefore invent an optional power-off-delay-us DT binding for
mmc-pwrseq-simple, to allow us to support this constraint.

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index e254368..9029b45 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -18,6 +18,8 @@ Optional properties:
   "ext_clock" (External clock provided to the card).
 - post-power-on-delay-ms : Delay in ms after powering the card and
 	de-asserting the reset-gpios (if any)
+- power-off-delay-us : Delay in us after asserting the reset-gpios (if any)
+	during power off of the card.
 
 Example:
 
-- 
2.7.4

