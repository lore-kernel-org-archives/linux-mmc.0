From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/5] Adding MMC Support on OMAP4430 SDP
Date: Mon, 17 May 2010 19:50:27 -0700
Message-ID: <20100518025026.GF5818@atomide.com>
References: <22422.10.24.255.17.1273947606.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61834 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab0ERCuh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 May 2010 22:50:37 -0400
Content-Disposition: inline
In-Reply-To: <22422.10.24.255.17.1273947606.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, santosh.shilimkar@ti.com

Hi,

* kishore kadiyala <kishore.kadiyala@ti.com> [100515 11:15]:
> Adding MMC1 and MMC2 controllers support for OMAP4
> 
> V4:
> - Rebased to "for_next" branch[LO].
> - The first 3 patches [1,2,3] in the series are Minimal set of changes
>   with which MMC1/MMC2 works [No card detect for MMC1]on OMAP4 but with
>   dependencies on following patches [Not in "for_next" branch]
>   [1] I2c patches
>       a)https://patchwork.kernel.org/patch/98937/
>       b)https://patchwork.kernel.org/patch/98936/
>       c)https://patchwork.kernel.org/patch/98939/
>       d)https://patchwork.kernel.org/patch/79735/

I've taken the updated versions of the I2C patches,
and fixed them not to break omap3_defconfig.

>   [2] Regulator pacth
>       a)https://patchwork.kernel.org/patch/94054/
>   [3] hsmmc-clk patch
>       a)https://patchwork.kernel.org/patch/96821/

I've picked up these too.

> - The patches 4,5 adds card detect feature for MMC1

I only took 1 - 3 out of the MMC patches, it's too
late to start changing the other stuff.

I've reposted the whole series for a quick review.

Regards,

Tony
