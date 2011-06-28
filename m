From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC] How working MMC_BUS_WIDTH_TEST??
Date: Tue, 28 Jun 2011 12:50:57 -0700
Message-ID: <A143AB12-AF84-4CD9-BA9C-97651D0ED29C@marvell.com>
References: <4E09B2E3.20903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:41478 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751117Ab1F1Tvm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Jun 2011 15:51:42 -0400
In-Reply-To: <4E09B2E3.20903@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


On Jun 28, 2011, at 3:54 AM, Jaehoon Chung wrote:

> Hi..
> 
> I found the MMC_CAP_BUS_WIDTH_TEST...
> In mailing, I read the related patches..
> but i didn't fully understand...
> 
> /*
> * If controller can't handle bus width test,
> * compare ext_csd previously read in 1 bit mode
> * against ext_csd at new bus width
> */
> if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
> 	err = mmc_compare_ext_csds(card,
> 		ext_csd,
> 		bus_width);
> else
> 	err = mmc_bus_test(card, bus_width);
> if (!err)
> 	break;
> 
> And i tested suspend/resume..it's failed..
> If i didn't set MMC_CAP_BUS_WIDTH_TEST, always return -EINVAL..
> (using SDHCI controller, card is eMMC4.41)
> 
> Didn't compare ext_csd's value..
> 
> So i want to know how use MMC_CAP_BUS_WIDTH_TEST..

I am using eMMC and code works fine so  maybe there is issue in no ext_csd.  You will need to
add debug code to the compare_ext_csd and see what is not right and we can adjust the code.
I am surprised that resume fails -- code will default to 1 bit data and it is NOT possible for this to
be wrong.  At the moment -- clueless to explain with more information.

TheCMD14/ CMD19 is in JEDEC spec for bus width testing.  Sends a pattern to the card and
based on the returned values detects the bus width.  Some controllers do NOT support this command.
The just do not work.  You need to figure this out by enabling the quirk.  No other way to know.

regards,

Philip

> 
> Thanks,
> Jaehoon Chung

