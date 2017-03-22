From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v5 4/4] mmc: sdhci-cadence: refactor probe function
Date: Wed, 22 Mar 2017 16:31:54 +0900
Message-ID: <CAK7LNAT0yvGT-Zg0z3+B4amNxmhtZbCoszWc2F-39TxJLXKi4w@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com> <1490106806-3936-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:44964 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758877AbdCVHcI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 03:32:08 -0400
In-Reply-To: <1490106806-3936-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-03-21 23:33 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Use added dev variable for devm_clk_get.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v5:
> - patch created in v5
> ---


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


-- 
Best Regards
Masahiro Yamada
