Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96927C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Nov 2022 08:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiKXIBu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Nov 2022 03:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiKXIBs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2022 03:01:48 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46FAD1C01
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2022 00:01:42 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221124080139epoutp0403b2b386327231efcac4748c597dd40a~qdn7VJyDP2707127071epoutp04R
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2022 08:01:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221124080139epoutp0403b2b386327231efcac4748c597dd40a~qdn7VJyDP2707127071epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669276899;
        bh=voFfJu75DbaRp5dsghskwArTsRqxPUE0da7mBX7z8gU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uZiJjtPLvYCmwLx4FrK6teNj4ZZ6ypi30LEmpiJlz9gt9nncoU0b1zbLaLD02V790
         9J9xGGyJfcQ7Kw1hyzOYmBbCzPuEbfr5Dx8bD5k+Mnc5eYSq2PAR0lL3Ste1mbMcfk
         7jW0TQsxuT7hfs9ZNSZo4Whl4zHOWWlkqR/V8RDc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20221124080138epcas1p3585a3fc05cd79eae89eb5d29af9eace8~qdn64bTxU0269902699epcas1p35;
        Thu, 24 Nov 2022 08:01:38 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.248]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NHr6n6674z4x9Q7; Thu, 24 Nov
        2022 08:01:37 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.97.57013.FD42F736; Thu, 24 Nov 2022 17:01:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221124080135epcas1p2b899bc272cfefb823453c2b0559f925a~qdn4KIM1r2650926509epcas1p2h;
        Thu, 24 Nov 2022 08:01:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221124080135epsmtrp1cc1424cc27c2b7edc8d2b2353bd28c10~qdn4JMNyA0351403514epsmtrp1I;
        Thu, 24 Nov 2022 08:01:35 +0000 (GMT)
X-AuditID: b6c32a37-da3ff7000001deb5-94-637f24dfcb61
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8B.BD.14392.FD42F736; Thu, 24 Nov 2022 17:01:35 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.100.232]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221124080135epsmtip15d2058c14619cc941534ae0f01f7a712~qdn36XHVt1585515855epsmtip12;
        Thu, 24 Nov 2022 08:01:35 +0000 (GMT)
From:   Chanwoo Lee <cw9316.lee@samsung.com>
To:     ulf.hansson@linaro.org, jh80.chung@samsung.com,
        chaotian.jing@mediatek.com, matthias.bgg@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org
Cc:     ChanWoo Lee <cw9316.lee@samsung.com>
Subject: [PATCH] mmc: Replace with the already declared define
 function(mmc_op_tuning)
