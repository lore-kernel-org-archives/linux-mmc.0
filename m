From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/3] davinci_mmc fixes
Date: Wed, 6 Apr 2016 10:32:54 +0200
Message-ID: <CAPDyKFrAWu7hYY_Jwpm5qWz=b=cvDrFwMFedhZHRWCwP-EtJsw@mail.gmail.com>
References: <1459877512-25479-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33918 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760042AbcDFIc5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2016 04:32:57 -0400
Received: by mail-wm0-f52.google.com with SMTP id l6so54457435wml.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2016 01:32:56 -0700 (PDT)
In-Reply-To: <1459877512-25479-1-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 5 April 2016 at 19:31, David Lechner <david@lechnology.com> wrote:
> This fixes a compiler warning in the "fix unwinding in probe" patch where ret
> was used uninitalized.
>
> David Lechner (3):
>   mmc: davinci: fix unwinding in probe
>   mmc: davinci: prepare clock
>   ARM: davinci: remove mmc dma resources
>
>  arch/arm/mach-davinci/devices-da8xx.c |  20 -------
>  arch/arm/mach-davinci/devices.c       |  16 ------
>  drivers/mmc/host/davinci_mmc.c        | 100 ++++++++++++++--------------------
>  3 files changed, 40 insertions(+), 96 deletions(-)
>
> --
> 1.9.1
>

Thanks, applied for next!

Kind regards
Uffe
