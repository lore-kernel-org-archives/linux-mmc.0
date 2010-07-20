From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: [PATCH] MMC driver full patch for Moorestown platform
Date: Tue, 20 Jul 2010 22:56:57 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A473272A2391@shsmsx501.ccr.corp.intel.com>
References: <20100617151623.9951.41387.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18290 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758478Ab0GTO7X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jul 2010 10:59:23 -0400
In-Reply-To: <20100617151623.9951.41387.stgit@localhost.localdomain>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, "pierre@ossman.eu" <pierre@ossman.eu>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>-----Original Message-----
>From: linux-mmc-owner@vger.kernel.org
>[mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Alan Cox
>Sent: Thursday, June 17, 2010 11:17 PM
>To: pierre@ossman.eu; linux-mmc@vger.kernel.org
>Subject: [PATCH] MMC driver full patch for Moorestown platform
> ...
>@@ -240,6 +241,12 @@ struct sdhci_host {
> #define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN		(1<<25)
> /* Controller cannot support End Attribute in NOP ADMA descriptor */
> #define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<26)
>+/* Controller can only handle full speed mode */
>+#define SDHCI_QUIRK_FORCE_FULL_SPEED_MODE		(1<<27)
>+/* Controller has an issue with software reset all function */
>+#define SDHCI_QUIRK_BROKEN_RESETALL			(1<<28)
>+/* Controller has an issue when its two slots enabled together */
>+#define SDHCI_QUIRK_SERIALIZE				(1<<29)

The 'quirks' is a 32bit variable, but now bit0 - bit29 has already been used. And I think the bit30 and bit 31 will be used soon. So, after that, how to add a new quirk?
Do we need to change the 'quirk' variable to 64bit?

