From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [RFC] mmc: core: add the capability for broken voltage
Date: Mon, 06 Feb 2012 11:24:52 +0100
Message-ID: <000001cce4b9$906c6f90$b1454eb0$%szyprowski@samsung.com>
References: <4F13E47D.8040505@samsung.com> <m2aa4y9o7k.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:56634 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2BFKZO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 05:25:14 -0500
Received: from euspt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LYY00A2EVLZ7Q40@mailout4.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 Feb 2012 10:25:12 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LYY003TQVLZ7Q@spt1.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 Feb 2012 10:25:11 +0000 (GMT)
In-reply-to: <m2aa4y9o7k.fsf@bob.laptop.org>
Content-language: pl
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Adrian Hunter' <adrian.hunter@intel.com>

Hello,

On Sunday, February 05, 2012 12:25 AM Chris Ball wrote:

> On Mon, Jan 16 2012, Jaehoon Chung wrote:
> > This patch is added the MMC_CAP2_BROKEN_VOLTAGE.
> >
> > if the voltage didn't satisfy between min_uV and max_uV,
> > try to change the voltage in core.c.
> > When change the voltage, maybe use the regulator_set_voltage().
> 
> Thanks, pushed to mmc-next for 3.3 with Adrian's ACK.  Marek, does this
> work for you?

Yes, it works fine together with a patch from 
http://thread.gmane.org/gmane.linux.kernel.mmc/12658 
I also had to set this new capability in device's platform data.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center



