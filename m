Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4864C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E2E6125F
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Nov 2021 09:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhKEJI6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:08:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:10761 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhKEJIy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2021 05:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636103154;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UpNzzMU5r1D4mqcotomyqNYWgYPubHDJjTABPh5er6E=;
    b=gpkm4cEp7o2aw/8AIf8VMLaxr2lqaqKzKJJVU17+6ve2pMzsAYqngOqZpc6tOzQYO6
    ZbwkPw1X6YHwQLbXsarSn4+pp2hwG70AFi8W1X1fE7P68iw3gqp49SmcVevO//pJ8qDP
    nmdfbRTRDyJAn2fPm8uPifQSlNYHijaIcwH1jsuOJClj74A8LlV5R/rorAyXBTlHqMDZ
    SdbZVzbVFHFcJhXBa5uOTDy98bg5ZhvzFIBM1qD9hZ8xeLxGmll+Ol1ML3cGe8qcgfOl
    7bvUORtrZWyRuVRytrH9yz0lWSErUqZOz6JrvFOF9xSzTOpcCcjahXSJB9rZOAZ9sra7
    z5Eg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdfL1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.1 DYNA|AUTH)
    with ESMTPSA id 902c63xA595r8uM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 5 Nov 2021 10:05:53 +0100 (CET)
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
Subject: [RFC v4 3/6] mmc: core: provide macro and table to match the device tree to apply quirks
Date:   Fri,  5 Nov 2021 10:05:48 +0100
Message-Id: <ac5cc7cdcd530af35c483cc9ea110013fb1a6049.1636103151.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1636103151.git.hns@goldelico.com>
References: <cover.1636103151.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This (initially empty) table allows to match quirks early based
on .compatible of the child node of some mmc/sdio interface.

A new macro SDIO_FIXUP_COMPATIBLE makes the definition readable.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/mmc/core/card.h   | 15 +++++++++++++++
 drivers/mmc/core/quirks.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
index a3204c19861a4..089ede71d3150 100644
--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -122,6 +122,21 @@ struct mmc_fixup {
 		   _vendor, _device,					\
 		   _fixup, _data, EXT_CSD_REV_ANY)			\
 
+#define SDIO_FIXUP_COMPATIBLE(_compatible_list, _fixup, _data)		\
+	{						\
+		.name = CID_NAME_ANY,			\
+		.manfid = CID_MANFID_ANY,		\
+		.oemid = CID_OEMID_ANY,			\
+		.rev_start = 0,				\
+		.rev_end = -1ull,			\
+		.cis_vendor = SDIO_ANY_ID,		\
+		.cis_device = SDIO_ANY_ID,		\
+		.vendor_fixup = (_fixup),		\
+		.data = (_data),			\
+		.ext_csd_rev = EXT_CSD_REV_ANY,		\
+		.of_compatible = _compatible_list,	\
+	}
+
 #define cid_rev(hwrev, fwrev, year, month)	\
 	(((u64) hwrev) << 40 |			\
 	 ((u64) fwrev) << 32 |			\
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index ee591fd8aeca2..41c418527199c 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -146,6 +146,10 @@ static const struct mmc_fixup __maybe_unused sdio_fixup_methods[] = {
 	END_FIXUP
 };
 
+static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] = {
+	END_FIXUP
+};
+
 static inline bool mmc_fixup_of_compatible_match(struct mmc_card *card,
 						 const char *const *compat_list)
 {
-- 
2.33.0

