From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Mon, 29 Aug 2016 11:44:32 +0200
Message-ID: <5229438.Oa2AiqCmJN@wuerfel>
References: <20160808015803.2528-1-jaedon.shin@gmail.com> <501206D1-D60B-4BA7-99C0-C38065C3AE9E@gmail.com> <7edcef69-d364-8845-a677-3827a50f4da1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:52555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756125AbcH2Jot (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 05:44:49 -0400
In-Reply-To: <7edcef69-d364-8845-a677-3827a50f4da1@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jaedon Shin <jaedon.shin@gmail.com>, Alan Cooper <alcooperx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

On Saturday, August 27, 2016 12:56:10 PM CEST Florian Fainelli wrote:
> 
> Finally, Arnd's suggestions of using "dma-ranges" is fine, but I do not
> think we quite need this here because we really need to advertise the
> right set of capabilities based on the generation/version of the
> controller deployed in specific chips.

To be more specific here, I think that without the dma-ranges property
you should never be able to set a dma-mask larger than the 32-bit
mask, so if you have machines that are capable of high DMA, you
should definitely add the property in the bus, even if that is
currently ignored.

I've suggested a patch before, but I believe both ARM and MIPS ignore
this at the moment, and just allow drivers to set arbitrary masks
even when the bus does not have a dma-ranges property, and that
is a bug.

	Arnd
