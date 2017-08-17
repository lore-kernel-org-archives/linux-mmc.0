From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Thu, 17 Aug 2017 15:48:32 -0500
Message-ID: <20170817204832.mxqpzojz6ak5lbqx@rob-hp-laptop>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35278 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdHQUsh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Aug 2017 16:48:37 -0400
Content-Disposition: inline
In-Reply-To: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Mon, Aug 14, 2017 at 12:39:26PM +0100, Biju Das wrote:
> Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> is identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch is compiled and tested againt linux next tag
> next-20170811. This patch depend on the driver change
> [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
> https://patchwork.kernel.org/patch/9898611/
> 
> 
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
