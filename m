From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 6/9] omap: hsmmc: remove unused variable
Date: Wed, 11 Aug 2010 13:08:28 +0300
Message-ID: <AANLkTi=bB++-VU88JQTicJeYf==9qccx0HMDiz5-geyg@mail.gmail.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
	<1281478348-24833-7-git-send-email-ohad@wizery.com> <4C627378.2090304@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:57949 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827Ab0HKKIt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2010 06:08:49 -0400
In-Reply-To: <4C627378.2090304@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, San Mehat <san@google.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, Tony Lindgren <tony@atomide.com>, Nicolas Pitre <nico@fluxnic.net>, Pandita Vikram <vikram.pandita@ti.com>, Kalle Valo <kalle.valo@iki.fi>

On Wed, Aug 11, 2010 at 12:55 PM, Adrian Hunter <adrian.hunter@nokia.co=
m> wrote:
> Ohad Ben-Cohen wrote:
>>
>> Make this go away:
>>
>> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_suspend':
>> drivers/mmc/host/omap_hsmmc.c:2328: warning: unused variable 'state'
>
> Was done a while ago.

Are you sure ?

I can still see the unused state variable in Linus' tree:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3Ddrivers/mmc/host/omap_hsmmc.c;h=3Db032828c61263028963bd412a745=
5546d5e86ce7;hb=3DHEAD#l2275


> See 1a13f8fa76c880be41d6b1e6a2b44404bcbfdf9e in linus' tree.

This commit only seem to adapt to the API change (the state variable
is not removed):

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index d25b19b..b032828 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2292,7 +2292,7 @@ static int omap_hsmmc_suspend(struct device *dev)
                }
                cancel_work_sync(&host->mmc_carddetect_work);
                mmc_host_enable(host->mmc);
-               ret =3D mmc_suspend_host(host->mmc, state);
+               ret =3D mmc_suspend_host(host->mmc);
                if (ret =3D=3D 0) {
                        omap_hsmmc_disable_irq(host);
                        OMAP_HSMMC_WRITE(host->base, HCTL,

>
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A01 -
>> =A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index b032828..d50e917 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -2272,7 +2272,6 @@ static int omap_hsmmc_suspend(struct device *d=
ev)
>> =A0 =A0 =A0 =A0int ret =3D 0;
>> =A0 =A0 =A0 =A0struct platform_device *pdev =3D to_platform_device(d=
ev);
>> =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D platform_get_drvdata=
(pdev);
>> - =A0 =A0 =A0 pm_message_t state =3D PMSG_SUSPEND; /* unused by MMC =
core */
>> =A0 =A0 =A0 =A0if (host && host->suspended)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
>
