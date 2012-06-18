From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] gpio: of_get_named_gpio_flags() return -EPROBE_DEFER
 if GPIO not yet available
Date: Mon, 18 Jun 2012 08:50:38 -0600
Message-ID: <4FDF403E.9090302@wwwdotorg.org>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de> <4FDE8D27.6030508@wwwdotorg.org> <4FDEF293.9080305@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:36076 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab2FROuo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jun 2012 10:50:44 -0400
In-Reply-To: <4FDEF293.9080305@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On 06/18/2012 03:19 AM, Roland Stigge wrote:
> On 06/18/2012 04:06 AM, Stephen Warren wrote:
>> On 06/17/2012 04:11 AM, Roland Stigge wrote:
>>> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
>>> respective GPIO is not (yet) available. This is useful if driver's probe()
>>> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
>>> can be probed again later on.
>>>
>>> The function still returns -EINVAL on other errors (parse error or node doesn't
>>> exist). This way, the case of an optional/intentionally missing GPIO is handled
>>> appropriately.
>>
>> While I agree this is a correct change, it is going to break some
>> existing code - at least sound/soc/tegra/tegra_{wm8903.c,alc5632.c}.
> 
> Can you please tell in which way the patch breaks those drivers?
> However, I can see that those drivers solved the same problem in a
> different way (deferring of_get_named_gpio(), via the sound init()). So
> they could be adjusted to take advantage of new -EPROBE_DEFER.

The drivers I mentioned test the return code of of_get_named_gpio() to
see if it's -ENODEV, which means that DT property for that GPIO exists
but the driver for it isn't available yet, so the property can't be
parsed. In this case, the sound drivers defer their own probe. If
of_get_named_gpio() is modified to return -EPROBE_DEFER directly, then
it won't be returning -ENODEV, and hence the sound drivers' check for
-ENODEV won't fire, and hence the sound drivers will just continue their
probe assuming that the particular GPIOs are not present on the board
(since they are all optional, so anything other than an explicit
deferral error from of_get_named_gpio() is not treated as an error).
This will break sound on those platforms.
