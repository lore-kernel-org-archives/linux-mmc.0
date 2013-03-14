From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: MMC block discard / erase ioctl
Date: Thu, 14 Mar 2013 09:12:25 +0200
Message-ID: <51417859.8070600@intel.com>
References: <CAP6JJ88G-7XXU=a+ukj=EkS-=X7F19kQ_AHfga_ApHSwEKwT=A@mail.gmail.com> <514031D5.4020303@intel.com> <CAP6JJ8_sJiz837i_rNdtdiDE38-4qj0_LEw6ThODLqF=gCTETw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:27804 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab3CNHHx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Mar 2013 03:07:53 -0400
In-Reply-To: <CAP6JJ8_sJiz837i_rNdtdiDE38-4qj0_LEw6ThODLqF=gCTETw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Deneen <mdeneen@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13/03/13 16:51, Mark Deneen wrote:
> On Wed, Mar 13, 2013 at 3:59 AM, Adrian Hunter <adrian.hunter@intel.com
> <mailto:adrian.hunter@intel.com>> wrote:
> 
>     On 12/03/13 18:13, Mark Deneen wrote:
>     > I assume that this never made it into mainline?  I'm looking to do
>     something
>     > similar, and I was wondering if it somehow did make it in but in a
>     different
>     > form that I'm not seeing.
> 
>     There is BLKDISCARD and BLKSECDISCARD
> 
>     Perhaps MMC_IOC_CMD could be useful too
> 
> 
> Hmm.  I tried the BLKDISCARD ioctl and received "ioctl: Operation not
> supported", so I started digging into the mmc layer to see if this ioctl was
> implemented.  I must have been looking in the wrong place.

drivers/mmc/card/block.c supports REQ_DISCARD

