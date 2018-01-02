From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: MMC flash is very slow since 4.14 - "mmc: Delete bounce buffer
 handling" was the problem
Date: Tue, 2 Jan 2018 17:34:58 +0100
Message-ID: <CAPDyKFrGgLiy9cvhtTGt5Q+MSMCuA5yw_Q7Nd77_0WnawP_BAw@mail.gmail.com>
References: <OF8C6780FA.78E4ECBE-ONC1258209.003268EF-C1258209.003268F0@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:33237 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeABQe7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jan 2018 11:34:59 -0500
Received: by mail-it0-f53.google.com with SMTP id o130so11606933itg.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jan 2018 08:34:59 -0800 (PST)
In-Reply-To: <OF8C6780FA.78E4ECBE-ONC1258209.003268EF-C1258209.003268F0@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

+ to: Linus
+ cc: Adrian

On 2 January 2018 at 10:10, Benjamin Beckmeyer <beckmeyer.b@rittal.de> wrot=
e:
> Hey all,
>
> I have a problem with mmc flash on an i.mx 25 architecture. Im running it=
 with Linux 4.14.x and the flash is really slow.
> I digged a little bit deeper into this problem and it has nothing to do w=
ith the driver (sdhci-esdhci-imx.c), because all registers for the SDHCI ha=
ve the same values in a kernel before 4.14 and in the current 4.14 kernel.
>
> I figured out that following commit "mmc: Delete bounce buffer handling" =
 is the problem. I compiled my kernel without that patch and everything is =
running fine. There is a patch "mmc: sdhci: Avoid swiotlb buffer being full=
" and  I hoped this will fix the problem but it doesn't.. But maybe it does=
n't fixed it for the imx driver.

When we applied the commit "mmc: Delete bounce buffer handling", is
was simply because we more or less thought it was dead code. It turned
out, that wasn't case and we got some error reported due to it. Those
errors *should* be fixed, but perhaps not from a performance
regression point view.

I have looped in Linus (and Adrian), hopefully we can figure out a
good of how to move forward on this topic.

>
> Hopefully anybody can help me with this problem. But I thought somebody w=
ith a better understanding of the mmc core components knows how to handle t=
his problem (maybe somebody from linaro, because the two patches come from =
them).
>
> Kind regards,
> Benjamin

Thanks for reporting!

Could you perhaps post some performance measurements done "before" and
"after". A guess a simple "dd" test is sufficient, just to get an idea
in what range the regression is about?

Kind regards
Uffe
