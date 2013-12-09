From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv5 2/4] clk: socfpga: Add a hook for SD/MMC driver to control CIU clock settings
Date: Mon, 9 Dec 2013 17:28:07 +0100
Message-ID: <201312091728.07940.arnd@arndb.de>
References: <1386597462-29471-1-git-send-email-dinguyen@altera.com> <1386597462-29471-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56505 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab3LIQ2O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2013 11:28:14 -0500
In-Reply-To: <1386597462-29471-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, mturquette@linaro.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 09 December 2013, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
> the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
> the correct clock-phase for the CIU clock of the SD/MMC IP.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Please see my comments for this patch for v4, it still looks wrong to me.
The other three patches are good though.

	Arnd
