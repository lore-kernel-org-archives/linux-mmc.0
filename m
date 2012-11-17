From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 06/14] mmc: sdhci-pxav3: controller can't get base clock
Date: Sat, 17 Nov 2012 16:57:26 -0500
Message-ID: <87d2zb99kp.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-7-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60775 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab2KQV5g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 16:57:36 -0500
In-Reply-To: <1350471893-29633-7-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 17 Oct 2012 19:04:45 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Wed, Oct 17 2012, Kevin Liu wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> Enable the quirk SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN since
> SD_CAPABILITIES_1[15:8](BASE_FREQ) can't get correct base
> clock value. It return a fixed pre-set value like 200 on
> some sdhci-pxav3 based platforms like MMP3 while return 0
> on the other sdhci-pxav3 based platforms.
> So we enable the quirk and get the base clock via function
> get_max_clock.
> Also add get_max_clock.

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
