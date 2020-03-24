Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B25C54FCF
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7546A2074D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glVXZKRQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCXSIK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:08:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41239 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCXSIJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:08:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id z23so2339692lfh.8
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vy0uyy35QNpejtYD8qe9CDDYciuKj7VGVF2mU0OiMZs=;
        b=glVXZKRQdT0CXTjE2q/fj8TR19MdtGbZbi5RntaucgoFDQPU9Nzez6Z7Eqi9XxbpnT
         v1w9zxF/BdGLA8zwpsJD+vqaahkmcR9rIe7CMV3WjKn0hPBrug6x8jnoCJENcsvrJHuq
         PB3qx9ikGrgbsGlUfTWYzXvEFJOzTvhM/uDztt4zPISUQ5FQ08188T63ppuaJUv6hsf/
         IwIyjQfrtScTCktOdHkC4h5ijZjB6yPBuIJu+X9RwOp2zaBBnSJ+NG7U2w/Ly9t5bJzY
         urhgRaq5T4FnEPdvfzeSxvnStuBMmJOfkK29yUIm6hKhbpIgbj0P+774g2Bf/wufs19p
         LjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vy0uyy35QNpejtYD8qe9CDDYciuKj7VGVF2mU0OiMZs=;
        b=hFVkFODJd1mXL8+RtKrS/lbAyyxFDbwlNqNFW9vbJscOwuEgJbcNnwbvwqFsObH+oe
         yMfm+rtn7kLD6w3pY8KhUe+zOt4qP9V6RnK27nKNBTPksmOvSh8NFVRyDqeyNBNOZx9j
         RiemCYh0k6vjHkTzMjyf4INJkt0hiUkRck9Ypd8CX4Vcpgxt3AAcJfx2SSnzba4ftwjs
         K0ylFpOWkowK57qGgotIQCGMcE9ZsRL4BMuUznaWsMoHVS65DAjR2iYarv1pr+17wd3m
         i6TiT2KT3xZ8MjjEFc38VK6c1/Ce42qCx0e9eFtJ25JqnvFzbHRpxGa6WRjdFzn3BjCA
         +CpQ==
X-Gm-Message-State: ANhLgQ2UGpre4a35DblOJeevtn9hVMhpP6N0MRrFvBeDsAPkwZnx8ZqZ
        tKg3V2sSeeC6zJqO/Cp7lOWo8Q==
X-Google-Smtp-Source: ADFU+vv5Vne+R/AEBwzTXBWCEPinvro0MlDIH4orKlxDvpFc2ATn+mnt2jhgUKdZCOPE5HWcx+n0zw==
X-Received: by 2002:ac2:4a88:: with SMTP id l8mr7201139lfp.138.1585073287419;
        Tue, 24 Mar 2020 11:08:07 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s10sm11029858ljp.87.2020.03.24.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:08:06 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 4.19.113 2/5] mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
Date:   Tue, 24 Mar 2020 19:07:57 +0100
Message-Id: <20200324180800.28953-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180800.28953-1-ulf.hansson@linaro.org>
References: <20200324180800.28953-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[ Upstream commit 43cc64e5221cc6741252b64bc4531dd1eefb733d ]

The busy timeout that is computed for each erase/trim/discard operation,
can become quite long and may thus exceed the host->max_busy_timeout. If
that becomes the case, mmc_do_erase() converts from using an R1B response
to an R1 response, as to prevent the host from doing HW busy detection.

However, it has turned out that some hosts requires an R1B response no
matter what, so let's respect that via checking MMC_CAP_NEED_RSP_BUSY. Note
that, if the R1B gets enforced, the host becomes fully responsible of
managing the needed busy timeout, in one way or the other.

Suggested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: <stable@vger.kernel.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
Tested-By: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0a74785e575b..56f7f3600469 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2043,8 +2043,11 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	 * the erase operation does not exceed the max_busy_timeout, we should
 	 * use R1B response. Or we need to prevent the host from doing hw busy
 	 * detection, which is done by converting to a R1 response instead.
+	 * Note, some hosts requires R1B, which also means they are on their own
+	 * when it comes to deal with the busy timeout.
 	 */
-	if (card->host->max_busy_timeout &&
+	if (!(card->host->caps & MMC_CAP_NEED_RSP_BUSY) &&
+	    card->host->max_busy_timeout &&
 	    busy_timeout > card->host->max_busy_timeout) {
 		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 	} else {
-- 
2.20.1

