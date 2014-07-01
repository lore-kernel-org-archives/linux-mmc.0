From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: one doubt about mmc_sdio_init_card function
Date: Tue, 01 Jul 2014 13:39:48 +0800
Message-ID: <53B249A4.2040404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:46911 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaGAFj5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Jul 2014 01:39:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, aaron.lu@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jackey.shen@amd.com, gregkh@linuxfoundation.org


Hi, all

The mmc_sdio_init_card(drivers/mmc/core/sdio.c) function calls mmc_alloc_card(drivers/mmc/core/bus.c) function to allocate a card structure. card->dev.bus is assigned with mmc_bus_type in mmc_alloc_card function. Why not assign sdio_bus_type to card->dev.bus?


struct mmc_card *mmc_alloc_card(struct mmc_host *host, struct device_type *type)
{
    struct mmc_card *card;

    card = kzalloc(sizeof(struct mmc_card), GFP_KERNEL);
    if (!card)
        return ERR_PTR(-ENOMEM);

    card->host = host;

    device_initialize(&card->dev);

    card->dev.parent = mmc_classdev(host);
    card->dev.bus = &mmc_bus_type;
    card->dev.release = mmc_release_card;
    card->dev.type = type;

    return card;
}


Thanks,
Zhonghui
