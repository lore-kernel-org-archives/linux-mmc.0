From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc:sdhci: handle busy-end interrupt during command
Date: Thu, 21 Aug 2014 09:26:54 +0200
Message-ID: <CAPDyKFoeONs8OXZ3=2ZT54Nfdq_dLqgatMcq2DyZ=rs1r0x+dg@mail.gmail.com>
References: <1408585989-1084-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:39569 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbaHUH0z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Aug 2014 03:26:55 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so8638015qge.30
        for <linux-mmc@vger.kernel.org>; Thu, 21 Aug 2014 00:26:55 -0700 (PDT)
In-Reply-To: <1408585989-1084-1-git-send-email-chanho.min@lge.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hankyung Yu <hankyung.yu@lge.com>, Gwendal Grignou <gwendal@chromium.org>

On 21 August 2014 03:53, Chanho Min <chanho.min@lge.com> wrote:
> It is fully legal for a controller to start handling busy-end interrupt
> before it has signaled that the command has completed. So make sure
> we do things in the proper order, Or it results that command interrupt
> is ignored so it can cause unexpected operations. This is founded at some
> toshiba emmc with the bellow warning.
>
> "mmc0: Got command interrupt 0x00000001 even though
> no command operation was in progress."
>
> This issue has been also reported by Youssef TRIKI:
> It is not specific to Toshiba devices, and happens with eMMC devices
> as well as SD card which support Auto-CMD12 rather than CMD23.
>
> Also, similar patch is submitted by:
> Gwendal Grignou <gwendal@chromium.org>
>
> Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Tested-by: Youssef TRIKI <youssef.triki@st.com>

Hi Chanho,

This patch has been around for quite some time, sorry for lack of
response. Appreciate if we could get this tested on a few more
variants of sdhci, I am not able to test myself.

I plan to queue this for 3.18, unless someone objects soon.

Kind regards
Uffe
