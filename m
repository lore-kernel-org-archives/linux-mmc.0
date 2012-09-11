From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: dt: Support "power-gpios" property
Date: Tue, 11 Sep 2012 13:00:27 +0800
Message-ID: <CAMj5Bkji+WV0dx7vuC8OxprbW0TAOWBsCUimmr5r9iiXAEVw_A@mail.gmail.com>
References: <87ligjzyge.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45362 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab2IKFA3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Sep 2012 01:00:29 -0400
Received: by wibhi8 with SMTP id hi8so3226178wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Sep 2012 22:00:28 -0700 (PDT)
In-Reply-To: <87ligjzyge.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Sun, Sep 9, 2012 at 11:06 AM, Chris Ball <cjb@laptop.org> wrote:
> Tested on OLPC XO-4/MMP3, where the card power for two of the
> controllers is a sideband GPIO.  The third cell in the power-gpios
> property controls whether the GPIO is active high/active low.
>
> (Also, pass host_caps2 through from platdata to the mmc host.)
>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> This patch depends on "mmc: slot-gpio: Add support for power gpios"
>
>  drivers/mmc/host/sdhci-pxav3.c          | 25 +++++++++++++++++++++++++
>  include/linux/platform_data/pxa_sdhci.h |  2 ++
>  2 files changed, 27 insertions(+)

Thanks Chris.
One questions is could we simply use fixed voltage regulator to control gpio?
And register this gpio as vmmc.

Thanks
