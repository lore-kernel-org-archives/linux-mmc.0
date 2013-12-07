From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv2 2/3] mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc driver structure
Date: Sat, 7 Dec 2013 13:51:09 +0100
Message-ID: <201312071351.10121.heiko@sntech.de>
References: <1386386424-859-1-git-send-email-dinguyen@altera.com> <1386386424-859-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:48123 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab3LGMvT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 7 Dec 2013 07:51:19 -0500
In-Reply-To: <1386386424-859-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

Am Samstag, 7. Dezember 2013, 04:20:23 schrieb dinguyen@altera.com:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Rockchip's implementation of the dw_mmc controller only requires the
> setting of the SDMMC_CMD_USE_HOLD_REG on every command. With the patch to
> set the SDMMC_CMD_USE_HOLD_REG by checking the slot's speed mode, this
> Rockchip custom driver structure is no longer necessary.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

on a rockchip,rk3066 (dw_mmc 10214000.dwmmc: Version ID is 240a)
Tested-by: Heiko Stuebner <heiko@sntech.de>
