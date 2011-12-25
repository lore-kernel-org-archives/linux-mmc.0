From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio_mmc: Hotplug code regrouping
Date: Sat, 24 Dec 2011 21:43:47 -0500
Message-ID: <m2liq1xtek.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1112232301310.1911@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49830 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab1LYCny (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Dec 2011 21:43:54 -0500
In-Reply-To: <Pine.LNX.4.64.1112232301310.1911@axis700.grange> (Guennadi
	Liakhovetski's message of "Fri, 23 Dec 2011 23:03:13 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On Fri, Dec 23 2011, Guennadi Liakhovetski wrote:
> From: Bastian Hecht <hechtb@googlemail.com>
>
> This patch regroups the code slightly, adds documentation and allows
> the rtpm counter of MMC_CAP_NEEDS_POLL devices to reach 0 again.
>
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> [g.liakhovetski@gmx.de: restore pm_runtime_get_noresume()]
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Pushed to mmc-next for 3.3, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
