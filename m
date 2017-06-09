From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC 5/5] mmc: renesas-sdhi: remove gen3 support from sysc
 dmac driver
Date: Fri, 9 Jun 2017 17:40:15 +0900
Message-ID: <CANqRtoTF-xev1F9nC9a_0oLQSE5-M4SnozTyzrndDrbW8fhurw@mail.gmail.com>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
 <1496927368-18897-8-git-send-email-horms+renesas@verge.net.au> <CAMuHMdUUXnpXgoO7O8XtQcusTcHPffkKESVbWO54Yo54179u6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33123 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFIIkR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Jun 2017 04:40:17 -0400
In-Reply-To: <CAMuHMdUUXnpXgoO7O8XtQcusTcHPffkKESVbWO54Yo54179u6A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Geert and Simon,

On Fri, Jun 9, 2017 at 4:40 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Simon,
>
> On Thu, Jun 8, 2017 at 3:09 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
>> Gen3 SoCs are now supported by the internal dmac variant of the SDHI driver.
>> Remove them from the sys dmac variant where only PIO mode is supported.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> Is it possible to fall back to PIO with the new DMAC driver?
> If not, is this desirable?

I believe R-Car Gen3 SDHI may depending on SoC use either on-chip bus
mastering DMA or SYS-DMAC via DMA Engine. In both cases fall back to
PIO is most likely valid. For any given SoC which is better of on-chip
DMA or SYS-DMAC needs to be investigated together with IPMMU.

Cheers,

/ magnus
