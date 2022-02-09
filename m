Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BFAC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Feb 2022 19:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiBITRW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:17:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiBITRW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Feb 2022 14:17:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF668DD5BD08;
        Wed,  9 Feb 2022 11:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 540E361921;
        Wed,  9 Feb 2022 19:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30876C340E7;
        Wed,  9 Feb 2022 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644434135;
        bh=NoYfRKvg94/26C90i9BW28UUtPlRTuDUjNMESDy43NU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lurLDJaOzVoHjbvt1XsYNjs6yItcm9ZzfEsn9zigGlyXqmWr1XSIndE1FL0Fc9LXD
         NhiKKc3p59Ut7VA74XzLYiE0xOGGENAb50garFRf5bDFwRoM9v7ATHZT/EVngmKpJR
         DvCmzOWnXtV0S8Pce6bMRKRsJ4NAkrETR00MfzXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Xiong <xiongx18@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-mmc@vger.kernel.org, whitehat002 <hackyzh002@gmail.com>
Subject: [PATCH 5.15 1/5] moxart: fix potential use-after-free on remove path
Date:   Wed,  9 Feb 2022 20:14:26 +0100
Message-Id: <20220209191250.030905483@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209191249.980911721@linuxfoundation.org>
References: <20220209191249.980911721@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit bd2db32e7c3e35bd4d9b8bbff689434a50893546 upstream.

It was reported that the mmc host structure could be accessed after it
was freed in moxart_remove(), so fix this by saving the base register of
the device and using it instead of the pointer dereference.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: Xin Xiong <xiongx18@fudan.edu.cn>
Cc: Xin Tan <tanxin.ctf@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-mmc@vger.kernel.org
Cc: stable <stable@vger.kernel.org>
Reported-by: whitehat002 <hackyzh002@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20220127071638.4057899-1-gregkh@linuxfoundation.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/moxart-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -705,12 +705,12 @@ static int moxart_remove(struct platform
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
 	mmc_remove_host(mmc);
-	mmc_free_host(mmc);
 
 	writel(0, host->base + REG_INTERRUPT_MASK);
 	writel(0, host->base + REG_POWER_CONTROL);
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
+	mmc_free_host(mmc);
 
 	return 0;
 }


