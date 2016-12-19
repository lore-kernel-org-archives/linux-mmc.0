From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] mmc: sdhci-cadence: add Socionext UniPhier specific
 compatible string
Date: Mon, 19 Dec 2016 12:44:59 -0600
Message-ID: <20161219184459.sdo3c3regs4sflpk@rob-hp-laptop>
References: <1481681446-29832-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33966 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932519AbcLSSpB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2016 13:45:01 -0500
Content-Disposition: inline
In-Reply-To: <1481681446-29832-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

On Wed, Dec 14, 2016 at 11:10:46AM +0900, Masahiro Yamada wrote:
> Add a Socionext SoC specific compatible (suggested by Rob Herring).
> 
> No SoC specific data are associated with the compatible strings for
> now, but other SoC vendors may use this IP and want to differentiate
> IP variants in the future.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add "uniphier" to the compatible to make it more SoC-specific
> 
>  Documentation/devicetree/bindings/mmc/sdhci-cadence.txt | 6 ++++--
>  drivers/mmc/host/sdhci-cadence.c                        | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
