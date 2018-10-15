From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc: mediatek: add MT8183 MMC driver support
Date: Mon, 15 Oct 2018 15:15:55 +0200
Message-ID: <CAPDyKFp3Wn9Wz8bmaSXFmNe0HOKCMcy7Pue3C7+9w5kq2AO0Sw@mail.gmail.com>
References: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539415250-32337-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sean Wang <sean.wang@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, jjian.zhou@mediatek.com, wenbin.mei@mediatek.com
List-Id: linux-mmc@vger.kernel.org

On 13 October 2018 at 09:20, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> this series of patch include below changes:
> 1. Add MT8183 SoC support in Mediatek MMC DT bindings
> 2. Fill mmc->actual_clock
> 3. Fix cannot receive new request issue
> 4. Tune CMD/DATA together to save tuning time
> 5. Add MT8183 MMC driver support
> 6. Refine the tuning method to drop too much redundant code
>
> Chaotian Jing (6):
>   mmc: dt-bindings: add support for MT8183 SoC
>   mmc: mediatek: fill the actual clock for mmc debugfs
>   mmc: mediatek: fix cannot receive new request when msdc_cmd_is_ready
>     fail
>   mmc: mediatek: tune CMD/DATA together
>   mmc: mediatek: add MT8183 MMC driver support
>   mmc: mediatek: drop too much code of tuning method
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   1 +
>  drivers/mmc/host/mtk-sd.c                        | 292 ++++++++++++++++++++---
>  2 files changed, 254 insertions(+), 39 deletions(-)
>
> --
> 1.8.1.1.dirty
>

Applied for next, thanks!

Kind regards
Uffe
