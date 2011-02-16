From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 00/11] MMC DMA-API/dmaengine fixups
Date: Wed, 16 Feb 2011 22:04:20 +0100
Message-ID: <AANLkTi=aU9B7Qo3RWifjJPLXR_E6hQm4A3iEdsLwhcgX@mail.gmail.com>
References: <1297350372-725-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52188 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1BPVEV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 16:04:21 -0500
Received: by pva4 with SMTP id 4so259302pva.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Feb 2011 13:04:20 -0800 (PST)
In-Reply-To: <1297350372-725-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>

2011/2/10 Linus Walleij <linus.walleij@linaro.org>:

> This patch series fixes a number of DMA-API and dmaengine issues
> that we encountered while working with the recent changes to the
> MMCI/PL180 driver. It'd be bad to leave bad examples around like
> this.

Chris are you picking these up? Maybe the only way of getting
some broad test of these cleanups is to push it into -next
so it'll be noticed...

Linus Walleij
