From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: meson-gx: add device reset
Date: Mon, 21 May 2018 13:36:29 +0200
Message-ID: <CAPDyKFqxaqHZ6D_kY8P53WmXOyL4xj4UGOyfT8Nb2W1pPKxBEg@mail.gmail.com>
References: <20180515095748.6794-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515095748.6794-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15 May 2018 at 11:57, Jerome Brunet <jbrunet@baylibre.com> wrote:
> This patchset adds the optional reset of the meson-gx mmc controller and
> the related documentation.
>
> Changes since v1: [0]
>  * Correct typo in the documentation
>  * Separate code and documentation patches
>  * Error on reset failure.
>
> [0]: https://lkml.kernel.org/r/20180426103817.12675-1-jbrunet@baylibre.com
>
> Jerome Brunet (2):
>   dt-bindings: mmc: meson-gx: add reset
>   mmc: meson-gx: add device reset
>
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 2 ++
>  drivers/mmc/host/meson-gx-mmc.c                            | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> --
> 2.14.3
>

Thanks, applied for next!

Kind regards
Uffe
