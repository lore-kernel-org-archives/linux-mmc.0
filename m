Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258519;
	b=ISBL30VZ4sjwBVbISxtWQ4/G73y3f+ClKccIMLNG82sDa3TSZk3eiawFSMywzhY7oxj2
	 NPg5qk4+5j8H81Q0AwFQtdEdvhwGHH5dCXB3T4LX9gFrSty+BQCFGXDz9R8eTwQ71x+b0
	 VA2bIb7B38/RdMEKoAThJImH4OKdYVk9WMBQ6pTFsd4/k8M27QqMLkYxGcLYGiWDP51l1
	 Ytit8dYLbRje9CjI4Q6T29eGlhiwQmCuzWGam0MvYp/cXOXVlCzOXnZDR0bJP1MtJfAQD
	 KO0H+3QnF2sI+eSlAyxcbsZRsMjLKSfT9s0LLiT4BV975Ntg4Wn8yWRmnYew2hPNzOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258519;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Pq+rUe2h6lwne59EbimzJsOTsSFWdwJecoD7SnDlf28=;
	b=ekG5WRtqrZfmRs9Gc1xfiIlfJBJLzGoKFcM2N3vbVm5vy+FzVBHl949PISn2h41HX00F
	 weaTEmYkvCE+IDkjuSr03l8Xc6JaDUUdeI5/DH+3HYb9pxL3ItcPlfguQelyhFGOMwIBM
	 g6NJ2msKUCqll72jJgkQanrmGs/xpbpFJPQnRpDS10BHmztuf4ittVws3eofhoX5VsDDV
	 kmpumV2olgyVKOyA9sNTCj7FcGq3gwFY+4woovOBMiYh12UcrzIQnK+iHJX/sCgoFoF1H
	 q+UFOiqpJNUaoW2N8IbIqxPZXJET3ZVAjEg6ngNM1iS+F2JLBbYJCZL9Xq3yfhhVJhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kk0vqNR9;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA37C606A334;
	Mon,  9 Nov 2026 21:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA37C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kk0vqNR9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258519; x=1825794519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BuusNMbZxO+ErFUdpf9Ul1RNEs8Z0V6p6exb7dpC0MQ=;
  b=Kk0vqNR9GGeSqZFtaTxSSg1FcWAPsjSl8epug+dR+ALYI8v+lA0PAtso
   qdG67cnKxfHloL8W4gm8Svq7GlD9uBatiPwmqkUkNKMuwEC613O5C5Qb7
   NegrAu4v2HlILP0cJU8EFgjzONX2xr7KoNlFvlKt5PAP3qypqWuquUQyc
   v1EgmlzmGrZyglAv4gDIspXAjk7Nu2ixsCc5OhSqbTBTgouDM6hgk6hqf
   gz/C4IOCvd7n6vT7C0lCap1oPxP8aimYHc8eIsv5aAKsjArEZQweGPJbj
   sEbzGPDRxvSgBJTtixwSAIdABA4oRxrKJjQz7Ra0rogj+j8otveYbPopp
   A==;
X-CSE-ConnectionGUID: +ZW4pc4eSL+Er5hON+ZB+A==
X-CSE-MsgGUID: /H6Fz6epSWeP2iWlJ+yKQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2874579"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2874579"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:38 -0800
X-CSE-ConnectionGUID: dLo04yZBReOn+4Azaw0BTg==
X-CSE-MsgGUID: /9SIhAK9SgGKVVAJpyu1yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7838187"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:08:34 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Alex Dubov <oakad@yahoo.com>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: [RFC PATCH 08/11] PCI: Move CardBus device setup to setup-cardbus.c
Date: Mon,  9 Nov 2026 23:07:08 +0200
Message-ID: <20261109210714.3862-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CardBus support can be disabled with CONFIG_CARDBUS, but
pci_setup_device() still sets up CardBus bridges regardless of it. This
inconsistency leads to a few corner cases in the resource sizing and
assignment algorithm where CardBus bridges are treated like normal PCI
devices.

Move the CardBus-specific part of pci_setup_device() into
pci_setup_cardbus_device() in setup-cardbus.c and ignore CardBus bridges
when CARDBUS is not set.

