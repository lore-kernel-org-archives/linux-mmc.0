From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: fix some host driver defect
Date: Wed, 6 Jul 2016 18:21:35 +0200
Message-ID: <CAPDyKFoZVoZpKh90hG-QoSdwWSgAdV0b6oup-w-dOQ8atRZ+2w@mail.gmail.com>
References: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>, Wei-Ning Huang <wnhuang@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 30 June 2016 at 04:00, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> Chaotian Jing (4):
>   mmc: mediatek: do not tune data for HS400 mode
>   mmc: mediatek: fix CRC error when calling mmc_select_hs400()
>   mmc: mediatek: fix CMD21/CMD19 timeout issue
>   mmc: mediatek: perfer to use rise edge latching
>
>  drivers/mmc/host/mtk-sd.c | 70 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 14 deletions(-)
>
> --
> 1.8.1.1.dirty
>

Thanks, applied for next!

Kind regards
Uffe
