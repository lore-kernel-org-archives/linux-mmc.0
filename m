From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] DWMMC controller fixes
Date: Mon, 7 Nov 2016 08:56:11 +0100
Message-ID: <CAPDyKFosvVvxmBpm4tj3XaWeWxGtQgsSaBMFaSdMtkY9iCfbgA@mail.gmail.com>
References: <587f4226-0c21-899b-b16d-3f33d092e382@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35797 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbcKGIC1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 03:02:27 -0500
Received: by mail-wm0-f45.google.com with SMTP id a197so165103093wmd.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 00:02:27 -0800 (PST)
In-Reply-To: <587f4226-0c21-899b-b16d-3f33d092e382@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 3 November 2016 at 06:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches on your fixes branch?
>
> The following changes since commit d1f63f0c81c22ba705fcd149a1fcec37b734d818:
>
>   mmc: sdhci-msm: Fix error return code in sdhci_msm_probe() (2016-10-27 09:43:01 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git fixes
>
> for you to fetch changes up to 5c3d7c7ed1e676d7fa1c9222d9a46c5d09b9fe97:
>
>   mmc: dw_mmc: add the "reset" as name of reset controller (2016-11-03 14:11:59 +0900)
>
> ----------------------------------------------------------------
> DWMMC core:
> - Add the "reset" as "#reset-names" property for preventing wrong operation.
>
> ----------------------------------------------------------------
> Jaehoon Chung (2):
>       Documentation: synopsys-dw-mshc: add binding for reset-names
>       mmc: dw_mmc: add the "reset" as name of reset controller
>
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 +++++
>  drivers/mmc/host/dw_mmc.c                                  | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
>
> Best Regards,
> Jaehoon Chung

Thanks Jaehoon, pulled into fixes - and sorry for the delay!

Kind regards
Uffe
