Return-Path: <SRS0=mkSb=27=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B9C33CA3
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AD520838
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jan 2020 13:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="y5FHZFwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgAJNtc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:49:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61190 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727919AbgAJNtL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2020 08:49:11 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ADm0QM013161;
        Fri, 10 Jan 2020 14:49:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Huk5zIYk1Jr66peEpN7YfxHE+3Lw48xMpcF+1ILPSFg=;
 b=y5FHZFwC60GfYbX2wLYBGkKivAyyLBeQqD5ruWFDTrwFDW/yTV87uBg5iELY0DVPxFlu
 eXajl9xPhXYo9art8g3R/cWeGO87teWN0QsP0SeMYBTMV710u96o351rLDF1rx5q0x8Q
 iZhyHyMJu5IOxW4tHcHsZxeNOpboInXf1s45d6SxgJM08k6EqUxs24CRTjTZVSmTYjF4
 yETToIyKjJMFRHJbBesvphqFA2LAaZD0R/IhZw+vFX9cFEYY5AvftffTI81mHylZeB8P
 XrVKAX5sEQ9m2naR6pdnzraOEj16TM5b87fchiSWye8hIr3YWdwgYeZTHIjjQvk3c+Ys NA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xepyt8w0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 14:49:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 40DE210002A;
        Fri, 10 Jan 2020 14:49:02 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 325372BC7D1;
        Fri, 10 Jan 2020 14:49:02 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jan 2020 14:49:01
 +0100
From:   Ludovic Barre <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH 5/9] dt-bindings: mmc: mmci: add delay block base register for sdmmc
Date:   Fri, 10 Jan 2020 14:48:19 +0100
Message-ID: <20200110134823.14882-6-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To support the sdr104 mode, the sdmmc variant has a
hardware delay block to manage the clock phase when sampling
data received by the card.

This patch adds a second base register (optional) for
sdmmc delay block.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index 6d3c626e017d..4ec921e4bf34 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -28,6 +28,8 @@ specific for ux500 variant:
 - st,sig-pin-fbclk       : feedback clock signal pin used.
 
 specific for sdmmc variant:
+- reg			 : a second base register may be defined if a delay
+                           block is present and used for tuning.
 - st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
 - st,neg-edge            : data & command phase relation, generated on
                            sd clock falling edge.
-- 
2.17.1

