From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] mmc: tmio: fix compiler warning
Date: Tue, 23 Jul 2013 12:01:43 -0700
Message-ID: <CAOesGMgMZR=yjDDWWDb21iuZaVocXqYZUg8C=hyGk4oHrRxDig@mail.gmail.com>
References: <Pine.LNX.4.64.1307081135170.19819@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:45059 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757036Ab3GWTBn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2013 15:01:43 -0400
Received: by mail-qa0-f48.google.com with SMTP id o19so1838601qap.0
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2013 12:01:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1307081135170.19819@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Jul 8, 2013 at 2:38 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch fixes a compiler warning:
>
> drivers/mmc/host/tmio_mmc_pio.c: In function 'tmio_mmc_power_on':
> drivers/mmc/host/tmio_mmc_pio.c:798:19: warning: ignoring return value of
> 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Olof Johansson <olof@lixom.net>

Chris, this warniong is staring at me from my inbox every morning.
Would you mind picking it up for 3.11?


Thanks!

-Olof
