From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 3/3] mmc: dw_mmc-exynos: Remove Exynos' custom prepare_command function
Date: Sat, 7 Dec 2013 05:12:55 +0100
Message-ID: <201312070512.55712.arnd@arndb.de>
References: <1386386424-859-1-git-send-email-dinguyen@altera.com> <1386386424-859-4-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63813 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3LGENH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 23:13:07 -0500
In-Reply-To: <1386386424-859-4-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

On Saturday 07 December 2013, dinguyen@altera.com wrote:
> -static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
> -{
> -       /*
> -        * Exynos4412 and Exynos5250 extends the use of CMD register with the
> -        * use of bit 29 (which is reserved on standard MSHC controllers) for
> -        * optionally bypassing the HOLD register for command and data. The
> -        * HOLD register should be bypassed in case there is no phase shift
> -        * applied on CMD/DATA that is sent to the card.
> -        */
> -       if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
> -               *cmdr |= SDMMC_CMD_USE_HOLD_REG;
> -}

Hmm, according to the comment that gets deleted here, it seems that older
versions of this controller don't support that function, right?
If that's true, we may have to also check the version of the MSHC before
setting this.

	Arnd
