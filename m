From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap: remove clock rate hard coding
Date: Tue, 27 Dec 2011 13:23:51 -0500
Message-ID: <m27h1hkh54.fsf@bob.laptop.org>
References: <1324374120-19920-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35891 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903Ab1L0SYJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Dec 2011 13:24:09 -0500
In-Reply-To: <1324374120-19920-1-git-send-email-svenkatr@ti.com> (Venkatraman
	S.'s message of "Tue, 20 Dec 2011 15:12:00 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji TK <balajitk@ti.com>

Hi,

On Tue, Dec 20 2011, Venkatraman S wrote:
> From: Balaji TK <balajitk@ti.com>
>
> MMC master clock rate can vary for each instance of the MMC controller
> on the device. Use clk_get_rate instead to get the value.
>
>   Signed-off-by: Balaji TK  <balajitk@ti.com>
>   Reviewed-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
