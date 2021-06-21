Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D16C49EA2
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901B461153
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhFUXz3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhFUXz1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2021 19:55:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C64C061760
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id n12so6716755pgs.13
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2021 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n91GfziZ5syAC28F6UjBolJ+M+YVU4V/73A7TE0XUb0=;
        b=SUyoFV/+KdCNo/00LCnOAUpTOHYgzf0cSORstuKQbNiRU4V1vUrGu4QetCpbQBYc1W
         GAxBENYZAxru0gINenfaFo3ipVEzhLwv0U2eNgFcJ2cPC7dG4++rrl8IkdEXEecTnwhe
         LSHANxMj999/UFOJcme3BmijnH7TMuu4qQkCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n91GfziZ5syAC28F6UjBolJ+M+YVU4V/73A7TE0XUb0=;
        b=m9Bi+6F9OjYQybO2EyQN9JWqnNub7FhThXnJbhE7y2OB0EV9IRlCCpM3fAJe6w1/oF
         +MYnSEvTjvTBHqsFTciSnYhYRnxBB/Mu/Ho4LXG6gDNE/qKMJ49hQZIZprqveXCU7txC
         gwsComcuYIqH1WoJ++U9sOhNqYsokuUTWx1UUmQ7yyGIzVmn//hq7OQVjVvZrYFYqFhS
         HhHjQR5L058C9uVNqgA3hYTPYreJvR/PtF5DQyagyiQ21QGROKpBNw1SKdbWbIhUJtT1
         1n/6kBHxuwZstcvChmxZbJAH51/HyZtvJJfRzdv1f3NHWt7ovx67F8fetqre5NfC72SS
         B33g==
X-Gm-Message-State: AOAM531vysbRDJ1Z94x8joL0ioRxwSfZFod8ZrSqgl9N11OQ7FNB7V1A
        6mmkoULmpX2m7eusITFj6/sqvQ==
X-Google-Smtp-Source: ABdhPJxZEK+bTs68KqckxQkGsSx8yLSwQ1E3xNiGaYMPOkRx7NyxIeuHTI/Mz9yWdTNtGbeL+DqgvQ==
X-Received: by 2002:a62:2601:0:b029:300:bd5a:9268 with SMTP id m1-20020a6226010000b0290300bd5a9268mr718024pfm.1.1624319588586;
        Mon, 21 Jun 2021 16:53:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:08 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] iommu: Enable devices to request non-strict DMA, starting with QCom SD/MMC
Date:   Mon, 21 Jun 2021 16:52:42 -0700
Message-Id: <20210621235248.2521620-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


This patch attempts to put forward a proposal for enabling non-strict
DMA on a device-by-device basis. The patch series requests non-strict
DMA for the Qualcomm SDHCI controller as a first device to enable,
getting a nice bump in performance with what's believed to be a very
small drop in security / safety (see the patch for the full argument).

As part of this patch series I am end up slightly cleaning up some of
the interactions between the PCI subsystem and the IOMMU subsystem but
I don't go all the way to fully remove all the tentacles. Specifically
this patch series only concerns itself with a single aspect: strict
vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
to talk about / reason about for more subsystems compared to overall
deciding what it means for a device to be "external" or "untrusted".

If something like this patch series ends up being landable, it will
undoubtedly need coordination between many maintainers to land. I
believe it's fully bisectable but later patches in the series
definitely depend on earlier ones. Sorry for the long CC list. :(


Douglas Anderson (6):
  drivers: base: Add the concept of "pre_probe" to drivers
  drivers: base: Add bits to struct device to control iommu strictness
  PCI: Indicate that we want to force strict DMA for untrusted devices
  iommu: Combine device strictness requests with the global default
  iommu: Stop reaching into PCIe devices to decide strict vs. non-strict
  mmc: sdhci-msm: Request non-strict IOMMU mode

 drivers/base/dd.c             | 10 +++++--
 drivers/iommu/dma-iommu.c     |  2 +-
 drivers/iommu/iommu.c         | 56 +++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci-msm.c  |  8 +++++
 drivers/pci/probe.c           |  4 ++-
 include/linux/device.h        | 11 +++++++
 include/linux/device/driver.h |  9 ++++++
 include/linux/iommu.h         |  2 ++
 8 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

