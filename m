From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc-imx: Use pinctrl PM helpers
Date: Tue, 16 Jun 2015 11:49:49 +0200
Message-ID: <CAJ=nTssf_KA5yY86sg-JvGndonR5655=7TeV9uAVrwkLATTmgg@mail.gmail.com>
References: <1434101473-4109-1-git-send-email-mirza.krak@hostmobility.com>
	<CAPDyKFoqAV4fW=V56vvPh5-9=w+0Di8VzTBNRmpF_2ETp_pHNA@mail.gmail.com>
	<CAJ=nTsvT-0UZTRhGrRvqG0Gp5yhPVhUWzMtupXrXVxnwwhfS=Q@mail.gmail.com>
	<f668b0c77c6e297bd4b89cbb74dcb15e@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35815 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbbFPJtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2015 05:49:51 -0400
Received: by lbbwc1 with SMTP id wc1so7197999lbb.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2015 02:49:49 -0700 (PDT)
In-Reply-To: <f668b0c77c6e297bd4b89cbb74dcb15e@agner.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

2015-06-16 11:05 GMT+02:00 Stefan Agner <stefan@agner.ch>:
> The pltfm_suspend/resume functions have been used since quite some ti=
me.
> However, the Toradex branch carries a patch which introduces local
> suspend/resume functions to work around a system PM vs. runtime PM
> suspend issue.

Hence my confusion :).

> > I am thinking sdhci_suspend_host would be good location, but then t=
he
> > change will effect a lot more drivers. Maybe a good thing?
>
> I guess most device trees don't have a specific idle/sleep state
> specification, how does the pinctrl API act in this situation?

pinctrl API can handle if states are not defined. Also the API calls
are considered successful when successfully set state or if no state
definition is present.

Undefined states are set to ERR_PTR(-ENODEV)

and in the API calls there is a

if (IS_ERR(state))
    return 0; /* No such state */

>
> FWIW, the Vybrid SoC is not able to control pins during LPSTOP suspen=
d,
> hence configuring the sleep mode explicitly for system PM is not very
> useful on that platform. However, for runtime PM it coud still be
> valuable I guess.

I was testing the "standby" state and noticed unwanted states on some
pins and hence this patch :). Good to know about LPSTOP.

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
