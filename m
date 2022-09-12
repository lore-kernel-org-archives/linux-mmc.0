Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563FAC6FA82
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Sep 2022 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiILV3J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Sep 2022 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiILV3H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Sep 2022 17:29:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9E4A820
        for <linux-mmc@vger.kernel.org>; Mon, 12 Sep 2022 14:29:06 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349423f04dbso35616217b3.13
        for <linux-mmc@vger.kernel.org>; Mon, 12 Sep 2022 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=mxPU3RrXnbJ1WXb6Kin68nj36f2XNWSY+VuVvzRvyEk=;
        b=ho/udzQ1QwBPrL+l4lPxAGUsHZmchvUPQehgWyBn+SR92V2PaL0P66O1BjkjAFjVyS
         WySl7GCaFhY90IiNxtck4h8oFOAWvlP9tapWEwETZMkUuH/onb0lekOI9WR4DQySM/xl
         rh+rFhxH24KJYMa48SUw/KEzM7uwCKVF90xVf8lhp8+AgZ2rPRVjMXfJibgr4jTEuuOU
         32OQ1YIt81DKsn0QysexyfxUQOEJAyeDfuufX0Y9/h8Ke3zJy7hK8SFBrqP/dCc4tJTF
         ngtYRb9ls9lYXHl0LZx9cB4ONa+IagbfWMOtmUZp9GGmfguzTh2OctNsyyf3jMmERGQM
         Qexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mxPU3RrXnbJ1WXb6Kin68nj36f2XNWSY+VuVvzRvyEk=;
        b=NqwVvuD66hUcrrFpanvgKE9Gf17km24Q1pDwHkjRJ6jVQsxJobdJMlAF6TLtev14Ox
         34VoIxokIGAPJ1CWKpddCassqryh8LJ8SFlw9DV7xH+s5eankjfFhW8cQSVGOdhN2Vb+
         Tum0SHedbWWoXLhv5yDLGoFVlFQ11+x3w7eTIbyDN43TYiJ2m/JiCOJbacnFbFoMP20W
         vSoR14JJI5GEQDfduxRhAqgDCJzjzaM3LQtd66EqIsPeoh38Fq7oWw05Bvd+5Rw1VX61
         I6Vi/pdN3RFMnZJAOLRi0qFpg6f5EHzLtWBBuiJahGq0Li67vrgPRQENW99SBplPSUfv
         GtUg==
X-Gm-Message-State: ACgBeo0Y0PLZYHcdYHX5BmcNXfp2SAZF8a/IqLax41bvp+pA242d5YUp
        VWZ5LUtMkpIUt1ZdPngblYdRXzMlVo6Y2agk0Br1dYQFGNyTUJ1u8SnvWr2QH+SNSEPGXN7hSjX
        6tFTx22gQr8dg+u7UsJrNIyRe5RE+S8z4do0ZJlmI6NjjVhvZ6H6Z31hagQ==
X-Google-Smtp-Source: AA6agR6YE+RSwmk0iaq48+VyoAumb8My8Fi+5JunqR9z5dNQL2jD3vBbU5RMgxSZHYil+Pd5hNhaMKQ=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:e24f:43ff:fee6:db57])
 (user=ptf job=sendgmr) by 2002:a25:2411:0:b0:6af:2407:ecfa with SMTP id
 k17-20020a252411000000b006af2407ecfamr5440196ybk.10.1663018145243; Mon, 12
 Sep 2022 14:29:05 -0700 (PDT)
Date:   Mon, 12 Sep 2022 17:28:47 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912212847.1337868-1-ptf@google.com>
Subject: [PATCH] mmc: sdhci-pci-core: Disable cqe for ASUS 1100FK family devices
From:   Patrick Thompson <ptf@google.com>
To:     Linux MMC development <linux-mmc@vger.kernel.org>
Cc:     Sangwhan Moon <sxm@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, ptf <ptf@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: ptf <ptf@google.com>

The CQE implementation for the eMMC in the ASUS 1100FK family of devices
is broken. This causes installations to fail and thus we are disabling
CQE for this family of devices.

Signed-off-by: Patrick Thompson <ptf@google.com>
---

Hello,

I was hoping to get some advice on adapting this patch to target the
eMMC directly instead of a family of laptops. One idea is to use the
PCI-id of the controller (in this case [8086:4dc4]). Would that make
sense? Is there someone with more knowledge on the subject that could
confirm that the [8086:4dc4] device doesn't have a working CQE?

Thank you,
Patrick


 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 622b7de96c7f..3ba0250559e7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -890,7 +890,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 {
 	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
 	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
-		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
+		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
+		dmi_match(DMI_PRODUCT_FAMILY, "ASUS BR1100FKA"));
 }
 
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
-- 
2.37.2.789.g6183377224-goog

