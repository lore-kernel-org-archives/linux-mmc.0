From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: SDIO bus hang on BayTrail machines
Date: Wed, 11 Jan 2017 16:42:16 +0100
Message-ID: <CAPDyKFrO4ajLw=TDsMa==fL_Q6BYxoO_x1OFODB7+oMJdJCr3w@mail.gmail.com>
References: <CA+A7VXXmA1KGjPfnUmZPBKDXmUMYhjLeXbo=8Ho3CrCvt7rjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:34135 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761512AbdAKPmT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 10:42:19 -0500
Received: by mail-wj0-f179.google.com with SMTP id tn15so105552887wjb.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 07:42:18 -0800 (PST)
In-Reply-To: <CA+A7VXXmA1KGjPfnUmZPBKDXmUMYhjLeXbo=8Ho3CrCvt7rjbA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux@endlessm.com

On 12 December 2016 at 23:55, Jo=C3=A3o Paulo Rechi Vita <jprvita@gmail.com=
> wrote:
> Hello Dong Adrian and Ulf,
>
> I'm working on enabling a BayTrail-based machine with very similar
> hardware to one of the Intel Compute sticks, which is an Intel
> BayTrail and has a RTL8723BS WiFi card on the SDIO bus. I'm using
> Linux 4.8 with the driver from https://github.com/hadess/rtl8723bs,
> and I was experiencing a complete machine hang when using the WiFi
> card. Passing `intel_idle.max_cstate=3D1` together with the following
> patch (with the sdhci_runtime_pm_get and sdhci_runtime_pm_put
> implementations added back) makes the problem go away:
> https://github.com/hadess/rtl8723bs/blob/master/patches_4.5/0002-mmc-sdhc=
i-get-runtime-pm-when-sdio-irq-is-enabled.patch

It's been a while ago and I wasn't able to dig out some information
from earlier discussions/submissions.

>
> I could not find much information on why this was never sent upstream,
> and would like to know if this approach would be acceptable, or if
> there are any other better alternatives to solve this problem. I'm not
> a runtime PM expert, but as I understand this keeps the device powered
> on as long as interrupts are enabled, potentially increasing the power
> consumption. As this kernel has to run several different machines
> using the same code base and config, I would rather avoid something
> that could have a negative impact on other platforms.

Unless the board/soc supports an option to re-configure the SDIO IRQ
as wakeup when entering runtime suspend state, there is no other way
but to keep the device runtime resumed.

For this specific case, I have seen two different solutions for how to
allow the device to be runtime suspended when using SDIO IRQ.
1) Re-routing the SDIO IRQ DAT line as a GPIO IRQ at runtime suspend,
thus a wakeup becomes enabled.
2) Using a completely separate line for SDIO IRQs and thus not a DAT
line, configured as a GPIO IRQ.

>
> Any ideas appreciated, and I'm happy to try a newer tree if you guys
> think some other commit might have fixed the problem.

I think the best option right now, is something very similar to the
patch you point to at github above.

Kind regards
Uffe
