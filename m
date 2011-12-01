From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] SD/MMC: add support of adjust bounce size at run-time
Date: Thu, 01 Dec 2011 13:37:36 -0500
Message-ID: <877h2gkuj3.fsf@laptop.org>
References: <1322103977-7155-1-git-send-email-b32616@freescale.com>
	<1322103977-7155-2-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56754 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755747Ab1LASh3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 13:37:29 -0500
In-Reply-To: <1322103977-7155-2-git-send-email-b32616@freescale.com> (Qiang
	Liu's message of "Thu, 24 Nov 2011 11:06:17 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Qiang Liu <b32616@freescale.com>
Cc: linux-mmc@vger.kernel.org, leoli@freescale.com

Hi,

On Wed, Nov 23 2011, Qiang Liu wrote:
> Add bounce_size under /sys/block/mmcblk0/bouncesz.
> Support dynamic adjustment of bounce buffer in run-time (include mounted or
> unmounted filesystem).
>
> /sys/block/mmcblk0/bouncesz should be integer multiple of 512, the
> value should be range from 4096 to 4194304.
>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>

Thanks; please add some documentation on this feature to:

Documentation/mmc/mmc-dev-attrs.txt

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
