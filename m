From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mxs-mmc: Fix warning due to incorrect type
Date: Mon, 28 Jan 2013 15:48:45 -0500
Message-ID: <87wqux824y.fsf@laptop.org>
References: <1357605755-8872-1-git-send-email-festevam@gmail.com>
	<201301080757.29584.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40640 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155Ab3A1UtY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Jan 2013 15:49:24 -0500
In-Reply-To: <201301080757.29584.marex@denx.de> (Marek Vasut's message of
	"Tue, 8 Jan 2013 07:57:29 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi,

On Tue, Jan 08 2013, Marek Vasut wrote:
>> Fixes the following warning when building with W=1 option:
>> 
>> drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_adtc':
>> drivers/mmc/host/mxs-mmc.c:401:2: warning: comparison between signed and
>> unsigned integer expressions [-Wsign-compare]
>> 
>> The warning happens because 'i' is used in 'for_each_sg(sgl, sg, sg_len,
>> i)' and should be made unsigned.
>> 
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Nice
>
> Acked-by: Marek Vasut <marex@denx.de>

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
