From: Bean Huo <bpqw@micron.com>
Subject: Re: [PATCH 3/3] mmc: Support FFU for eMMC v5.0
Date: Mon, 24 Nov 2014 13:26:23 +0000 (UTC)
Message-ID: <loom.20141124T142342-222@post.gmane.org>
References: <1415896362-28343-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58702 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbaKXNfI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Nov 2014 08:35:08 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1XstnD-0002fi-MP
	for linux-mmc@vger.kernel.org; Mon, 24 Nov 2014 14:35:06 +0100
Received: from 111.20.158.2 ([111.20.158.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 14:35:03 +0100
Received: from bpqw by 111.20.158.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 14:35:03 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Avi Shchislowski <avi.shchislowski <at> sandisk.com> writes:

> 
>  Add support of FFU for eMMC v5.0
> 
> Signed-off-by: Avi Shchislowski <avi.shchislowski <at> sandisk.com>
> ---
hi,
How about your this patch?I think,it'd better be enabled and done in the
bootloader,just as uboot.

