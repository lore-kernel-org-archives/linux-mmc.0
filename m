From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: Do not break platform data boards
Date: Fri, 8 May 2015 08:55:29 -0300
Message-ID: <CAOMZO5DpF7JbdoEMRLRpOWR15gE2ZNcWBcc+tHwv3Gy0Z_Eypw@mail.gmail.com>
References: <1431064569-5947-1-git-send-email-festevam@gmail.com>
	<1431064569-5947-2-git-send-email-festevam@gmail.com>
	<CAPDyKFr=y6Wjssv4K9ri281Su1ivY3DHwkMxJjFa-HoEOoWQ8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:34312 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbEHLza (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 07:55:30 -0400
Received: by laat2 with SMTP id t2so50924583laa.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2015 04:55:29 -0700 (PDT)
In-Reply-To: <CAPDyKFr=y6Wjssv4K9ri281Su1ivY3DHwkMxJjFa-HoEOoWQ8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

Hi Ulf,

On Fri, May 8, 2015 at 8:46 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>>         /* card_detect */
>> -       if (boarddata->cd_type == ESDHC_CD_CONTROLLER)
>> +       switch (boarddata->cd_type) {
>
> I don't think you want to do this "switch" for dt case, right?

dt case needs the switch in order not to break the users of the
"fsl,cd-controller" property.

Actually, I don't see any dts file really using it, but since it is
documented in Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt,
then we need to keep supporting it.

Regards,

Fabio Estevam
