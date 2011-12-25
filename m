From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2 v2] mmc: add a generic GPIO card-detect helper
Date: Sun, 25 Dec 2011 17:46:40 -0500
Message-ID: <m262h4xoa7.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1112232346180.1911@axis700.grange>
	<Pine.LNX.4.64.1112232358100.1911@axis700.grange>
	<m2pqfdxthz.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1112252129530.22951@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52916 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891Ab1LYWqr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Dec 2011 17:46:47 -0500
In-Reply-To: <Pine.LNX.4.64.1112252129530.22951@axis700.grange> (Guennadi
	Liakhovetski's message of "Sun, 25 Dec 2011 21:36:02 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi,

On Sun, Dec 25 2011, Guennadi Liakhovetski wrote:
> This patch adds a primitive helper to support card hotplug detection on
> platforms, where a GPIO, capable of producing interrupts, is used for
> detection of card-insertion and -removal events.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> v2: switch to use snprintf()

Thanks, pushed to mmc-next for 3.3.  I agree the change was only
necessarily to make life easier for humans.  :-)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
