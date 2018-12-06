From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
Date: Thu, 6 Dec 2018 15:34:07 -0800
Message-ID: <CAD=FV=XWpLcevH72bchsKauqRpH3FSSKooQ7r6uoEgjN=4k_PQ@mail.gmail.com>
References: <20181206184522.118062-1-evgreen@chromium.org> <20181206184522.118062-2-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206184522.118062-2-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi,
On Thu, Dec 6, 2018 at 10:45 AM Evan Green <evgreen@chromium.org> wrote:
>
> In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
> one register region required.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You probably should have skipped this patch from v2.  Ulf already
landed it.  It can be found at:

https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=68fe87ac8a9309bbdc960cbd774725e44ea98b58

-Doug
