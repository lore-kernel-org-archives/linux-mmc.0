Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D430C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Feb 2022 19:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbiBITRn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:17:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiBITRj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Feb 2022 14:17:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7C5C0DE7D8;
        Wed,  9 Feb 2022 11:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5ABC61938;
        Wed,  9 Feb 2022 19:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E2C340E7;
        Wed,  9 Feb 2022 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644434124;
        bh=doDB2uOge/0eFsvsZ3gymCVqHyVcqN9XDLRmz9p8KJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvOTk5nlN7hSky5QTEEOI7nfJUuxRjEQHa3y860SMNhXlROhdrRIpr6H86k0idhm3
         Vc/L6clnK6sTsDHA8fxvZ7K8RCXUtNtupIK5thKmpiqA3OGi2aWJBPconzCH5dDfHD
         LPpFcDtezyhd3itWezNVWblmxMH8Oe8ll4+3euWE=
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
Subject: [PATCH 5.10 1/3] moxart: fix potential use-after-free on remove path
Date:   Wed,  9 Feb 2022 20:14:19 +0100
Message-Id: <20220209191248.941605067@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209191248.892853405@linuxfoundation.org>
References: <20220209191248.892853405@linuxfoundation.org>
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
@@ -708,12 +708,12 @@ static int moxart_remove(struct platform
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


