Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2FC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 06:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156CE611CB
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 06:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhKDGfp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:35:45 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:28150 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbhKDGff (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2021 02:35:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211104063256epoutp01ee4ec225bc40a3abee317de421a0837f~0RDkkXRrz2260022600epoutp01d
        for <linux-mmc@vger.kernel.org>; Thu,  4 Nov 2021 06:32:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211104063256epoutp01ee4ec225bc40a3abee317de421a0837f~0RDkkXRrz2260022600epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636007576;
        bh=HbUW4qifAWoNUuU9gayTS1pIYwS2WitkSoJNEgHsies=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eq+sBj5rSH1cPIigM8ji5Y6LYK8ou50Gy1JzH6jjV6hN1oSVrXyBPnlv2j17QmWbc
         /fNOAerCHtICjxyQ8QEBMMnV2wjKskRWA2A/dMPO4zgvWBoynB/o4xVhd6uC5d2VZF
         Q75KZ4Byr8OVpBDVwXLx/pJYxvIDQlSijUnKgAO0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211104063256epcas1p4b7b0f710764b287e59389e671d60b126~0RDkLwAuX2541625416epcas1p49;
        Thu,  4 Nov 2021 06:32:56 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.243]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HlDN50Y71z4x9QW; Thu,  4 Nov
        2021 06:32:53 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.D8.64085.29E73816; Thu,  4 Nov 2021 15:32:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211104063250epcas1p36056caad956e599300146bae77f799d6~0RDe6DQHw0544305443epcas1p3D;
        Thu,  4 Nov 2021 06:32:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211104063250epsmtrp132d1cb882998642c86b71cea5f8bcda1~0RDe5blWs0558305583epsmtrp1z;
        Thu,  4 Nov 2021 06:32:50 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-6e-61837e9261f7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.19.29871.29E73816; Thu,  4 Nov 2021 15:32:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.98.193]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211104063250epsmtip2a64034e61511a06726339c954d48cd69~0RDes1Z4i2388323883epsmtip2m;
        Thu,  4 Nov 2021 06:32:50 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>,
        Huijin Park <huijin.park@samsung.com>
