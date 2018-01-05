From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri, 5 Jan 2018 17:14:25 +0100
Message-ID: <CACRpkdZ4OMczAuGmkWs1U0mdEFwCBQt=k=Ft_t8Gq95nwuMtwA@mail.gmail.com>
References: <20180105141535.17614-1-linus.walleij@linaro.org> <OF516BA7ED.7F78F40A-ONC125820C.0052D43F-C125820C.0053AA04@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:38852 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeAEQO0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 11:14:26 -0500
Received: by mail-io0-f182.google.com with SMTP id 87so6252459ior.5
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2018 08:14:26 -0800 (PST)
In-Reply-To: <OF516BA7ED.7F78F40A-ONC125820C.0052D43F-C125820C.0053AA04@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>

On Fri, Jan 5, 2018 at 4:13 PM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

> That works!
>
> Tested on i.mx25 architecture with sdhci-esdhc-imx driver.

NICE!

I will add your Tested-by on the patch and send it for Adrian and Ulf
to consider.

> Here are some time measurements.

You can see that the biffer requests is now even a bit faster than in
the past. This is likely because now we have a bounce buffer of
256K instead of 64K which was what the old bounce buffer code
capped it to.

This exercises the SDMA (it should even be able to use a 512 KB
buffer) better so unless people are very
memory constrained I suggest we keep this.

Yours,
Linus Walleij
