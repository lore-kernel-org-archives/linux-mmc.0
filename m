From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 01/15] ARM: pxa: Don't rely on public mmc header to include leds.h
Date: Fri, 20 Jan 2017 20:34:29 +0100
Message-ID: <87a8aleda2.fsf@belgarion.home>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
        <1484313256-25993-2-git-send-email-ulf.hansson@linaro.org>
        <87efzydusi.fsf@belgarion.home>
        <CAPDyKFo=tUu9D5zZnUME_+HFBPEnnjy2taTdFLO9H6jSSgKc5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:32011 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbdATTef (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 14:34:35 -0500
In-Reply-To: <CAPDyKFo=tUu9D5zZnUME_+HFBPEnnjy2taTdFLO9H6jSSgKc5A@mail.gmail.com>
        (Ulf Hansson's message of "Fri, 20 Jan 2017 09:27:29 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 20 January 2017 at 09:01, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>> So I was wondering how you made the choice of which files you add the include to
>> and which you don't touch ?
>
> By building the pxa_defconfig, see what errors it reports and then fix them.
>
> Isn't pxa_defconfig building all the variants?
Euh actually it should, but it's not.

The file was built from all _existing_ pxa defconfigs in arch/arm/configs/. The
trick is that there were many pxa boards for which no defconfig file was
available, and therefore they "escape" the pxa_defconfig coverage.

Cheers.

-- 
Robert
