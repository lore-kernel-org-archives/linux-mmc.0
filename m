From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] omap: hsmmc: fix ocr mask usage
Date: Sat, 18 Jun 2011 23:18:32 -0400
Message-ID: <m2y60yzeyf.fsf@bob.laptop.org>
References: <1308047399-8537-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34190 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab1FSDSn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 23:18:43 -0400
In-Reply-To: <1308047399-8537-1-git-send-email-sourav.poddar@ti.com> (Sourav
	Poddar's message of "Tue, 14 Jun 2011 15:59:59 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-mmc@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com, kishore.kadiyala@ti.com, gadiyar@ti.com

Hi,

On Tue, Jun 14 2011, Sourav Poddar wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
>
> The OMAP HSMMC driver uses an ocr_mask to determine the
> list of voltages supported by the card. It populates this
> mask based on the list of voltages supported by the
> regulator that supplies the voltage.
>
> Commit 64be97822b (omap4 hsmmc: Update ocr mask for MMC2 for
> regulator to use) passed a fixed ocr_mask from the OMAP4 SDP
> board file to limit the voltage to 2.9-3.0 Volts, and updated
> the driver to use this mask if provided, instead of using the
> regulator's supported voltages.
>
> However the commit is buggy - the ocr_mask is overridden
> by the regulator's capabilities anyway. Fix this.
>
> (The bug shows up when a system-wide suspend is attempted
> on the OMAP4 SDP/Blaze platforms. The eMMC card comes up
> at 3V, but drops to 1.65V after the system resumes).
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Acked-by: Balaji T K <balajitk@ti.com>
> Tested-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Pushed to mmc-next for 3.0-rc with Venkat's ACK, thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
