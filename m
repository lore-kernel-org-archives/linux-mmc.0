From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 11/11] arm64: dts: r8a7796: salvator-x: Enable UHS-I SDR-104
Date: Tue, 25 Oct 2016 12:49:42 +0200
Message-ID: <CAMuHMdVLAK0TKLoB07_U1XNW9kCOyen80gPrkaXOLqAq0=BA+Q@mail.gmail.com>
References: <1473764228-24768-1-git-send-email-horms+renesas@verge.net.au> <1473764228-24768-12-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33104 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755604AbcJYKtn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2016 06:49:43 -0400
In-Reply-To: <1473764228-24768-12-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 13, 2016 at 12:57 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add the sd-uhs-sdr104 property to SDHI0 and SDHI1.

SDHI0 and SDHI3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