Subject: [PATCH v2 2/2] mmc: core: adjust polling interval for CMD1
Date:   Thu,  4 Nov 2021 15:32:31 +0900
Message-Id: <20211104063231.2115-3-huijin.park@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104063231.2115-1-huijin.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmge7kuuZEg1VfGC1e7j3EbNFx0cXi
        8q45bBZH/vczWhxfG+7A6rFz1l12jzvX9rB59G1ZxejxeZNcAEtUtk1GamJKapFCal5yfkpm
        XrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0FYlhbLEnFKgUEBicbGSvp1NUX5p
        SapCRn5xia1SakFKToFZgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGnL8bGAumK1bs+3eJuYHx
        m2QXIyeHhICJxJk9s9i6GLk4hAR2MEr8u7GdHcL5xChx9NchVgjnG6PE5yN32WBavre1sUAk
        9jJKrO/5iNCypWkBE0gVm4C2xPW1WxlBbBEBDYk9D8+zgtjMAl2MEjdvOYDYwgLOEhNmngKL
        swioSuz6d4QZxOYVsJb4+38lE8Q2eYmZl76zg9icAjYSS57/ZoKoEZQ4OfMJC8RMeYnmrbOZ
        QY6QELjELrFjxQ1GiGYXidYpc6FsYYlXx7ewQ9hSEi/726DscoldE65CNTcwSvSt/c4KkTCW
        ePd2LVCCA2iDpsT6XfoQYUWJnb8hZjIL8Em8+9rDClIiIcAr0dEmBFGiKrH46keoKdIShx7c
        hTrBQ+LBjlZokPYzSsx9Ppd1AqPCLCT/zELyzyyEzQsYmVcxiqUWFOempxYbFhjC4zg5P3cT
        IzgdapnuYJz49oPeIUYmDsZDjBIczEoivM83NCUK8aYkVlalFuXHF5XmpBYfYjQFhvZEZinR
        5HxgQs4riTc0sTQwMTMysTC2NDZTEuf9LFeYKCSQnliSmp2aWpBaBNPHxMEp1cC0XHbnOS21
        J/7txs7nWtfvMMi//5bBUei5cXLk5LN/d7B4nt3y+WKejcYMVQelMq4Z07e9WVdmsHSBYVrT
        pjVWdSosTLFhn9XYVZYL1jhXf10b++/4ug137VXXnphzu2u5SNbvnI28FzO5X2ovO71+etyF
        7/VLF25mmq7zbedi9oZHWkwfvlrKsKRtzXTbsPTD2aW/haO3Gzz+83LZjPU5J3a+Fen6UM+2
        73JkgH5+wKsurjcpf9ZOrpayVtEJYnBir0mU+6NaWy3e8jp4H9ubA19t1wXd/NDZxayekCnA
        Jrqr9+7+uieqHxe/vVpZs/nfHvnPfnldWx+c+nuSW57pyRyR4pAIpSW6zX94/r7VUWIpzkg0
        1GIuKk4EAGs5Z3sQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvO6kuuZEg6uL1C1e7j3EbNFx0cXi
        8q45bBZH/vczWhxfG+7A6rFz1l12jzvX9rB59G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8ac
        vxsYC6YrVuz7d4m5gfGbZBcjJ4eEgInE97Y2li5GLg4hgd2MEhNP3WKBSEhLvNt5nbWLkQPI
        FpY4fLgYJCwk8IFR4ulicxCbTUBb4vrarYwgtoiAhsSeh+dZQWxmgT5Gic5fWSC2sICzxISZ
        p8DiLAKqErv+HWEGsXkFrCX+/l/JBLFKXmLmpe/sIDangI3Ekue/mUDWCgHVnFgXA1EuKHFy
        5hMWiPHyEs1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M
        4HDV0tzBuH3VB71DjEwcjIcYJTiYlUR4n29oShTiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6Hr
        ZLyQQHpiSWp2ampBahFMlomDU6qBac/y5ZMWXHNa1mmfLOK+7cf53YrVxSXXOr8Ydb17HMa8
        VUerNDJp7ao5z3oCXxgyeOVdCnm9btWzuvOPv9jFu967I9BicsFhtjP3WicF9q55HhFLJxxk
        8nsxW+njlMjTS+zdc1y+K7NwTTjkvnC7tF2SmfrP5e9Pxu8699En3qAuz8nri0tzsPlzPY52
        bp/+UxFWuyJ+TnHnLC1qj9t3KP3vwhQF9b2XbkvInT28M2lD1bxboo9Ov9n46vGHizafVdNb
        fx/U93+/ryhwUpPNKotneeJqTemLC2bztgUW+JfemXbudtYb70+TCxTcX/j5pu6aezfvQmfK
        eV2X7i+pQavWZEZNFLyWeT/zqMybC0osxRmJhlrMRcWJADDv6mPGAgAA
X-CMS-MailID: 20211104063250epcas1p36056caad956e599300146bae77f799d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211104063250epcas1p36056caad956e599300146bae77f799d6
References: <20211104063231.2115-1-huijin.park@samsung.com>
        <CGME20211104063250epcas1p36056caad956e599300146bae77f799d6@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In mmc_send_op_cond(), loops are continuously performed at the same
interval of 10 ms.  However the behaviour is not good for some eMMC
which can be out from a busy state earlier than 10 ms if normal.

Rather than fixing about the interval time in mmc_send_op_cond(),
let's instead convert into using the common __mmc_poll_for_busy().

The reason for adjusting the interval time is that it is important
to reduce the eMMC initialization time, especially in devices that
use eMMC as rootfs.

Test log(eMMC:KLM8G1GETF-B041):

before: 12 ms (0.311016 - 0.298729)
[    0.295823] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    0.298729] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
[    0.311016] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
[    0.311336] mmc0: starting CMD2 arg 00000000 flags 00000007

