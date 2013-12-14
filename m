From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
Date: Sat, 14 Dec 2013 22:33:26 +0100
Message-ID: <201312142233.27143.arnd@arndb.de>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com> <1386880245-10192-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50196 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3LNVdp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Dec 2013 16:33:45 -0500
In-Reply-To: <1386880245-10192-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, mturquette@linaro.org, zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 12 December 2013, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add a "altr,socfpga-sdmmc-sdr-clk" clock type in the SOCFPGA clock driver. This
> clock type is not really a "clock" for say, but a mechanism to set the phase
> shift of the clock that is used to feed the SD/MMC CIU's clock. This clock does
> not have parent so it is designated as a CLK_IS_ROOT.
> 
> This clock implements the set_clk_rate method that is meant to receive the SDR
> settings that is designated by the "samsung,dw-mshc-sdr-timing" binding. The
> SD/MMC driver passes this clock phase information into the clock driver to use.
> 
> This enables the SD/MMC driver to touch registers that are located outside of
> the SD/MMC IP, which helps make the core SD/MMC driver generic.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@alter.com>

Ok, this looks like it will work, but we haven't concluded if this is the
best way to do it. I'm looking for guidance from Mike here.

The alternatives I can see for this particular problem are:

1. fake a clock and use the 'clk_set_rate' callback to set the phase
   rather than the clock frequency (as you do in this patch).
2. extend the common clock API to provide a 'clk_set_phase' interface
   that you can call on the CIU clock to set this, so you don't have
   to fake anything. This seems to be the nicest interface if we have
   the same problem in more drivers.
3. make the phase setting private to whichever clock is used for CIU
   (as one of your previous patches did, which I did not like).
4. make the phase an additional argument to the clock specifier,
   so you would have <&mmcclock 12345 5678> rather than just <&mmcclock>
   in the mmc host device node to specify the two possible phases.

I would also like to get buy-in from Zhangfei Gao, since he is working
on the same thing. Please coordinate with him to make sure whatever
one of you comes up with works for the other one too. At the moment,
patches are flying so fast without much discussion inbetween that I'd
prefer Chris to hold off from merging either one until you have both
revieved and Acked each other's patches.

	Arnd
