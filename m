From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] mmc: sdhci-msm: Corrections to implementation of
 power irq
Date: Tue, 22 Aug 2017 11:40:52 +0200
Message-ID: <CAPDyKFqFAbkwXyvfHOTRoe6J8EHirJFUYwR6TGq9BBRDq2Xfpg@mail.gmail.com>
References: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34562 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932305AbdHVJkx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 05:40:53 -0400
Received: by mail-qt0-f182.google.com with SMTP id p10so344476qte.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 02:40:53 -0700 (PDT)
In-Reply-To: <1503033582-48703-1-git-send-email-vviswana@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>

On 18 August 2017 at 07:19, Vijay Viswanath <vviswana@codeaurora.org> wrote:
> Register writes which change voltage of IO lines or turn the IO bus on/off
> require sdhc controller to be ready before progressing further. Once a
> register write which affects IO lines is done, the driver should wait for
> power irq from controller. Once the irq comes, the driver should acknowledge
> the irq by writing to power control register. If the acknowledgement is not
> given to controller, the controller may not complete the corresponding
> register write action and this can mess up the controller if drivers proceeds
> without power irq completing.
>
> Sahitya Tummala (2):
>   mmc: sdhci-msm: Fix HW issue with power IRQ handling during reset
>   mmc: sdhci-msm: Add support to wait for power irq
>
> Subhash Jadavani (1):
>   mmc: sdhci-msm: fix issue with power irq
>
> Vijay Viswanath (2):
>   mmc: sdhci-msm: Add ops to do sdhc register write
>   defconfig: msm: Enable CONFIG_MMC_SDHCI_IO_ACCESSORS
>
>  arch/arm64/configs/defconfig |   1 +
>  drivers/mmc/host/sdhci-msm.c | 233 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 229 insertions(+), 5 deletions(-)
>
> --
>  Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>

Looks good to me, besides patch 5 which I provided comments for.

Unless Adrian objects, I intend to queue this within the next couple of days.

Kind regards
Uffe
