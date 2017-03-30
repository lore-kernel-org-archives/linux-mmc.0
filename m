From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci: Disable runtime pm when the sdio_irq is enabled
Date: Thu, 30 Mar 2017 21:30:21 +0200
Message-ID: <CAPDyKFqmvtFv98aKw02daANtRxq1Mij9SRTr_JCysgN4cG6-4A@mail.gmail.com>
References: <20170326111445.1316-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34360 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934688AbdC3Ta2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:30:28 -0400
Received: by mail-vk0-f46.google.com with SMTP id z204so67219230vkd.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:30:27 -0700 (PDT)
In-Reply-To: <20170326111445.1316-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Dong Aisheng <b29396@freescale.com>, Ian W MORRISON <ianwmorrison@gmail.com>, Daniel Drake <drake@endlessm.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, "# 4.0+" <stable@vger.kernel.org>

+Daniel, Jo=C3=A3o, stable

On 26 March 2017 at 13:14, Hans de Goede <hdegoede@redhat.com> wrote:
> SDIO cards may need clock to send the card interrupt to the host.
>
> On a cherrytrail tablet with a RTL8723BS wifi chip, without this patch
> pinging the tablet results in:
>
> PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
> 64 bytes from 192.168.1.14: icmp_seq=3D1 ttl=3D64 time=3D78.6 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D2 ttl=3D64 time=3D1760 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D3 ttl=3D64 time=3D753 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D4 ttl=3D64 time=3D3.88 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D5 ttl=3D64 time=3D795 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D6 ttl=3D64 time=3D1841 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D7 ttl=3D64 time=3D810 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D8 ttl=3D64 time=3D1860 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D9 ttl=3D64 time=3D812 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D10 ttl=3D64 time=3D48.6 ms
>
> Where as with this patch I get:
>
> PING 192.168.1.14 (192.168.1.14) 56(84) bytes of data.
> 64 bytes from 192.168.1.14: icmp_seq=3D1 ttl=3D64 time=3D3.96 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D2 ttl=3D64 time=3D1.97 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D3 ttl=3D64 time=3D17.2 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D4 ttl=3D64 time=3D2.46 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D5 ttl=3D64 time=3D2.83 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D6 ttl=3D64 time=3D1.40 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D7 ttl=3D64 time=3D2.10 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D8 ttl=3D64 time=3D1.40 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D9 ttl=3D64 time=3D2.04 ms
> 64 bytes from 192.168.1.14: icmp_seq=3D10 ttl=3D64 time=3D1.40 ms
>
> Cc: Dong Aisheng <b29396@freescale.com>
> Cc: Ian W MORRISON <ianwmorrison@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This issue have been around for a while. I am adding a stable tag.

Thanks, applied for fixes!

Kind regards
Uffe

> ---
> Changes in v2:
> -New patch replacing "mmc: sdhci: sdio-intel: Set
>  SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk"
> Changes in v3:
> -Always get / put the runtime pm-ref instead of using a quirk, as (almost=
)
>  all sdhci controllers need this
> -Use pm_runtime_get_noresume / pm_runtime_put_noidle as the caller must
>  already have claimed the mmc-host so we will already be runtime-resumed
>  when called
> ---
>  drivers/mmc/host/sdhci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9c1a099..63bc33a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1830,6 +1830,9 @@ static void sdhci_enable_sdio_irq(struct mmc_host *=
mmc, int enable)
>         struct sdhci_host *host =3D mmc_priv(mmc);
>         unsigned long flags;
>
> +       if (enable)
> +               pm_runtime_get_noresume(host->mmc->parent);
> +
>         spin_lock_irqsave(&host->lock, flags);
>         if (enable)
>                 host->flags |=3D SDHCI_SDIO_IRQ_ENABLED;
> @@ -1838,6 +1841,9 @@ static void sdhci_enable_sdio_irq(struct mmc_host *=
mmc, int enable)
>
>         sdhci_enable_sdio_irq_nolock(host, enable);
>         spin_unlock_irqrestore(&host->lock, flags);
> +
> +       if (!enable)
> +               pm_runtime_put_noidle(host->mmc->parent);
>  }
>
>  static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> --
> 2.9.3
>
