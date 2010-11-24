From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] mmc: Add support for JMicron 388 SD/MMC controller
Date: Wed, 24 Nov 2010 07:21:12 +0100
Message-ID: <1290579674-4616-1-git-send-email-tiwai@suse.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51562 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab0KXGVg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 24 Nov 2010 01:21:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Aries Lee <arieslee@jmicron.com>

Hi,

this is a patch series to add the support for the new JMicron 388
SD/MMC controller.  The first patch is to add the support for the new
PCI device, including the quirks to handle different voltages per
medium.

The second patch is for improving the handling of different bus-
widths dynamically.


thanks,

Takashi
