Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA12C43217
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABD961262
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhKEJJA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:09:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:16169 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhKEJIy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 05:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636103152;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=e7xfcz9krTQc9FROwiWEKD4HCySxX7lxf7ekiUwaVrw=;
    b=Jkvl5x8i7dqbmqyMRflT2LmzPr+cIJR4zPc6R1lyKj9RQdovrPIdnVxTR7bdAMQ14b
    I+EZO/FWuNLQQI0KvOG69CUPfS/HtCzY8YMI1ZsCEiyHIfaVMDdJtBGenAUs+iM/r0++
    6yPiWiCvnEr0wHMIe3+LRSmi53yN2+NxFA/R+5ZrpdUW74Fe9v++5RVx+UO0UeSBssjr
    4UhFWEK1nhTVAVk8a8ahGP0Jfz21yThvdMZWcYnL21tFKWSJbD83tZ4JY6CUgkGmZ5ux
    v+Riki0ucnIEkatTHFE854gJU7mefdsuS4vzqQrY/VF/K2NMorCJ5TnW1SIIk9ktJa1K
    fpHw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdfL1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA595q8uI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 5 Nov 2021 10:05:52 +0100 (CET)
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
Subject: [RFC v4 0/6] mmc: core: extend mmc_fixup_device and transplant ti,wl1251 quirks from to be retired omap_hsmmc
Date:   Fri,  5 Nov 2021 10:05:45 +0100
Message-Id: <cover.1636103151.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RFC V4 2021-11-05 10:05:51:
* remove const from char *const * (Ulf Hansson <ulf.hansson@linaro.org>)
* use for_each_child_of_node() to scan compatible children (Ulf Hansson <ulf.hansson@linaro.org>)
(see: https://lore.kernel.org/lkml/CAPDyKFpr0kpRXoUACNNSwe8pL1S9wJPjnX+GFGS1PNezKCDYzQ@mail.gmail.com/)

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

 drivers/mmc/core/card.h       | 37 +++++++++++++++++++
 drivers/mmc/core/mmc.c        |  1 +
 drivers/mmc/core/quirks.h     | 69 ++++++++++++++++++++++++++---------
 drivers/mmc/core/sd.c         |  2 +
 drivers/mmc/core/sdio.c       |  1 +
 drivers/mmc/host/omap_hsmmc.c | 36 ------------------
 6 files changed, 93 insertions(+), 53 deletions(-)

-- 
2.33.0

