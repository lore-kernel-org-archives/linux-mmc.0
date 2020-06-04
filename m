Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D1C433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 01:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C336B20738
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 01:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgFDBv6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:51:58 -0400
Received: from inva020.nxp.com ([92.121.34.13]:32850 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgFDBv6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Jun 2020 21:51:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C2B4E1A10DA;
        Thu,  4 Jun 2020 03:51:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE2B41A0191;
        Thu,  4 Jun 2020 03:51:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8FC23402A5;
        Thu,  4 Jun 2020 09:51:45 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mpa@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 0/3] Convert i.MX/MXS mmc binding to json-schema
Date:   Thu,  4 Jun 2020 09:41:23 +0800
Message-Id: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series converts i.MX and MXS mmc binding to json-schema,
fix some minor issues in original binding doc, such as node name should be 'mmc',
compatible name for i.MX27, reg/interrupts should be required properties etc..

Compared to V1, this patch series adds "unevaluatedProperties: false" for
each binding doc.

Anson Huang (3):
  dt-bindings: mmc: Convert imx esdhc to json-schema
  dt-bindings: mmc: Convert imx mmc to json-schema
  dt-bindings: mmc: Convert mxs mmc to json-schema

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  67 -----------
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     | 124 +++++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-imx-mmc.txt        |  23 ----
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       |  53 +++++++++
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |  27 -----
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml |  58 ++++++++++
 6 files changed, 235 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml

-- 
2.7.4