Date:   Thu, 24 Nov 2022 17:00:31 +0900
Message-Id: <20221124080031.14690-1-cw9316.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmru59lfpkg5ZvZhYnn6xhszj3+DeL
        xbYOG4trt+azWcw41cZqceMXkOiYvJ3F4sj/fkaLphZji+Nrwx24PHbOusvusXjPSyaPTas6
        2TzuXNvD5tFycj+LR9+WVYwenzfJBbBHZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoa
        WlqYKynkJeam2iq5+AToumXmAB2npFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkw
        K9ArTswtLs1L18tLLbEyNDAwMgUqTMjO6Ln4l7XguUHF3p8TGRsYv6t3MXJySAiYSFxa+o2l
        i5GLQ0hgB6PExBWPGSGcT4wSc3fOZINwvjFKvPgyiwmmpWf9VXYQW0hgL6PEgj1Q7V8YJZ69
        /sbaxcjBwSagJXH7mDdIXETgMaPE0h3n2UAamAU0JE7OegLWLCwQIXFiyWcWEJtFQFWiYdU/
        RpBeXgFriblvcyB2yUv8ud/DDGLzCghKnJz5hAVijLxE89bZzCDzJQQ+sku8v9LHCtHgIvHp
        32moQ4UlXh3fwg5hS0m87G9jh2hoZpTY9vUSE4TTwSixsfUFI0SVscSnz5/BrmAW0JRYv0sf
        IqwosfP3XEaIzXwS7772gD0pIcAr0dEmBFGiIjGn6xwbzK6PNx5D3eMhsX7vU2hgxUo8mD+V
        ZQKj/Cwk/8xC8s8shMULGJlXMYqlFhTnpqcWGxYYw2M1OT93EyM4gWqZ72Cc9vaD3iFGJg7G
        Q4wSHMxKIrz1njXJQrwpiZVVqUX58UWlOanFhxhNgQE8kVlKNDkfmMLzSuINTSwNTMyMTCyM
        LY3NlMR5G2ZoJQsJpCeWpGanphakFsH0MXFwSjUwid5/vO/IrqOVJ74w7k/tiHV7K3/3lfbC
        O/sWzn9UcHHF/KXW4byHTj5NzP3f9Z15cb7/HpPqlgXTDRm3x/Etsb743Ks76Bfr/SXLfedb
        XgvsZ/26e8Z+s9UHy1ZEmH9xahTh1egMUDBhDamboj3xJNfGsC6DFgbvUz+arSp6pm9eIXm0
        0KtB8ABTyaN8gceLTfd2HlCL2yp/rMm4fEnCuRcMfh8+ZRw4WrT3fDeXh1N8qPv1Wgs70Rkp
        91tb5M+qbA9Z8PR8wJXuh7/Ypynd3PTcWflMweeVdV+0Vb6xeH9Ny1reIlR3ptNjd3zT7ry1
        M1s8PELa9TZkdbl6OlRufMRewaVS36l84IMUX1+2EktxRqKhFnNRcSIAA89ueSkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSnO59lfpkg5fTpS1OPlnDZnHu8W8W
        i20dNhbXbs1ns5hxqo3V4sYvINExeTuLxZH//YwWTS3GFsfXhjtweeycdZfdY/Gel0wem1Z1
        snncubaHzaPl5H4Wj74tqxg9Pm+SC2CP4rJJSc3JLEst0rdL4MroufiXteC5QcXenxMZGxi/
        q3cxcnJICJhI9Ky/yt7FyMUhJLCbUaLl1FdmiISUxO7959m6GDmAbGGJw4eLQcJCAp8YJdZM
        SQcJswloSdw+5g3SKiLwFij8sIUdpIZZQEPi5KwnYLawQJjE/mkTWUFsFgFViYZV/xhBenkF
        rCXmvs2B2CQv8ed+D9hWXgFBiZMzn7BAjJGXaN46m3kCI98sJKlZSFILGJlWMUqmFhTnpucW
        GxYY5qWW6xUn5haX5qXrJefnbmIEB7OW5g7G7as+6B1iZOJgPMQowcGsJMJb71mTLMSbklhZ
        lVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT/3qzffst8xs8Th29
        t21iQr7Sym9crmsD91WkzexhXlq7Uurr9JDQf1rGUqpqu75YODs3TD+w8cdi4UBN98x6EYF5
        sx8emv7lU41bdsDFdbNWBJrPEV62ympSYJAF42fRlSz37eS/JmauZpz+bGZZj6RTloNXesyJ
        ozIb+U4WO09Sm7BEdOVP9eJD8xKyDhmo2okeO1OpUF71g2fBQZlzh0VFTmx78cvqpLLZnpcf
        Nhz8aqRU9db60U7PdynnjK9PfcU8JazAViC5837j3udyV16ujvnNe6L2YdTiOKWFi3fIODgv
        qFwgHbn1PPP3+5lvV7il2d6f89DLaMamzzPWVNivcnL+NkMuOLL1wGRbHyWW4oxEQy3mouJE
        AHAQEgvVAgAA
X-CMS-MailID: 20221124080135epcas1p2b899bc272cfefb823453c2b0559f925a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221124080135epcas1p2b899bc272cfefb823453c2b0559f925a
References: <CGME20221124080135epcas1p2b899bc272cfefb823453c2b0559f925a@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ChanWoo Lee <cw9316.lee@samsung.com>

Replace with the already declared define function.
There are no functional differences.

Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>
---
 drivers/mmc/core/core.c              | 3 +--
 drivers/mmc/host/dw_mmc.c            | 3 +--
 drivers/mmc/host/mtk-sd.c            | 8 ++------
 drivers/mmc/host/sdhci-msm.c         | 3 +--
 drivers/mmc/host/sdhci-pci-o2micro.c | 3 +--
 drivers/mmc/host/sdhci-tegra.c       | 8 ++------
 drivers/mmc/host/sdhci.c             | 9 ++-------
 7 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1bb70d438d6c..efa7178955f8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -142,8 +142,7 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	int err = cmd->error;
 
 	/* Flag re-tuning needed on CRC errors */
