Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA2C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 15:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C55D61107
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 15:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbhIGPNV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344964AbhIGPNU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2021 11:13:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D20AC061575;
        Tue,  7 Sep 2021 08:12:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u9so14957410wrg.8;
        Tue, 07 Sep 2021 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1CBE93Vd06SdCbwZzdFIujxbJaHFE/SvhzoMX/Juik=;
        b=c/10kjA20ZiZRyU4FkwyNwUDdWfveoauAKZkrHEKaV+2QhIndjfKuDxtfDfHqSkxC9
         HEil2zw//WsT1S/FJ4eDzXVXWwqjglxp1SVp/dY2e0gN928NYIKV4w420cYytNQbiIl2
         kPgyjNNrVj9CsT8+5xgmex5xFlRiKWMH1FtB+ZmbBLgMF2PJa7255zZH4efI9tKkzaNs
         AR/3QiE+w3RgbzTuY3QfkkAgjYs8e1Ov4Z0848x3iDjT6a/68YmlWc0+bLDiKtqwCUXZ
         c9KU9aIhbDYLuJIEzt8bWQj5mcm1cweoOWFRUZhlwneRgPMSKaoMvzGSubU8VNVG+9uH
         cs9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T1CBE93Vd06SdCbwZzdFIujxbJaHFE/SvhzoMX/Juik=;
        b=ZRJdMe3RAb4juh1RxOK7VIS/Jrv9g3tE58iLJxn0LyflOYkZeqn0o4qpdZCGgB0mZg
         W2ljAYLYxQIa4l1gvZYGfrQbGQsrjoNj97Q6qol1wPtkfZglsMlf83YXVlq/nPyTa+8q
         +b+RuMtwWEa2OHbkvtRBVHThtJlFg65w1BX5h9HNNj+fFvEoOWFkXgSMq+AyvrxT1Q5I
         74BJpi+YkzNvs7weooAxmS6tjYbS2cQKbwfW+BXL39ysWGl8gieZWNgLaYvrAhguIDYA
         R2mxVuss3Uo+wGrSCUyB2F4hY4j9ET7e4KphVWaVlV4j0pL+SF5WhU6OZnuHsp4aLvj7
         OObQ==
X-Gm-Message-State: AOAM532b39eqJmUHzdTOoaCNGIT+03ZQzuje2M/LUSRwBFG5gh0ZWwhN
        c6wUIsNiGAfD7H4CcKyEpmOZN7BI5iZAfw==
X-Google-Smtp-Source: ABdhPJwWDzr9QUXRdXoXhQ4kkBgDGCjDzNZ4LfmcaXS8pOoV6tFsAgF0FvmALA/UaIk/XG408S5JUg==
X-Received: by 2002:adf:9f0d:: with SMTP id l13mr19712463wrf.328.1631027533193;
        Tue, 07 Sep 2021 08:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b9a6:8ece:d93e:2093:39d0:bcfd])
        by smtp.gmail.com with ESMTPSA id h16sm11271138wre.52.2021.09.07.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:12:12 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        wsa+renesas@sang-engineering.com, linus.walleij@linaro.org,
        avri.altman@wdc.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     beanhuo@micron.com
Subject: [PATCH v1 0/2] Two nimor eMMc changes
Date:   Tue,  7 Sep 2021 17:12:02 +0200
Message-Id: <20210907151204.118861-1-huobean@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>


Bean Huo (2):
  mmc: cqhci: Print out qcnt in case of timeout
  mmc: core: No need to calculate the timeout value for CQE data
    transmission

 drivers/mmc/core/core.c       | 8 ++++++++
 drivers/mmc/host/cqhci-core.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.25.1

