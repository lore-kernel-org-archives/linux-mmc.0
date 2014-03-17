From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/6] mmc: sdhci-acpi: Fix broken card detect for ACPI
 HID 80860F14
Date: Mon, 17 Mar 2014 11:14:25 +0200
Message-ID: <5326BCF1.4010509@intel.com>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9500 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbaCQJPL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Mar 2014 05:15:11 -0400
In-Reply-To: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ulf Hansson <ulf.hansson@linaro.org>

On 10.03.2014 15:02, Adrian Hunter wrote:
> Hi
> 
> Here are some patches that fix broken card detect for ACPI HID
> 80860F14.  To do that the card detect GPIO API needed to be
> extended to support the new GPIO descriptor API.
> 
> There are also 2 unrelated but self-explanatory patches
> appended:
> 	mmc: sdhci-acpi: Add device id 80860F16
> 	mmc: sdhci: Allow for irq being shared.
> 
> 
> Adrian Hunter (6):
>       mmc: slot-gpio: Record GPIO descriptors instead of GPIO numbers
>       mmc: slot-gpio: Split out CD IRQ request into a separate function
>       mmc: slot-gpio: Add GPIO descriptor based CD GPIO API
>       mmc: sdhci-acpi: Fix broken card detect for ACPI HID 80860F14 SD cards
>       mmc: sdhci-acpi: Add device id 80860F16
>       mmc: sdhci: Allow for irq being shared.

Chris, can these be queued for 3.15?  Note I did a V2 of just "mmc: sdhci:
Allow for irq being shared"


