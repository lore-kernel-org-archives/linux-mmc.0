From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 1/3 ] mmc: add support for h/w clock gating of sd
	controller
Date: Sun, 5 Dec 2010 17:48:36 -0800
Message-ID: <8C107ACA-5CFA-4678-B3B2-42028B4DF587@marvell.com>
References: <3C50EC54-F380-4AE8-A417-4D3557FEB588@marvell.com>
 <20101204210213.GA671@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:36510 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751735Ab0LFBsq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 5 Dec 2010 20:48:46 -0500
In-Reply-To: <20101204210213.GA671@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Linus Walleij <linus.Walleij@stericsson.com>


will change tomorrow with other changes Nico Suggested.

Philip

On Dec 4, 2010, at 1:02 PM, Wolfram Sang wrote:

> Hi,
> 
> minor comments in addition to Nicolas:
> 
> On Fri, Dec 03, 2010 at 11:26:50AM -0800, Philip Rakity wrote:
> 
>> hardware clock gating is enabled by setting the mmc quirk
> 
> It's not a quirk, it's a capability :)
> 
>> MMC_CAP_CLOCK_GATING_HW
> 
> Why not MMC_CAP_HW_CLOCK_GATING? Might be a mileage, though...
> 
> Regards,
> 
>   Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

