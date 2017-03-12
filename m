From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v2 PATCH 1/3] mmc: sdhci-cadence: Fix writing PHY delay
Date: Mon, 13 Mar 2017 00:37:35 +0900
Message-ID: <CAK7LNATB-h+tM6ajb7q7Pb1gi+pXuXfinhCWw=EnH_utquhhMQ@mail.gmail.com>
References: <1488807487-28442-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:20710 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755675AbdCLPht (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2017 11:37:49 -0400
In-Reply-To: <1488807487-28442-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2017-03-06 22:38 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> Add polling for ACK to be sure that data are written to PHY register.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v2:
> - fix indent
> ---

This one looks OK.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
