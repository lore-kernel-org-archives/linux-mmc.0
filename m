Return-Path: <SRS0=RiNA=5T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5644C43331
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801D520787
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Apr 2020 07:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNk/VOOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbgDCHFm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:05:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40138 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbgDCHFm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Apr 2020 03:05:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so2357197plk.7;
        Fri, 03 Apr 2020 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f1ljEZxkc/cLkZYV4QENVzqOYupDNQ/8GxzhBvvZzdk=;
        b=fNk/VOOMa14KjRsQbqIlEj7vnuOZORkMnFPW7wQcbRWaqoMMyd+t+Rikwdft7IoxaH
         /oO3/AlY5u0XrGrLaUtMEUvxvub5aEmsb5ocOG887r07db395e6GMwkUhga2wW7wbsUl
         DsCHzQJNIjtTFkUicTfJ4qWo1fn4LFriKW3Yueei1muOG7Dx2ltyK5pwZaUIAS/qr1bB
         SPeCO4QVysjfJZDgNdOOlgME/XIyuU8YTXp2mE66gQNxYZ/t904V9OI1oWLjro2U/kKh
         Du0DKSnyWj0W3tD+NvW6IsMLADbVvX21SSoMvQ2K2axMMhYyDtI2mdFyLYxzFU2N8vHG
         CFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f1ljEZxkc/cLkZYV4QENVzqOYupDNQ/8GxzhBvvZzdk=;
        b=RK7cpPt0QaZOCgLkUWELA3KWhl17TuYoWO4aXsx2hqF9sEReeEVjD0DgWCphmzwt2J
         RiR9DsrPY69JwfSzthpenYp5Rp9R4a4JggSFWmH19Mowee6hP9TiemzTfWShj1KWPTgY
         Z5P2qEL18ZVEf77JKg+eoZKXfa41+OOfrZxd6Vc4z52LutOo2l7yvat9WEYatpxKKCek
         2RlgLpSGg5FHvg9xwrGwQTvdSO8Raw/04rtu1iws5X0dfm661Z72qCwirhxLucbpDM8W
         qlU7BWivYBSNwThclr+lk/TU2W1tcssGztVnaIg3UVO47RfawEoL+YXP6Qvpe6VOVpCV
         DYqg==
X-Gm-Message-State: AGi0PubX+KpEgWqwBB+MhX9XP/u/CjifxoPHHuDiq86iwHVhEr9kwNsP
        +5iE1ilRMIFt2ul5FtobtNQ=
X-Google-Smtp-Source: APiQypKH42XogwRKLUryFeeun9m1hlzdB1iy3eQpiOfMtRe2h+HP2EscTGfVtAeKb/TpiD6lv9SfQA==
X-Received: by 2002:a17:90a:1acf:: with SMTP id p73mr7996756pjp.53.1585897541601;
        Fri, 03 Apr 2020 00:05:41 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u18sm5138701pfl.40.2020.04.03.00.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Apr 2020 00:05:40 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        arnd@arndb.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Introduce the request_atomic() for the host
Date:   Fri,  3 Apr 2020 15:05:25 +0800
Message-Id: <cover.1585896945.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch set introduces a new request_atomic() interface for the
MMC host controller, which is used to submit a request to host in
the atomic context, such as in the irq hard handler, to reduce the
request latency.

Any comments are welcome. Thanks.

Changes from v3:
 - Move patch 3 of V3 patch set into patch 1.
 - Add a warning for unexpected return value of request_atomic().
 - Remove redundant checking of ops->request().

Changes from v2:
 - Return busy flag if encountering unusual card busy state
 instead of polling in interrupt context.
 - Add a work for HSQ to try again in non-atomic context if the host
 returns busy flag.

Changes from v1:
 - Re-split the changes to make them more clear suggested by Ulf.
 - Factor out the auto CMD23 checking into a separate function.

Baolin Wang (3):
  mmc: host: Introduce the request_atomic() for the host
  mmc: host: sdhci: Implement the request_atomic() API
  mmc: host: sdhci-sprd: Implement the request_atomic() API

 drivers/mmc/host/mmc_hsq.c    | 29 ++++++++++++++++++-
 drivers/mmc/host/mmc_hsq.h    |  1 +
 drivers/mmc/host/sdhci-sprd.c | 23 +++++++++++++--
 drivers/mmc/host/sdhci.c      | 65 ++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h      |  4 ++-
 include/linux/mmc/host.h      |  3 ++
 6 files changed, 103 insertions(+), 22 deletions(-)

-- 
1.9.1

