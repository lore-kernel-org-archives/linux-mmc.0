From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] mmc: block: delete packed command support
Date: Thu, 24 Nov 2016 16:22:02 +0100
Message-ID: <CACRpkdYq5vdZfRAARcRKLjtWq13H+dBdbyTrhZRfO0D2=Xmv7Q@mail.gmail.com>
References: <CGME20161123154834epcas3p479d3731e59db07c42688b323cd37104e@epcas3p4.samsung.com>
 <1479916086-26641-1-git-send-email-linus.walleij@linaro.org>
 <0e12314b-e1ce-d2ce-1136-02465fdbead4@samsung.com> <CACRpkdZqL0b9i0r+TwRVYD-uw5PuoNbOsxKoghtHam+Wawp1Rg@mail.gmail.com>
 <bffa21b9-6c14-345b-bf90-f12ffe56b542@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33127 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965959AbcKXPWE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 10:22:04 -0500
Received: by mail-qt0-f178.google.com with SMTP id p16so42853452qta.0
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2016 07:22:03 -0800 (PST)
In-Reply-To: <bffa21b9-6c14-345b-bf90-f12ffe56b542@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

On Thu, Nov 24, 2016 at 11:23 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:

> Anyway, until today, i have checked the I/O performance with Exynos3/4/5 boards which i have.
> It seems that there is no I/O performance benefit about packed command at this time.

Hm so is that with a separate tree where the packed command is enabled
and with an eMMC 4.5 that has packed command support?

If you put a print in some packed command code, can you see it getting
executed?

I think we may want packed command support but we need to fix it
on top of blk-mq as well as we need to fix command queueing.

Yours,
Linus Walleij
