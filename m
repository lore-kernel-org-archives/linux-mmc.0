From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v9 0/2] mmc: support packed command feature of eMMC4.5
Date: Tue, 12 Feb 2013 19:53:31 +0900
Message-ID: <001f01ce090f$329c3320$97d49960$%jun@samsung.com>
References: <003001ce0440$04844b40$0d8ce1c0$%jun@samsung.com>
 <87liaupvny.fsf@octavius.laptop.org>
 <201302112007.10195.arnd.bergmann@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45060 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820Ab3BLKxd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Feb 2013 05:53:33 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MI3002JFSX4MTO0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Feb 2013 19:53:32 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MI3006MDSX7O880@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Feb 2013 19:53:31 +0900 (KST)
In-reply-to: <201302112007.10195.arnd.bergmann@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Arnd Bergmann' <arnd.bergmann@linaro.org>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

On Tuesday, February 12, 2013, Arnd Bergmann wrote:
> On Monday 11 February 2013, Chris Ball wrote:
> > On Wed, Feb 06 2013, Seungwon Jeon wrote:
> > > This patch-set adds support of packed command feature for eMMC4.5 devices.
> > > Specially, packed write is introduced.
> >
> > Thanks, I've pushed this to mmc-next for 3.9 now.
> >
> > It would be great to see benchmarks for the effect on average write
> > latency, instead of just throughput, though.
> 
> Yes, I agree absolutely. In the end, it's always the latency that
> matters for user experience not the maximum throughput.
I didn't see a significant difference in random I/O.
Write packing completely depends on seamless I/O from block layer.
As size of media contents is bigger, enhanced write is required in some user scenarios.
I guess write throughput is important factor cannot be easily ignored.

Thanks,
Seungwon Jeon
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

