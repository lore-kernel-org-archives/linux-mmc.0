From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v4 2/3] dt-bindings: mmc: add description of PHY delays for sdhci-cadence
Date: Tue, 21 Mar 2017 16:40:07 +0900
Message-ID: <CAK7LNATgKnJUApbTJ08y08KmA2pNx93Nep7yvBN19cHGfwV3hQ@mail.gmail.com>
References: <1490008372-16372-1-git-send-email-piotrs@cadence.com> <1490008842-26854-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490008842-26854-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2017-03-20 20:20 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
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


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
