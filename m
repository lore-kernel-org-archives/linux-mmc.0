From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: MMC block discard / erase ioctl
Date: Wed, 13 Mar 2013 09:59:17 +0200
Message-ID: <514031D5.4020303@intel.com>
References: <CAP6JJ88G-7XXU=a+ukj=EkS-=X7F19kQ_AHfga_ApHSwEKwT=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44353 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab3CMHyr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Mar 2013 03:54:47 -0400
In-Reply-To: <CAP6JJ88G-7XXU=a+ukj=EkS-=X7F19kQ_AHfga_ApHSwEKwT=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Deneen <mdeneen@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 12/03/13 18:13, Mark Deneen wrote:
> I assume that this never made it into mainline?  I'm looking to do something
> similar, and I was wondering if it somehow did make it in but in a different
> form that I'm not seeing.

There is BLKDISCARD and BLKSECDISCARD

Perhaps MMC_IOC_CMD could be useful too

