From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: add missing MFD_SYSCON dependency for SOCFPGA
Date: Sat, 24 Aug 2013 23:33:29 -0400
Message-ID: <874naesauu.fsf@octavius.laptop.org>
References: <002601ce8e4e$027246c0$0756d440$@samsung.com>
	<001401ce9504$b4554ce0$1cffe6a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46626 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939Ab3HYDde (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 23:33:34 -0400
In-Reply-To: <001401ce9504$b4554ce0$1cffe6a0$%jun@samsung.com> (Seungwon
	Jeon's message of "Fri, 09 Aug 2013 22:31:07 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jingoo Han' <jg1.han@samsung.com>, linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Dinh Nguyen' <dinguyen@altera.com>

Hi,

On Fri, Aug 09 2013, Seungwon Jeon wrote:
> On Thu, August 01, 2013, Jingoo Han wrote:
>> Added missing MFD_SYSCON dependency for SOCFPGA in order to fix
>> the following link error.
>> 
>> drivers/mmc/host/dw_mmc-socfpga.c:49: undefined reference to
>> syscon_regmap_lookup_by_compatible'
>> 
>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
