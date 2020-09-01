Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB8C433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D831220E65
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 08:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RoWkybLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIAIu2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:50:28 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:47171 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAIu1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 04:50:27 -0400
IronPort-SDR: DwCiWk1/MCA5CPbyQoI42uC+mUG7pJ2VLPGgjl+14SAA3fqvx5hrN7IUuC9NRKxW679rFZTwaC
 w0flCZ3LFo+YhkiBbVhSs6X4Aifox6uhr5KzTiz9P8pKydk+KJ2qfcKM2sdzrxkoT3oJhXimgC
 zr17ynR4yoyLtaSNq+QTslAVnfbf1lYRY3kAjOlVTGEME+ivDB8VsIqyub3mJcFMsayXrFtCQ8
 288Vyl8ec5E5NwmQj99chjGv8ofvd4VZLkAldt7HjUZM9JkGpj61oBMTeaWMblFu+CkTncnHQT
 gcg=
X-IronPort-AV: E=Sophos;i="5.76,378,1592863200"; 
   d="scan'208";a="13677466"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Sep 2020 10:50:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 01 Sep 2020 10:50:24 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 01 Sep 2020 10:50:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598950224; x=1630486224;
  h=from:to:cc:subject:date:message-id;
  bh=Mu2xmjPdSJd4EA0jIUBhaOSiI9fbd+rNqRkizJUx3mI=;
  b=RoWkybLwVqaRleCcMOQXA3ux5W1Tz8SBqoFet7kmKyXCaQhUMzl7Z2kT
   KkP0P/0m3xou44eQy/O9aMb9YmFk8KdNOzEyJN8tOmS0saE5Dlzowp5SM
   8cUAYg8Cxy+twFQ2pbBmrUud+O6exD4sm6RtjKhzI0ZD1Z8Alwr+M4Ome
   HpRn5NajzAovCHnEts8gd0ZiukVTRMTY43il7+m0dkOzT0rE2H76llOKW
   BhtMtfn5tSaPcwi9b01HucydlBETdtaK8y5q4qndBPs05yba7/UThIDrD
   rUrpaRTruGacO00UC3IFJKLNoNjvAnaopIgwAZ4Y/Smsh8k6sH1RGE80i
   A==;
IronPort-SDR: 6WtvfxfqcFHIhjUrssWxYyY3OST7vbgXxy6Afa6CeOgbuhRvUYhV/kq1K71PIBZV6yoh3l7+N4
 IHxqeJdRjbHmQG6ZIdyXCgZJSrHhmQLOqcFIAhYPlvb//8UCcoUXO2nyw4xSfASUyDyqI5CehY
 S87VWTN7loEr9fOyrOIXCDEfYWje20u2oYLsw7zpdErbEXVMBHgfIq4lfPuL2iUxeFZOZ5ThNU
 zr5ca2gByzyI0+NdG1VUthjxgTRItVDOr689RVo5cso2lO1z+VvPbkFq6IkhOrpcF6hVkGoHsi
 9EA=
X-IronPort-AV: E=Sophos;i="5.76,378,1592863200"; 
   d="scan'208";a="13677465"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Sep 2020 10:50:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 12855280065;
        Tue,  1 Sep 2020 10:50:24 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH mmc-next v4 1/2] dt-bindings: mmc: document alias support
Date:   Tue,  1 Sep 2020 10:50:03 +0200
Message-Id: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As for I2C and SPI, it now is possible to reserve a fixed index for
mmc/mmcblk devices.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v4: moved alias documentation from example to description

v3: new patch

 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index b96da0c7f819..f928f66fc59a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -14,6 +14,10 @@ description: |
   that requires the respective functionality should implement them using
   these definitions.
 
+  It is possible to assign a fixed index mmcN to an MMC host controller
+  (and the corresponding mmcblkN devices) by defining an alias in the
+  /aliases device tree node.
+
 properties:
   $nodename:
     pattern: "^mmc(@.*)?$"
-- 
2.17.1

