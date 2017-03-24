From: Rob Herring <robh@kernel.org>
Subject: Re: [v5 2/4] dt-bindings: mmc: add description of PHY delays for
 sdhci-cadence
Date: Fri, 24 Mar 2017 11:26:20 -0500
Message-ID: <20170324162620.mukktylezkobybfm@rob-hp-laptop>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
 <1490106781-3129-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33091 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757349AbdCXQ0X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Mar 2017 12:26:23 -0400
Content-Disposition: inline
In-Reply-To: <1490106781-3129-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

On Tue, Mar 21, 2017 at 02:33:01PM +0000, Piotr Sroka wrote:
> DTS properties are used instead of fixed data
> because PHY settings can be different for different chips/boards.
> Add description of new DLL PHY delays.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v2:
> - file was created in v2. It was a part of driver source file patch.
> - most delays were moved from dts file
>   to data associated with an SoC specific compatible
> - description of delays was updated to be more clearly
> ---
> Changes for v3:
> - move all delays back to dts because they are also boards dependent
> - prefix all of the Cadence-specific properties with cdns prefix
> ---
> Changes for v4:
> - change the beginning of the commit subject
> ---
> Changes for v5:
> - change name of property to be consistent with timing modes 
>   available in Linux

I don't see any change here...

> ---
>  .../devicetree/bindings/mmc/sdhci-cadence.txt      | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
