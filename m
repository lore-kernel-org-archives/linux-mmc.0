From: "Minjian Wu (minjianwu)" <minjianwu@micron.com>
Subject: [PATCH] mmc: core: mmc bus test data timeout setting
Date: Fri, 26 Jul 2013 05:06:48 +0000
Message-ID: <59606D77376AA44BB2E289FE5BA55046751F63AE@NTXXIAMBX01.xacn.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:49166 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab3GZFGz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 01:06:55 -0400
Received: from mail.micron.com (ntxboicas03.micron.com [137.201.84.59])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id r6Q56r7r032591
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jul 2013 23:06:54 -0600
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Add data timeout setting for mmc bus test command(CMD14 and CMD19).

Signed-off-by: Minjian Wu <minjianwu@micron.com>
---
 drivers/mmc/core/mmc_ops.c                     |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -562,6 +562,7 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
 
 	data.sg = &sg;
 	data.sg_len = 1;
+	mmc_set_data_timeout(&data,card);
 	sg_init_one(&sg, data_buf, len);
 	mmc_wait_for_req(host, &mrq);
 	err = 0; 

