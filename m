Return-Path: <SRS0=eM5z=EG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DA3C388F7
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 14:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B436206A5
	for <linux-mmc@archiver.kernel.org>; Sat, 31 Oct 2020 14:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WV04PlE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgJaO2L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 31 Oct 2020 10:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgJaO2K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 31 Oct 2020 10:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604154489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=KDQ2Q1WrfPeBaMWL4WQgVqLf/RWk9Z5JfCqkrJoKAU8=;
        b=WV04PlE72s9n1XzA25ckD3QCZ31nK8JY3yPgtiOtZdbLYt/Lw9syMctu4Vt7vT9bHeVvX9
        4sxX2xUH/MYg3oXHrel7z5HuchZe17AJourwJWUxkCXyNO1x5a9/S1GoRc7xARmytuVnAp
        QkGSmy091C8lVeedSsQ/ljgTbUbvnAw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-7ikn_4pXNNGarW3ZwBN9mA-1; Sat, 31 Oct 2020 10:28:07 -0400
X-MC-Unique: 7ikn_4pXNNGarW3ZwBN9mA-1
Received: by mail-ot1-f72.google.com with SMTP id k103so3471690otk.1
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2020 07:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KDQ2Q1WrfPeBaMWL4WQgVqLf/RWk9Z5JfCqkrJoKAU8=;
        b=G1XfAwngtYXTu1UDuBS+BeZ8e6JpypwhSUGKMy2sMapwoPdA7TPzTAFMUKjTtkhFav
         8bYMhO/8p8mWfmTAtR3Th+4DaLKMktUYolt2ygE5MgD5uL2OXE0dFE4p+NMdH3W3NgxM
         awxrRSpbOWgr+CUlMPY8Ek8diZ1MHyiHBuQ0Nv7Qa8IeqAJIUJtfn+9+B6hRJaXAd/LA
         Lp/MHOcX6goa6G5c4/3ax9Bj7bJuYz9r40xBFqq69pfigPotNq3YlDFzQ2hpiRgul+k3
         GUgnynNzYhwuyaPohua0lu6Z9H/por0luSyLLXsJzmpqJLxzLQ4AuTdbyPEDUXaYGdmr
         g/SA==
X-Gm-Message-State: AOAM532+tfJZiHr0oixNTOtm7FsDPpiokVDbkOLlUp3r+4cSjjKbW9pB
        iD9c4IEF0r5rlP4Lp65Jzrs+uQEGz/8GrGCgkwbSTgGsAEgLU6jGsjdzdNsoyBTETqzWuSSWX4R
        yKA+vNR2u2ddBtdWcmiFb
X-Received: by 2002:a4a:d848:: with SMTP id g8mr5776412oov.35.1604154486781;
        Sat, 31 Oct 2020 07:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL4YNo6zuxvjwLQHq+MTN5D27aIClSv1bhC8z+upoQKQkJ4Vdxt3pW0jvKVDrp7pvrCaxYTg==
X-Received: by 2002:a4a:d848:: with SMTP id g8mr5776397oov.35.1604154486629;
        Sat, 31 Oct 2020 07:28:06 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x14sm2063997ooo.43.2020.10.31.07.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 07:28:06 -0700 (PDT)
From:   trix@redhat.com
To:     oakad@yahoo.com, maximlevitsky@gmail.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] memstick: tifm: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 07:27:56 -0700
Message-Id: <20201031142756.2140029-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/memstick/host/tifm_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index 786e46798da2..57145374f6ac 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -528,7 +528,7 @@ static int tifm_ms_set_param(struct memstick_host *msh,
 		} else
 			return -EINVAL;
 		break;
-	};
+	}
 
 	return 0;
 }
-- 
2.18.1

