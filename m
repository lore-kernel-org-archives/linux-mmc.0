Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD0C7619A
	for <linux-mmc@archiver.kernel.org>; Sat, 15 Apr 2023 14:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjDOOS7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 15 Apr 2023 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOOS6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Apr 2023 10:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8773344BA;
        Sat, 15 Apr 2023 07:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23BFE60C96;
        Sat, 15 Apr 2023 14:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E6E2C433D2;
        Sat, 15 Apr 2023 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681568336;
        bh=NU2bCHBCBu/FVM8V5ZxWORQ+XnnJ/22QxWvmPvYrkQw=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=fffqcVMJ3eOkgOZGMvowotNdRuGMPBN6BMQT+DmIxWkiJ8kwLFPk+64f6m1pgO2DQ
         DtAQa3rq964WruOoZeh6xRHkR/bD5GAW73+YiH5hWXxcdeSk/ElExzGPx1ibKQE9Y8
         zOe0+saqLQNES9mfpAFJ5+VOel1kY/VHV+ckXjxqfcThL8uUhiWHvg3c+flbLu6vmj
         YXzo0kCT7JvbrfkGIQtQBQlyUMNq8/zhY64SRA2OzZfg+QZPTFTnm1y8ovgUpea2RS
         jn9WZyzNFy+Emx7xNGY/xqdFWkDvzfl8B032gOUwEAPPZHSuJ63x/j3nFfYwclPV5F
         uIj1p5j/sDDSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 57880C77B70;
        Sat, 15 Apr 2023 14:18:56 +0000 (UTC)
From:   Yang Xiwen via B4 Relay 
        <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RFC 0/3] mmc: add support for the dw-mmc controller on
 Hi3798MV200
Date:   Sat, 15 Apr 2023 22:18:43 +0800
Message-Id: <20230415-mmc-hi3798mv200-v1-0-db5b91d939d4@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOyOmQC/x2NQQrCMBAAv1L2bCBJbWy8Cj6gV/GQxNXsIVF2S
 xFK/27qcRiGWUGQCQXO3QqMCwm9awNz6CDlUF+o6NEYrLa9PppBlZJUpv7kx7JYrVVCM6CP3o3
 OQatiEFSRQ01570qQGXkXH8Ynff+rG0zXC9y37Qd+CibYfwAAAA==
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681568331; l=1144;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=NU2bCHBCBu/FVM8V5ZxWORQ+XnnJ/22QxWvmPvYrkQw=;
 b=3xDF9NiFLIw4XcXlfHospvvBjb4Bhkt3ICZkU3monaSgRKpk0SYnAOCP83Nip5dD4fK9lOTlj
 pz/WjDjUWCACfbtinZekZdg/c7PNTyeth7SCAwKXNcxsbcz7a2UHwgN
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with auth_id=44
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The dw-mmc controller found on Hi3798MV200 is like the one found on
Hi3798CV200, but has some tweaks.
Also refreshed the dt binding and converted it to YAML.
Unfortunately, DDR52 is not supported yet.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Yang Xiwen (3):
      mmc: dw_mmc-hi3798cv200: rename to dw_mmc-histb
      mmc: dw_mmc-histb: add support for hi3798mv200
      binding: mmc: hi3798cv200-dw-mshc: convert to YAML and rename to histb-dw-mshc, add compatible of hi3798mv200

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ---
 .../devicetree/bindings/mmc/histb-dw-mshc.yaml     |  90 ++++++
 drivers/mmc/host/Kconfig                           |   8 +-
 drivers/mmc/host/Makefile                          |   2 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              | 206 -------------
 drivers/mmc/host/dw_mmc-histb.c                    | 336 +++++++++++++++++++++
 6 files changed, 431 insertions(+), 251 deletions(-)
---
base-commit: 76f598ba7d8e2bfb4855b5298caedd5af0c374a8
change-id: 20230415-mmc-hi3798mv200-ce15e9b96866

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

