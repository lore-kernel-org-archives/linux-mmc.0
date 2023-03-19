Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC4C6FD1F
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Mar 2023 16:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjCSQsr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjCSQsf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Mar 2023 12:48:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C11EBC3
        for <linux-mmc@vger.kernel.org>; Sun, 19 Mar 2023 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679244470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VkDP5nwJg3NiX0wmWxZjf2UT2F8zhLNQEpn1rGiXRWY=;
        b=NXp+ni3eseIbvksloR4gYCqBR3QMn4TIbn8Pgm92Sld3HE4YYKOlpv5VzEcfAa1ppC4g+D
        AVmBYO8zbRPbpjQ3ljg4WWhum/WWxyiOQAywjfvNRK2q0CoJOrg4zRKoyyze7Ru4G8zAk5
        De09GnYhTK7VMdzr1xiyh4SOgreSP5k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-PASHLQv_OEiu6lf1KkarDw-1; Sun, 19 Mar 2023 12:47:48 -0400
X-MC-Unique: PASHLQv_OEiu6lf1KkarDw-1
Received: by mail-qt1-f199.google.com with SMTP id j4-20020ac85f84000000b003d864ebfc20so5248860qta.14
        for <linux-mmc@vger.kernel.org>; Sun, 19 Mar 2023 09:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679244468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkDP5nwJg3NiX0wmWxZjf2UT2F8zhLNQEpn1rGiXRWY=;
        b=06+x5KF6+59gZWqHdLv0EbI5KTCX0SvMexjJU49nnfVRtDsfj+NkQPzSWn7mpmLmmF
         wXa5O5O8NAOaGz/Y1o/660PsPV9ZijkewROvOOwIDJOxaVQ8N2vmY/myQzKMaUbUxXJT
         5sUxXOzsGARaKDMTq2dkgzo3EfAxCsdvWgweFvhn+d/qOqcwJPLweQ/Ab9UOEXcwhUdr
         MqZIvAXnKZfGDEANbAMCwK7+nb9GS7TQzVLxG8lODhLwUCON3SeNxZCR6USGcpoQQKU2
         7bGz95psw95btDN3Kd2kwONHUqtEkKHZ/GrlFfi5cKcVvGlrVP83KJO3A6BG+bqkRZ7V
         Radg==
X-Gm-Message-State: AO0yUKUjOl1LzBW0UbZrDATkgOE3A0JYIylzR50Rw8tHKElDIqsNeVfC
        LFNnGBVvCMjEIY0jRl+sHDYq3kXdII7lXhTb9VtpmOJ98+jJ8SagYJIxvZST16ZdqWa2JbBrPSj
        33/FPrRTkDVmNUHlveilI
X-Received: by 2002:ac8:5f83:0:b0:3bf:d71e:5af4 with SMTP id j3-20020ac85f83000000b003bfd71e5af4mr22398120qta.26.1679244468427;
        Sun, 19 Mar 2023 09:47:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set81mKcQVWIpj0FlTITDASkQiikMe5/r0glEegQKpqPmrpVC5hxR63neRzk9SnibKH7bRsoSwg==
X-Received: by 2002:ac8:5f83:0:b0:3bf:d71e:5af4 with SMTP id j3-20020ac85f83000000b003bfd71e5af4mr22398109qta.26.1679244468205;
        Sun, 19 Mar 2023 09:47:48 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 124-20020a370482000000b0073b929d0371sm5734012qke.4.2023.03.19.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:47:47 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     saschasommer@freenet.de, ulf.hansson@linaro.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] mmc: sdricoh_cs: remove unused sdricoh_readw function
Date:   Sun, 19 Mar 2023 12:47:44 -0400
Message-Id: <20230319164744.1707169-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

clang with W=1 reports
drivers/mmc/host/sdricoh_cs.c:104:28: error: unused function
  'sdricoh_readw' [-Werror,-Wunused-function]
static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
                           ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mmc/host/sdricoh_cs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 76a8cd3a186f..57b8c1a96756 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -101,14 +101,6 @@ static inline void sdricoh_writel(struct sdricoh_host *host, unsigned int reg,
 
 }
 
-static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
-					 unsigned int reg)
-{
-	unsigned int value = readw(host->iobase + reg);
-	dev_vdbg(host->dev, "rb %x 0x%x\n", reg, value);
-	return value;
-}
-
 static inline void sdricoh_writew(struct sdricoh_host *host, unsigned int reg,
 					 unsigned short value)
 {
-- 
2.27.0

