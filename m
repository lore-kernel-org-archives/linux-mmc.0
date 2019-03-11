From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1 1/2] mmc: add SDIO identifiers for MediaTek Bluetooth
 devices
Date: Mon, 11 Mar 2019 17:38:52 +0100
Message-ID: <7C99941A-306E-4233-9EA4-5D681308C490@holtmann.org>
References: <cover.1552007058.git.sean.wang@mediatek.com>
 <97d7949c00bd78f8ec282fb9cd380ad161244616.1552007059.git.sean.wang@mediatek.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <97d7949c00bd78f8ec282fb9cd380ad161244616.1552007059.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, ulf.hansson@linaro.org, linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Sean,

> The SDIO identifier for MediaTek Bluetooth devices were defined in the
> MediaTek Bluetooth driver. Moving the definitions in MMC header file
> seems common sense.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> include/linux/mmc/sdio_ids.h | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Can we also update the sdio.ids database inside systemd.

https://github.com/systemd/systemd/blob/master/hwdb/sdio.ids

Regards

Marcel
