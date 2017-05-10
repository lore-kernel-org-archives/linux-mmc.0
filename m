From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/6] mmc: renesas-sdhi: refactor DMA support
Date: Wed, 10 May 2017 12:07:02 +0200
Message-ID: <CAK8P3a3b0cLAB_+52uXQU8NsSJ4PjAXo7JPAKKoYWiUqiP3Rjw@mail.gmail.com>
References: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35986 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752606AbdEJKHD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2017 06:07:03 -0400
In-Reply-To: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Wed, May 10, 2017 at 11:25 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Wolfram, Hi Ulf, Hi Arnd, Hi all,
>
> the intention of this patch-set is to refactor the DMA support in
> the Renesas SDHI driver in order to make it easier to add support
> for using the SDHI hardware with different DMA implementations.
>
> This is based on earlier work, posted as "[PATCH/RFC v3 0/6] mmc:
> renesas_sdhi: add R-Car Gen-3 DMA support". It attempts to implement
> the reworking of the driver proposed by Arnd[1] in his review of that
> patch-set.
>
> [1] http://www.spinics.net/lists/linux-mmc/msg38004.html
>
> Unlike that patch-set this patch-set does not add support for
> R-Car Gen-3 DMA. Rather it focuses on refactoring the code.

(whole series)

Acked-by: Arnd Bergmann <arnd@arndb.de>
