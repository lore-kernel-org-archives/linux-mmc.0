From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: add SoC specific compatible string
Date: Wed, 14 Dec 2016 11:12:24 +0900
Message-ID: <CAK7LNASg=apv0JGcdwnS8Yy2zO6u9rQS-1ca717T4QaZ8QOO1A@mail.gmail.com>
References: <1481680795-15697-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:20652 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbcLNCMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2016 21:12:32 -0500
In-Reply-To: <1481680795-15697-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Rob Herring <robh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

2016-12-14 10:59 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Add a Socionext SoC specific compatible (suggested by Rob Herring).
>
> No SoC specific data are associated with the compatible strings for
> now, but other SoC vendors may use this IP and want to differentiate
> IP variants in the future.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I thought adding SoC family name ("uniphier") would be better.

I've just sent v2.




-- 
Best Regards
Masahiro Yamada
