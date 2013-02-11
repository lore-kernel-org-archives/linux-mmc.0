From: Arnd Bergmann <arnd.bergmann@linaro.org>
Subject: Re: [PATCH v9 0/2] mmc: support packed command feature of eMMC4.5
Date: Mon, 11 Feb 2013 20:07:10 +0000
Message-ID: <201302112007.10195.arnd.bergmann@linaro.org>
References: <003001ce0440$04844b40$0d8ce1c0$%jun@samsung.com> <87liaupvny.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56558 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759326Ab3BKUHQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Feb 2013 15:07:16 -0500
In-Reply-To: <87liaupvny.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

On Monday 11 February 2013, Chris Ball wrote:
> On Wed, Feb 06 2013, Seungwon Jeon wrote:
> > This patch-set adds support of packed command feature for eMMC4.5 devices.
> > Specially, packed write is introduced.
> 
> Thanks, I've pushed this to mmc-next for 3.9 now.
> 
> It would be great to see benchmarks for the effect on average write
> latency, instead of just throughput, though.

Yes, I agree absolutely. In the end, it's always the latency that
matters for user experience not the maximum throughput.

	Arnd
