From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH v6 2/2] mmc: jz4740: prepare next dma transfer in parallel with current transfer
Date: Tue, 12 Aug 2014 19:12:33 +0100
Message-ID: <86y4ut60ha.fsf@void.printf.net>
References: <1405917465-18185-1-git-send-email-apelete@seketeli.net>
	<1405917465-18185-3-git-send-email-apelete@seketeli.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47859 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753895AbaHLSMr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Aug 2014 14:12:47 -0400
In-Reply-To: <1405917465-18185-3-git-send-email-apelete@seketeli.net> (Apelete
	Seketeli's message of "Mon, 21 Jul 2014 06:37:45 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Apelete Seketeli <apelete@seketeli.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alex Smith <alex.smith@imgtec.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Apelete,

On Mon, Jul 21 2014, Apelete Seketeli wrote:
> It should help reduce the impact of DMA preparation overhead on the SD
> card performance.

Did you do any benchmarking to check that this is true?  (If so, it'd
be good to note what performance change you saw in the commit message.)

Thanks!

- Chris.
-- 
Chris Ball   <http://printf.net/>
