From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/4 v3] mmc: sh_mmcif: process requests asynchronously
Date: Mon, 26 Dec 2011 12:59:52 -0500
Message-ID: <m2boqvjjs7.fsf@bob.laptop.org>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
	<1323887514-12650-4-git-send-email-g.liakhovetski@gmx.de>
	<m2boqxz91n.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1112252105340.22951@axis700.grange>
	<m2aa6gxog7.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1112252358050.22951@axis700.grange>
	<m2y5u0w1a2.fsf@bob.laptop.org>
	<Pine.LNX.4.64.1112260942330.9178@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38041 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484Ab1LZSAN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Dec 2011 13:00:13 -0500
In-Reply-To: <Pine.LNX.4.64.1112260942330.9178@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 26 Dec 2011 09:44:32 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi,

On Mon, Dec 26 2011, Guennadi Liakhovetski wrote:
> I can resend it if you like, but in fact that fuzz is harmless - you can 
> go ahead with the patch you have at hand. But, please, do let me know if 
> you prefer to have an updated patch.

Okay, pushed to mmc-next for 3.3 -- please just check everything looks
reasonable there.  Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
