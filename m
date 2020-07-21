Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A322C433E2
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E6C2073A
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595366637;
	bh=RNILwOin5kwW3Hlbc+oaU3qoHR9blyRxCdbK2sRyfIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=No1Cnx8omIKoMdI0YXq11xqgMPrUzCLsAWiGZ8TiyfMod0WtODVXq/sbdG5q+9I/h
	 w2YqcQFq/wqInDokVctLDgbzVtNteiOVsIEaAW6zF3czYyz4fQnEEKYyweHcW2hzya
	 ksbINueXgca7MQpZlfqRVxxP2tYsCbOjnmavB2O8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgGUVX4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgGUVX4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jul 2020 17:23:56 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A537A20717;
        Tue, 21 Jul 2020 21:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595366636;
        bh=RNILwOin5kwW3Hlbc+oaU3qoHR9blyRxCdbK2sRyfIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7kCGblC8cZuPdD4jW786SouTiiPMt8Akmn0zfa4/ESdHATfBFQhvImdPulmPpyIi
         3hFpj71dQxvi64Jag7Dor1SSZDgCcRj27Tm3ltCr+AlrHeAYLQbwzNczRqXt98465Q
         k2O7ngX4G5ymMVjrEbz4gLiO7XEOpOHFEJBTeQBs=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ricky Wu <ricky_wu@realtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rui Feng <rui_feng@realsil.com.cn>, Klaus Doth <kdlnx@doth.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/5] misc: rtsx: Use pcie_capability_clear_and_set_word() for PCI_EXP_LNKCTL
Date:   Tue, 21 Jul 2020 16:23:32 -0500
Message-Id: <20200721212336.1159079-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721212336.1159079-1-helgaas@kernel.org>
References: <20200721212336.1159079-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Instead of using the driver-specific rtsx_pci_write_config_byte() to update
the PCIe Link Control Register, use pcie_capability_write_word() like the
rest of the kernel does.  This makes it easier to maintain ASPM across the
PCI core and drivers.

No functional change intended.  I missed this when doing 3d1e7aa80d1c
("misc: rtsx: Use pcie_capability_clear_and_set_word() for
PCI_EXP_LNKCTL").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 0d5928bc1b6d..6a4d6c8f4e71 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1231,6 +1231,7 @@ int rtsx_ms_power_off_card3v3(struct rtsx_pcr *pcr)
 
 static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 {
+	struct pci_dev *pdev = pcr->pci;
 	int err;
 
 	pcr->pcie_cap = pci_find_capability(pcr->pci, PCI_CAP_ID_EXP);
@@ -1324,7 +1325,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	rtsx_pci_init_ocp(pcr);
 
 	/* Enable clk_request_n to enable clock power management */
-	rtsx_pci_write_config_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL + 1, 1);
+	pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
+				   PCI_EXP_LNKCTL_CLKREQ_EN);
 	/* Enter L1 when host tx idle */
 	rtsx_pci_write_config_byte(pcr, 0x70F, 0x5B);
 
-- 
2.25.1

