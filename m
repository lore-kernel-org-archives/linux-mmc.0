From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Wed, 07 Nov 2012 14:36:47 -0500
Message-ID: <87vcdh6w8g.fsf@octavius.laptop.org>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
	<201210181302.30843.heiko@sntech.de>
	<006501cdadd0$548d1f70$fda75e50$%jun@samsung.com>
	<201210191010.48776.heiko@sntech.de>
	<87liepq8qo.fsf@octavius.laptop.org>
	<00b001cdb65f$6958fb80$3c0af280$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39005 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab2KGTgx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Nov 2012 14:36:53 -0500
In-Reply-To: <00b001cdb65f$6958fb80$3c0af280$%jun@samsung.com> (Seungwon
	Jeon's message of "Tue, 30 Oct 2012 14:28:36 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Heiko =?utf-8?Q?St=C3=BCbner'?= <heiko@sntech.de>, 'Chander Kashyap' <chander.kashyap@linaro.org>

Hi,

On Tue, Oct 30 2012, Seungwon Jeon wrote:
> If host clock is disabled, host cannot detect a card
> in case of using CD internal for detection.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
