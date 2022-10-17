Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2247DC43217
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 23:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJQX4W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 19:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJQX4M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 19:56:12 -0400
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 287927E036
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 16:56:07 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kZxkoIDsHJpY4kZxloMdtZ; Tue, 18 Oct 2022 01:56:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666050966; bh=V+admxQwpLfW/V/+bGSuXav4uFvMNNrftW6txCx6iRw=;
        h=From:To:Subject:Date:MIME-Version;
        b=CXmSTPNv+sjLLeHTr9MgSboyhUdNZGdxctm70YpIHOJRBp5UsPS8fORljpbDc7Qlf
         H32XRZt4bOlaEhQV+7vXA0XiLLUB3/9alxoJ5+ZlicTDfTOieWcdZ6I1mZ4Dn7seQw
         fBnwahbGeclMjcJg1IX0D+rPh5QasBzYsZ0ladmh7/YZ6gFMs/fvYIAucwKlGTfh/v
         LLzU4bdCRXsPVnyF9WxHpUFDwYr8c8GtuH0DJB4Rf/pS8+XODy2KPIt18VYko00tvZ
         Q2atlRNtE99P+PjjsmUAMlBw46Myzus5aBwHYJpMaGEilInsFB9FYNbVSzr5blDfQu
         p2wJUP9TbeZ8Q==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 4/5] ARM: dts: imxrt1050: remove mmc max-frequency property
Date:   Tue, 18 Oct 2022 01:56:01 +0200
Message-Id: <20221017235602.86250-4-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJPiiR7i7lCy6Uzn2y/6TcFw3IkBM6IvSZFACENWKfnFdxiEKvsCk201PTya2kR/sMbSF8+kn6SIFMRLEbEa9epVh9dBM9z2XG7rHdStuL9DnZyi1aX3
 wE9L05Lj8Gh4iZyg7/b5mN/4XN2WRdc8ZlhMW+dWt79tJUXGk48n1gCgHGnTuyubP3115nj9T8CQbHEWaVd2q22uji6mucyxAHW3divjewOqKB3hsZpDOsVB
 dR81CRik/xL4kbu6iHBEfGDHuulBynKZYP31InOz6FPQyDOD/LAzEeBaAvsnuySS4pZJajEgf5qSQkEvb3aDpGBrLM5BYZqhCYuHaVTaJtfUdVdhJFwuc8CJ
 DUFxOI6tZPRyjnc5Htn1GWgaOvIDlfiF9lMjOZpxwSj9gsKLP4WyticVFSblu3NyJDBUaVu4RuP27b6qK1kmQpTFeZ6mD3/4kgUTJInwn6tUZeg9QrvXa1HG
 Mwn3bFPI4SgKUuX7RkiKi/QdxxI7sb4BVrMl0OrCXI3KIROKT3QRqdpakssp/lxvERehuQ6u1iSe5GGVq5MOROxexWA72LGUsUGv5YVQvXBf1V3M3+cfCu40
 BYA=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to i.MXRT1050 Reference Manual usdhc supports up to 208Mhz clock
so let's remove max-frequency property in the .dtsi base file and
in case add that property in the board specific .dts file for a specific
device connected to it.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/boot/dts/imxrt1050.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 114465e4dde6..0b44cc4ce6ad 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -93,7 +93,6 @@ usdhc1: mmc@402c0000 {
 			bus-width = <4>;
 			fsl,wp-controller;
 			no-1-8-v;
-			max-frequency = <4000000>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step = <2>;
 			status = "disabled";
-- 
2.34.1

