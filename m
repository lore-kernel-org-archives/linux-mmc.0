From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: support deferred probing for GPIOs
Date: Fri, 22 Mar 2013 11:52:16 -0400
Message-ID: <87ehf7qvnz.fsf@octavius.laptop.org>
References: <1359536837-14874-1-git-send-email-jlu@pengutronix.de>
	<1360838617.3892.27.camel@coredoba.hi.pengutronix.de>
	<511CEC76.9020703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44576 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933488Ab3CVPwX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 11:52:23 -0400
In-Reply-To: <511CEC76.9020703@ti.com> (Balaji T. K.'s message of "Thu, 14 Feb
	2013 19:23:58 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On Thu, Feb 14 2013, Balaji T K wrote:
> On Thursday 14 February 2013 04:13 PM, Jan L=C3=BCbbe wrote:
>> On Wed, 2013-01-30 at 10:07 +0100, Jan Luebbe wrote:
>>> If the CD/WP-GPIOs are not provided by the SoC's GPIO controller,
>>> we need to handle the case where omap_hsmmc is probed earlier than
>>> the GPIO controller chosen in the device tree.
>>>
>>> Fix this by checking the return value of of_get_named_gpio against
>>> -EPROBE_DEFER and passing it through to the probe function.
>>>
>>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>>
>> Balaji, since you seem to be the new OMAP HSMMC maintainer, do you h=
ave
>> any comments on this patch?
>
> Looks good to me,
> Acked-by: Balaji T K <balajitk@ti.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
