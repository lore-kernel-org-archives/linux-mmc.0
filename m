From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v1 2/2] Bluetooth: mediatek: add support for MediaTek
 MT7663S and MT7668S SDIO devices
Date: Mon, 11 Mar 2019 17:38:51 +0100
Message-ID: <71123002-4772-4BDC-BFEF-4C520F4459FE@holtmann.org>
References: <cover.1552007058.git.sean.wang@mediatek.com>
 <89776e11d742196e50e2d5f3ccc4336dc5aee134.1552007059.git.sean.wang@mediatek.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89776e11d742196e50e2d5f3ccc4336dc5aee134.1552007059.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Wang <sean.wang@mediatek.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Sean,

> This adds the support of enabling MT7663S and MT7668S SDIO-based
> Bluetooth function.
> 
> There are quite many differences between MT766[3,8]S and standard
> Bluetooth SDIO devices such as Type-A and Type-B devices. For example,
> MT766[3,8]S have its own SDIO registers layout, definition, SDIO packet
> format, and the specific flow should be programmed on them to complete
> the device initialization and low power control and so on.
> 
> Currently, there are many independent programming sequences from the
> transport which are exactly the same as the ones in btusb.c about MediaTek
> support [1] and btmtkuart.c. We can try to split the transport independent
> Bluetooth setups on the advance, place them into the common files and allow
> varous transport drivers to reuse them in the future.
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/Kconfig     |  11 +
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/btmtksdio.c | 979 ++++++++++++++++++++++++++++++++++
> 3 files changed, 991 insertions(+)
> create mode 100644 drivers/bluetooth/btmtksdio.c

patch has been applied to bluetooth-next tree.

You also need to send an extra patch providing a fix for this:

  CC      drivers/bluetooth/btmtksdio.o
drivers/bluetooth/btmtksdio.c: In function ‘btmtksdio_interrupt’:
drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:376:15: note: ‘old_len’ was declared here
  unsigned int old_len;
               ^~~~~~~
drivers/bluetooth/btmtksdio.c:470:2: warning: ‘old_data’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:375:17: note: ‘old_data’ was declared here
  unsigned char *old_data;
                 ^~~~~~~~

And can we actually introduce module_sdio_driver similar to module_usb_driver.

Regards

Marcel
