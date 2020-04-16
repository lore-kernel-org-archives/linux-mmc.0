Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBFC38A29
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608F2206E9
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 18:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FG9WLRGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgDPShj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgDPShZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 14:37:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D0C061A0C;
        Thu, 16 Apr 2020 11:37:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so6082601wrd.0;
        Thu, 16 Apr 2020 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5aO4xzcD+0wNNf/PxxNiXuB2ikdc6r7QQ2PRhCRC3Yg=;
        b=FG9WLRGecEzt5yeGkGmmEEDa7GQwVbDWiOvSd9qjmkGgeQGFjYkiAo3br+2/TroUip
         dV+Ad4C2oS+YHZWy9GdT2Vxd7rXDbBW5OsT+xcDZqeO7TtT5ml+gbnoFMIkgSzs0sIjc
         jGemJiIb3YzPLELsNskzftGnUhPSnFdbwONV9Cyveq/qWS4XfW9sIwu2VoYz0P/3Gt+P
         AP1gaT/nhrXKaL4caHp6D8jQmY12FHzzSgpscu42dF8gJT/l/NcdTgkxCn/IJgjUwPax
         HdQ0GgaEHjxBjw30yu1v9b+6Xc7u/XM6XAacI/hE8p3JMIgSjwqO7rNjK/BzSqJg1P2J
         pkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5aO4xzcD+0wNNf/PxxNiXuB2ikdc6r7QQ2PRhCRC3Yg=;
        b=sZv5/LjoguBgbh1kesYwdqBbqRDjZhxqw2yUNgS6L6aEyNQJW+IsIMqVP+eP+JJtN9
         dQizbfHZdPU35AC2cxXi8dr3MKUk0Xex7eYeu4u7pkgbMhm8ShDka+G3M/fyq+PIw5WR
         bgRFr/Sv74GQbcrDMR9LI8eaid6gupD1QDh2t7d7f0/Jlm/HWmBEwjPcruSfmbFsXtMJ
         wauDgpgiQzjPyufKzz83Y/zRqrpqyLVGy1ql2HR8A69Oro+9ip6Qmji+8/LYmGQkkwW+
         yXJ/ZYhcypRi5cxJ5t5HoFpS4TOydxbgp6+hLodI53O9c2mTI0GOJQmaj1+LTQPnne4q
         nAjQ==
X-Gm-Message-State: AGi0PuYWhbJ+SZoun4ar5r3lG+1njZWpG8TnDwXR6jcHylp6jvQHsR9V
        STLuC1veL+j/VRX66gw9c7kpPJur+Rg=
X-Google-Smtp-Source: APiQypLF69djmNWJQ16igTe3DHck+hJYapQKt6rYlnZf9gHpnpETMKxfUYg/wmGaM5Csx0GhrQ9CWw==
X-Received: by 2002:adf:ee91:: with SMTP id b17mr6072924wro.109.1587062242718;
        Thu, 16 Apr 2020 11:37:22 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v131sm4626434wmb.19.2020.04.16.11.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:37:22 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/2] meson-mx-sdhc card busy detection fixes
Date:   Thu, 16 Apr 2020 20:35:11 +0200
Message-Id: <20200416183513.993763-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The following errors were observed with Linux 5.7-rc1 and an SD card
hooked up to the meson-mx-sdio controller:
  mmc1: Card stuck being busy! __mmc_poll_for_busy
  blk_update_request: I/O error, dev mmcblk1, sector 17111080 op
   0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0


At least patch #1 should go to a -fixes branch so it can make it
into v5.7.


Changes since v1 at [0]:
- added correct Fixes tag for patch #1
- added a patch which drops the ->card_busy() implementation from
  the meson-mx-sdio driver because this is not working
- special thanks to Ulf for taking the time to provide debug
  patches, explaining things and answering my questions!


[0] https://patchwork.kernel.org/patch/11483621/


Martin Blumenstingl (2):
  mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
  mmc: meson-mx-sdio: remove the broken ->card_busy() op

 drivers/mmc/host/meson-mx-sdio.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

-- 
2.26.1

