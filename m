From: Tony Lindgren <tony@atomide.com>
Subject: Re: randconfig build error with next-20150529, in
 drivers/mmc/host/omap_hsmmc.c
Date: Fri, 29 May 2015 09:44:35 -0700
Message-ID: <20150529164434.GQ30984@atomide.com>
References: <CA+r1Zhj3epGqV_Po0X-Q2hROKpG=a8L2R=D+5qdZTAptWtP3HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:54672 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbbE2Qoh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 May 2015 12:44:37 -0400
Content-Disposition: inline
In-Reply-To: <CA+r1Zhj3epGqV_Po0X-Q2hROKpG=a8L2R=D+5qdZTAptWtP3HQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

* Jim Davis <jim.epost@gmail.com> [150529 09:27]:
> Building with the attached random configuration file,
>=20
> warning: (USB_OTG_FSM && FSL_USB2_OTG && USB_MV_OTG) selects USB_OTG
> which has unmet direct dependencies (USB_SUPPORT && USB && PM)
>=20
> drivers/mmc/host/omap_hsmmc.c: In function =E2=80=98omap_hsmmc_config=
ure_wake_irq=E2=80=99:
> drivers/mmc/host/omap_hsmmc.c:1663:8: error: implicit declaration of
> function =E2=80=98dev_pm_set_dedicated_wake_irq=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>   ret =3D dev_pm_set_dedicated_wake_irq(host->dev, host->wake_irq);

Oops, there's a typo in the prototype. I must have only tested
dev_pm_set_wake_irq case and not the dev_pm_set_dedicated_wake_irq
on x86. Patch coming shortly.

Regards,

Tony
