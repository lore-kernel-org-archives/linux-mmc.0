From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v6 0/3]mmc: implement eMMC4.4 standard HW reset feature
Date: Mon, 10 Jan 2011 10:46:11 +0800
Message-ID: <5D8008F58939784290FAB48F549751983519F48E5D@shsmsx502.ccr.corp.intel.com>
References: <20101227101305.GA20143@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63631 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab1AJCqs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 21:46:48 -0500
In-Reply-To: <20101227101305.GA20143@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Hi Chris,
The HW ware reset patches have been pending for several weeks. The first version was sent at Oct.25th, and now I have updated them to be the version 6. So Chris, would you help me on this?. I want to know whether they are acceptable. And I am ready to fix all the comments from the community. Thanks a lot.

-Chuanxiao

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Chuanxiao Dong
> Sent: Monday, December 27, 2010 6:13 PM
> To: linux-mmc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; cjb@laptop.org; akpm@linux-foundation.org
> Subject: [PATCH v6 0/3]mmc: implement eMMC4.4 standard HW reset feature
> 
> Hi all,
>    This is the version 6 of hardware reset feature implementation. When eMMC
>    card cannot response any command, signal RST_n can help to reset eMMC
>    card.
> 
>    patch1: enable HW reset capability if card supports.
>    patch2: do hardware reset if card occurs read/write/erase timeout
>    patch3: implement hwreset_emmc and reinit_emmc callbacks. In this patch,
>    hwreset_emmc callback will pull up/down the corresponded GPIO line number
>    to trigger RST_n signal.
> 
>    change log:
>    1. Move hardware_reset callback to mmc_bus_ops so that all kinds of host
>    controller can use hardware_reset callback to trigger RST_n signal.
>    Different host controller only needs to provide a GPIO line number to
>    this callback.
>    2. Add GPIO pull up/down part in hardware_reset callback.
>    3. Remove reset_emmc callback in sdhci_ops.
> 
> Thanks
> Chuanxiao
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
