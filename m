From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v3] mmc: sdhci-cadence: add HS400 enhanced strobe support
Date: Tue, 7 Mar 2017 05:59:21 +0900
Message-ID: <CAK7LNASidygSfmRZw7GWwG34W+kpaxvV5=OK=jrLcCSq_DOzLg@mail.gmail.com>
References: <1488788921-29260-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from condef-07.nifty.com ([202.248.20.72]:33147 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbdCFVG3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Mar 2017 16:06:29 -0500
In-Reply-To: <1488788921-29260-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Piotr,

2017-03-06 17:28 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Add support for HS400ES mode to Cadence SDHCI driver.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes in v2:
> - Modify enhanced strobe function to handle disabling
>   enhanced strobe inside the function.
>   Do no relay on that mmc_set_ios() is called
>   immediately after host->ops->hs400_enhanced_strobe(host, &host->ios).
> Changes in v3:
> - Few coding-style fixes were made.


Thanks for the update, and it looks good to me.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
