Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0B8C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 02:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiK1Con (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 27 Nov 2022 21:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiK1Com (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2022 21:44:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C36270
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so8910876pjj.4
        for <linux-mmc@vger.kernel.org>; Sun, 27 Nov 2022 18:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFW+xBSrRhj3S5V+zwdSCmKiydzyqT7Qr1fgriy5ddI=;
        b=bE6GehmeINV0QlMAfaGk5c0NRGESXLW6xsJOo/AhFiljhM+Rg1uHQHqP+XetJAiRtr
         b2lR0Zghhx0db8nvp9wrEh6FADNOTyiBxAs8SRw3IJl0MA58IEHedFs9GwDZGvhTPhVI
         zedqzI5MzYC4LMye6jc3AdDyHX+N/JVRoKaE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFW+xBSrRhj3S5V+zwdSCmKiydzyqT7Qr1fgriy5ddI=;
        b=Rc0VB+dQNj6BQusQt17zwRbkJFciQh+zAnHrwepvuZNBZT8GgesCSZozq5xJ9Y911c
         BnayLkrMfNT/joeLWmIwUAO843THfLPVRIjlTB+mtTY+ud7+FHSir9yPyXI3DVigjUch
         YPI/rFvPbejybnRs3oyzyhulfF4qXv4w+WetFxHFozr2K3pc3kIAGJLLegVi6qp+DjOZ
         tf44LMwWE0yabdfsjXtoF2IXPSADvQn5tKeeYxa3kFm4h9u7SXuGFQrYqy3efqQYNx6c
         ObsTZtT8m8vENicMXD40xoU72tD61UKPMVENBOAyhnGfqDHeNvdLHGDzOE3vWjjeUDdk
         lWlA==
X-Gm-Message-State: ANoB5pkyYTt09qKZffzT5euIr2YrIiTfzJ84nRhbO4bDaY+8iwcJp5o2
        tgdDm+fA+WuKU5lEC/UR7ZRmrA==
X-Google-Smtp-Source: AA0mqf4NVncO4H0MNL7gp1GMvcvcQ5fJJ5I4anSVIKZlSP4swi7UWMtV+YLxoiJGF+60JxEbAOXRvA==
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id qi3-20020a17090b274300b0020d4173faf9mr57474076pjb.147.1669603481135;
        Sun, 27 Nov 2022 18:44:41 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79910000000b005752201d4ffsm1431568pff.213.2022.11.27.18.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 18:44:40 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH 0/8] mmc: sdhci-pxav2: Add support for PXA168
Date:   Sun, 27 Nov 2022 18:43:59 -0800
Message-Id: <20221128024407.224393-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a revival of an earlier patch series from 2013 to add support
for the PXA168 SDHC controller, with an additional SDIO IRQ errata fix.
It also cleans up the clock naming to be consistent with the existing DT
schema shared with the pxav3 driver (in a backwards-compatible way).

Here is the original patch series this is based on:
https://lore.kernel.org/linux-mmc/1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com/

Note that I left out the platform_specific_completion and clock gating
changes from the original patches. They both seemed controversial, and
don't seem necessary based on my testing. I've been running this code on
a PXA168 for months without any issues.

The SDIO IRQ workaround of sending a dummy CMD0 isn't pretty, but it
works just as the errata said it would. Should I export sdhci_post_req
and refer to it directly, rather than saving a pointer to it in this
driver like I'm doing now? Or is there a cleaner way to send the dummy
command after every SDIO command? It felt hacky, but I wasn't sure how
else to do it.

Doug Brown (8):
  mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
  mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
  mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
  mmc: sdhci-pxav2: change clock name to match DT bindings
  mmc: sdhci-pxav2: add optional core clock
  mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1
    controller
  mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
  dt-bindings: mmc: sdhci-pxa: add pxav1

 .../devicetree/bindings/mmc/sdhci-pxa.yaml    |  22 ++-
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-pxav2.c                | 138 +++++++++++++++++-
 3 files changed, 154 insertions(+), 7 deletions(-)

-- 
2.34.1

