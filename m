Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F3C77B7D
	for <linux-mmc@archiver.kernel.org>; Sat, 13 May 2023 15:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjEMPEo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 13 May 2023 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPEn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 13 May 2023 11:04:43 -0400
X-Greylist: delayed 901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 May 2023 08:04:41 PDT
Received: from mailgw02.mediatek.com (mailgw02.mediatek.com [216.200.240.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE3F2684
        for <linux-mmc@vger.kernel.org>; Sat, 13 May 2023 08:04:41 -0700 (PDT)
X-UUID: 60371228f19d11ed83ed1395ce914268-20230513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xqSIeMMS8THtmucp/HLVRArGbSPfK6G34ffOwINcu84=;
        b=gMli8w7FMRcEITsLYmscgNMjYxMNX34gc55muslOl8llt4PQBJ+4bfpVpsJc5EYzWuLYSnlEtAUNFBSOBRoZZI0qz7sesDwEcIJoVHPaSlDi7qaNVTqXVtgnBq+SEf9/Khs8UGJJZp/dFmJ6sXBLvngKhq/hFxc8Jtr4Gm9mNmU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:6b4c88d4-b958-4d78-b9b2-b58e07e2b864,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-META: VersionHash:178d4d4,CLOUDID:e9a90d3b-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 60371228f19d11ed83ed1395ce914268-20230513
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 190616146; Sat, 13 May 2023 07:49:34 -0700
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 13 May 2023 22:48:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 13 May 2023 22:48:36 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2] mmc: vub300: fix invalid response handling
Date:   Sat, 13 May 2023 22:48:15 +0800
Message-ID: <048cd6972c50c33c2e8f81d5228fed928519918b.1683987673.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We may get an empty response with zero length at the beginning of
the driver start and get following UBSAN error. Since there is no
content(SDRT_NONE) for the response, just return and skip the response
handling to avoid this problem.

Test pass : SDIO wifi throughput test with this patch

[  126.980684] UBSAN: array-index-out-of-bounds in drivers/mmc/host/vub300.c:1719:12
[  126.980709] index -1 is out of range for type 'u32 [4]'
[  126.980729] CPU: 4 PID: 9 Comm: kworker/u16:0 Tainted: G            E      6.3.0-rc4-mtk-local-202304272142 #1
[  126.980754] Hardware name: Intel(R) Client Systems NUC8i7BEH/NUC8BEB, BIOS BECFL357.86A.0081.2020.0504.1834 05/04/2020
[  126.980770] Workqueue: kvub300c vub300_cmndwork_thread [vub300]
[  126.980833] Call Trace:
[  126.980845]  <TASK>
[  126.980860]  dump_stack_lvl+0x48/0x70
[  126.980895]  dump_stack+0x10/0x20
[  126.980916]  ubsan_epilogue+0x9/0x40
[  126.980944]  __ubsan_handle_out_of_bounds+0x70/0x90
[  126.980979]  vub300_cmndwork_thread+0x58e7/0x5e10 [vub300]
[  126.981018]  ? _raw_spin_unlock+0x18/0x40
[  126.981042]  ? finish_task_switch+0x175/0x6f0
[  126.981070]  ? __switch_to+0x42e/0xda0
[  126.981089]  ? __switch_to_asm+0x3a/0x80
[  126.981129]  ? __pfx_vub300_cmndwork_thread+0x10/0x10 [vub300]
[  126.981174]  ? __kasan_check_read+0x11/0x20
[  126.981204]  process_one_work+0x7ee/0x13d0
[  126.981246]  worker_thread+0x53c/0x1240
[  126.981291]  kthread+0x2b8/0x370
[  126.981312]  ? __pfx_worker_thread+0x10/0x10
[  126.981336]  ? __pfx_kthread+0x10/0x10
[  126.981359]  ret_from_fork+0x29/0x50
[  126.981400]  </TASK>

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
v2: add Fixes tag
    update commit description
---
 drivers/mmc/host/vub300.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index e4c4bfac3763..9ec593d52f0f 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1713,6 +1713,9 @@ static void construct_request_response(struct vub300_mmc_host *vub300,
 	int bytes = 3 & less_cmd;
 	int words = less_cmd >> 2;
 	u8 *r = vub300->resp.response.command_response;
+
+	if (!resp_len)
+		return;
 	if (bytes == 3) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24)
 			| (r[2 + (words << 2)] << 16)
-- 
2.18.0

