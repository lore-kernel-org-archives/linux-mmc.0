Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C27C4361A
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B88023A82
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 10:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbhAVJtd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 04:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbhAVJpV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 04:45:21 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DFFC06174A
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:44:17 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so5732942ljo.13
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTGiS+heLDwMPrDkZxlriD+q4LmeVPglFgOPJ0siNp0=;
        b=F256DV2QWsUrgpznESD2OlEkKF2ukvzZZQ4Aw7n2Favo/yBCwnRJAuhcbRhaKM5zdU
         bxHC9I1Rz1ZQT3F5m0/QPSr+vUXIg4pRS2eVwESG8rUj1AOrgeUjkg3Y9MGGkuJBKbtr
         OUcDgR/P9sQvA4ttAn0czDDG4KXivLXw3vIAHO2fhJpnBtRCOx1nsG4/WOPRopv03fp4
         204Wc5EyzoVgB0qC1gRPYmjIHXdHivlXO5qsAIl5FcOEXuBepUd1OHrzVg3HgO/x9UIJ
         ko3fCSZrNQoU1aj7Nm+w5YiXswlTi91ru8fi7fpV1RqUHRqtV7iIVUbgAbYav6z1TV37
         78bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTGiS+heLDwMPrDkZxlriD+q4LmeVPglFgOPJ0siNp0=;
        b=XdCPAwJ/ABVGKuYVKfmVDlqiIWqjNfXKXuFSa/U7Z0Ke8FnmHBIK1vb/5npPvXqOPc
         gFQY/t2WM4bPkb8cS2GMWYA1AAEBWGwqfU6zTBmXfvifwsfhgWjf6J9UU5ewKqSs45Mg
         zuwxnjhU902haKVhWqjCWuThSR8ezNGmpZ72852FqDZQgI4LyiPYcRbPEuFWycc3vrag
         HK8019F6yfbzyq5ahpbSgqF11q3jrri1a4OHh0PQmUVcfcNj9bDFvAK4YjsTW+05rfgP
         vK6UmQhJNIVkxlQTG2r+ImV1bv7Y6oI9IX5SPNF99XfmwJ5bpGQbEN5uy5mbzZXJ/HWY
         EZfw==
X-Gm-Message-State: AOAM531EYrVsnIhYxplQZ4akvWVIr++KO/2XImJs0qEI4TNXhHx3KUSt
        WBXUlP0moDGgsApZR6SgbClYSQ==
X-Google-Smtp-Source: ABdhPJzqTqNqnW5z3kQ4JW34MX/y9yYZzWPkUDhZm5ktkPZgZQPJR/4+KJ/J1Q92gtO/sOA65aljdw==
X-Received: by 2002:a2e:90d3:: with SMTP id o19mr1444028ljg.382.1611308655122;
        Fri, 22 Jan 2021 01:44:15 -0800 (PST)
Received: from localhost.localdomain (h-98-128-180-179.NA.cust.bahnhof.se. [98.128.180.179])
        by smtp.gmail.com with ESMTPSA id n18sm820161lfh.37.2021.01.22.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 01:44:14 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.11-rc5
Date:   Fri, 22 Jan 2021 10:44:13 +0100
Message-Id: <20210122094413.69488-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.11-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11-rc3

for you to fetch changes up to b503087445ce7e45fabdee87ca9e460d5b5b5168:

  mmc: core: don't initialize block size from ext_csd if not present (2021-01-15 12:09:15 +0100)

----------------------------------------------------------------
MMC core:
 - Fix initialization of block size when ext_csd isn't present

MMC host:
 - sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
 - sdhci-of-dwcmshc: Fix request accessing RPMB
 - sdhci-xenon: Fix 1.8v regulator stabilization

----------------------------------------------------------------
Al Cooper (1):
      mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend

Alex Leibovich (1):
      mmc: sdhci-xenon: fix 1.8v regulator stabilization

Jisheng Zhang (1):
      mmc: sdhci-of-dwcmshc: fix rpmb access

Peter Collingbourne (1):
      mmc: core: don't initialize block size from ext_csd if not present

 drivers/mmc/core/queue.c            |  4 +++-
 drivers/mmc/host/sdhci-brcmstb.c    |  6 +-----
 drivers/mmc/host/sdhci-of-dwcmshc.c | 27 +++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.c      |  7 ++++++-
 4 files changed, 37 insertions(+), 7 deletions(-)
