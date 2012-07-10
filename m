From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] mmc: sd: Fix sd current limit setting
Date: Mon, 09 Jul 2012 22:57:40 -0400
Message-ID: <87629wuxuj.fsf@octavius.laptop.org>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
	<1341296172-10645-3-git-send-email-aaron.lu@amd.com>
	<87mx3g5ov5.fsf@octavius.laptop.org>
	<20120704053148.GC2607@aarontestpc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56404 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189Ab2GJC7E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Jul 2012 22:59:04 -0400
In-Reply-To: <20120704053148.GC2607@aarontestpc.amd.com> (Aaron Lu's message
	of "Wed, 4 Jul 2012 13:31:48 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Wed, Jul 04 2012, Aaron Lu wrote:
> Host has different current capabilities at different voltages, we need
> to record these settings seperately. The defined voltages are 1.8/3.0/3.3.
> For other voltages, we do not touch current limit setting.
>
> Before set current limit for the sd card, find out the host's operating
> voltage first and then find out the current capabilities of the host at
> that voltage to set the current limit.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> ---
> v2:
> Do not call BUG() when the host's voltage is not supported as suggested by
> Chris Ball.
> Do not use 0/1/2 to represent the host's voltage as suggested by Philip Rakity.

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
