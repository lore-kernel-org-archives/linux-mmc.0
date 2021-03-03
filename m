Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CE9C4332D
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B205B64F5B
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhCDAAg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349278AbhCCN45 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 08:56:57 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED6C061356
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 05:55:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id u16so5772270wrt.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2021 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ty0BzBDNPFd+4Q3CQdXodQA+pq5y755+2zWo49k15dc=;
        b=vPU2cpPrXqRPQjdvIZ5y1sDo76JnkGXxuh3u21DG73cAmeDzm2Iqk+DajmBGMambD4
         larStOihTuOwXTxzhjpNkeEZOfylXyxk1rc1djLp2tBV0fSCsGpsBJhzhx7vaQXQQY0o
         +texv1rR+Dyeg+KR64oU8fCZfU2rwqyRWQ1CbGN4LctCb9A700AMVH2tQ2fzRVbCPqXp
         XFiCbKye6XzgQRiCHG+V2g4zTk72wxJdLhFK3L3EX80XtfuYdR8bwOOx1JWOqAAAJHeG
         q8Ge9XpOU0HUSmy8un+qpD0oN+F7fOHBCuUZ8S8X9ElUoqTJrXJFXjnDEqCKQdOzmErY
         Di0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ty0BzBDNPFd+4Q3CQdXodQA+pq5y755+2zWo49k15dc=;
        b=c3KzdlTi3Edw1QJEWAXV9txEeLINh0etyqvP97kjfsynWiyyizPD/GIcmJHPFbtKab
         qRk1eaFke0R+I3HDxcM1M0ItJvVsbt5QmpJVshcxC3SokuT1nmKTJ6yWgyx+67/L5L+W
         PeHGlFDnZOU2z2ZkpQqZzcgaOdXAhZA6l7DULGA1KgljXQGaAvIcS94CIT2nPLkyiBy+
         zlSpbJLQ4jmnJalz1DUpsEXrSksqs5fKqtIJzjvdbhn0CQiAWDng+UjGLzU0uhm00DhT
         hleidra8xyOO5L+Gaklt3yofIiDSw6HjnUrVJ0PXWtyQHLfheftotjmj3Vt5Wa8VeMBd
         4H0A==
X-Gm-Message-State: AOAM533L0daVwtMJHpptecNuNx4sihrFPtQqeBx2aNZAdOAk2/jDWc0W
        okE7LgUrQz6fFaFF61VIc/csaQ==
X-Google-Smtp-Source: ABdhPJwi5nmL+zXteQsjQGsjHpIU26byW+qlik7BOIakozNfL2yoCTXbIq3y9fVry18+g8PqUY+bwQ==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr21988503wrn.213.1614779709687;
        Wed, 03 Mar 2021 05:55:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id u4sm25329574wrm.24.2021.03.03.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:55:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id D32EE1FF91;
        Wed,  3 Mar 2021 13:55:00 +0000 (GMT)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH  5/5] tools/rpmb: simple test sequence
Date:   Wed,  3 Mar 2021 13:55:00 +0000
Message-Id: <20210303135500.24673-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303135500.24673-1-alex.bennee@linaro.org>
References: <20210303135500.24673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A simple test script to exercise the rpmb interface.

Signed-off-by: Alex BennÃ©e <alex.bennee@linaro.org>
---
 tools/rpmb/key     |  1 +
 tools/rpmb/test.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 tools/rpmb/key
 create mode 100755 tools/rpmb/test.sh

diff --git a/tools/rpmb/key b/tools/rpmb/key
new file mode 100644
index 000000000000..2b6bd3bc3fe6
--- /dev/null
+++ b/tools/rpmb/key
@@ -0,0 +1 @@
+˜ƒÆÐh«#×¢ö‹pRTà¿®åô\r|OŠ	¯mo«
\ No newline at end of file
diff --git a/tools/rpmb/test.sh b/tools/rpmb/test.sh
new file mode 100755
index 000000000000..ae5ce49a412f
--- /dev/null
+++ b/tools/rpmb/test.sh
@@ -0,0 +1,13 @@
+#!/bin/sh -e
+echo "get info"
+./rpmb -v get-info /dev/rpmb0
+echo "program key"
+./rpmb -v program-key /dev/rpmb0 key
+echo "get write counter"
+./rpmb -v write-counter /dev/rpmb0
+echo "generating data"
+dd if=/dev/urandom of=data.in count=1 bs=256
+echo "write data"
+./rpmb -v write-blocks /dev/rpmb0 0 1 data.in
+echo "read data back"
+./rpmb -v read-blocks /dev/rpmb0 0 1 data.out
-- 
2.20.1

