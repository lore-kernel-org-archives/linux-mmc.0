From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 0/9] mmc: sdhci-esdhc-imx: add SD3.0 support
Date: Wed, 25 Sep 2013 22:01:52 -0400
Message-ID: <87siws2ve7.fsf@octavius.laptop.org>
References: <1379070698-7344-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33628 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991Ab3IZCCD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 22:02:03 -0400
In-Reply-To: <1379070698-7344-1-git-send-email-b29396@freescale.com> (Dong
	Aisheng's message of "Fri, 13 Sep 2013 19:11:29 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, anton@enomsg.org, s.hauer@pengutronix.de, w.sang@pengutronix.de, ulf.hansson@linaro.org, neko@bakuhatsu.net

Hi Shawn, Sascha,

On Fri, Sep 13 2013, Dong Aisheng wrote:
> This patch series add SD3.0 support for i.MX6Q/DL.
> Since freescale i.MX6Q/DL uSDHC clock tuning progress is a little different from
> the standard tuning process defined in host controller spec v3.0.
> So we add a hook to allow execute platform specific tuning instead of
> standard host controller tuning.
>
> The main difference are:
> 1) not only generate Buffer Read Ready interrupt when tuning is performing.
> It generates all other DATA interrupts like the normal data command.
> 2) SDHCI_CTRL_EXEC_TUNING is not automatically cleared by HW,
> instead it's controlled by SW.
> 3) SDHCI_CTRL_TUNED_CLK is not automatically set by HW,
> it's controlled by SW.
> 4) the clock delay for every tuning is set by SW.
>
> Tested on i.MX6Q Sabreauto board.

Please could someone ACK this series?  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
