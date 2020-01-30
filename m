Return-Path: <SRS0=Wkjf=3T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221E2C2D0DB
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Jan 2020 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0D9206F0
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Jan 2020 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GK91sSM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgA3OWI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:22:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34504 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3OWI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jan 2020 09:22:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so3578074ljc.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jan 2020 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U/q0/AZVShqwSIJ5XHbOARBIimDxx6cqWeMsQ9sFBA=;
        b=GK91sSM/ycZt5/DrNcDL9wG6LE+kiK7XA9XtM4gmoW2HUbY0l2u310xuJVvySLCqwi
         VxQjFSiEJvHRtL2ntJk0iEXPSvHBwzpsKHbqnIq+Gytl15B0UEVTkl4klFwQmHfSU6CJ
         frIOMm0kVj0bHWOAkw6jvTXaH9OswGQtLexYPsiIDVHKmFRYtSD7yJ1WTRgqx9rf+2lt
         9LYRRVXAQxhEuy8fxue8Eb1hl6Q6xizcihpwlKTlpoBzfyZPkKhosdh6G7vwuB6LHgKE
         f4PUUD+174qo5G7YzjsrNu7McvJr0faT9xZDUI9Zm9dQIMAnGM6Q4jaKAD7YQWHdOx60
         XMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9U/q0/AZVShqwSIJ5XHbOARBIimDxx6cqWeMsQ9sFBA=;
        b=ZTpQAjNCCQGQk7ARaPkrFC+43uUF0Fv0zqnZXDd94z0lGo5afjSpkmoIVxtQRWTjky
         TGU4DV1yniidzQK9vyMYielVnNL+CCzt9MUF4AHuE5y4egdp6bp2QhtDMWR/dc25CfxE
         nc4EFn4Krj3hCLu/Fi39kES3A4Or1YN/+Ex59LjDcF0GF3PHnUUatkogdNNXT4shAPkv
         vrXV5xv7y3Dz8CPOA8f7a4EzRMMj8H9oERU9p4bjJbLex1pyGGNcVB9tqDvX8do/bZ+m
         cLCH431i2pFDIK0WBadmA0ms9bz2q+QJuP6fM08TxqkO2S4DZMckwL/U15EV26NYchLn
         qBEA==
X-Gm-Message-State: APjAAAW+cyfcRkW83QbD309KOuBOytvArVTK56kyr3QHV3mq+Aop1s/N
        UvYOnooP6wxNMYTHCYWWYIgnEHR6d70=
X-Google-Smtp-Source: APXvYqwOByEWYs6HfBgE1yTgJFE0cJq1rDVa2Lps8ZCTb7np6fEqsf1X4etSY5HEIneQL9iuCAW4PQ==
X-Received: by 2002:a2e:3504:: with SMTP id z4mr3012367ljz.273.1580394125476;
        Thu, 30 Jan 2020 06:22:05 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id a28sm2882715lfg.86.2020.01.30.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:22:04 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: [PATCH] mmc: core: Throttle polling rate for CMD6
Date:   Thu, 30 Jan 2020 15:22:01 +0100
Message-Id: <20200130142201.28492-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In mmc_poll_for_busy() we loop continuously, either by sending a CMD13 or
by invoking the ->card_busy() host ops, as to detect when the card stops
signaling busy. This behaviour is problematic as it may cause CPU hogging,
especially when the busy signal time reaches beyond a few ms.

Let's fix the issue by adding a throttling mechanism, that inserts a
usleep_range() in between the polling attempts. The sleep range starts at
16-32us, but increases for each loop by a factor of 2, up until the range
reaches ~32-64ms. In this way, we are able to keep the loop fine-grained
enough for short busy signaling times, while also not hogging the CPU for
longer times.

Note that, this change is inspired by the similar throttling mechanism that
we already use for mmc_do_erase().

Reported-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Hi all,

I have tried this on a ux500 platform (using the mmci mmc host driver), which
has two different eMMCs connected to the board. I manually checked that the busy
loops during boot for the worst CMD6 case, dropped from around ~50 attempts to
around 5-6 attempts, while the total loop time stayed to the similar numbers. In
general the loop times I observed for all the CMD6 sent during boot, were in the
range of 0 - 900us.

Any feedback and of course tests are greatly appreciated!

Kind regards
Ulf Hansson

---
 drivers/mmc/core/mmc_ops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index da425ee2d9bf..446a37cc2a86 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -456,6 +456,7 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 	struct mmc_host *host = card->host;
 	int err;
 	unsigned long timeout;
+	unsigned int udelay = 32, udelay_max = 32768;
 	u32 status = 0;
 	bool expired = false;
 	bool busy = false;
@@ -500,6 +501,13 @@ static int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 				mmc_hostname(host), __func__);
 			return -ETIMEDOUT;
 		}
+
+		/* Throttle the polling rate to avoid hogging the CPU. */
+		if (busy) {
+			usleep_range(udelay, udelay * 2);
+			if (udelay < udelay_max)
+				udelay *= 2;
+		}
 	} while (busy);
 
 	return 0;
-- 
2.17.1

