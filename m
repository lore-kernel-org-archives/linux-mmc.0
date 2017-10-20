From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/3] mmc: renesas_sdhi: add R-Car Gen[123] fallback
 compatibility strings
Date: Fri, 20 Oct 2017 12:03:23 +0200
Message-ID: <CAPDyKFoHBSj6j+ksfGtqyxiwWsS8CfNio-6TN4XyVGWji27qMQ@mail.gmail.com>
References: <20171018070023.3878-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:55828 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752793AbdJTKDY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 06:03:24 -0400
Received: by mail-it0-f65.google.com with SMTP id l196so12849403itl.4
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 03:03:23 -0700 (PDT)
In-Reply-To: <20171018070023.3878-1-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 18 October 2017 at 09:00, Simon Horman <horms+renesas@verge.net.au> wrote:
> Add fallback compatibility strings for R-Car Gen 1, 2 and 3 to the SDHI
> bindings and driver.
>
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
> between IP blocks might be. For example, I believe that r8a7790 is older
> than r8a7791 but that doesn't imply that the latter is a descendant of the
> former or vice versa.
>
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
>
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme is being adopted for
> drivers for Renesas SoCs.
>
> Based on mmc/next
>
> Changes since v3:
> * Corrected typos in changelogs
> * Enhanced grammar in comatibility string usage text
>
> Changes since v2:
> * Update example to current upstream using newer CPG/MSSR bindings
>
> Changes since v1:
> * Describe example in patch one as being for the r8a7790 (R-Car H2) rather
>   than the r8a7779 (R-Car H1)
> * Accumulate review tags from Geert Uytterhoeven
>
> Simon Horman (3):
>   dt-bindings: mmc: renesas_sdhi: provide example in bindings
>     documentation
>   dt-bindings: mmc: renesas_sdhi: add R-Car Gen[123] fallback
>     compatibility strings
>   mmc: renesas_sdhi: implement R-Car Gen[123] fallback compatibility
>     strings
>
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 70 +++++++++++++++++++++-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c      |  1 +
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c           |  5 +-
>  3 files changed, 74 insertions(+), 2 deletions(-)
>
> --
> 2.11.0
>

Thanks, applied for next!

Kind regards
Uffe