after: 2 ms (0.301270 - 0.298762)
[    0.295862] mmc0: starting CMD0 arg 00000000 flags 000000c0
[    0.298762] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
[    0.299067] mmc0: starting CMD1 arg 40000080 flags 000000e1
[    0.299441] mmc0: starting CMD1 arg 40000080 flags 000000e1
[    0.299879] mmc0: starting CMD1 arg 40000080 flags 000000e1
[    0.300446] mmc0: starting CMD1 arg 40000080 flags 000000e1
[    0.301270] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
[    0.301572] mmc0: starting CMD2 arg 00000000 flags 00000007

Signed-off-by: Huijin Park <huijin.park@samsung.com>

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 9946733a34c6..d63d1c735335 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -58,6 +58,12 @@ struct mmc_busy_data {
 	enum mmc_busy_cmd busy_cmd;
 };
 
+struct mmc_op_cond_busy_data {
+	struct mmc_host *host;
+	u32 ocr;
+	struct mmc_command *cmd;
+};
+
 int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries)
 {
 	int err;
@@ -173,43 +179,62 @@ int mmc_go_idle(struct mmc_host *host)
 	return err;
 }
 
+static int __mmc_send_op_cond_cb(void *cb_data, bool *busy)
+{
+	struct mmc_op_cond_busy_data *data = cb_data;
+	struct mmc_host *host = data->host;
+	struct mmc_command *cmd = data->cmd;
+	u32 ocr = data->ocr;
+	int err = 0;
+
+	err = mmc_wait_for_cmd(host, cmd, 0);
+	if (err)
+		return err;
+
+	if (mmc_host_is_spi(host)) {
+		if (!(cmd->resp[0] & R1_SPI_IDLE)) {
+			*busy = false;
+			return 0;
+		}
+	} else {
+		if (cmd->resp[0] & MMC_CARD_BUSY) {
+			*busy = false;
+			return 0;
+		}
+	}
+
+	*busy = true;
+
+	/*
+	 * According to eMMC specification v5.1 section 6.4.3, we
+	 * should issue CMD1 repeatedly in the idle state until
+	 * the eMMC is ready. Otherwise some eMMC devices seem to enter
+	 * the inactive mode after mmc_init_card() issued CMD0 when
+	 * the eMMC device is busy.
+	 */
+	if (!ocr && !mmc_host_is_spi(host))
+		cmd->arg = cmd->resp[0] | BIT(30);
+
+	return 0;
+}
+
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
 	struct mmc_command cmd = {};
-	int i, err = 0;
+	int err = 0;
+	struct mmc_op_cond_busy_data cb_data = {
+		.host = host,
+		.ocr = ocr,
+		.cmd = &cmd
+	};
 
 	cmd.opcode = MMC_SEND_OP_COND;
 	cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
 
-	for (i = 100; i; i--) {
-		err = mmc_wait_for_cmd(host, &cmd, 0);
-		if (err)
-			break;
-
-		/* wait until reset completes */
-		if (mmc_host_is_spi(host)) {
-			if (!(cmd.resp[0] & R1_SPI_IDLE))
-				break;
-		} else {
-			if (cmd.resp[0] & MMC_CARD_BUSY)
-				break;
-		}
-
-		err = -ETIMEDOUT;
-
-		mmc_delay(10);
-
-		/*
-		 * According to eMMC specification v5.1 section 6.4.3, we
-		 * should issue CMD1 repeatedly in the idle state until
-		 * the eMMC is ready. Otherwise some eMMC devices seem to enter
-		 * the inactive mode after mmc_init_card() issued CMD0 when
-		 * the eMMC device is busy.
-		 */
-		if (!ocr && !mmc_host_is_spi(host))
-			cmd.arg = cmd.resp[0] | BIT(30);
-	}
+	err = __mmc_poll_for_busy(host, 1000, &__mmc_send_op_cond_cb, &cb_data);
+	if (err)
+		return err;
 
 	if (rocr && !mmc_host_is_spi(host))
 		*rocr = cmd.resp[0];
-- 
2.17.1

