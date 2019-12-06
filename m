Return-Path: <SRS0=q/7Q=Z4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED812C43603
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B952920706
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Dec 2019 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKEdKFCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFRIa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:08:30 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39107 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFRI3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2019 12:08:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id e10so8407746ljj.6
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2019 09:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RJvo8dm1C4RBvX1inxnpeI4gjWGaZu/lxsw87fYACSk=;
        b=ZKEdKFCNBnvtG/sUsIn6WbE1agwFb7pAX0rX8oiyhTW2UVzDGNZ15Viw02DIoANhDH
         ow/UceeMZwqdeZK09cLELLKiuToZgF7sq/5+i37Nb/4KgbqTZ3eEhZHE+KeJ/3XA4zpo
         EElDnweCXYXoxMUOyM4fVseOnLlFpnvo8R1roTu5hLAirI6oSRFuLhBqdgyIKYw/GwvI
         G/M+wEWPZLKq/T8uZuJeP1J0zjigSRl8p8Ksl7G7uzks1v//9fpOIcZPv28jTsAKwsSG
         mBZBrLPveWioEqKqLgy4FhrZ3sB2Nl6BlkCrEMf8qOYXXr8840H89n7CdPL+hWK0Y3G+
         rNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RJvo8dm1C4RBvX1inxnpeI4gjWGaZu/lxsw87fYACSk=;
        b=hFTud+oU6fSg33oHs3wEivJ2yqMCEAXdlHHttxyVEkLK1jAoO0SyjyN34QLyfcL8L8
         XWCJfO9RbGecHg8lurjCfcnTBAJpR5/OpFQ96rdxpfh+asc9CaBaG6JBi6zOY5lZUKYr
         882k5u/ihxsrYz6bppTuH5auw+N2kczB9/xZeeESGJogfPCBaMnAtU+YYy/jYff13kdu
         t5+VeUWV9/Q/snHAp95izf3K2xmlJUWgwHg4GIi62bDDZ3OA+/CBkdii0vRrF/Ejow1U
         4Z9e88L0u/ZStmPhQTyjmoKeu/DrNsCmpzkN83U4T9D8LEN2NJbHMczUqXVvaeIBRkWp
         672g==
X-Gm-Message-State: APjAAAWS+c3pBVnPz4ffqBKdG/wD9ZEZ/vtT91dbaIAE56IyIJr4qoCJ
        rUEsfYW4yleBdjM8Ul02EgECnw==
X-Google-Smtp-Source: APXvYqzJt+YACb3a8Tl61TG8pgv8gqMLZ4+X330YLPAqOz0ACqmdzKUNe8U0rzCbkaa5XP9lXfTcUg==
X-Received: by 2002:a2e:998a:: with SMTP id w10mr9545421lji.241.1575652107749;
        Fri, 06 Dec 2019 09:08:27 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id z9sm6905283ljm.40.2019.12.06.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:08:27 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/9] pinctrl: Consolidate some pinctrl code for mmc
Date:   Fri,  6 Dec 2019 18:08:12 +0100
Message-Id: <20191206170821.29711-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some mmc host drivers, but perhaps also others drivers, needs to reset the
pinctrl into the default state (PINCTRL_STATE_DEFAULT). However, they can't use
the existing pinctrl_pm_select_default_state(), as that requires CONFIG_PM to
be set. This leads to open coding, as they need to look up the default state
themselves and then select it. This series attempt to address these problems.

Ulf Hansson (9):
  pinctrl: core: Add pinctrl_select_default_state() and export it
  mmc: meson-gx: Convert to pinctrl_select_default_state()
  mmc: mmci: Convert to pinctrl_select_default_state()
  mmc: usdhi6rol0: Convert to pinctrl_select_default_state()
  mmc: omap_hsmmc: Convert to pinctrl_select_default_state()
  mmc: sdhci-esdhc-imx: Convert to pinctrl_select_default_state()
  mmc: atmel-mci: Convert to pinctrl_select_default_state()
  mmc: jz4740: Convert to pinctrl_select_default_state()
  mmc: uniphier-sd: Convert to pinctrl_select_default_state()

 drivers/mmc/host/atmel-mci.c       |  2 +-
 drivers/mmc/host/jz4740_mmc.c      |  2 +-
 drivers/mmc/host/meson-gx-mmc.c    | 10 +--------
 drivers/mmc/host/mmci.c            | 12 ++---------
 drivers/mmc/host/mmci.h            |  1 -
 drivers/mmc/host/omap_hsmmc.c      | 10 ++-------
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++--------
 drivers/mmc/host/uniphier-sd.c     | 14 +++++--------
 drivers/mmc/host/usdhi6rol0.c      | 15 +-------------
 drivers/pinctrl/core.c             | 33 +++++++++++++++++-------------
 include/linux/pinctrl/consumer.h   |  6 ++++++
 11 files changed, 40 insertions(+), 76 deletions(-)

-- 
2.17.1

