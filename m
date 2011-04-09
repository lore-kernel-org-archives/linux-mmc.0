From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci: add error checking for mmc_add_host
Date: Sat, 9 Apr 2011 20:49:44 +0900
Message-ID: <BANLkTi=N6ZzsqRfEe_kX6=JuF_0Fry1Ybw@mail.gmail.com>
References: <4D9ACC8B.8070407@samsung.com>
	<20110408183157.GA23883@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50163 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1DILtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Apr 2011 07:49:46 -0400
Received: by bwz15 with SMTP id 15so3437377bwz.19
        for <linux-mmc@vger.kernel.org>; Sat, 09 Apr 2011 04:49:45 -0700 (PDT)
In-Reply-To: <20110408183157.GA23883@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Wolfram..

2011/4/9 Wolfram Sang <w.sang@pengutronix.de>:
> Hi,
>
> On Tue, Apr 05, 2011 at 05:02:19PM +0900, Jaehoon Chung wrote:
>> Sometimes we can't add the device,but we didn't check any error stat=
us.
>> Need to check error status for mmc_add_host.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungin Park <kyungmin.park@samsung.com>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 20 ++++++++++++++++++--
>> =A01 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 9e15f41..1768ffb 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2025,7 +2025,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>
>> =A0 =A0 =A0 mmiowb();
>>
>> - =A0 =A0 mmc_add_host(mmc);
>> + =A0 =A0 ret =3D mmc_add_host(mmc);
>> + =A0 =A0 if (unlikely(ret))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mmc;
>>
>> =A0 =A0 =A0 printk(KERN_INFO "%s: SDHCI controller on %s [%s] using =
%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(mmc), host->hw_name, dev_na=
me(mmc_dev(mmc)),
>> @@ -2036,15 +2038,29 @@ int sdhci_add_host(struct sdhci_host *host)
>>
>> =A0 =A0 =A0 return 0;
>>
>> +err_free_mmc:
>> + =A0 =A0 mmc_remove_host(host);
>
> As I asked in my last review: Why do you remove the host when add_hos=
t failed?
> Doesn't that crash?
>
>> +
>> =A0#ifdef SDHCI_USE_LEDS_CLASS
>> + =A0 =A0 led_classdev_ungregister(&host->led);
>> =A0reset:
>> +#endif
>> =A0 =A0 =A0 sdhci_reset(host, SDHCI_RESET_ALL);
>> =A0 =A0 =A0 free_irq(host->irq, host);
>> -#endif
>> + =A0 =A0 del_timer_sync(&host->timer);
>> +
>> =A0untasklet:
>> =A0 =A0 =A0 tasklet_kill(&host->card_tasklet);
>> =A0 =A0 =A0 tasklet_kill(&host->finish_tasklet);
>>
>> + =A0 =A0 if (host->flags & SDHCI_USE_ADMA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(host->adma_desc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(host->align_buffer);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->adma_desc =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->align_buffer =3D NULL;
>> + =A0 =A0 }
>
> The if-condition is not needed, kfree is NULL-safe.

I'll remove that..Thanks for your reviewed

Regards,
Jaehoon Chung

>
>> +
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Wolfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAk2fVJ0ACgkQD27XaX1/VRsZFwCgsgZ567Z5EP981NF4/cEXG9z/
> HvAAoMFOud43MnfeKNDX2/HCBKBdVnJu
> =3DRTub
> -----END PGP SIGNATURE-----
>
>
