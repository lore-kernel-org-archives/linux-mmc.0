From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 0/6] mmc: sdhci-acpi: Fix broken card detect for ACPI HID 80860F14
Date: Mon, 17 Mar 2014 13:14:16 +0000
Message-ID: <86zjkpvufr.fsf@void.printf.net>
References: <1394456564-13783-1-git-send-email-adrian.hunter@intel.com>
	<5326BCF1.4010509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37513 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932514AbaCQNOT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Mar 2014 09:14:19 -0400
In-Reply-To: <5326BCF1.4010509@intel.com> (Adrian Hunter's message of "Mon, 17
	Mar 2014 11:14:25 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Adrian,

On Mon, Mar 17 2014, Adrian Hunter wrote:
>> Adrian Hunter (6):
>>       mmc: slot-gpio: Record GPIO descriptors instead of GPIO numbers
>>       mmc: slot-gpio: Split out CD IRQ request into a separate function
>>       mmc: slot-gpio: Add GPIO descriptor based CD GPIO API
>>       mmc: sdhci-acpi: Fix broken card detect for ACPI HID 80860F14 SD cards
>>       mmc: sdhci-acpi: Add device id 80860F16
>>       mmc: sdhci: Allow for irq being shared.
>
> Chris, can these be queued for 3.15?  Note I did a V2 of just "mmc: sdhci:
> Allow for irq being shared"

Thanks, merged all six patches (with v2 of 6/6) to mmc-next for 3.15.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
