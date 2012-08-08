From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: dw_mmc: fix error handling in PIO mode
Date: Tue, 07 Aug 2012 23:21:17 -0400
Message-ID: <874noexe4y.fsf@octavius.laptop.org>
References: <006501cd6f7c$e4ca6670$ae5f3350$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54278 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757323Ab2HHDVV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:21:21 -0400
In-Reply-To: <006501cd6f7c$e4ca6670$ae5f3350$%jun@samsung.com> (Seungwon
	Jeon's message of "Wed, 01 Aug 2012 09:30:46 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On Tue, Jul 31 2012, Seungwon Jeon wrote:
> Data transfer will be continued until all the bytes are transmitted,
> even if data crc error occurs during a multiple-block data transfer.
> This means RXDR/TXDR interrupts will occurs until data transfer is
> terminated. Early setting of host->sg to NULL prevents going into
> xxx_data_pio functions, hence permanent unhandled RXDR/TXDR interrupts
> occurs. And checking error interrupt status in the xxx_data_pio functions
> is no need because dw_mci_interrupt does do the same. This patch also
> removes it.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
