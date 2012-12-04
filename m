From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V5] Powerpc eSDHC Recover from the ADMA error
Date: Mon, 03 Dec 2012 21:47:47 -0500
Message-ID: <87obiah6ss.fsf@octavius.laptop.org>
References: <1354241680-13903-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42099 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340Ab2LDCrw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 21:47:52 -0500
In-Reply-To: <1354241680-13903-1-git-send-email-Haijun.Zhang@freescale.com>
	(Haijun Zhang's message of "Fri, 30 Nov 2012 10:14:40 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

Hi,

On Thu, Nov 29 2012, Haijun Zhang wrote:
> A-003500: False ADMA Error might be reported when ADMA is used for 
> multiple block read command with Stop at Block Gap. If PROCTL[SABGREQ] 
> is set when the particular block's data is received by the System side 
> logic before entire block(with CRC) data is received by the SD side 
> logic, and also if ADMA descriptor line is fetched at the same time, 
> then DMA engine might report false ADMA error. eSDHC might not be able 
> to Continue(PROCTL[CREQ]=1)after Stop at Block Gap.
> This issue will impact the eSDHC IP VVN2.3.
>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>

This doesn't apply to mmc-next; please fix and resend.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