If a CardBus bridge that is Function 0 of a Multi-Function Device is
ignored, pci_scan_slot() does not enumerate the other Functions either.
Without CARDBUS, this makes the other Functions of CardBus combo chips
unusable, e.g., the SD controller of the Ricoh RL5C476 (sdhci-pci), and
the FireWire (firewire-ohci), Flash Media (tifm_7xx1), and SD
(sdhci-pci) controllers of the TI PCIxx21. Making those drivers depend
on CARDBUS would force CardBus also on users of chips without CardBus,
e.g., the SD controller of the Ricoh R5C832 family, where Function 0 is
a FireWire controller.

CARDBUS defaults to y if CONFIG_PCCARD is enabled and the yenta_socket
driver (CONFIG_YENTA) selects it, so CARDBUS=n on hardware with a
CardBus slot is most likely an intentional choice. It seems reasonable
to require users with such an exceptional config to enable CARDBUS to
keep using the drivers above with this legacy hardware.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ulf Hansson <ulfh@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Alex Dubov <oakad@yahoo.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net

 drivers/pci/pci.h           |  6 ++++++
 drivers/pci/probe.c         | 13 +++++++------
 drivers/pci/setup-cardbus.c | 13 +++++++++++++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 798b31c31ae4..057c8a2c7ee7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -425,6 +425,7 @@ static inline bool pci_is_cardbus_bridge(const struct pci_dev *dev)
 }
 #ifdef CONFIG_CARDBUS
 unsigned long pci_cardbus_resource_alignment(const struct resource *res);
+int pci_setup_cardbus_device(struct pci_dev *dev);
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head);
 int pci_cardbus_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
@@ -437,6 +438,10 @@ static inline unsigned long pci_cardbus_resource_alignment(const struct resource
 {
 	return 0;
 }
+static inline int pci_setup_cardbus_device(struct pci_dev *dev)
+{
+	return -EOPNOTSUPP;
+}
 static inline int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 					      struct list_head *realloc_head)
 {
@@ -528,6 +533,7 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
 					int rrs_timeout);
 
 int pci_setup_device(struct pci_dev *dev);
+void pci_read_irq(struct pci_dev *dev);
 void __pci_size_stdbars(struct pci_dev *dev, int count,
 			unsigned int pos, u32 *sizes);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a20ceaf7307a..f7afbaac723d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1599,7 +1599,7 @@ EXPORT_SYMBOL(pci_scan_bridge);
  * Read interrupt line and base address registers.
  * The architecture-dependent code can tweak these, of course.
  */
-static void pci_read_irq(struct pci_dev *dev)
+void pci_read_irq(struct pci_dev *dev)
 {
 	unsigned char irq;
 
@@ -2180,12 +2180,13 @@ int pci_setup_device(struct pci_dev *dev)
 		break;
 
 	case PCI_HEADER_TYPE_CARDBUS:		    /* CardBus bridge header */
-		if (class != PCI_CLASS_BRIDGE_CARDBUS)
+		err = pci_setup_cardbus_device(dev);
+		if (err == -EOPNOTSUPP) {
+			pci_err(dev, "CONFIG_CARDBUS not set, ignoring CardBus bridge\n");
+			goto free_name;
+		}
+		if (err)
 			goto bad;
-		pci_read_irq(dev);
-		pci_read_bases(dev, 1, 0);
-		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
-		pci_read_config_word(dev, PCI_CB_SUBSYSTEM_ID, &dev->subsystem_device);
 		break;
 
 	default:				    /* unknown header */
diff --git a/drivers/pci/setup-cardbus.c b/drivers/pci/setup-cardbus.c
index dcb8e2b3f73b..0de82d7fde68 100644
--- a/drivers/pci/setup-cardbus.c
+++ b/drivers/pci/setup-cardbus.c
@@ -31,6 +31,19 @@ unsigned long pci_cardbus_resource_alignment(const struct resource *res)
 	return 0;
 }
 
+int pci_setup_cardbus_device(struct pci_dev *dev)
+{
+	if (dev->class >> 8 != PCI_CLASS_BRIDGE_CARDBUS)
+		return -EIO;
+
+	pci_read_irq(dev);
+	pci_read_bases(dev, 1, 0);
+	pci_read_config_word(dev, PCI_CB_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
+	pci_read_config_word(dev, PCI_CB_SUBSYSTEM_ID, &dev->subsystem_device);
+
+	return 0;
+}
+
 int pci_bus_size_cardbus_bridge(struct pci_bus *bus,
 				struct list_head *realloc_head)
 {
-- 
2.47.3

