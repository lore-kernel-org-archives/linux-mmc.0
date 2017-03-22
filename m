From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v5 2/4] dt-bindings: mmc: add description of PHY delays for sdhci-cadence
Date: Wed, 22 Mar 2017 16:30:56 +0900
Message-ID: <CAK7LNAS+=KjuD-31he5fRw=S_t10Uygae7bOWf+uRYVCPeW=5w@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com> <1490106781-3129-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:54451 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757351AbdCVHbJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 03:31:09 -0400
In-Reply-To: <1490106781-3129-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org

2017-03-21 23:33 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
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


As I gave Reviewed-by in v4 already, this looks good to me.


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


As I said before,
once you get Reviewed/Acked tags,
please include them in your later version.



-- 
Best Regards
Masahiro Yamada
