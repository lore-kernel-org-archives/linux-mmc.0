Return-Path: <SRS0=eM5z=EG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C885C388F9
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 13:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582A12071A
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 13:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqYy1OUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgJaNs1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbgJaNs1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Oct 2020 09:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604152106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=koqxXVI3CHRUKXsDex4SfEdQYS8NkBCLBnUpSAjG+sY=;
        b=KqYy1OUihDfcytXJQbwS3mCiCPUfF9PdC+sZZVUINdyEZBRWJcYdbQS6vgIJs7oH0IsH2/
        CMk4sizaKIDhE1NASy6vvNIoOClB3faX99DW48M5CcWu/78wyWnwgaCS0WFGDTY3q9lgbw
        eD8IIuw5XEY08Yirol3glQvlfGpx8cA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-2lqUNr9HO-u17LCBbT4H0w-1; Sat, 31 Oct 2020 09:48:24 -0400
X-MC-Unique: 2lqUNr9HO-u17LCBbT4H0w-1
Received: by mail-ot1-f69.google.com with SMTP id a1so3784687otb.14
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2020 06:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=koqxXVI3CHRUKXsDex4SfEdQYS8NkBCLBnUpSAjG+sY=;
        b=lnYO/M8ABASYGa1hKLTNIJcFKYTGdJtqS+fvhcp3eR6e1HwwczLglbMRGD2q7olgKJ
         BqFf3hvxfJ2gbTN+jQVPxTeh58txoz3c6J3eAnFxdFQMC1nSmMncPmrskUXylj1XVfDZ
         iOG96TVGm6z4IQ14yUfwkMrHwtLL9NibPFjo0TEtv2RSGXUEU24+6YBXRW1oK6QoETsn
         ojMtXx59YyZhoCMnMawsnOTl72zD/SNyY7QhVKaC/ozOEwAtWXFKpwWSsdZKeAuLozVc
         l5IGpe2GZpZtGiToSDBJRjMMsF/FibuaegBmys2gM7MVFyrAL76wxQPyYZ+beZIBZu6n
         txDw==
X-Gm-Message-State: AOAM5326r3WbDzHWeMxbatAKnyKZrxT7D9dX6cetgTWL4DgsqRWw+rl5
        gASXNynPxLSARQfZ5fp3wka70tcUCckqdxl3fBBsID7gejDw4CEEhUK43hAeNWZ1LPhuq5mhTwD
        gCzxATC9p15WZWmYWMIBa
X-Received: by 2002:aca:ef06:: with SMTP id n6mr3963808oih.173.1604152103470;
        Sat, 31 Oct 2020 06:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjCMbRXrdCYsKD15lUL6wntOAje2yEwKUXm9Q2bku2WeEsh3eA9hPN7AjaxlYjNcTZpy6TuQ==
X-Received: by 2002:aca:ef06:: with SMTP id n6mr3963801oih.173.1604152103349;
        Sat, 31 Oct 2020 06:48:23 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d22sm2094299oij.53.2020.10.31.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:48:22 -0700 (PDT)
From:   trix@redhat.com
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] memstick: mspro_block: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:48:18 -0700
Message-Id: <20201031134818.2135446-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/memstick/core/mspro_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index cd6b8d4f2335..afb892e7ffc6 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -276,7 +276,7 @@ static const char *mspro_block_attr_name(unsigned char tag)
 		return "attr_devinfo";
 	default:
 		return NULL;
-	};
+	}
 }
 
 typedef ssize_t (*sysfs_show_t)(struct device *dev,
-- 
2.18.1

