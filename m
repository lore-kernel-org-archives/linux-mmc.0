From: Johan Derycke <johan.derycke@barco.com>
Subject: Re: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Mon, 6 Jul 2015 11:57:19 +0000 (UTC)
Message-ID: <loom.20150706T134729-84@post.gmane.org>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50681 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591AbbGFMAH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Jul 2015 08:00:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1ZC549-0005yr-I6
	for linux-mmc@vger.kernel.org; Mon, 06 Jul 2015 14:00:05 +0200
Received: from 68.172-183-91.adsl-static.isp.belgacom.be ([68.172-183-91.adsl-static.isp.belgacom.be])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2015 14:00:05 +0200
Received: from johan.derycke by 68.172-183-91.adsl-static.isp.belgacom.be with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2015 14:00:05 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dong Aisheng <aisheng.dong <at> freescale.com> writes:

> 
> Commit 8d86e4f mmc: sdhci-esdhc-imx: Call mmc_of_parse()
> seriously break the sd card detect/write protect function
> of most IMX platforms since a lot of GPIO flags of cd-gpios/wp-gpios
> are wrongly set in devicetree.
 
 
...


Hi,

Reviewed-by: Johan Derycke <johan.derycke@barco.com>

I have tested this patches on a nitrogen board and two custom boards with 
imx6dl. They seem to be working OK. I had continuous mmc interrupts before 
they were applied.
Will they be included in 4.2 or is it to late for that?

Best regards,

Johan




