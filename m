From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 1/5] ARM: davinci: mmc: derive version information
 from device name
Date: Wed, 27 Feb 2013 17:15:59 +0530
Message-ID: <512DF1F7.6010508@ti.com>
References: <1360909322-1858-1-git-send-email-prakash.pm@ti.com> <1360909322-1858-2-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54613 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759491Ab3B0LqV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Feb 2013 06:46:21 -0500
In-Reply-To: <1360909322-1858-2-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com

On 2/15/2013 11:51 AM, Manjunathappa, Prakash wrote:
> Remove specifying mmc controller IP version information via platform
> data, instead specify device name so that driver derives it from
> platform_device_id table. Also change the clock node name to match
> the changed dev_id.
> Tested on da850-evm to make sure driver loads without clk_get failures.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

The patch looks good to me, but after this patch MMC/SD will be broken.
I suggest merging this into 2/5. It makes little sense without those
changes anyway.

Thanks,
Sekhar
