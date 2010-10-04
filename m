From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/3] Enabling patches for Intel MID SDHCI
Date: Mon, 04 Oct 2010 15:23:55 +0100
Message-ID: <20101004142246.901.37491.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46815 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab0JDPrb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 11:47:31 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id o94EgLTJ024694
	for <linux-mmc@vger.kernel.org>; Mon, 4 Oct 2010 15:42:26 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Try again...

This adds basic support for the Intel MID platform devices. It doesn't include
the callback stuff to handle some of the errata but I'm trying to verify
which if any of those make sense outside of Intel before resubmitting that
bit.

---

Alan Cox (2):
      sdhci: Add Moorestown devices
      sdhci: Allow the probe handler to override slots

Xiaochen Shen (1):
      sdhci: Intel Medfield support


 drivers/mmc/host/sdhci-pci.c |   89 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h      |    7 +++
 2 files changed, 96 insertions(+), 0 deletions(-)

-- 
Please mind the gap. Care for it and look after its needs

