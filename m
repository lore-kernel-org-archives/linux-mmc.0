From: Chris Ball <cjb@laptop.org>
Subject: Re: [mmc:mmc-next 17/28] sdhci-pltfm.c:(.text+0x80): multiple definition of `sdhci_runtime_pm_get'
Date: Thu, 08 Nov 2012 07:21:19 -0500
Message-ID: <874nl070ao.fsf@octavius.laptop.org>
References: <509ac6c4.cYfNNpMXVvvrRu6C%fengguang.wu@intel.com>
	<87ip9h6t5y.fsf@octavius.laptop.org> <20121108120833.GA8199@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37794 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463Ab2KHMVa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Nov 2012 07:21:30 -0500
In-Reply-To: <20121108120833.GA8199@localhost> (Fengguang Wu's message of
	"Thu, 8 Nov 2012 20:08:33 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On Thu, Nov 08 2012, Fengguang Wu wrote:
>> (Wu, are you sure that this is the correct config?  It's i386 without
>> MMC_SDHCI_S3C=y, and MMC_SDHCI_S3C depends on PLAT_SAMSUNG/ARM.)
>
> Sorry I don't understand that. MMC_SDHCI_S3C seems to not matter at all?

Oops, sorry about that -- you're right, of course.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
