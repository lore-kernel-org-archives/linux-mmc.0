From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH RESEND 0/3] mmc: rtsx: fix bug and support nonblocking
 request
Date: Mon, 17 Feb 2014 03:12:22 +0100
Message-ID: <20140217021222.GI18868@zurbaran>
References: <cover.1392602322.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7771 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540AbaBQCMd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 16 Feb 2014 21:12:33 -0500
Content-Disposition: inline
In-Reply-To: <cover.1392602322.git.micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: chris@printf.net, gregkh@linuxfoundation.org, dan.carpenter@oracle.com, ulf.hansson@linaro.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rogerable@realtek.com, wei_wang@realsil.com.cn, Lee Jones <lee.jones@linaro.org>

Hi Micky,

On Mon, Feb 17, 2014 at 10:00:54AM +0800, micky_ching@realsil.com.cn wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
> 
> First we fix the card poweroff bug: the card power is not shutdown when sd/mmc
> card removed, this will make UHS-card failed to running in high speed mode if we
> insert the card again.
> 
> We offer a concise tuning searching method, it is much easier to read.
> 
> At last we add support for nonblocking request, which will improve card read
> speed at about 10% write speed about 5% normally.
> 
> Micky Ching (3):
>   mmc: rtsx: fix card poweroff bug
>   mmc: rtsx: modify phase searching method for tuning
>   mmc: rtsx: add support for pre_req and post_req
> 
>  drivers/mfd/rtsx_pcr.c            |  132 ++++++---
Please add Lee Jones (cc'ed) for MFD.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
