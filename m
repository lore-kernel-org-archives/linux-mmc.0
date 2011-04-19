From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH/RFC] MMC: remove unbalanced pm_runtime_suspend()
Date: Tue, 19 Apr 2011 15:44:33 +0300
Message-ID: <BANLkTinQv1u243d+YBriVdvVRMT5oe9aYQ@mail.gmail.com>
References: <Pine.LNX.4.64.1104191230150.16641@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49231 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab1DSMoy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 08:44:54 -0400
Received: by iyb14 with SMTP id 14so4722495iyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2011 05:44:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104191230150.16641@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, Apr 19, 2011 at 1:46 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> MMC bus PM operations implement a .runtime_idle() method, which calls
> pm_runtime_suspend(), but this call is not balanced by a resume
> counterpart,

What's the exact flow you refer to ?

> which causes problems with repeated card-plug and driver-load
> cycles.

Can you please be more specific ? What are you trying to achieve, what
are the problems you encounter ?

>  Removing this method fixes the disbalance.

I'm not sure which disbalance you're referring to, but if you'll
remove this method you will break MMC/SDIO runtime PM.

More specifically, without having this ->runtime_idle() handler, the
last user giving up its power usage_count (e.g. by calling
pm_runtime_put{_sync}) will not end up powering down the MMC card.
