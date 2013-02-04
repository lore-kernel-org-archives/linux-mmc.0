From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] MMC: rtsx: remove driving adjustment
Date: Mon, 4 Feb 2013 11:47:37 +0300
Message-ID: <20130204084737.GG4937@mwanda>
References: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
 <1359963959-2305-2-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:29230 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab3BDIr4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Feb 2013 03:47:56 -0500
Content-Disposition: inline
In-Reply-To: <1359963959-2305-2-git-send-email-rogerable@realtek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roger Tseng <rogerable@realtek.com>
Cc: cjb@laptop.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org

On Mon, Feb 04, 2013 at 03:45:57PM +0800, Roger Tseng wrote:
> Several new models of readers use different way to select driving
> capability(a necessary adjustment along with voltage change). Removing this
> from device-independent rtsx_pci_sdmmc module. It will be implemented in
> device-depend calls encapsulated by rtsx_pci_switch_output_voltage().
> 

I'm not sure I understand.

Does this patch break things and then "[PATCH 2/3] mfd: rtsx:
implement driving adjustment to device-dependent callbacks" fixes
things again?  In other words, will all the old devices run if we
only apply patch 1/3 and not 2/3?

That's not the right idea.  Just merge the two patches into one
patch.

regards,
dan carpenter

