From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/6] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr not supported on sabresd issues
Date: Tue, 26 Nov 2013 16:37:29 -0500
Message-ID: <87siuig7za.fsf@octavius.laptop.org>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34278 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753533Ab3KZViF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 16:38:05 -0500
In-Reply-To: <1383142193-24950-1-git-send-email-b29396@freescale.com> (Dong
	Aisheng's message of "Wed, 30 Oct 2013 22:09:47 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, wsa@the-dreams.de

Hi Dong,

On Wed, Oct 30 2013, Dong Aisheng wrote:
> Patch 1~3 fix acmd23 unwork issue.
> Currently the eMMC chip integrated on i.MX6Q SabreSD boards does not work.
> (It's easily reproduced once you enable usdhc4 on sabresd, see patch 3)
> It's caused by acmd setting bits are never cleared once it's been set
> which cause the next normal commands to work abnormally.
>
> Patch 4~6 fix DDR not supported on SabreSD board.
> The SabreSD board does not have 1.8v signal voltage switch support for uSDHC,
> thus it can not support UHS_DDR50 mode which can only run at 1.8v signal voltage.

Thanks, pushed patches 1-6 to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
