Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC91C33CA9
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620B924655
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFNRMkJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgAMVIE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:08:04 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50840 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgAMVIE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:08:04 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so4693292pjb.0;
        Mon, 13 Jan 2020 13:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rOhBlNJi9zrxB4FIvl/Mh1uvf9WxyGooJc5KOiTW4C4=;
        b=fFNRMkJo4sm00mqmdW9+R0XDO7L77nGlx3ahfBF3j67d6gXqpk6gikR9CCTtDn8DKC
         u+4mWuM8BvBCwk8nZOT3HUpw1hg+i6B5j7DtR+3IU1TPGLEUEuC0SMCF6FAYq9ppauwe
         AT9LyA1CG/JU8Q7UvNneRngS6XaoHMtuq8V4qddt9jTwiPsD2h7MxKLKWlGdLBUoDzw7
         gZ+EXEtiYsZeylhK4wtG94imkgkclc8m090Xm5VT2fcgw0hrk1xk0QypqPqyeJ0Oqggn
         53D7Y4fkr1rLJ8rHeUFWaSyDEeY3Heks0+zOS3qgOkjLem+G2NkAbRHnzFjrcBJpr8SY
         gcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rOhBlNJi9zrxB4FIvl/Mh1uvf9WxyGooJc5KOiTW4C4=;
        b=CHxVPrzrcY3ikCRxfGT5ntCLMvkUk4AuCvhMeDyr9ps97b5twKT+30/tWfkyB1cVNL
         F/RROk4gWBuueZ5ZO//ukcX6eZfWU6PtsmTqQx770BzIRF/cA/RsZCNoG5SG9k2k4Ka0
         I/LYkjs8IuxcKojRkUC5FKBk7ejlRh/9wXWauad+xAxycCxpIMZGgbD5p1bWf/jmkrZN
         KFpiYVMXS3L4mpriJ+KPZojV0SB2zyWTjFzYGI6A8EbptCjOKk3ClgHUZudJIJinkJ9V
         CFlp0bX9I0162liJOgesDNvGChA4LrKvLW5X4uvwFtZ8MWvgWCeq6X+/bbNNYswiEuId
         LWjg==
X-Gm-Message-State: APjAAAVKfvym83fDWNj1tfpHTxjQYHfQ5RijROyJe/tMb8IgyHQWXdqh
        0vGj/UQM2tnyoCiPpUcUQ5qEXOgSYtLlWg==
X-Google-Smtp-Source: APXvYqx2patM7VBVBxwBeswjSO473DoUGIG2YsvJzVZ/PsXS9f3/IqWQa1b6UA762LZuyPV50J8bxw==
X-Received: by 2002:a17:90a:30a4:: with SMTP id h33mr24508794pjb.50.1578949683175;
        Mon, 13 Jan 2020 13:08:03 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s1sm14195827pgv.87.2020.01.13.13.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:08:02 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 6/6] mmc: sdhci-brcmstb: Fix incorrect switch to HS mode
Date:   Mon, 13 Jan 2020 16:07:06 -0500
Message-Id: <20200113210706.11972-7-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
References: <20200113210706.11972-1-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When switching from any MMC speed mode that requires 1.8v
(HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
ends up configured for SDR12 with a 50MHz clock which is an illegal
mode.

This happens because the SDHCI_CTRL_VDD_180 bit in the
SDHCI_HOST_CONTROL2 register is left set and when this bit is
set, the speed mode is controlled by the SDHCI_CTRL_UHS field
in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
because there is no UHS mode being set.

The fix is to change sdhci_set_uhs_signaling() to set the
SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
any switch to HS mode.

This was found on a new eMMC controller that does strict checking
of the speed mode and the corresponding clock rate. It caused the
switch to HS400 mode to fail because part of the sequence to switch
to HS400 requires a switch from HS200 to HS before going to HS400.

This issue was previously fixed by commit c894e33ddc191 ("mmc: sdhci:
Fix incorrect switch to HS mode") and later removed by commit
07bcc411567c ("Revert \"mmc: sdhci: Fix incorrect switch to HS mode\"")
because it caused failures with some SD cards on AM65X systems. The
fix will now be done in a platform specific callback instead of
common sdhci code.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 2c4b6e7e3d9a..ad01f6451a95 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -65,6 +65,35 @@ static void sdhci_brcmstb_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_enable_clk(host, clk);
 }
 
+static void sdhci_brcmstb_set_uhs_signaling(struct sdhci_host *host,
+					    unsigned int timing)
+{
+	u16 ctrl_2;
+
+	dev_dbg(mmc_dev(host->mmc), "%s: Setting UHS signaling for %d timing\n",
+		__func__, timing);
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	/* Select Bus Speed Mode for host */
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+	if ((timing == MMC_TIMING_MMC_HS200) ||
+	    (timing == MMC_TIMING_UHS_SDR104))
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+	else if (timing == MMC_TIMING_UHS_SDR12)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+	else if (timing == MMC_TIMING_SD_HS ||
+		 timing == MMC_TIMING_MMC_HS ||
+		 timing == MMC_TIMING_UHS_SDR25)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (timing == MMC_TIMING_UHS_SDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+	else if ((timing == MMC_TIMING_UHS_DDR50) ||
+		 (timing == MMC_TIMING_MMC_DDR52))
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+	else if (timing == MMC_TIMING_MMC_HS400)
+		ctrl_2 |= SDHCI_CTRL_HS400; /* Non-standard */
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+}
+
 static void sdhci_brcmstb_dumpregs(struct mmc_host *mmc)
 {
 	sdhci_dumpregs(mmc_priv(mmc));
@@ -101,7 +130,7 @@ static struct sdhci_ops sdhci_brcmstb_ops_7216 = {
 	.set_clock = sdhci_brcmstb_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_uhs_signaling = sdhci_brcmstb_set_uhs_signaling,
 };
 
 static struct brcmstb_match_priv match_priv_7425 = {
-- 
2.17.1

