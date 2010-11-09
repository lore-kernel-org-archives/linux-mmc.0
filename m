From: Philip Rakity <prakity@marvell.com>
Subject: Re: can we remove the quirk  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN ?
Date: Tue, 9 Nov 2010 04:02:37 -0800
Message-ID: <23C594B6-1B72-4DE0-8BE7-04E1FD36B58E@marvell.com>
References: <4D68A6A7-2D95-463F-875B-DB52ECCC53F1@marvell.com>
 <65EBF3EE-DE1E-46A4-BF41-A9D5A6096673@marvell.com>
 <20101109115517.GD3223@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59037 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754265Ab0KIMDi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 07:03:38 -0500
In-Reply-To: <20101109115517.GD3223@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Zhangfei Gao <zhangfei.gao@gmail.com>


Doesn't the platform data hold the specific board specific quirks ?

Can you provide an example of how you see the platform data being used.  I think we are saying the same thing using different words but a code snippet would clarify this.

Philip

On Nov 9, 2010, at 3:55 AM, Wolfram Sang wrote:

> On Tue, Nov 09, 2010 at 03:45:15AM -0800, Philip Rakity wrote:
>> 
>> reposting since we are discussing removing quirks.   
>> 
>> We could partition the quirks into one set for controller quirks and one set for platform quirks.  That would give us another 32 quirks. 
> 
> IMHO we need less quirks, not more. Adding the number of potential
> quirks just delays the underlying problem. Also, unless someone
> enlightens me, I don't think there are platform quirks, only
> platform_data?
> 
> Regards,
> 
>   Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

