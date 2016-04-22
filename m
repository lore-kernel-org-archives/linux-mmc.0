From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/7] mmc: sdhci-pltfm: fix and tidy up sdhci_pltfm_init()
Date: Fri, 22 Apr 2016 14:54:40 +0200
Message-ID: <CAPDyKFqARKho0T-usGvsjNKL4DBp6S9Kg8USNnBzEc8Wke937g@mail.gmail.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34257 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcDVMym (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2016 08:54:42 -0400
Received: by mail-wm0-f46.google.com with SMTP id v200so2313767wmv.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2016 05:54:41 -0700 (PDT)
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 20 April 2016 at 04:16, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
>
> Changes in v2:
>   - Remove resource size checking rather than fix it.
>   - Add \n to the tail of the error message
>
> Masahiro Yamada (7):
>   mmc: sdhci-pltfm: drop error message for too small MMIO resource size
>   mmc: sdhci-pltfm: check return value of platform_get_irq()
>   mmc: sdhci-pltfm: use devm_request_mem_region()
>   mmc: sdhci-pltfm: use devm_ioremap()
>   mmc: sdhci-pltfm: use devm_ioremap_resource()
>   mmc: sdhci-pltfm: move devm_ioremap_resource() up
>   mmc: sdhci-pltfm: call platform_get_irq() before sdhci_alloc_host()
>
>  drivers/mmc/host/sdhci-pltfm.c | 42 +++++++++++++-----------------------------
>  1 file changed, 13 insertions(+), 29 deletions(-)
>
> --
> 1.9.1
>

Thanks, applied for next!

Kind regards
Uffe
