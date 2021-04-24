Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1300C43460
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Apr 2021 08:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEA0F611F1
	for <linux-mmc@archiver.kernel.org>; Sat, 24 Apr 2021 08:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhDXI0j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 24 Apr 2021 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhDXIZ2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Apr 2021 04:25:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE9C06174A;
        Sat, 24 Apr 2021 01:17:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t13so219396pji.4;
        Sat, 24 Apr 2021 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SNOBsMH6hsVrtOZBfES+XFjoqfZ4tZXMmDAM/d9yCW0=;
        b=nDfAjvSaBukuzHQZFqayoYjcWAVJZvfAsIWufYv/XTRHe8J8tEG7xvd7V0buVXE/6g
         qcMc4XbAjSrbdUH4CoradY9JACfaHlWQu9y/0tgHKs3DYT0v2pKUvFH5iMZ+fqPpI9nz
         YT8NcCLaeNPoJJC5jAJOndlsh5Hbixscv+hdtCxr9oPgKinwF7oEs69R2xMUEy7mmz6I
         N9F1Bo5M7hmkd8fNnbQV2R6nGn3nle1KUfQTU7iyvpmF5EB5XdngoTjQyO8imOtFpl2z
         UTS1SKqMg4z1khlrmOZbKwgzxY+p8r9JBPAJ92WksCu2R7UJxmmcfy2ahq6yqHFt/H1V
         QK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SNOBsMH6hsVrtOZBfES+XFjoqfZ4tZXMmDAM/d9yCW0=;
        b=K/qqdUjoG4hPh22zIrClGbZNhgHfXZ1w7NstrpAUy81+q8o3Q/fIlJVzlf5fht/5+f
         lSATa+k5gwJQ/6Gcqi0+X7ptwsTwokBmErt+TW13JfY1NHEnjTUgJF0YLb9O6IPpMlj7
         z9Re9/Mhem5TbBJY9lx6oxpoz6cVeMUtppVTwBSIpbvVp7ZF2/yzyygzNNlWbQ+Jma34
         Q4hvFaZdMbDUJowDCcwaB18+aEg8EOSFujQYhOPAqEsb67Z+SOMaBtj9EagF6ThE+FSr
         mIevOieI4EVgJgyQBBIjeQihlhHSKhLsIoO+gNHvmp+bTau/v1qkrhJfWxztK1R6uqEV
         fqgA==
X-Gm-Message-State: AOAM533RPNU5RPSb7SWYcojgi/MoYeMyHGrprjPLnyoXjkklPPXLC29h
        knEPPr2ATMSHT9rFN2Zr32s=
X-Google-Smtp-Source: ABdhPJzFfPA+ORO7YmRlJnRiYqjZBrMqDO/4/ch4aPBZYgL41HJ1/RSkitblZIzpl6Z3koPsq18UFA==
X-Received: by 2002:a17:90b:388a:: with SMTP id mu10mr9870600pjb.203.1619252219831;
        Sat, 24 Apr 2021 01:16:59 -0700 (PDT)
Received: from soma ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id d4sm9157893pjz.49.2021.04.24.01.16.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 24 Apr 2021 01:16:59 -0700 (PDT)
Received: by soma (sSMTP sendmail emulation); Sat, 24 Apr 2021 20:16:52 +1200
Date:   Sat, 24 Apr 2021 20:16:52 +1200
From:   Daniel Beer <dlbeer@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Daniel Beer <dlbeer@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: increase 1.8V regulator wait
Message-ID: <20210424081652.GA16047@nyquist.nev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Inserting an SD-card on an Intel NUC10i3FNK4 (which contains a GL9755)
results in the message:

    mmc0: 1.8V regulator output did not become stable

Following this message, some cards work (sometimes), but most cards fail
with EILSEQ. This behaviour is observed on Debian 10 running kernel
4.19.188, but also with 5.8.18 and 5.11.15.

The driver currently waits 5ms after switching on the 1.8V regulator for
it to become stable. Increasing this to 10ms gets rid of the warning
about stability, but most cards still fail. Increasing it to 20ms gets
some cards working (a 32GB Samsung micro SD works, a 128GB ADATA
doesn't). At 50ms, the ADATA works most of the time, and at 100ms both
cards work reliably.

Signed-off-by: Daniel Beer <dlbeer@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 592d79082f58..061618aa247f 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -627,8 +627,13 @@ static void sdhci_gli_voltage_switch(struct sdhci_host *host)
 	 *
 	 * Wait 5ms after set 1.8V signal enable in Host Control 2 register
 	 * to ensure 1.8V signal enable bit is set by GL9750/GL9755.
+	 *
+	 * ...however, the controller in the NUC10i3FNK4 (a 9755) requires
+	 * slightly longer than 5ms before the control register reports that
+	 * 1.8V is ready, and far longer still before the card will actually
+	 * work reliably.
 	 */
-	usleep_range(5000, 5500);
+	usleep_range(100000, 110000);
 }
 
 static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
-- 
2.20.1

