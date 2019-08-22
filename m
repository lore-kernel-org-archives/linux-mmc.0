From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: fix controller busy issue and add 24bits segment support
Date: Thu, 22 Aug 2019 14:13:21 +0200
Message-ID: <CAPDyKFqEqF_ZHerbkTqqcVBceQvMr_A+-MkbzQJBByhCv9B0fg@mail.gmail.com>
References: <20190822064741.11196-1-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822064741.11196-1-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, 22 Aug 2019 at 08:47, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> the below 2 patches fix controller busy issue when plug out SD card
> and add 24bits segment size support.
>
> Chaotian Jing (2):
>   mmc: mediatek: fix controller busy when plug out SD
>   mmc: mediatek: support 24bits segment size
>
>  drivers/mmc/host/mtk-sd.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
