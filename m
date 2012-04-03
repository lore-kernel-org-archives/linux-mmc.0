From: Chris Ball <cjb@laptop.org>
Subject: Re: [REGRESSION][3.4-rc1] mmc0: Timeout waiting for hardware interrupt.
Date: Tue, 03 Apr 2012 12:08:20 -0400
Message-ID: <87bon8iyrv.fsf@laptop.org>
References: <4F7B1E36.1030509@spahan.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51253 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082Ab2DCQIK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Apr 2012 12:08:10 -0400
In-Reply-To: <4F7B1E36.1030509@spahan.ch> (Hanspeter Spalinger's message of
	"Tue, 03 Apr 2012 17:58:46 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hanspeter Spalinger <hanfi@spahan.ch>
Cc: linux-mmc@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Hi,

On Tue, Apr 03 2012, Hanspeter Spalinger wrote:
> Hi,
> My Laptop (HP Elitebook 8560p) started throw
> " mmc0: Timeout waiting for hardware interrupt." at updating from
> 3.3-rc7 to 3.4-rc1 and is no longer able to mount my SD-card.
>
> I bisected this and found the culprit to be:
> e6039832bed9a9b967796d7021f17f25b625b616 is the first bad commit
> commit e6039832bed9a9b967796d7021f17f25b625b616
> Author: Alexander Stein <alexander.stein@systec-electronic.com>
> Date:   Tue Mar 13 18:16:40 2012 +0100
>
>     mmc: sdhci-pci: Add MSI support
>
>     Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
>     Signed-off-by: Chris Ball <cjb@laptop.org>

So we're seeing chipsets from multiple vendors stop working after
enabling MSI.  Seems clear that we should revert Alexander's patch
for 3.4; perhaps we should turn MSI on using a whitelist instead?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
