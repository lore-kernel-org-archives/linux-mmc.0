Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF39C28CC4
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F97C64E62
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbhCCBr6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:47:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384036AbhCBNwh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Mar 2021 08:52:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8CF964F84;
        Tue,  2 Mar 2021 11:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614686278;
        bh=JNK95SdVhIVLOXU8nEZ/8IUZMewWsAmR59ci6jG+V2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBpGvjhS/oWpV02faACmZPKn61sLqLi1Hh7GRiAaXZZCQMYJPWZArxRFAxx1JwYBz
         mEzux85JXoC+Jt14M0OngS9+WsBAkPDgd7kft2UpzW6Wrj1PQUWkiIDzDsElIxUZ/N
         MSr+EGikOfZjNWzb5BERACLpCrD682X+URIrwLaxdkwTwRAkVg+T2gz+lz5qFUpiZ/
         Tl3LHW4PZJvx0uIks2m/qx8/nL7erXvOw4xa2pHNPis9JLbDj4as9RR31a/d1gYqt1
         xDlbZkaMdVX3T/dqWyLn0WZNyKJPziOI5hPK4D2YRQ5oQkQOvThw0g3eIk/mGE3yae
         s/qfFiNXV8oAg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 06/33] mmc: mediatek: fix race condition between msdc_request_timeout and irq
Date:   Tue,  2 Mar 2021 06:57:22 -0500
Message-Id: <20210302115749.62653-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302115749.62653-1-sashal@kernel.org>
References: <20210302115749.62653-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Chaotian Jing <chaotian.jing@mediatek.com>

[ Upstream commit 0354ca6edd464a2cf332f390581977b8699ed081 ]

when get request SW timeout, if CMD/DAT xfer done irq coming right now,
then there is race between the msdc_request_timeout work and irq handler,
and the host->cmd and host->data may set to NULL in irq handler. also,
current flow ensure that only one path can go to msdc_request_done(), so
no need check the return value of cancel_delayed_work().

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Link: https://lore.kernel.org/r/20201218071611.12276-1-chaotian.jing@mediatek.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 9d47a2bd2546..1254a5650cff 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1020,13 +1020,13 @@ static void msdc_track_cmd_data(struct msdc_host *host,
 static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
 {
 	unsigned long flags;
-	bool ret;
 
-	ret = cancel_delayed_work(&host->req_timeout);
-	if (!ret) {
-		/* delay work already running */
-		return;
-	}
+	/*
+	 * No need check the return value of cancel_delayed_work, as only ONE
+	 * path will go here!
+	 */
+	cancel_delayed_work(&host->req_timeout);
+
 	spin_lock_irqsave(&host->lock, flags);
 	host->mrq = NULL;
 	spin_unlock_irqrestore(&host->lock, flags);
@@ -1046,7 +1046,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 	bool done = false;
 	bool sbc_error;
 	unsigned long flags;
-	u32 *rsp = cmd->resp;
+	u32 *rsp;
 
 	if (mrq->sbc && cmd == mrq->cmd &&
 	    (events & (MSDC_INT_ACMDRDY | MSDC_INT_ACMDCRCERR
@@ -1067,6 +1067,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
 
 	if (done)
 		return true;
+	rsp = cmd->resp;
 
 	sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
 
@@ -1254,7 +1255,7 @@ static void msdc_data_xfer_next(struct msdc_host *host,
 static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 				struct mmc_request *mrq, struct mmc_data *data)
 {
-	struct mmc_command *stop = data->stop;
+	struct mmc_command *stop;
 	unsigned long flags;
 	bool done;
 	unsigned int check_data = events &
@@ -1270,6 +1271,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
 
 	if (done)
 		return true;
+	stop = data->stop;
 
 	if (check_data || (stop && stop->error)) {
 		dev_dbg(host->dev, "DMA status: 0x%8X\n",
-- 
2.30.1

