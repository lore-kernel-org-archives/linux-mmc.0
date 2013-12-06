From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 1/4] arm: dts: Add support for SD/MMC on SOCFPGA
Date: Fri, 6 Dec 2013 01:47:51 +0100
Message-ID: <201312060147.51489.arnd@arndb.de>
References: <1386263677-7733-1-git-send-email-dinguyen@altera.com> <201312052208.38342.arnd@arndb.de> <1386281452.26656.8.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50416 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab3LFAr7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 19:47:59 -0500
In-Reply-To: <1386281452.26656.8.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dinh Nguyen <dinguyen@altera.com>, mark.rutland@arm.com, devicetree@vger.kernel.org, mturquette@linaro.org, ian.campbell@citrix.com, pawel.moll@arm.com, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, jh80.chung@samsung.com, dinh.linux@gmail.com, cjb@laptop.org

On Thursday 05 December 2013, Dinh Nguyen wrote:
> Perhaps Seungwon and Chris might have an opinion on this:
> 
> From the Synopsys databook for this IP, using the SDMMC_CMD_USE_HOLD_REG
> is not recommended for SDR104, SDR50 and DDR50 speed modes. For other
> speeds, SDR12, and SDR25, it would be necessary to use
> SDMMC_CMD_USE_HOLD_REG.
> 
> I am referencing v2.50a of the Synopsys DesignWare Cores Mobile Storage
> Host Databook.
> 
> So I think a binary DT property should suffice?

Well, if it depends on the interface speed, it is something the driver should
actually be able to figure out itself, since it knows the speed that is used.

That way, you don't even need a property or per-platform compatible string.

	Arnd
