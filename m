From: Sachin Kamat <spk.linux@gmail.com>
Subject: Re: [PATCH 1/1] mmc: host: Kconfig: Update SDHCI S3C entry
Date: Wed, 25 Jun 2014 16:27:02 +0530
Message-ID: <CAK5sBcHp74qqa=EU5TfSpCO+VWbYnQx+QFQado6S75bhRfiCDQ@mail.gmail.com>
References: <1403690286-1264-1-git-send-email-sachin.kamat@samsung.com>
	<4605637.HIkriDj1YF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:38588 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096AbaFYK5E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jun 2014 06:57:04 -0400
Received: by mail-lb0-f173.google.com with SMTP id s7so1705278lbd.4
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2014 03:57:02 -0700 (PDT)
In-Reply-To: <4605637.HIkriDj1YF@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, chris@printf.net, Ulf Hansson <ulf.hansson@linaro.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Doug Anderson <dianders@chromium.org>

On Wed, Jun 25, 2014 at 3:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 25 June 2014 15:28:06 Sachin Kamat wrote:
>> All Exynos4 SoC based boards have SDHCI controller and mostly
>> use SD mounted filesystem. Hence it makes sense to default it
>> to yes on Exynos4 platform. While at it also fix a couple of
>> typos in the help text.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Doug Anderson <dianders@chromium.org>
>>
>
> I'm not following that reasoning. We don't normally 'default y'
> peripheral drivers at all, but just enable them in the defconfig.

Doug and I had a small private discussion whereby defaulting commonly
used features across platforms to 'yes' seemed sensible to avoid end users
from trying to figure out the options and dependencies themselves when
trying to build their own configs.

Probably Doug can add more or correct me here.

-- 
Regards,
Sachin.
