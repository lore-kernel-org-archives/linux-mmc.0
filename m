From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/4] mmc:core: parse voltage from device-tree
Date: Mon, 26 Aug 2013 12:36:22 -0400
Message-ID: <87zjs49zp5.fsf@octavius.laptop.org>
References: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50009 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab3HZQgh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Aug 2013 12:36:37 -0400
In-Reply-To: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com>
	(Haijun Zhang's message of "Mon, 26 Aug 2013 09:19:22 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, galak@kernel.crashing.org, cbouatmailru@gmail.com, scottwood@freescale.com, X.Xie@freescale.com

Hi Haijun,

On Sun, Aug 25 2013, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this function
> will parse it and return the available voltage mask.
>
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Acked-by: Anton Vorontsov <anton@enomsg.org>

Thanks, I've pushed all four patches to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
