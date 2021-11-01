Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E467AC433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 09:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E4C60F24
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Nov 2021 09:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhKAJor (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Nov 2021 05:44:47 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:16241 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhKAJmF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2021 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635759559;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=DomC1tuVP3Rv6ZCK3xOqypw8WWUpvV1haZLRxSaIuL4=;
    b=Dxo1FWuEfO+HNkN2ScdmQzcdxUDP3PPUL84vC2hvKtDK0Kmoy8l/0cal6zTL+aO0S1
    sECMwnD7Ogr2t78SJEiLP2PEmRFAvofkcTG0d2zgw5CJ9eR3WNbk/LLxjO3Ncloag5FM
    2a3vtsgbLde6ZD2RYiS1GAHCiauIT9cuYO5dBnP7vQdMU2L26IfSNOClRYS594+9/9dI
    9lTW5p1G8Ly4rLhUeCQ6ljX6YYzb/bD3Z/SzNp4gLqJAlYwJbd6BgnTQ27CnXLQ7z+Xf
    q0Y+NeZL/HsLtZdZV2Ppmhhlc7lGrma6lmyVmG7uGBil0snAsu43iNm80I49n7r9ODhw
    6aTQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1KHeBQyh+ITDDJhD74="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 SBL|AUTH)
    with ESMTPSA id d01d1fxA19dJH5j
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 1 Nov 2021 10:39:19 +0100 (CET)
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
Subject: [RFC v2 0/2] 
Date:   Mon,  1 Nov 2021 10:39:10 +0100
Message-Id: <cover.1635759337.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RFC V2 2021-11-01 10:24:26:
* reworked to not misuse mmc_select_card() but add a call to
  mmc_fixup_device() right after where host->ops->init_card
  was called before to apply the wl1251 specific quirks.
  Device tree matching is done by a new table passed to mmc_fixup_device().
  suggested by: ulf.hansson@linaro.org
  based on patches by: jerome.pouiller@silabs.com

RFC V1 2021-10-06 13:24:13:


H. Nikolaus Schaller (2):
  mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
  mmc: host: omap_hsmmc: revert special init for wl1251

 drivers/mmc/core/card.h       | 19 ++++++++++++++++++
 drivers/mmc/core/mmc.c        |  1 +
 drivers/mmc/core/quirks.h     | 22 +++++++++++++++++++++
 drivers/mmc/core/sd.c         |  2 ++
 drivers/mmc/core/sdio.c       |  1 +
 drivers/mmc/host/omap_hsmmc.c | 36 -----------------------------------
 6 files changed, 45 insertions(+), 36 deletions(-)

-- 
2.33.0

