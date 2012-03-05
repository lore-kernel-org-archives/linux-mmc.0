From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] MMC / PM: Make it possible to use PM QoS latency
 constraints, v2
Date: Mon, 5 Mar 2012 08:02:02 +0100
Message-ID: <CACRpkdahugC214JLaRwWHBvaMkGaa7yL3Cr3vYkYtk+PSb++_A@mail.gmail.com>
References: <201203040101.53177.rjw@sisk.pl>
	<201203042053.19314.rjw@sisk.pl>
	<201203042055.28111.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33461 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab2CEHCD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Mar 2012 02:02:03 -0500
Received: by iagz16 with SMTP id z16so5162018iag.19
        for <linux-mmc@vger.kernel.org>; Sun, 04 Mar 2012 23:02:02 -0800 (PST)
In-Reply-To: <201203042055.28111.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>

On Sun, Mar 4, 2012 at 8:55 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> A runtime suspend of an MMC controller belonging to a power domain
> or, in a more complicated scenario, a runtime suspend of another
> device in the same power domain, may cause power to be removed from
> the entire domain. =A0In that case, the amount of time necessary to
> runtime-resume the MMC controller is often substantially greater
> than the time needed to enable its clock. =A0That may hurt performanc=
e
> in some situations, because user data may need to wait for the
> controller to become operational, so we should make it possible to
> prevent that from happening.
>
> For this reason, introduce a new sysfs attribute for MMC hosts,
> pm_latency_limit_ms, allowing user space to specify the upper bound
> of the time necessary to bring the (runtime-suspended) host up after
> the resume of it has been requested. =A0However, make that attribute
> appear ony for the hosts whose drivers declare support for PM QoS by
> populating the pm_qos member of struct mmc_host before registering
> the host.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
