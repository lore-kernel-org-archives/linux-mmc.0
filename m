From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Mon, 28 Nov 2011 13:33:22 +0200 (IST)
Message-ID: <3cda1651a2c6624538bda5e049b04e15.squirrel@www.codeaurora.org>
References: <4EC45A39.5030706@samsung.com>
    <3f75bb7f25e649376784536d819e7fbf.squirrel@www.codeaurora.org>
    <4ECC3625.3090109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:36315 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab1K1LdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2011 06:33:23 -0500
In-Reply-To: <4ECC3625.3090109@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Konstantin Dorfman <kdorfman@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hi Jaehoon,

>
> i didn't know how poll for ack from card..did you know?
> So i implemented that send the hpi command whatever status.
>
> If let me know checking for ack from card, i will consider that.

Some of MMC controllers (in my case msm_sdcc) can process automatically
"busy line" and fire interrupt with "prog done" bit asserted, so we can
use handler of this irq to turn off "doing bkops" flag. Otherwise it is
possible to read mmc controller status and check busy line, in case it is
already released we can skip HPI command.

Thanks,
Kostya

