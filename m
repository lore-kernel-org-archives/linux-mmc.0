Return-Path: <SRS0=zOov=BA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDECFC433E5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A121120717
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jul 2020 21:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595366640;
	bh=ajSaAeF2n7h94VHdL4uWUGlYN0WyGAIis5MfUlWwmP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LIJ00yt2VBUVgPprPBCiTbry5KUSqY3csS//Hx3iKiHSZJg/eRaGlKHv8e4umd4NQ
	 OprHIHVKN4NC0eYEKxYnp2A8U7m2r2PABvEZ+qilIZFHxkfTfkEAeqs+ZhhzUXEsuh
	 IQif9U3Xfqc8ij+h+xFdzuT5NuB804HEktE4sTkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbgGUVYA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731217AbgGUVX7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jul 2020 17:23:59 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0885F2072E;
        Tue, 21 Jul 2020 21:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595366639;
        bh=ajSaAeF2n7h94VHdL4uWUGlYN0WyGAIis5MfUlWwmP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/ZR+ZcPViUCvb3a1csLlqWzupg0vM/RX6nw+mRD9UnE06WzyUUd39rGMR2e9lugH
         fpiyGIlABT0VyKTaEGw1rJNdjs6JcH0JvUlwLFz30ZvrseTKLYJ7wsa6NTXDDK3F1w
         QftBuXdBOb2nM0Pc7lvpSSCGlYDuSm8gqe4hMwDE=
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
Subject: [PATCH 2/5] misc: rtsx: Remove unused pcie_cap
Date:   Tue, 21 Jul 2020 16:23:33 -0500
Message-Id: <20200721212336.1159079-3-helgaas@kernel.org>
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

There are no more uses of struct rtsx_pcr.pcie_cap.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 1 -
 include/linux/rtsx_pci.h           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 6a4d6c8f4e71..169505165a52 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1234,7 +1234,6 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 	struct pci_dev *pdev = pcr->pci;
 	int err;
 
-	pcr->pcie_cap = pci_find_capability(pcr->pci, PCI_CAP_ID_EXP);
 	rtsx_pci_writel(pcr, RTSX_HCBAR, pcr->host_cmds_addr);
 
 	rtsx_pci_enable_bus_int(pcr);
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index e8780d4e4636..b1071c80fffc 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1158,7 +1158,6 @@ struct rtsx_hw_param {
 struct rtsx_pcr {
 	struct pci_dev			*pci;
 	unsigned int			id;
-	int				pcie_cap;
 	struct rtsx_cr_option	option;
 	struct rtsx_hw_param hw_param;
 
-- 
2.25.1

