From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC][PATCH] mmc_block: Allow more than 8 partitions per card
Date: Fri, 16 Oct 2015 21:08:26 +0200
Message-ID: <8708065.t39NvS0r8j@wuerfel>
References: <1445020846-529-1-git-send-email-john.stultz@linaro.org> <56214A01.2030906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52694 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbJPTIj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2015 15:08:39 -0400
In-Reply-To: <56214A01.2030906@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Austin S Hemmelgarn <ahferroin7@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ben Hutchings <ben@decadent.org.uk>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Android Kernel Team <kernel-team@android.com>, linux-mmc@vger.kernel.org

On Friday 16 October 2015 15:03:29 Austin S Hemmelgarn wrote:
> On 2015-10-16 14:40, John Stultz wrote:
> > From: Colin Cross <ccross@android.com>
> >
> > It is quite common for Android devices to utilize more
> > then 8 partitions on internal eMMC storage. This patch,
> > which has been carried for quite awhile in the AOSP common
> > tree is necessary in order to support such configurations,
> > so I wanted to submit it for consideration upstream.
>
> Isn't this what CONFIG_MMC_BLOCK_MINORS is for?  It does limit you to 
> 256 minors total, and therefore the number of supported MMC's is equal 
> to 256/CONFIG_MMC_BLOCK_MINORS, but I've never heard of an Android 
> device with support for more than 4 MMC/SD cards (including eMMC's), and 
> I would seriously question anyone who has the need for more than 32 
> partitions on the root device for a phone/tablet/television.

The 256 minor limit is really arbitrary, we should not be limited by
that, and you should have have to decide at compile time whether you
might need many partitions or many devices, even if we believe that
nobody will ever need both at the same time.

	Arnd
