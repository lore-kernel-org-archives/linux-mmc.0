From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: Do not break platform data boards
Date: Sat, 9 May 2015 14:49:44 +0200
Message-ID: <CAPDyKFprE5mop9Lt7cQz+_JeMjbxMTNs7WqXukZrir3u1g4Ftw@mail.gmail.com>
References: <1431064569-5947-1-git-send-email-festevam@gmail.com>
	<1431064569-5947-2-git-send-email-festevam@gmail.com>
	<CAPDyKFr=y6Wjssv4K9ri281Su1ivY3DHwkMxJjFa-HoEOoWQ8w@mail.gmail.com>
	<CAOMZO5DpF7JbdoEMRLRpOWR15gE2ZNcWBcc+tHwv3Gy0Z_Eypw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35825 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbbEIMtp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 May 2015 08:49:45 -0400
Received: by qkhg7 with SMTP id g7so63690533qkh.2
        for <linux-mmc@vger.kernel.org>; Sat, 09 May 2015 05:49:45 -0700 (PDT)
In-Reply-To: <CAOMZO5DpF7JbdoEMRLRpOWR15gE2ZNcWBcc+tHwv3Gy0Z_Eypw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 8 May 2015 at 13:55, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Ulf,
>
> On Fri, May 8, 2015 at 8:46 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>>>         /* card_detect */
>>> -       if (boarddata->cd_type == ESDHC_CD_CONTROLLER)
>>> +       switch (boarddata->cd_type) {
>>
>> I don't think you want to do this "switch" for dt case, right?
>
> dt case needs the switch in order not to break the users of the
> "fsl,cd-controller" property.
>
> Actually, I don't see any dts file really using it, but since it is
> documented in Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt,
> then we need to keep supporting it.

Okay. Perhaps the commit message could inform us about that as well?

Kind regards
Uffe
