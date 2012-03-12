From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [Update][PATCH 1/3] PM / QoS: Make it possible to expose PM QoS
 latency constraints
Date: Mon, 12 Mar 2012 20:32:26 +0100
Message-ID: <CACRpkdYo65VhM+ZAHLy=xQyQqTMnkExAE3WuTre1gH7ye9Q-DQ@mail.gmail.com>
References: <201203040101.53177.rjw@sisk.pl>
	<201203080027.27435.rjw@sisk.pl>
	<201203090000.17664.rjw@sisk.pl>
	<201203090001.06683.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49339 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714Ab2CLTc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Mar 2012 15:32:27 -0400
Received: by ghrr11 with SMTP id r11so2950067ghr.19
        for <linux-mmc@vger.kernel.org>; Mon, 12 Mar 2012 12:32:26 -0700 (PDT)
In-Reply-To: <201203090001.06683.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>

On Fri, Mar 9, 2012 at 12:01 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> A runtime suspend of a device (e.g. an MMC controller) belonging to
> a power domain or, in a more complicated scenario, a runtime suspend
> of another device in the same power domain, may cause power to be
> removed from the entire domain. =A0In that case, the amount of time
> necessary to runtime-resume the given device (e.g. the MMC
> controller) is often substantially greater than the time needed to
> run its driver's runtime resume callback. =A0That may hurt performanc=
e
> in some situations, because user data may need to wait for the
> device to become operational, so we should make it possible to
> prevent that from happening.
>
> For this reason, introduce a new sysfs attribute for devices,
> power/pm_qos_resume_latency_us, allowing user space to specify the
> upper bound of the time necessary to bring the (runtime-suspended)
> device up after the resume of it has been requested. =A0However, make
> that attribute appear only for the devices whose drivers declare
> support for it by calling the (new) dev_pm_qos_expose_latency_limit()
> helper function with the appropriate initial value of the attribute.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
