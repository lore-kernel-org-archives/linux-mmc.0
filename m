From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: support deferred probing for GPIOs
Date: Thu, 14 Feb 2013 19:23:58 +0530
Message-ID: <511CEC76.9020703@ti.com>
References: <1359536837-14874-1-git-send-email-jlu@pengutronix.de> <1360838617.3892.27.camel@coredoba.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1360838617.3892.27.camel@coredoba.hi.pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
To: =?UTF-8?B?SmFuIEzDvGJiZQ==?= <jlu@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday 14 February 2013 04:13 PM, Jan L=C3=BCbbe wrote:
> On Wed, 2013-01-30 at 10:07 +0100, Jan Luebbe wrote:
>> If the CD/WP-GPIOs are not provided by the SoC's GPIO controller,
>> we need to handle the case where omap_hsmmc is probed earlier than
>> the GPIO controller chosen in the device tree.
>>
>> Fix this by checking the return value of of_get_named_gpio against
>> -EPROBE_DEFER and passing it through to the probe function.
>>
>> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
>
> Balaji, since you seem to be the new OMAP HSMMC maintainer, do you ha=
ve
> any comments on this patch?

Looks good to me,
Acked-by: Balaji T K <balajitk@ti.com>


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
