Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D7CC32771
	for <linux-mmc@archiver.kernel.org>; Sun, 18 Sep 2022 12:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiIRMnQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Sep 2022 08:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRMnO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Sep 2022 08:43:14 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 05:43:13 PDT
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5663C21E18
        for <linux-mmc@vger.kernel.org>; Sun, 18 Sep 2022 05:43:13 -0700 (PDT)
Received: from localhost.localdomain ([146.241.46.240])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ZtchopqfQsT4eZtchofFZJ; Sun, 18 Sep 2022 14:42:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1663504932; bh=7NFTBjGrKCLi5hRyzlwBE0e8Hls3DfjyN9/zGXBDpfY=;
        h=From:To:Subject:Date:MIME-Version;
        b=iTJ/jzzxwV5YJz44NYvQ75D04LiTtC3UcAl1hFAxOyN6vYqScVV7VmluIdB07msue
         hcoMwKE+7C081ij+zBG0tTPN38p6I2qnGmHAsaR5CeOzje5w1A2IzX/59nSGJRKDmB
         czDm2xI/2Sv3NVmJ2gePs2GljWmH3EOocsfuPFs5vEuGVDsscrfEas/+UerslDAHz+
         34B75nnIK6wuATFD4Fb5iUbBH+0Gh+RjomhSuZuF3j+2xZalkWTNVSnxL1uSGAklXD
         3ynogUgtIThHwuh2N1OZwGEvQ4mCRcR4jdyL7Ngs0aOeK+PonjvD1bhvDNWsW5huCD
         xZdJJ5XoKVakw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2] mmc-utils: mmc_cmds.c: fix warning on uninitialized 'cnt'
Date:   Sun, 18 Sep 2022 14:42:10 +0200
Message-Id: <20220918124210.1127345-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <DM6PR04MB657537960D8614C467F6708CFC4A9@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM+Lz1jZsn1/30MzfBcWwoXBBsI4jM+et3iy45CvKD1qdKRAAd/H5pErfIRneJLyHUF88r5fRjNBjTUbsEDT1Qn1KT6UTPX+U9crHHkEDcRElWvY0Bdh
 oPfCje2p1mvPAyv9x7pyHOUG7wdFnDbIB/fLuUPNRa4J+AfMYR6w5tS9D6b9ZbP0qZCURZsOng59meo0fNqDDYKbg7KKel7t96R4nTEbztdop1GgBSMgtFaz
 79xnl65Bxr7IPef4GNsreN4Tpd0zizAT6+f5uPenxjDRiGXEunCXWj1tpwV8h6HYG3KdjvWX0IR0BL7YZIZGjw==
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* prefix subjet with 'mmc-utils:' as pointed by Avri Altman
---
 mmc_cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 12b7802..777d649 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2436,7 +2436,7 @@ int do_rpmb_write_block(int nargs, char **argv)
 	int ret, dev_fd, key_fd, data_fd;
 	unsigned char key[32];
 	uint16_t addr;
-	unsigned int cnt;
+	unsigned int cnt = 0;
 	struct rpmb_frame frame_in = {
 		.req_resp    = htobe16(MMC_RPMB_WRITE),
 		.block_count = htobe16(1)
-- 
2.34.1

