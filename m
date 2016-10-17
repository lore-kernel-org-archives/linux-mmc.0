From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci-iproc: Add byte register access support
Date: Mon, 17 Oct 2016 15:49:29 +0200
Message-ID: <CAPDyKFpsTNKCC3dTJUipRVhALh2=4YJ5k6Ofp9TUu0RjKO6FaA@mail.gmail.com>
References: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:32978 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757959AbcJQNtc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2016 09:49:32 -0400
Received: by mail-yw0-f175.google.com with SMTP id t192so116240481ywf.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2016 06:49:31 -0700 (PDT)
In-Reply-To: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 October 2016 at 20:35, Scott Branden <scott.branden@broadcom.com> wrote:
> Add brcm,sdhci-iproc compat string and code for support of newer versions of
> sdhci-iproc controller that allow byte-wise register accesses.
>
> Scott Branden (2):
>   mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings
>     document
>   mmc: sdhci-iproc: support standard byte register accesses
>
>  .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  1 +
>  drivers/mmc/host/sdhci-iproc.c                     | 35 ++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> --
> 2.5.0
>

Thanks, applied for next!

Kind regards
Uffe
