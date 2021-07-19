Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C120C636CB
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C316100C
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jul 2021 02:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhGSCVH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 18 Jul 2021 22:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGSCVH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Jul 2021 22:21:07 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4272C061762;
        Sun, 18 Jul 2021 19:18:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id k9so335086qtx.3;
        Sun, 18 Jul 2021 19:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eK4dLN6Hh5Xn+AoNYC/jTTz3XjpPwSRyowzhMkiPWZ4=;
        b=YyZCJUDo33wlu/PklnfLM6m/u/vzKF62OVgo3EGkCp7IwPoNPG8NPuszyLI/gALdhT
         wawKLIe4qiWzWOkdgb6X6dvnyjKacJ7AghiSpQ4Dn6DQOJAhBMeM1BBZNHV0uxVz2P33
         apkvrQsNsP2lJ7htulIBsIOjbmksX9iQQhkjQbgm+b8HKsVd9YLsUAGVfRp/h/zKrtbN
         GSLCQQKucqNPxmIemSvi2b0PvyK8ZmbCHBWI/1dDTjW0OGmlNO6ov8lW968fYxQu3t0W
         d7mIy3EDJ5Yqtys/70TN+SoOCh9B7o3ONFqf0mRTW/rJ7Ja4Nj4oGKTfMnItLMWC41rU
         TQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eK4dLN6Hh5Xn+AoNYC/jTTz3XjpPwSRyowzhMkiPWZ4=;
        b=hPY1jvwcCZ2e4Ycvra4mlwPhzTsG34zRKMZmSB4EogF/jxukci7XWamlROomgWyrpe
         u53WHmUAvRFDDwQmYZJ/TwD1caVLsTaC/Ax4riwXrRdu1Nn9OpKSE/hQadIwkEcLLOCP
         oQ5pXhqgn2ho/jhNoGlFRZrEt+Kvvvf/RRHHvmL38PG9GAvEsohEWk8aHzTP5sTBUZot
         4jU8jIBHb7ecgrShddW7RuD+9b2BBoyv583V8Bc+ui4pJ5KvgRhcR+wo7T3avg+KAY4+
         JHqUWn1ABut+l0S9V4t40YBXfIBWNHLXYBTFydfcUz0PtMDBh4BcS1GC3lmh2ShZuepk
         GauA==
X-Gm-Message-State: AOAM533UVqVtplIqF60XnXbgNOSUXWCk5du4ofctQqB+ZS0Q1ADhYIwi
        Q09NVxAy88BlnyGBLdM7N1YMSEbiA+o=
X-Google-Smtp-Source: ABdhPJz9CBPYo+uPdMEMMh21TBch2HQ+d3d/po8ULWIUDdW5L/qjQkGRlxiBnbFzjcFH9PbHRzp0Qw==
X-Received: by 2002:a05:622a:14d3:: with SMTP id u19mr9545947qtx.258.1626661086530;
        Sun, 18 Jul 2021 19:18:06 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id y24sm8025966qkj.4.2021.07.18.19.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 19:18:06 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mmc@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/4] bitmap: unify for_each_bit() macros
Date:   Sun, 18 Jul 2021 19:17:51 -0700
Message-Id: <20210719021755.883182-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Replace bitmap_for_each_bit_region() with for_each_set_bitrange()
and ~30 times improve bitmap_list_string() with new macro.

On top of:
https://lore.kernel.org/lkml/YNp3extAkTY8Aocd@yury-ThinkPad/T/ and
https://lore.kernel.org/lkml/YNirnaYw1GSxg1jK@yury-ThinkPad/T/

The full series is here:
https://github.com/norov/linux/commits/bitmap-20210716

v1: https://lore.kernel.org/patchwork/patch/1455255/
v2: - replace bitmap_for_each_bit_region();
    - address comments for bitmap_list_string() rework. 

Yury Norov (4):
  mm/percpu: micro-optimize pcpu_is_populated()
  bitmap: unify find_bit operations
  lib: bitmap: add performance test for bitmap_print_to_pagebuf
  vsprintf: rework bitmap_list_string

 drivers/mmc/host/renesas_sdhi_core.c |  2 +-
 include/linux/bitmap.h               | 41 --------------------
 include/linux/find.h                 | 56 ++++++++++++++++++++++++++++
 lib/test_bitmap.c                    | 37 ++++++++++++++++++
 lib/vsprintf.c                       | 24 ++++--------
 mm/percpu.c                          | 35 ++++++++---------
 6 files changed, 117 insertions(+), 78 deletions(-)

-- 
2.30.2

