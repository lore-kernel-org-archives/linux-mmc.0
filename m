From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Tue, 19 Apr 2011 17:16:19 +0300
Message-ID: <BANLkTikGMfb_G2dW2btgGdbKnO3DxVOPYg@mail.gmail.com>
References: <Pine.LNX.4.64.1104191230150.16641@axis700.grange>
 <BANLkTinQv1u243d+YBriVdvVRMT5oe9aYQ@mail.gmail.com> <Pine.LNX.4.64.1104191505230.16641@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51927 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab1DSOQk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 10:16:40 -0400
Received: by iyb14 with SMTP id 14so4794671iyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 07:16:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104191505230.16641@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, Apr 19, 2011 at 4:23 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Seeing a "struct dev_pm_ops" instance with .runtime_suspend(),
> .runtime_resume(), and .runtime_idle() methods I understand, that
> "suspend" and "resume" are two counterparts, that balance each other. Now
> with "idle" I am not sure which method should balance it. With platform
> devices in the generic case idle ends up calling
> pm_generic_runtime_idle(), which then calls pm_runtime_suspend(). So,
> there should be a balancing pm_runtime_resume() somewhere?

There are many ways with which the dev_pm_ops handlers get called, but
none of them include imbalance.

E.g. take a look how pm_runtime_{get,put}_sync balance each other,
while involving all three runtime pm handlers that you've specified
(suspend/resume/idle).

Can you point out an existing device/flow that demonstrates a runtime
pm imbalance ?

>> More specifically, without having this ->runtime_idle() handler, the
>> last user giving up its power usage_count (e.g. by calling
>> pm_runtime_put{_sync}) will not end up powering down the MMC card.
>
> How do they work then? Who does the pm_runtime_resume() to undo the
> effects of the pm_runtime_suspend()

Let's take SDIO for example; note how sdio_bus_probe and
sdio_bus_remove balance each other with respect to runtime PM api
invocations.

> or is it the platform runtime-pm that is implementing the "idle" method wrongly?

I'm not following what's wrong exactly. If you point out specific code
and specify exactly the issues you witness, it might be easier to
help.

Thanks,
Ohad.
