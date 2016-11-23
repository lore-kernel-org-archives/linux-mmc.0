From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-pci: Add GLK support and misc
Date: Wed, 23 Nov 2016 13:49:41 +0100
Message-ID: <CAPDyKFr11HaZ8ee1JMorMw5TDBqxY__NNsDWAt7F1etU10=VOA@mail.gmail.com>
References: <1479805418-19603-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36632 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936202AbcKWMtn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 07:49:43 -0500
Received: by mail-wm0-f52.google.com with SMTP id g23so76597518wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2016 04:49:42 -0800 (PST)
In-Reply-To: <1479805418-19603-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>

On 22 November 2016 at 10:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> Here are a couple of small patches.
>
>
> Adrian Hunter (1):
>   mmc: sdhci-pci: Add support for Intel GLK
>
> David E. Box (1):
>   mmc: sdhci-pci: Allow deferred probe for sd card detect gpio
>
>  drivers/mmc/host/sdhci-pci-core.c | 42 +++++++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci-pci.h      |  3 +++
>  2 files changed, 39 insertions(+), 6 deletions(-)
>

Thanks, applied for next!

Kind regards
Uffe
