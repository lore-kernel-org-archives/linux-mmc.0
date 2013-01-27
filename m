From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 0/3] Fix two bugs in rtl8411
Date: Sun, 27 Jan 2013 01:21:51 +0100
Message-ID: <20130127002151.GD1174@sortiz-mobl>
References: <cover.1358905022.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26419 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811Ab3A0AVx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 26 Jan 2013 19:21:53 -0500
Content-Disposition: inline
In-Reply-To: <cover.1358905022.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de

Hi Wei,

On Wed, Jan 23, 2013 at 09:51:03AM +0800, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> 1. The method to switch output voltage is different in rtl8411
> 2. Fix the formula to calculate N from SD clock if clock divider is more than 1
> 
> Wei WANG (3):
>   MFD:rtsx: Add callback function switch_output_voltage
>   MMC:rtsx: Using callback function to switch output voltage
>   MFD:rtsx: Add callback function conv_clk_and_div_n
All 3 patches applied to my for-linus branch. I rephrased the changelog
slightly, to make it clearer that this is a bug fix.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
