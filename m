From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 04/13] mmc: mxs-mmc: Let device core handle pinctrl
Date: Sun, 26 May 2013 18:01:17 -0300
Message-ID: <CAOMZO5BmvsnNPCxv6shNQsVg3cJcdPxQrMJzZz3fyBGKPOYF_A@mail.gmail.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
	<1367863561-11534-4-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:38226 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab3EZVBR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 May 2013 17:01:17 -0400
Received: by mail-vc0-f169.google.com with SMTP id kw10so4378661vcb.28
        for <linux-mmc@vger.kernel.org>; Sun, 26 May 2013 14:01:17 -0700 (PDT)
In-Reply-To: <1367863561-11534-4-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, Fabio Estevam <fabio.estevam@freescale.com>
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org

Hi Chris,

On Mon, May 6, 2013 at 3:05 PM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for handling pinctrl.
>
> So remove devm_pinctrl_get_select_default() from the driver.
>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Any comments on this one?
