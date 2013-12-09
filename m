From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 0/3] mmc: dw_mmc: Make the use of the hold reg generic
Date: Mon, 9 Dec 2013 17:12:19 +0100
Message-ID: <201312091712.19872.arnd@arndb.de>
References: <1386564668-24738-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53097 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933653Ab3LIQMq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2013 11:12:46 -0500
In-Reply-To: <1386564668-24738-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

On Monday 09 December 2013, dinguyen@altera.com wrote:
> This is v3 of the patch series that makes the setting of the SDMMC_CMD_USE_HOLD_REG
> bit generic.
> 
> v3 differences:
> 
> * Read the IHR(Implement HOLD Register) bit in the HCON register. Will not use
> the SDMMC_CMD_USE_HOLD_REG if the IHR bit is 0 and cclk_in_drv = 0.
> 
> * Changes the cclk_in_drv and use_hold_reg register type from bool to u32.
> 
> * Add can_use_hold_reg variable that is condition on whether or not we can use
> the hold reg.
> 
> * v2 of (1/3, 2/3) was Acked-by: and Tested-by: Heiko Stuebner <heiko@sntech.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
