Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD171C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 06:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B550A61056
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Nov 2021 06:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhKDGfa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Nov 2021 02:35:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:28014 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhKDGf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2021 02:35:29 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211104063250epoutp01ffbe446d57c9ec68d50cd6c7cb59368c~0RDeZ7tXc2247022470epoutp01a
        for <linux-mmc@vger.kernel.org>; Thu,  4 Nov 2021 06:32:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211104063250epoutp01ffbe446d57c9ec68d50cd6c7cb59368c~0RDeZ7tXc2247022470epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636007570;
        bh=i8bLZHLvtSevkStEmGjE3Xk1rIqhSiRrh5sy93Gyqck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iTrf0cOORKNAdnCmy3OE8ziSDUKVirfCshdbtexRRQYFmYHSvyGaAECcmhScj06+t
         nsOXkTBCJvbXeIoKUMHMjvy4wZF/gte/XUMwa4GyUYz5KebwU1nZ65wdvHrPdFfTxl
         4LDcnmpLTKm+PlpBd0U6Xy6JrzdPGREVPWNz21BE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211104063249epcas1p2ac000fe375d7a1391fa5802bd3d2db75~0RDd9olkx2737727377epcas1p2D;
        Thu,  4 Nov 2021 06:32:49 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.241]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HlDMz5jJKz4x9Px; Thu,  4 Nov
        2021 06:32:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.E7.08277.F8E73816; Thu,  4 Nov 2021 15:32:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211104063247epcas1p15d9d319877f1a8519c0ee52a41a176ef~0RDbzfG7e2036320363epcas1p18;
        Thu,  4 Nov 2021 06:32:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211104063247epsmtrp2f500c94e65b25fc5f37a26a8e04d00c9~0RDbyusfJ2082120821epsmtrp2B;
        Thu,  4 Nov 2021 06:32:47 +0000 (GMT)
X-AuditID: b6c32a36-203ff70000002055-f0-61837e8f585c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.19.29871.F8E73816; Thu,  4 Nov 2021 15:32:47 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.98.193]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211104063247epsmtip2f168f4c3dadec77465718e93cffb1203~0RDbl8dwH1646816468epsmtip2k;
        Thu,  4 Nov 2021 06:32:47 +0000 (GMT)
From:   Huijin Park <huijin.park@samsung.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>,
        Huijin Park <huijin.park@samsung.com>
Subject: [PATCH v2 1/2] mmc: core: change __mmc_poll_for_busy() parameter
 type
Date:   Thu,  4 Nov 2021 15:32:30 +0900
Message-Id: <20211104063231.2115-2-huijin.park@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104063231.2115-1-huijin.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmgW5/XXOiwbsd2hYv9x5itui46GJx
        edccNosj//sZLY6vDXdg9dg56y67x51re9g8+rasYvT4vEkugCUq2yYjNTEltUghNS85PyUz
        L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
        JFUhI7+4xFYptSAlp8CsQK84Mbe4NC9dLy+1xMrQwMDIFKgwITvj35qnzAWPZSqaXi5mbmDc
        LNHFyMkhIWAice7XXtYuRi4OIYEdjBKH105lhnA+MUrsunWPBaRKSOAbo8SxZnaYjs/nH0EV
        7WWUeNH9kxGu48e3VUwgVWwC2hLX125lBLFFBDQk9jw8zwpiMwt0MUrcvOUAYgsLBEg0ty8A
        q2ERUJU4f2wnG4jNK2At8XjSRKht8hIzL30HszkFbCSWPP/NBFEjKHFy5hMWiJnyEs1bZ4Nd
        JCFwjl3i0cZJjBDNLhL3v01hg7CFJV4d3wI1VEri87u9UPFyiV0TrkI1NzBK9K39zgqRMJZ4
        93YtUIIDaIOmxPpd+hBhRYmdv+cyQizmk3j3tYcVpERCgFeio00IokRVYvHVj1BTpCUOPbgL
        dY6HxPWWOWyQwOpnlFi/+Q37BEaFWUj+mYXkn1kImxcwMq9iFEstKM5NTy02LDCCR3Fyfu4m
        RnAy1DLbwTjp7Qe9Q4xMHIyHGCU4mJVEeJ9vaEoU4k1JrKxKLcqPLyrNSS0+xGgKDO2JzFKi
        yfnAdJxXEm9oYmlgYmZkYmFsaWymJM77Wa4wUUggPbEkNTs1tSC1CKaPiYNTqoHJXYnX/2oB
        c2qht/uRpul1M+4qW26UT9S/5KR+W1U/8GBQxi/PgKP9nPf3XJ6ouvur4q2GNcq35qqnR/PZ
        K6Q9DDuu2fLy7EX5/5Pe78kPXPFpw7NP1rXKxqLx6vmrphzVnqFl9PpAcKlOi4+VidTpgkcb
        Lr1badjyaM3WY/nVt8L/5JguqrxltvXhHIa/Hgu8nUPF+/0fxoubMrAFn9t84KVv1+1bfTvf
        vM6v22z67mdK5+w6465vn6bF5WinNe9PKXv5vTrI+ZXTu+e/udhkj82YVr2dL+Dgzj+TN3zb
        zp0W+VtP5XLFNt6CjDPLpqZeWbKQZ24jI5Pb8Rkc2UqdefOkz5fNWcCvyt4mJ3tNiaU4I9FQ
        i7moOBEA0YSUng8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSvG5/XXOiwdNHQhYv9x5itui46GJx
        edccNosj//sZLY6vDXdg9dg56y67x51re9g8+rasYvT4vEkugCWKyyYlNSezLLVI3y6BK+Pf
        mqfMBY9lKppeLmZuYNws0cXIySEhYCLx+fwj5i5GLg4hgd2MEkuObmeCSEhLvNt5nbWLkQPI
        FpY4fLgYouYDo8STZV+YQWrYBLQlrq/dyghiiwhoSOx5eJ4VxGYW6GOU6PyVBWILC/hJzJrZ
        DVbPIqAqcf7YTjYQm1fAWuLxpInsELvkJWZe+g5mcwrYSCx5/psJZK8QUM2JdTEQ5YISJ2c+
        YYEYLy/RvHU28wRGgVlIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgO
        WC3NHYzbV33QO8TIxMF4iFGCg1lJhPf5hqZEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7G
        CwmkJ5akZqemFqQWwWSZODilGpjCko0Pugj9v6TQH/CCtyn76L7nbe+/JW1dH7GkYL+zkMXt
        8LysE1lztBZO17LJnBvyWUUuJ9XaT10jRqWw+qHY4genZk0M6Tqq/Hjf3s1V5bLBt6rXm+65
        G6caNCurq8Oj6MNl42M3pyuKhLHI/m1rm3ny8S8J32Qr1ylPz/ffnygeaa87K6FZfk7+37kr
        U1+5ZO9dq/btOK/htNWPwqZyJqi/vfT8e9HpMsutardkemYfuevuI1TbpjWPp/NDFcc/tk2p
        7srNO1K8jT/KC78ynLaj2laJ/ZMJh8G/JxuYvyfsX37kYOybFW78ci9jc8qn/xY5IWXrmn7B
        xS5dWND2svniVs5qG9lMHqfItUosxRmJhlrMRcWJAGfFI1nHAgAA
