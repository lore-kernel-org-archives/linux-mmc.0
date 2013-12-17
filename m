From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: sdhci-esdhc-imx - power management supported
Date: Tue, 17 Dec 2013 14:51:55 +0800
Message-ID: <CAA+hA=Tz6QOa9grNzS35F_Vs9PoqcgUMSji6F7ABVwr9uX2qfQ@mail.gmail.com>
References: <CACUGKYNj3hBaDfzO7o2VuoFLCvQZdutFV=Q5QrzLcBF8Y2cfRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:55781 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab3LQGvz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 01:51:55 -0500
Received: by mail-qa0-f43.google.com with SMTP id ii20so2325957qab.9
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2013 22:51:55 -0800 (PST)
In-Reply-To: <CACUGKYNj3hBaDfzO7o2VuoFLCvQZdutFV=Q5QrzLcBF8Y2cfRQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi John,

On Tue, Dec 17, 2013 at 3:11 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Dong,
>
> I saw your sdhci-esdhc-imx driver supported the power management. I am
> assuming you have a working power management on your kernel. I would
> like to know which kernel has a working power management for iMX6?.
>

Chris' tree already has imx rpm patches for uSDHC.
git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
You can refer to it.

Regards
Dong Aisheng

> Regards,
>
> john
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
