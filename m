From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage switch
 procedure
Date: Wed, 16 Feb 2011 01:55:12 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300DCDEF7F0@SAUSEXMBP01.amd.com>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-3-git-send-email-arindam.nath@amd.com>
 <20110215101627.GC13934@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:5458 "EHLO
	VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab1BPHz0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 02:55:26 -0500
In-Reply-To: <20110215101627.GC13934@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Wolfram,

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Tuesday, February 15, 2011 3:46 PM
> To: Nath, Arindam
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> anath.amd@gmail.com
> Subject: Re: [PATCH 02/12] mmc: sd: add support for signal voltage
> switch procedure
> 
> On Tue, Feb 15, 2011 at 03:05:00PM +0530, Arindam Nath wrote:
> 
> > Host Controller v3.00 adds another Capabilities register. We can
> > directly read this register without any version checking since the
> > new register bits will be considred as reserved in older controllers,
> > and will be read as 0.
> 
> I so much wish you were right, but reality is different :(
> 
> The i.MX35-processor, for example, has a custom watermark-register
> there. I
> could fix this by intercepting the read using io-accessors, but to
> minimize
> potential regressions on older controllers in general, I'd say the
> check for v3
> might be justified?

Thanks for the suggestion. I will add the changes in V2 of the patchset.

Regards,
Arindam

