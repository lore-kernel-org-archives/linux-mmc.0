From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [v5 3/4] mmc: sdhci-cadence: Update PHY delay configuration
Date: Wed, 22 Mar 2017 16:31:35 +0900
Message-ID: <CAK7LNASmyrbKc=2LSSj2kvsLJ+N29qn_x3aNWQ78V21_6nfu9Q@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com> <1490106791-3553-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490106791-3553-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

2017-03-21 23:33 GMT+09:00 Piotr Sroka <piotrs@cadence.com>:
> DTS properties are used instead of fixed data
> because PHY settings can be different for different chips/boards.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
> Changes for v2:
> - dts part was removed from this patch
> - most delays were moved from dts file
>   to data associated with an SoC specific compatible
> - remove unrelated changes
> ---
> Changes for v3:
> - move all delays back to dts because they are also boards dependent
> - prefix all of the Cadence-specific properties with cdns prefix
> - put checking delay properties inside the for loop
>   instead of using a lot of single if expressions
> ---
> Changes for v4:
> - remove unecessary declaration of sdhci_cdns_match
> - format fix (blank line removed)
> ---
> Changes for v5:
> - use driver version from next branch, with applied enhanced strobe feature support.
> - change name of property to be consistent with timing modes
>   available in Linux
> ---


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

-- 
Best Regards
Masahiro Yamada
