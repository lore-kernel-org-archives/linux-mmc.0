Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36179C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1560F60F90
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Nov 2021 13:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhKCND2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Nov 2021 09:03:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:34010 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCND2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2021 09:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635944419;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=mAhcM7qlQhV+zsJUgsi5MqKZxixjHLQqGyoVSaOR4WA=;
    b=mFGC93xFn007IUPTB+Of4os9W1giMJJSxt+UwfFGfnxN7e6Au1M+2+KnQRjcHC03vY
    EYpx9MWXTcTFnhnNsPeKdstKX3j2R5Ybyh98db9dRCzwXanDDjLIX709fKxOQioqEd6t
    KvQbP3/7+/wLSENYEy9/gbld2Em1QvrCK2bB3P3ewQr5/W8pdeay6508pe0uUr6O98f6
    r0P61LIxrpflTLQypczOqLxiT2CUxHouiZnx673Wh3m0ndxLW2cFggNL2WADL/7VV8d0
    LYKpT39Ojdne4pUFzN6x5rrzSGH8kSM/l1td8GIaYVrxf0SWypsIocH0EN467AL821Fd
    CwfQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgc7na"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA3D0F0EW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 3 Nov 2021 14:00:15 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>, Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Bean Huo <beanhuo@micron.com>
Cc:     notasas@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC v3 0/6] mmc: core: extend mmc_fixup_device and transplant ti,wl1251 quirks from to be retired omap_hsmmc
Date:   Wed,  3 Nov 2021 14:00:08 +0100
Message-Id: <cover.1635944413.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RFC V3 2021-11-03 14:00:13:
* patches have been split into smaller ones a little further
* propose a new macro for setup of device tree compatible quirks
* directly include patches by jerome.pouiller@silabs.com
  in this series

RFC V2 2021-11-01 10:24:26:
* reworked to not misuse mmc_select_card() but add a call to
  mmc_fixup_device() right after where host->ops->init_card
  was called before to apply the wl1251 specific quirks.
  Device tree matching is done by a new table passed to mmc_fixup_device().
  suggested by: ulf.hansson@linaro.org
  based on patches by: jerome.pouiller@silabs.com

RFC V1 2021-10-06 13:24:13:


H. Nikolaus Schaller (4):
  mmc: core: provide macro and table to match the device tree to apply
    quirks
  mmc: core: add new calls to mmc_fixup_device(sdio_card_init_methods)
  mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
  mmc: host: omap_hsmmc: revert special init for wl1251

Jérôme Pouiller (2):
  mmc: core: rewrite mmc_fixup_device()
  mmc: core: allow to match the device tree to apply quirks

 drivers/mmc/core/card.h       | 37 ++++++++++++++++++
 drivers/mmc/core/mmc.c        |  1 +
 drivers/mmc/core/quirks.h     | 70 ++++++++++++++++++++++++++---------
 drivers/mmc/core/sd.c         |  2 +
 drivers/mmc/core/sdio.c       |  1 +
 drivers/mmc/host/omap_hsmmc.c | 36 ------------------
 6 files changed, 94 insertions(+), 53 deletions(-)

-- 
2.33.0

