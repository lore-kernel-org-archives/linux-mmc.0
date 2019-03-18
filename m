From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1 0/3] add module_sdio_driver and enable a few users
Date: Mon, 18 Mar 2019 18:17:39 +0100
Message-ID: <D233C009-8EA4-4C47-9CB3-A26C74C200D1@holtmann.org>
References: <cover.1552510141.git.sean.wang@mediatek.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: Johan Hedberg <johan.hedberg@gmail.com>, ulf.hansson@linaro.org, linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Sean,

> Add module_sdio_driver exactly like the function module_usb_drivear offers to
> and enable a few users to eliminate a few lines of boilerplate code per SDIO
> driver.
> 
> Sean Wang (3):
>  mmc: sdio: Add helper macro for sdio_driver boilerplate
>  Bluetooth: mediatek: Use module_sdio_driver helper
>  Bluetooth: btsdio: Use module_sdio_driver helper
> 
> drivers/bluetooth/btmtksdio.c | 15 +--------------
> drivers/bluetooth/btsdio.c    | 15 +--------------
> include/linux/mmc/sdio_func.h | 12 ++++++++++++
> 3 files changed, 14 insertions(+), 28 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel
