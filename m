From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 1/5] mmc: remove .owner field for drivers using
 module_platform_driver
Date: Thu, 21 Aug 2014 14:11:07 +0100
Message-ID: <20140821131107.GA17487@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
 <1407860069-12706-2-git-send-email-peter.griffin@linaro.org>
 <3815db00-4b32-4484-b97e-2144dc5abb45@BY2FFO11FD040.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:35089 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbaHUNLM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Aug 2014 09:11:12 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so9280928wes.11
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2014 06:11:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3815db00-4b32-4484-b97e-2144dc5abb45@BY2FFO11FD040.protection.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, jarkko.lavinen@nokia.com, balajitk@ti.com, baohua@kernel.org, viresh.linux@gmail.com, ian.molton@codethink.co.uk, maxime.ripard@free-electrons.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org, swarren@wwwdotorg.org, patches@linaro.org, lee.jones@linaro.org

Hi Michal,

On Mon, 18 Aug 2014, Michal Simek wrote:

> I have checked this for all xilinx drivers we have in the tree
> and I have sent similar patches.
> This problem is probably in all subsystems.

Yep

> With communication with Mark Brown. Don't you have
> cocinelle script for fixing this everywhere?

Nope. Never really looked at cocinelle until now, but it looks like
a useful tool for these sort of mass updates.

regards,

Peter.


