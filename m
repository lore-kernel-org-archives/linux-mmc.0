From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Mon, 21 Aug 2017 18:34:42 -0500
Message-ID: <20170821233442.hthn2rhv4g5rapkx@rob-hp-laptop>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
 <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34582 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbdHUXeo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 19:34:44 -0400
Content-Disposition: inline
In-Reply-To: <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Mon, Aug 21, 2017 at 11:38:17AM +0100, Biju Das wrote:
> Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> v1->v2
>     -Modified the listing SoC's description related to SoC
>      with 1 Clock and 2 Clocks
> 
> This patch is compiled and tested against linux next tag
> next-20170817.
> 
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
