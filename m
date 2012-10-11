From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [RESEND PATCH 2/2] mmc: mmci: Switching off HWFC for SDIO depends
 on MCLK
Date: Thu, 11 Oct 2012 08:50:34 +0200
Message-ID: <CA+20K0As20SrYGMQy8zmuH3SR=fcwnyiEfAa1svYOp2xokmaQA@mail.gmail.com>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
	<1349885000-22887-2-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdbWVLJKroUgX_kSO4Mwgxfhe3gZO9701xmpDuQJKx7sOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36675 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab2JKGue (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Oct 2012 02:50:34 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2445020iea.19
        for <linux-mmc@vger.kernel.org>; Wed, 10 Oct 2012 23:50:34 -0700 (PDT)
In-Reply-To: <CACRpkdbWVLJKroUgX_kSO4Mwgxfhe3gZO9701xmpDuQJKx7sOQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>

2012/10/10 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Oct 10, 2012 at 6:03 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> For writes, HWFC shall be switched off when transfer size <= 8
>> bytes and when MCLK rate is above 50 MHz. For 50MHz and below
>> it shall be switched off when transfer size < 8 bytes.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>
