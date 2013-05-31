From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] dmaengine: shdma: fix a build failure on platforms with no DMA support
Date: Fri, 31 May 2013 17:04:17 +0200
Message-ID: <4422231.HoYmB8LUsn@wuerfel>
References: <Pine.LNX.4.64.1305310423360.1470@axis700.grange> <alpine.DEB.2.00.1305311504460.6919@axis700.grange> <51A8BB0D.9060907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64347 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336Ab3EaPEs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 May 2013 11:04:48 -0400
In-Reply-To: <51A8BB0D.9060907@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dan Murphy <dmurphy@ti.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kevin Hilman <khilman@linaro.org>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Chris Ball <cjb@laptop.org>

On Friday 31 May 2013 10:00:29 Dan Murphy wrote:
> My consideration was that since this is an exported symbol that a driver
> could call this API explicitly without checking for
> the function pointer first, there is a potential of calling a NULL pointer.

Drivers never call a filter function directly, so that is not an issue.
Even if a driver would try it, that would not actually compile.
	
	Arnd
