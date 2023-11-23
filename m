Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgPEgfot"
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7569D65
	for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:19:17 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5cc86fcea4fso9504547b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759957; x=1701364757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWk/RgHbKOlFY39aGIpjm5vZs/TIaAEJUzezOamB9tA=;
        b=lgPEgfotXMvzK8cXSTLkl0svVRTVi/N2fmGN8N79B3nF4j50ZyNhAAxX2ryP9x/MtQ
         v6gn9RCMR+hbA++nj3XzDwaVj7vI9qLrT+Qq/4JimW4u09V6+sDF0qVsk59LB7P/3emP
         9e5yR1WePuJLUiqVD0fqMbE4oMpsA8W88XxvdsrS2cMelUZT0IvEY+ayajr7AlS6j4SB
         +TZRUSOfO0xPAvxdK+vdDWUTtJN0D0yYZOnAuypa1bqPvXzzitD1A/2yvO/sR+WcGf8Q
         LGh2CX5/7MBomZOvWVx3LQHnH3DVLVuTymicPoCTPhm5f8+PzRNILyWSW6H+TXNdmVs+
         k1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759957; x=1701364757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWk/RgHbKOlFY39aGIpjm5vZs/TIaAEJUzezOamB9tA=;
        b=d7GRiz7/B3Iz7jqGlyzs1vmSFJYBjd5hCRvbLoXllFrRa9yu4Ke7qzrGdXyw9atzZz
         pGseJBQHtZiFMz+F1zZauDFjdL0BF1wWhSDfwf8HRiuPl+u7+FwqZbyKpqB3vOwuwJUB
         QOlJdrQhV22D1+Hp3y8yLWBKevPQGHguGysmbK1/RAvq2y7TcSjJ2SznOo3FWO9DiUx+
         LPhT6ie2ffLcyosoz3UwY33v0wSsRk6PDC5Hz73tORHWzu+Tq4rFNukBbgBb/3A6Qge6
         kxjN96//sqqkEOlmwN0TBIW4s9mbdQshzq+Iso8mAdFtLvGmVp7KoF5KJWND4gfH6PA7
         Hc4g==
X-Gm-Message-State: AOJu0YzwRoUE+IIhHFoz4hcjlm9z8k0gYCjKFvA/xpim7g3n+/sn8Qd1
	ebaYSU7W8DPfgESHH6HWuxTYoQlarQ4smA90Rdt17Q==
X-Google-Smtp-Source: AGHT+IFwyFMR/NrdcChscDcLqQ70TVmEfxpocrRkYan5zonKuyVIeZHKpaW0fvUM00WVfJdfUBy1f7OPfUyE579mt2A=
X-Received: by 2002:a0d:f986:0:b0:5c5:d898:e476 with SMTP id
 j128-20020a0df986000000b005c5d898e476mr17348ywf.33.1700759956922; Thu, 23 Nov
 2023 09:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122060215.2074799-1-vigneshr@ti.com>
In-Reply-To: <20231122060215.2074799-1-vigneshr@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 18:18:41 +0100
Message-ID: <CAPDyKFrsXSwyU-VsPEt1tYCPWk99XaNZ7kJGGWPEDEYBWaPktg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Drop lookup for deprecated ti,otap-del-sel
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 07:05, Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> ti,otap-del-sel has been deprecated since v5.7 and there are no users of
> this property and no documentation in the DT bindings either.
> Drop the fallback code looking for this property, this makes
> sdhci_am654_get_otap_delay() much easier to read as all the TAP values
> can be handled via a single iterator loop.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2:
> * Drop legacy_otapdly as pointed out by Adrian
>
> v1: https://lore.kernel.org/r/20231110072535.2695134-1-vigneshr@ti.com
>
>  drivers/mmc/host/sdhci_am654.c | 37 ++++++----------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 967bd2dfcda1..d659c59422e1 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -141,7 +141,6 @@ static const struct timing_data td[] = {
>
>  struct sdhci_am654_data {
>         struct regmap *base;
> -       bool legacy_otapdly;
>         int otap_del_sel[ARRAY_SIZE(td)];
>         int itap_del_sel[ARRAY_SIZE(td)];
>         int clkbuf_sel;
> @@ -272,11 +271,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_set_clock(host, clock);
>
>         /* Setup DLL Output TAP delay */
> -       if (sdhci_am654->legacy_otapdly)
> -               otap_del_sel = sdhci_am654->otap_del_sel[0];
> -       else
> -               otap_del_sel = sdhci_am654->otap_del_sel[timing];
> -
> +       otap_del_sel = sdhci_am654->otap_del_sel[timing];
>         otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
>
>         mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> @@ -314,10 +309,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>         u32 mask, val;
>
>         /* Setup DLL Output TAP delay */
> -       if (sdhci_am654->legacy_otapdly)
> -               otap_del_sel = sdhci_am654->otap_del_sel[0];
> -       else
> -               otap_del_sel = sdhci_am654->otap_del_sel[timing];
> +       otap_del_sel = sdhci_am654->otap_del_sel[timing];
>
>         mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
>         val = (0x1 << OTAPDLYENA_SHIFT) |
> @@ -577,32 +569,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>         int i;
>         int ret;
>
> -       ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
> -                                &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
> -       if (ret) {
> -               /*
> -                * ti,otap-del-sel-legacy is mandatory, look for old binding
> -                * if not found.
> -                */
> -               ret = device_property_read_u32(dev, "ti,otap-del-sel",
> -                                              &sdhci_am654->otap_del_sel[0]);
> -               if (ret) {
> -                       dev_err(dev, "Couldn't find otap-del-sel\n");
> -
> -                       return ret;
> -               }
> -
> -               dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
> -               sdhci_am654->legacy_otapdly = true;
> -
> -               return 0;
> -       }
> -
>         for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>
>                 ret = device_property_read_u32(dev, td[i].otap_binding,
>                                                &sdhci_am654->otap_del_sel[i]);
>                 if (ret) {
> +                       if (i == MMC_TIMING_LEGACY) {
> +                               dev_err(dev, "Couldn't find mandatory ti,otap-del-sel-legacy\n");
> +                               return ret;
> +                       }
>                         dev_dbg(dev, "Couldn't find %s\n",
>                                 td[i].otap_binding);
>                         /*
> --
> 2.42.0
>
