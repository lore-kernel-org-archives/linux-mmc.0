From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Tue, 03 Jul 2012 20:52:46 -0400
Message-ID: <87mx3g5ov5.fsf@octavius.laptop.org>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
	<1341296172-10645-3-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50114 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756460Ab2GDAww (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 20:52:52 -0400
In-Reply-To: <1341296172-10645-3-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Tue, 3 Jul 2012 14:16:12 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Tue, Jul 03 2012, Aaron Lu wrote:
> Host has different current capabilities at different voltages, we need
> to record these settings seperately. Before set current limit for the sd
> card, find out the current voltage first and then find out the current
> capabilities of the host to set the limit.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> [...]
> +	switch (1 << card->host->ios.vdd) {
> +		case MMC_VDD_165_195:
> +			voltage = 0; /* host's voltage is 1.8V */
> +			break;
> +		case MMC_VDD_29_30:
> +		case MMC_VDD_30_31:
> +			voltage = 1; /* host's voltage is 3.0V */
> +			break;
> +		case MMC_VDD_32_33:
> +		case MMC_VDD_33_34:
> +			voltage = 2; /* host's voltage is 3.3V */
> +			break;
> +		default:
> +			BUG(); /* host's voltage is invalid */

Please don't call BUG() -- that could easily cause a kernel panic here
(the mmc_core module will hang), which is unjustified.  You'll need to
figure out what exactly you want to have happen when the host's voltage
is invalid, and do that without affecting other controllers that are
in use on the board.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
