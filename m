Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7DCC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491982078D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os8uLJ7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJLMP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGJLME (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:12:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1456FC08C5CE;
        Fri, 10 Jul 2020 04:12:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so2416531pfi.2;
        Fri, 10 Jul 2020 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7yVpx9Ygx5/VQ/WoaheeloIQ6g4ecPLVpX/LrJKnQ8=;
        b=Os8uLJ7qBc9aLgAmNWYB9sd2IUB6Gra0WHDPMxHgQNCdWVdwc9+dOuy2xVw7UtlBue
         tkQNyIFczI63sen2wg6m7gkIX+yHVokdBpiCWcXaPTdpqrCgpQhBxe6IKmq37OmgrMbG
         zJivl/E9SLAUmosgHOAIXiVhEXQJMHFWQY1ye9fzuTEX3hvCbKB6y8Svj2DSSt/azdEL
         vrU9t6inD0KxX1iGGd75xS/MhzvRY+nI7+A2FB1y0T2Kh7stONaEiMMdDYWj1xsl+3ew
         7CZwDegcnQrUsczZ8qQTwkka4nMkSi9nyMqqZfON0jI4Ra1XWaq644vn8RE2yV0QAs5Y
         Rt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7yVpx9Ygx5/VQ/WoaheeloIQ6g4ecPLVpX/LrJKnQ8=;
        b=cX1uQ8CHJBqe96vrYSZn5y7TsXH9lWIQlT9gx4yCRRbzu23EOG0mf+WS/TVANKc85Y
         gh4Z9g/jQF/0tYyJiLBNSmtXNoFi74sWMhyrBtkngf8ELjNSagAmtWr5ia4Sr+mlFdQL
         DezDEEFxz09mHedPiEFTljcgJBzugQsELC4eK7InUD91EMHbxQyv8mu3yqpfMimdsyBR
         t6Amti6rjzJSERXj/xSvZTYkm0Mv5q+kusGxLSjk8YErw/bujb2bHFr7RWntF5GtSBG+
         ItVjwbZGKjofa2CSmOyuQCJAaMCxhff0DLxp1UjVGotaYj+zQwuj4gDrE9QZFN46Pygf
         LBxQ==
X-Gm-Message-State: AOAM531VYCthftH4wbADSQWUT95FrUqRzGnUWgtg46wr9vPC3B4Rjhl3
        Ihl3Wy95gDIpF+RIsbZT5LE=
X-Google-Smtp-Source: ABdhPJwk+ecIgJlHDMQzbxsodEXMOQGmZRDBOAjMNyfp/q/BE8CrQjcv+FHjPXZzeSJxmeF8tMfvoA==
X-Received: by 2002:a63:d250:: with SMTP id t16mr56958474pgi.51.1594379523645;
        Fri, 10 Jul 2020 04:12:03 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x7sm5842904pfq.197.2020.07.10.04.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:12:03 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 19/21] mmc: core: add post-mmc_attach_sd hook
Date:   Fri, 10 Jul 2020 19:12:47 +0800
Message-Id: <20200710111247.29937-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This "post" hook for mmc_attach_sd() will be required to enable UHS-II
support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/sd.c    | 6 ++++++
 include/linux/mmc/host.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c5b071bd98b3..fd4cae4ed747 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1381,6 +1381,12 @@ int mmc_attach_sd(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	/* TODO: Is this the right place? */
+	if ((host->flags & MMC_UHS2_INITIALIZED) &&
+	    host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+
 	return 0;
 
 remove_card:
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 56bdb153ef16..e61e0ae62cff 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -180,6 +180,7 @@ struct mmc_host_ops {
 	int	(*uhs2_set_reg)(struct mmc_host *host, enum uhs2_act act);
 	void    (*uhs2_disable_clk)(struct mmc_host *host);
 	void    (*uhs2_enable_clk)(struct mmc_host *host);
+	void    (*uhs2_post_attach_sd)(struct mmc_host *host);
 };
 
 struct mmc_cqe_ops {
-- 
2.27.0

