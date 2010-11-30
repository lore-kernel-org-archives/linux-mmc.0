From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 0/3]mmc: set a suitable max_discard_sectors value for
 HC
Date: Tue, 30 Nov 2010 15:21:15 +0800
Message-ID: <5D8008F58939784290FAB48F54975198313E0F4220@shsmsx502.ccr.corp.intel.com>
References: <20101118085951.GA18161@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48136 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716Ab0K3HXq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 02:23:46 -0500
In-Reply-To: <20101118085951.GA18161@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "cjb@laptop.org" <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan@linux.intel.com" <alan@linux.intel.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Hi Chris,
I have submitted several patches to this mail list since Oct.25, but didn't get any response.
Do you have any plan to review them? I would like to fix all of them if you have concern about them.

Below are my patches, but no response got from each since the first submission.
1. eMMC4.4 hardware reset feature, the first submission was at Oct.25. Last patch list:
https://patchwork.kernel.org/patch/334931/
https://patchwork.kernel.org/patch/334941/
2. eMMC4.4 enhanced area feature, the first submission was at Oct.26. Last patch list:
https://patchwork.kernel.org/patch/282052/
3. usage of eMMC trim. This submission is a workaround for some sdhci host controller which cannot erase the whole device at one time. The first submission was at Nov.11. Last patch list:
https://patchwork.kernel.org/patch/335361/
https://patchwork.kernel.org/patch/335381/
https://patchwork.kernel.org/patch/335411/

I expect any comment from all of you.

Thanks
Chuanxiao

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
> Sent: Thursday, November 18, 2010 5:00 PM
> To: cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> alan@linux.intel.com; arjan@linux.intel.com
> Subject: [PATCH v2 0/3]mmc: set a suitable max_discard_sectors value for HC
> 
> Hello Chris,
> 	  These are the version 2 patches of setting a suitable
> 	  max_discard_sectors value for sdhci host controller.
> 
> 	  The max_discard_sectors determines how many sectors will be passed
> 	  down to host controller for erasing. The default value is UNIT_MAX
> 	  which means the block layer can pass down unlimited sectors one time
> 	  to host controller. But for some kinds of SDHCI host controller, like
> 	  MFLD SDHCI host controller cannot erase so many sectors one time. It
> 	  will generate a timeout interrupt since the erasing time is longer
> 	  than the host controller waiting timeout time. This should be a
> 	  hardware architecture issue.
> 
> 	  So in these patches, add a new quirk to work around this. The new
> 	  quirk can help host controllers to set a safe max_discard_sectors value
> 	  for them.
> 
> 	  patch1: Add a new quirk for SDHCI host controller and a new mmc
> 	  capability which will help mmc core layer to set a suitable
> 	  max_discard_sectors value for it.
> 
> 	  patch2: Set the sdhci host controller timeout value to be the maximum
> 	  one for each erase command. This will be safe for this kind of SDHCI
> 	  host controller.
> 
> 	  patch3: Add the new quirk to MFLD SDHCI host controller.
> 
> Thanks
> Chuanxiao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
