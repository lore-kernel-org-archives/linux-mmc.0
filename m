From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v5 0/9] mtd: sharpslpart partition parser
Date: Sun, 08 Oct 2017 11:53:11 +0200
Message-ID: <87376uezjs.fsf@belgarion.home>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
        <20170821221339.70cfcfb7@bbrezillon> <87pobmoz8n.fsf@belgarion.home>
        <CAAQYJAv8bNrxJ_ESgC0fOAdry7i5mstzgQ3P74q1D=C-xsJprg@mail.gmail.com>
        <20170824114631.089d2628@bbrezillon> <87inh6pw9e.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:50274 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdJHJxQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Oct 2017 05:53:16 -0400
In-Reply-To: <87inh6pw9e.fsf@belgarion.home> (Robert Jarzmik's message of
        "Tue, 29 Aug 2017 11:18:37 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Andrea Adami <andrea.adami@gmail.com>, linux-mtd@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Weinberger <richard@nod.at>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Lee Jones <lee.jones@linaro.org>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
>
>> Hi Robert,
>> Wait a bit before applying. I think patches 6 to 9 have a dependency on
>> patch 1 (it's not a build dependency, but NAND partitioning might be
>> wrong if you apply them), so we need to sync. What release is
>> pxa/for-next targeting? If it's 4.15 I can apply patch 1 just after
>> 4.14-rc1 is out and provide an immutable branch for you to pull in
>> pxa/for-next.
>
> Hi Boris,
>
> It's targeting 4.15 right now. And we can do as you like, either an immutable
> branch, or I wait to include these patches into my pxa/for-next until you give
> me your go, it's as you like.

Hi Boris,

So what's the status about the sync, should I pick the patches, and have the
others make it to your for-next branch ?

Cheers.

-- 
Robert