-	if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
-	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
+	if (!mmc_op_tuning(cmd->opcode) &&
 	    !host->retune_crc_disable &&
 	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
 	    (mrq->data && mrq->data->error == -EILSEQ) ||
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index e4d09c439051..829af2c98a44 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -334,8 +334,7 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	    cmdr == MMC_READ_MULTIPLE_BLOCK ||
 	    cmdr == MMC_WRITE_BLOCK ||
 	    cmdr == MMC_WRITE_MULTIPLE_BLOCK ||
-	    cmdr == MMC_SEND_TUNING_BLOCK ||
-	    cmdr == MMC_SEND_TUNING_BLOCK_HS200 ||
+	    mmc_op_tuning(cmdr) ||
 	    cmdr == MMC_GEN_CMD) {
 		stop->opcode = MMC_STOP_TRANSMISSION;
 		stop->arg = 0;
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 652a67f9b054..d3f24dbda49f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1224,9 +1224,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 
 	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
 		if (events & MSDC_INT_CMDTMO ||
-		    (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
-		     cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
-		     !host->hs400_tuning))
+		    (!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning))
 			/*
 			 * should not clear fifo/interrupt as the tune data
 			 * may have alreay come when cmd19/cmd21 gets response
@@ -1320,9 +1318,7 @@ static void msdc_cmd_next(struct msdc_host *host,
 {
 	if ((cmd->error &&
 	    !(cmd->error == -EILSEQ &&
-	      (cmd->opcode == MMC_SEND_TUNING_BLOCK ||
-	       cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200 ||
-	       host->hs400_tuning))) ||
+	      (mmc_op_tuning(cmd->opcode) || host->hs400_tuning))) ||
 	    (mrq->sbc && mrq->sbc->error))
 		msdc_request_done(host, mrq);
 	else if (cmd == mrq->sbc)
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 03f76384ab3f..4ac8651d0b29 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2219,8 +2219,7 @@ static int __sdhci_msm_check_write(struct sdhci_host *host, u16 val, int reg)
 		if (!msm_host->use_cdr)
 			break;
 		if ((msm_host->transfer_mode & SDHCI_TRNS_READ) &&
-		    SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK_HS200 &&
-		    SDHCI_GET_CMD(val) != MMC_SEND_TUNING_BLOCK)
+		    !mmc_op_tuning(SDHCI_GET_CMD(val)))
 			sdhci_msm_set_cdr(host, true);
 		else
 			sdhci_msm_set_cdr(host, false);
diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index bca1d095b759..98cadff47b2b 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -326,8 +326,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		(host->timing != MMC_TIMING_UHS_SDR50))
 		return sdhci_execute_tuning(mmc, opcode);
 
-	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
-			(opcode != MMC_SEND_TUNING_BLOCK)))
+	if (WARN_ON(!mmc_op_tuning(opcode)))
 		return -EINVAL;
 
 	/* Force power mode enter L0 */
diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index c71000a07656..9fc8a61eca54 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -268,13 +268,9 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
 {
 	bool is_tuning_cmd = 0;
 	bool clk_enabled;
-	u8 cmd;
 
-	if (reg == SDHCI_COMMAND) {
-		cmd = SDHCI_GET_CMD(val);
-		is_tuning_cmd = cmd == MMC_SEND_TUNING_BLOCK ||
-				cmd == MMC_SEND_TUNING_BLOCK_HS200;
-	}
+	if (reg == SDHCI_COMMAND)
+		is_tuning_cmd = mmc_op_tuning(SDHCI_GET_CMD(val));
 
 	if (is_tuning_cmd)
 		clk_enabled = tegra_sdhci_configure_card_clk(host, 0);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fb6e9a81f198..75437b0073e8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1692,8 +1692,7 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		flags |= SDHCI_CMD_INDEX;
 
 	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
-	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
+	if (cmd->data || mmc_op_tuning(cmd->opcode))
 		flags |= SDHCI_CMD_DATA;
 
 	timeout = jiffies;
@@ -3329,8 +3328,6 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 
 static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 {
-	u32 command;
-
 	/*
 	 * CMD19 generates _only_ Buffer Read Ready interrupt if
 	 * use sdhci_send_tuning.
@@ -3339,9 +3336,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	 * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
 	 */
 	if (intmask & SDHCI_INT_DATA_AVAIL && !host->data) {
-		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
-		if (command == MMC_SEND_TUNING_BLOCK ||
-		    command == MMC_SEND_TUNING_BLOCK_HS200) {
+		if (mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)))) {
 			host->tuning_done = 1;
 			wake_up(&host->buf_ready_int);
 			return;
-- 
2.29.0

