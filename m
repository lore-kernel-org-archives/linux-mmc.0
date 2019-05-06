From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mtk-sd enhancement to support MT7621 - V2
Date: Mon, 6 May 2019 11:51:30 +0200
Message-ID: <CAPDyKFp9aQNsqkUnznPUaDDZf8Oa95MRKmb35Y-PuMbSJPfZug@mail.gmail.com>
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, thirtythreeforty@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Sat, 4 May 2019 at 12:25, NeilBrown <neil@brown.name> wrote:
>
> The MT7621 MIPS-based SOC contains an sdhci unit that is
> much the same as the units supported by mtk-sd.c.
>
> These patches enhance the driver so that I can use it on my MT7621
> board (gnubee.org).
>
> This series have been revised based on feedback from Chaotian.

Applied for next, thanks!

Kind regards
Uffe


>
> Thanks,
> NeilBrown
>
> ---
>
> NeilBrown (4):
>       mmc: mtk-sd: don't hard-code interrupt trigger type
>       mmc: mtk-sd: add support for config found in mt7620 family SOCs.
>       mmc: mtk-sd: enable internal card-detect logic.
>       mmc: mtk-sd: select REGULATOR
>
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1
>  drivers/mmc/host/Kconfig                         |    1
>  drivers/mmc/host/mtk-sd.c                        |   78 +++++++++++++++++++++-
>  3 files changed, 75 insertions(+), 5 deletions(-)
>
> --
> Signature
>
