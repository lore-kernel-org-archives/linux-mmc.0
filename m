From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] ESDHC: Workaround for data crc error on p1010rdb
Date: Tue, 14 Feb 2012 06:11:00 -0500
Message-ID: <m2vcn9isaj.fsf@bob.laptop.org>
References: <1329199537-18447-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44914 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757600Ab2BNLLE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 06:11:04 -0500
In-Reply-To: <1329199537-18447-1-git-send-email-r66093@freescale.com>
	(r66093@freescale.com's message of "Tue, 14 Feb 2012 14:05:37 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Priyanka Jain <Priyanka.Jain@freescale.com>

Hi,

On Tue, Feb 14 2012, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
>
> SD card read was failing (data crc error)on some cards at
> maximum possible frequency on P1010(CCB frequency set to 400MHz).
> Some clock deviations are also observed at this frequency.
> Hence reduced the mmc clock freq.
>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Singed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Chris Ball <cjb@laptop.org>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!  Pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
