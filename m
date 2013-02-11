From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v9 0/2] mmc: support packed command feature of eMMC4.5
Date: Mon, 11 Feb 2013 13:12:01 -0500
Message-ID: <87liaupvny.fsf@octavius.laptop.org>
References: <003001ce0440$04844b40$0d8ce1c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52207 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758498Ab3BKSMM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Feb 2013 13:12:12 -0500
In-Reply-To: <003001ce0440$04844b40$0d8ce1c0$%jun@samsung.com> (Seungwon
	Jeon's message of "Wed, 06 Feb 2013 17:00:23 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>, 'Arnd Bergmann' <arnd.bergmann@linaro.org>

Hi Seungwon,

On Wed, Feb 06 2013, Seungwon Jeon wrote:
> This patch-set adds support of packed command feature for eMMC4.5 devices.
> Specially, packed write is introduced.

Thanks, I've pushed this to mmc-next for 3.9 now.

It would be great to see benchmarks for the effect on average write
latency, instead of just throughput, though.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
