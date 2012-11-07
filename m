From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-s3c: ensure non-transaction of bus before clk_disable
Date: Wed, 07 Nov 2012 14:34:50 -0500
Message-ID: <87zk2t6wbp.fsf@octavius.laptop.org>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
	<201210191010.48776.heiko@sntech.de>
	<87liepq8qo.fsf@octavius.laptop.org>
	<201210292337.35620.heiko@sntech.de>
	<00af01cdb65f$64009300$2c01b900$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38997 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab2KGTe4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Nov 2012 14:34:56 -0500
In-Reply-To: <00af01cdb65f$64009300$2c01b900$%jun@samsung.com> (Seungwon
	Jeon's message of "Tue, 30 Oct 2012 14:28:27 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Heiko =?utf-8?Q?St=C3=BCbner'?= <heiko@sntech.de>, 'Chander Kashyap' <chander.kashyap@linaro.org>

Hi,

On Tue, Oct 30 2012, Seungwon Jeon wrote:
> clock shoud be supplied during bus transaction. This patch defers
> clk_disabe in runtime_suspend if cmd/data line is used.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