X-CMS-MailID: 20211104063247epcas1p15d9d319877f1a8519c0ee52a41a176ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211104063247epcas1p15d9d319877f1a8519c0ee52a41a176ef
References: <20211104063231.2115-1-huijin.park@samsung.com>
        <CGME20211104063247epcas1p15d9d319877f1a8519c0ee52a41a176ef@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch changes the __mmc_poll_for_busy() first parameter type
from 'struct mmc_card*' to 'struct mmc_host*'.
Because the function refers only 'struct mmc_host' to get hostname.

Signed-off-by: Huijin Park <huijin.park@samsung.com>

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 61590cf7a7b1..5a39026e5b0f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1908,8 +1908,8 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 
 	cb_data.card = card;
 	cb_data.status = 0;
-	err = __mmc_poll_for_busy(card, MMC_BLK_TIMEOUT_MS, &mmc_blk_busy_cb,
-				  &cb_data);
+	err = __mmc_poll_for_busy(card->host, MMC_BLK_TIMEOUT_MS,
+				  &mmc_blk_busy_cb, &cb_data);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b1c1716dacf0..bbbbcaf70a59 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1962,7 +1962,7 @@ static int mmc_sleep(struct mmc_host *host)
 		goto out_release;
 	}
 
-	err = __mmc_poll_for_busy(card, timeout_ms, &mmc_sleep_busy_cb, host);
+	err = __mmc_poll_for_busy(host, timeout_ms, &mmc_sleep_busy_cb, host);
 
 out_release:
 	mmc_retune_release(host);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 0c54858e89c0..9946733a34c6 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -470,11 +470,10 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 	return 0;
 }
 
-int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+int __mmc_poll_for_busy(struct mmc_host *host, unsigned int timeout_ms,
 			int (*busy_cb)(void *cb_data, bool *busy),
 			void *cb_data)
 {
-	struct mmc_host *host = card->host;
 	int err;
 	unsigned long timeout;
 	unsigned int udelay = 32, udelay_max = 32768;
@@ -515,13 +514,14 @@ EXPORT_SYMBOL_GPL(__mmc_poll_for_busy);
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
 {
+	struct mmc_host *host = card->host;
 	struct mmc_busy_data cb_data;
 
 	cb_data.card = card;
 	cb_data.retry_crc_err = retry_crc_err;
 	cb_data.busy_cmd = busy_cmd;
 
-	return __mmc_poll_for_busy(card, timeout_ms, &mmc_busy_cb, &cb_data);
+	return __mmc_poll_for_busy(host, timeout_ms, &mmc_busy_cb, &cb_data);
 }
 EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index e5e94567a9a9..9c813b851d0b 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -41,7 +41,7 @@ int mmc_can_ext_csd(struct mmc_card *card);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 			  unsigned int timeout_ms);
-int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+int __mmc_poll_for_busy(struct mmc_host *host, unsigned int timeout_ms,
 			int (*busy_cb)(void *cb_data, bool *busy),
 			void *cb_data);
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 4646b7a03db6..e223275bbad1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1665,7 +1665,7 @@ static int sd_poweroff_notify(struct mmc_card *card)
 
 	cb_data.card = card;
 	cb_data.reg_buf = reg_buf;
-	err = __mmc_poll_for_busy(card, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
+	err = __mmc_poll_for_busy(card->host, SD_POWEROFF_NOTIFY_TIMEOUT_MS,
 				  &sd_busy_poweroff_notify_cb, &cb_data);
 
 out:
-- 
2.17.1

