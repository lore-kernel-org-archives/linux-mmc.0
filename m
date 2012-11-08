From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v7 0/3] Add modules to support realtek PCIE card reader
Date: Thu, 8 Nov 2012 10:41:31 +0100
Message-ID: <20121108094131.GB27828@sortiz-mobl>
References: <cover.1351481260.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12039 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607Ab2KHJlf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Nov 2012 04:41:35 -0500
Content-Disposition: inline
In-Reply-To: <cover.1351481260.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de

Hi Wei,

On Mon, Oct 29, 2012 at 01:49:28PM +0800, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> Support for Realtek PCI-Express driver-based card readers including rts5209,
> rts5229 and rtl8411.
All 3 patches applied now, thanks a lot.
I also fixed the Kconfig entry where you forgot to select MFD_CORE.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
