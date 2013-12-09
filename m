From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCHv3 1/3] mmc: dw_mmc: Enable the hold reg for certain speed modes
Date: Mon, 9 Dec 2013 10:56:41 +0100
Message-ID: <201312091056.42790.heiko@sntech.de>
References: <1386564668-24738-1-git-send-email-dinguyen@altera.com> <1386564668-24738-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:39183 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932303Ab3LIJ4w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Dec 2013 04:56:52 -0500
In-Reply-To: <1386564668-24738-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

Hi,

Am Montag, 9. Dezember 2013, 05:51:06 schrieb dinguyen@altera.com:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> This patch will enable the SDMMC_CMD_USE_HOLD_REG bit when the slot is
> operating all timing modes, except for SDR50, DDR50, SDR104, and MMC_HS200.
> 
> According to the Synopsys databook :"To meet the relatively high Input Hold
> Time requirement for SDR12, SDR25, and other MMC speed modes, you should
> program bit[29]use_hold_Reg of the CMD register to 1'b1;"..."However, for
> the higher speed modes of SDR104, SDR50 and DDR50, you can meet the much
> smaller Input Hold Time requirement of 0.8ns by bypassing the Hold Register
> (Path A in Figure 10-8, programming CMD.use_hold_reg = 1'b0) and then
> adding delay elements on the output path as indicated.
> 
> Also, "Never set CMD.use_hold_reg = 1 and cclk_in_drv phase shift to 0 at
> the same time. This would add an extra one-cycle delay on the output path,
> resulting in incorrect behavior."
> 
> This patch also checks the IHR(Implement Hold Register) in the HCON
> register.
> 
> This information is taking from the v2.50a of the Synopsys Designware Cores
> Mobile Storage Host Databook.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v3: Read the IHR(Implement Hold Register) in the HCON
> v2: Add check for cclk_in_drv phase shift in conjunction with use_hold_reg.

just to say it still works with the v3 changes.

Interestingly, the rockchip manual does not specify the hcon register at all, 
but reading it, I get a value of 0x4c534c1 - letting BIT(22) be the required 
one.


Heiko
