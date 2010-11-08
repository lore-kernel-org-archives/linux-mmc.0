From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3
	sd controller
Date: Sun, 7 Nov 2010 23:21:08 -0800
Message-ID: <BEF8AD05-D094-4607-8C4F-1908C4FF54B3@marvell.com>
References: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
 <20101107220411.GB5376@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38968 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751789Ab0KHHig convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Nov 2010 02:38:36 -0500
In-Reply-To: <20101107220411.GB5376@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 7, 2010, at 2:04 PM, Wolfram Sang wrote:

> On Fri, Oct 08, 2010 at 12:31:34PM -0700, Philip Rakity wrote:
>> 
>> 8 bit width is a new feature in the sd 3.0 spec.  Add checks to
>> ensure HOST_CONTROL register set 8 bit mode only if sd 3.0
>> 
>> add quirk to indicate that board design supports 8 data lines.
>> The controller can support 8 data bits but the board design may
>> only bring out 4 data bits.
> 
> This isn't a quirk, this is platform_data, no?

Never sure of the difference between a quirk and platform data. 
example:  Broken card detect is a quirk but maybe some slots on the board work and some do not

> 
> Without looking deeply into it, I think we need to use the callback you
> introduced in the other patch?
> 

It is needed in my experience because of how board design is done.  The controller can support 8 bits
but the board may not have DAT4-DAT7 connected.

> Regards,
> 
>   Wolfram
> 
> PS: Sorry if there already was a discussion I might have missed. The bus width
> thingie became a bit scattered, so I lost track...
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

