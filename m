Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B52C33CA9
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A2224656
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFyGHYP6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAMVHs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:07:48 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35371 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMVHr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:07:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so4834364pjc.0;
        Mon, 13 Jan 2020 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hH2HYPUX9M6K2Z8XwzaDO6EO0dTrQa3gOricl4ewwpo=;
        b=vFyGHYP6n86HZaGZ9+4JdkQf7CK+H28vzqquaSDxb9MCqb+LcyGTzf2CskjHwbZklD
         TvVhs2vnzH7pOxSJkGYxxT8XoJIS1R1KWU8qREHewOXxvI8X5jKtIfumStAJf4i54LvI
         0nYJVtU7/VdKjAjuKxnlPrJa23m7cyCSuswO+W4rukIKZNkHgQCqAYiWErw1pNVyciR7
         kX0Lbh5SdY1k4R3mzHXSq8q8wDlvc4fHX7lgWSw8e4zWs3yt6BmwdOKbht1djw8W7U+w
         WdzDDPAPeXiELByAweQWdH9LJyV7lmNpVnkoiuxsuTQz40qJXdxa5iUWz28aqEjNX2+j
         /lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hH2HYPUX9M6K2Z8XwzaDO6EO0dTrQa3gOricl4ewwpo=;
        b=cVn2OqAF89gh6aMi7/5ZteWvzvcPgBEjJWfn1u9OToyoF8f4pDVRYAMJzmHtalfBDE
         oPUr0pc540cfwrYRd5l5mSEivTYbv3XuarBQJVjIgJlTeiGyCUIvOkKrekMeCygFOkMq
         N5g18X5eVrUGtzIdWZEcbBeRlJsELfk14XCn1VAefw2F6NgzVXC3UO6I1a3vgCE3YSnz
         zY3fV86BrTlX6Xy6fzG3YTxujJJhWKDQPZ5iLnN3kLjEUfBeRDnARsxa98HSCxsVAPPf
         KrI0hOMXGl9mv7Fz92okhyzH2QA+lZWhaTtftKDbcQ6wmUmY9598rvq5tVhfUUOyEYLB
         GziQ==
X-Gm-Message-State: APjAAAW/UuydK6haarrjgt15SZM+3QoeENafaRLbzaROpWwGofwLNZKn
        kmvglkibec0fQujxN1s88oLYF3i6A+6U7A==
X-Google-Smtp-Source: APXvYqwKyTtQjzJW+9Hz6nQj31Gm7sA7wdoCBN07yvu9rXr0QkOkuRpV9u3YHV2lN2zba3A+W0wLJA==
X-Received: by 2002:a17:90a:7f01:: with SMTP id k1mr9851033pjl.81.1578949666986;
        Mon, 13 Jan 2020 13:07:46 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s1sm14195827pgv.87.2020.01.13.13.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:07:46 -0800 (PST)
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
Subject: [PATCH 0/6] mmc: sdhci-brcmstb: Driver updates
Date:   Mon, 13 Jan 2020 16:07:00 -0500
Message-Id: <20200113210706.11972-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The latest BRCMSTB SoC's now use a new Arasan controller along
with a custom Broadcom PHY that supports HS200, HS400, SDR104,
HS400E-ES and CQE. This series of commits adds support for these
new features along with a few bug fixes. The 7216 is the first
SoC to have this new hardware.

Al Cooper (6):
  dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 7216b0
  mmc: sdhci-brcmstb: Add ability to use HS400ES transfer mode
  mmc: sdhci-brcmstb: Fix driver to defer on clk_get defer
  mmc: sdhci-brcmstb: Add shutdown callback
  mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)
  mmc: sdhci-brcmstb: Fix incorrect switch to HS mode

 .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  41 ++-
 drivers/mmc/host/Kconfig                      |   1 +
 drivers/mmc/host/sdhci-brcmstb.c              | 270 +++++++++++++++++-
 3 files changed, 284 insertions(+), 28 deletions(-)

-- 
2.17.1

