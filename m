From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: core: eMMC in Sleep mode before suspend
Date: Wed, 21 Sep 2011 13:47:28 -0400
Message-ID: <m21uv96b4f.fsf@bob.laptop.org>
References: <1315499919-804-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33108 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103Ab1IURrq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 13:47:46 -0400
In-Reply-To: <1315499919-804-1-git-send-email-balajitk@ti.com> (Balaji T. K.'s
	message of "Thu, 8 Sep 2011 22:08:39 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, subhashj@codeaurora.org, adrian.hunter@intel.com

Hi Balaji,

On Thu, Sep 08 2011, Balaji T K wrote:
> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
> in the mmc suspend so that Vcc (NAND core) can be cut
> to minimize power consumption.
> eMMC put into SLEEP can respond to CMD0 or H/W reset or CMD5.
> Current implemention on resume from suspend relies on CMD0 in
> mmc_init_card to get out of SLEEP mode.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Acked-by: Venkatraman S <svenkatr@ti.com>

Thanks, pushed to mmc-next for 3.2.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
