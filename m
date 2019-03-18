From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 0/3] add module_sdio_driver and enable a few users
Date: Mon, 18 Mar 2019 11:26:57 +0100
Message-ID: <CAPDyKFrvZQBXYU3T=pPYYyx1TEu26U8Z3Nky+n5p8rfkxCqtKw@mail.gmail.com>
References: <cover.1552510141.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 13 Mar 2019 at 22:02, <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Add module_sdio_driver exactly like the function module_usb_drivear offers to
> and enable a few users to eliminate a few lines of boilerplate code per SDIO
> driver.
>
> Sean Wang (3):
>   mmc: sdio: Add helper macro for sdio_driver boilerplate
>   Bluetooth: mediatek: Use module_sdio_driver helper
>   Bluetooth: btsdio: Use module_sdio_driver helper
>
>  drivers/bluetooth/btmtksdio.c | 15 +--------------
>  drivers/bluetooth/btsdio.c    | 15 +--------------
>  include/linux/mmc/sdio_func.h | 12 ++++++++++++
>  3 files changed, 14 insertions(+), 28 deletions(-)
>
> --
> 2.18.0
>

For series:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
