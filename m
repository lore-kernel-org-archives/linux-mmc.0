From: Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/3] mmc: dw_mmc: call mmc_of_parse to fill in common options
Date: Sun, 19 Jan 2014 19:56:54 -0800
Message-ID: <1390190215-22700-3-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42140 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbaATD4B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jan 2014 22:56:01 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so6536286pab.1
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jan 2014 19:56:00 -0800 (PST)
In-Reply-To: <1390190215-22700-1-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, chris@printf.net, Olof Johansson <olof@lixom.net>

The shared of parse function fills in common options for capabilities,
etc, but it needs to be called from each driver that wants to make use
of it. dw_mmc was missing the call.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/mmc/host/dw_mmc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24..7119f63 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2137,6 +2137,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (!mmc)
 		return -ENOMEM;
 
+	mmc_of_parse(mmc);
+
 	slot = mmc_priv(mmc);
 	slot->id = id;
 	slot->mmc = mmc;
-- 
1.7.10.4

