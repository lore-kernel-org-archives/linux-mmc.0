Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD230C433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FBE20737
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664590;
	bh=gaxOcen6Q9dN8HfcwwrP4yk5frKodCMa00mJuEccJdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d8Micxu9xJOvHXHxjDTBbuMV/QiCd0Pq4I5fKp1Ie99MkTRu08aWwhkNu3t+6JEz9
	 kL+KVup+nVoJIqrSZ7j9MnaRJNYaeCoreqBGdAPPbU0TISTro20Q4iqbE/fKjGzbQA
	 jvq58WIgHpzMKPp2E8Y09DfC/Tmx7gkh6cE138rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgFHXHs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbgFHXHr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FA22085B;
        Mon,  8 Jun 2020 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657667;
        bh=gaxOcen6Q9dN8HfcwwrP4yk5frKodCMa00mJuEccJdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCZo0I1Ybf6xpusNtSPDjTtVn7SdvFYmZsk8z4q0H65Gp0xd9wKbKvdRp6oG8Rrhn
         uFlmGyQzPYeD88aIdsKXqGmOVE5sg0XYBd80Et3Yr7O7Fnw3z6zsSH+919Oe8q9g/N
         wvUzGuhXgwrSsbXZlKUGMdHWJhXujfzlpmVU6t0I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Tobias Baumann <017623705678@o2online.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 077/274] mmc: meson-mx-sdio: trigger a soft reset after a timeout or CRC error
Date:   Mon,  8 Jun 2020 19:02:50 -0400
Message-Id: <20200608230607.3361041-77-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 91995b904ec2e44b5c159ac6a5d3f154345a4de7 ]

The vendor driver (from the 3.10 kernel) triggers a soft reset every
time before starting a new command. While this fixes a problem where
SDIO cards are not detected at all (because all commands simply
timed out) this hurts SD card read performance a bit (in my tests
between 10% to 20%).

Trigger a soft reset after we got a CRC error or if the previous command
timed out (just like the vendor driver from the same 3.10 kernel for the
newer SDHC controller IP does). This fixes detection of SDIO cards and
doesn't hurt SD card read performance at the same time.

With this patch the initialization of an RTL8723BS SDIO card looks like
this:
  req done (CMD52): -110: 00000000 00000000 00000000 00000000
  clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 1 timing 0
  starting CMD0 arg 00000000 flags 000000c0
  req done (CMD0): 0: 00000000 00000000 00000000 00000000
  clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 0
  starting CMD8 arg 000001aa flags 000002f5
  req done (CMD8): -110: 00000000 00000000 00000000 00000000
  starting CMD5 arg 00000000 flags 000002e1
  req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
  starting CMD5 arg 00200000 flags 000002e1
  req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
  starting CMD3 arg 00000000 flags 00000075
  req done (CMD3): 0: 00010000 00000000 00000000 00000000
  starting CMD7 arg 00010000 flags 00000015
  req done (CMD7): 0: 00001e00 00000000 00000000 00000000
  starting CMD52 arg 00000000 flags 00000195
  req done (CMD52): 0: 00001032 00000000 00000000 00000000
  [... more CMD52 omitted ...]
  clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
  clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
  starting CMD52 arg 00000e00 flags 00000195
  req done (CMD52): 0: 00001000 00000000 00000000 00000000
  starting CMD52 arg 80000e02 flags 00000195
  req done (CMD52): 0: 00001002 00000000 00000000 00000000
  clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 2
  starting CMD52 arg 00020000 flags 00000195
  req done (CMD52): 0: 00001007 00000000 00000000 00000000
  [... more CMD52 omitted ...]
  new high speed SDIO card at address 0001

Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lore.kernel.org/r/20200503222805.2668941-1-martin.blumenstingl@googlemail.com
Tested-by: Tobias Baumann <017623705678@o2online.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/meson-mx-sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 2e58743d83bb..3813b544f571 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -246,6 +246,9 @@ static void meson_mx_mmc_request_done(struct meson_mx_mmc_host *host)
 
 	mrq = host->mrq;
 
+	if (host->cmd->error)
+		meson_mx_mmc_soft_reset(host);
+
 	host->mrq = NULL;
 	host->cmd = NULL;
 
-- 
2.25.1

