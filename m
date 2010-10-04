From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/3] Initial Intel MID support for SDHCI
Date: Mon, 04 Oct 2010 15:06:22 +0100
Message-ID: <20101004140454.14608.70665.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46815 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756404Ab0JDPra (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 11:47:30 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id o94EOm4S024091
	for <linux-mmc@vger.kernel.org>; Mon, 4 Oct 2010 15:24:53 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This implements the basic bits, it's not sufficient for the early steppings
but I want to verify which early steppings are actually worth supporting
outside of Intel before I resubmit the various callback quirk stuff.
---

Alan Cox (2):
      sdhci: Add Moorestown devices
      sdhci: Allow the probe handler to override slots

Xiaochen Shen (1):
      sdhci: Intel Medfield support


 drivers/mmc/host/sdhci-pci.c |   91 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h      |    7 +++
 2 files changed, 98 insertions(+), 0 deletions(-)

-- 
Please mind the gap, look after it and see to its needs

