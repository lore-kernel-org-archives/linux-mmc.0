From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1 0/4] Add a couple of enhancements to btmtksdio
Date: Tue, 23 Apr 2019 18:36:49 +0200
Message-ID: <43F9EB53-7994-4727-948D-29D455C4F19B@holtmann.org>
References: <cover.1555577565.git.sean.wang@mediatek.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1555577565.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Sean,

> First three are all minor changes and the final one adds a runtime pm support to
> enter a lower power state for decreasing power dissipation when there is idle
> traffic in SDIO transport for a while.
> 
> Sean Wang (4):
>  Bluetooth: btmtksdio: Drop newline with bt_dev logging macros
>  Bluetooth: btmtksdio: Add a bit definition for CHLPCR
>  Bluetooth: btmtksdio: Fix hdev->stat.byte_rx accumulation
>  Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth
> 
> drivers/bluetooth/btmtksdio.c | 161 ++++++++++++++++++++++++++++++++--
> 1 file changed, 153 insertions(+), 8 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel
