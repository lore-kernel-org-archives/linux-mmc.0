From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 3/3] MMC: OMAP: HSMMC: Remove unused iclk
Date: Mon, 27 Jun 2011 20:11:05 +0530
Message-ID: <BANLkTimaPkN-ybtEmk4F=YPzsxm5xbGj5A@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-4-git-send-email-balajitk@ti.com>
	<4E0217F9.9070105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:45996 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994Ab1F0OlR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Jun 2011 10:41:17 -0400
In-Reply-To: <4E0217F9.9070105@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On Wed, Jun 22, 2011 at 9:57 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> On 6/22/2011 4:18 PM, Krishnamoorthy, Balaji T wrote:
>>
>> After runtime conversion to handle clk,
>> iclk node is not used
>> However fclk node is still used to get clock rate.
>>
>> Signed-off-by: Balaji T K<balajitk@ti.com>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 10 ----------
>> =A01 files changed, 0 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 5b81d8b..afcca36 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -145,7 +145,6 @@ struct omap_hsmmc_host {
>> =A0 =A0 =A0 =A0struct =A0mmc_command =A0 =A0 *cmd;
>> =A0 =A0 =A0 =A0struct =A0mmc_data =A0 =A0 =A0 =A0*data;
>> =A0 =A0 =A0 =A0struct =A0clk =A0 =A0 =A0 =A0 =A0 =A0 *fclk;
>> - =A0 =A0 =A0 struct =A0clk =A0 =A0 =A0 =A0 =A0 =A0 *iclk;
>> =A0 =A0 =A0 =A0struct =A0clk =A0 =A0 =A0 =A0 =A0 =A0 *dbclk;
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * vcc =3D=3D configured supply
>> @@ -1855,17 +1854,10 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>>
>> =A0 =A0 =A0 =A0spin_lock_init(&host->irq_lock);
>>
>> - =A0 =A0 =A0 host->iclk =3D clk_get(&pdev->dev, "ick");
>> - =A0 =A0 =A0 if (IS_ERR(host->iclk)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(host->iclk);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->iclk =3D NULL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;
>> - =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0host->fclk =3D clk_get(&pdev->dev, "fck");
>> =A0 =A0 =A0 =A0if (IS_ERR(host->fclk)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D PTR_ERR(host->fclk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->fclk =3D NULL;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->iclk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err1;
>> =A0 =A0 =A0 =A0}
>>
>> @@ -2025,7 +2017,6 @@ err_irq:
>> =A0 =A0 =A0 =A0pm_runtime_mark_last_busy(host->dev);
>> =A0 =A0 =A0 =A0pm_runtime_put_autosuspend(host->dev);
>> =A0 =A0 =A0 =A0clk_put(host->fclk);
>
> Since you just have to use the clk_get_rate, you can remove as well a=
ll the
> clock related functions for the fck node: clk_put / clk_enable...

clk_enable is removed, but would prefer to keep clk_put for balancing c=
lk_get

>
>> - =A0 =A0 =A0 clk_put(host->iclk);
>> =A0 =A0 =A0 =A0if (host->got_dbclk) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable(host->dbclk);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(host->dbclk);
>> @@ -2062,7 +2053,6 @@ static int omap_hsmmc_remove(struct platform_d=
evice
>> *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_forbid(host->dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pm_runtime_disable(host->dev);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(host->fclk);
>
> Here as well.
>
> Regards,
> Benoit
>
