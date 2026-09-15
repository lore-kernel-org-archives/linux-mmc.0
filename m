Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508DB3B05B9
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471920; cv=pass; b=o8imu/xtU4SWwZTI/G4YjC6bduvrj3kuEDAY/syWHnA9zEoilX+jg/4IpCOp2mKbO/FrQdwOdQnXgd8W4cKcpwqrgxHU7fSCsUdOUh4GQu94CyoQab1l3bMb336xpoUFYZMQNVHRVdDH5QxaaUN6loLLI8NLU22UNfn3/woPgwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471920; c=relaxed/simple;
	bh=7NSvUJb+Kkse49Pbvizg9LMzUde+FsfN4VtU0EWT8Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paOswGRWkOIU9IhXZsA8Gq6AVt17ZzvPT7n0bpAcdt0pbTeD/vCrPU1E3uPGB550Zdpx51YNw23L02qaAJ9gjn1aHCYZDDkWWipApdsK71yJAZYi3oIp4158kUzGyT0mfy6Jlt/DwxFmXtYUDoQsmgx8/OlRq0bHURQo1vCzTNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=UbMUTwnA; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="UbMUTwnA"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f0b25dso1288125ad.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 04:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789471918; cv=none;
        d=google.com; s=arc-20260327;
        b=AvjIPt5LJt+U62Wl2xobe/D+H7eOWiJPiwlSlFf96hR8jr4pZjw53ubGyf2xoDBA9A
         RCSbu5tKt4CkJlTo+DsBQz4KG+FUR59I56+pHgvmMiZSUwIaoxv38OUhiH1s0CBag+RC
         XKLqp4vqwiQgV4DPeDca/OMtSEdAf+wgJ5EoaiR4M3agdu3KwUnqDwDODFesLcASU2Za
         5+FMSgU67VKPgvd+YG3LfBX8NnoW8eYVoB+lbs0o9I7Am/x5pxj1s0suA4oZM98xWp2S
         lQu2TR6ajcK+jmopKz1Q5/DEGIfCNHvbCqJHLU1YIsEF6d/3RutSlWALe+8UKFivKGyu
         K1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZWWxIYlBWABZ3GjM6t1BqbZ6aeOgozwkp5h4xrnqvNE=;
        fh=DSe10cWpqK2DMY2mqFVVuI+N9AFCQp1Ezc7HNqV2U+o=;
        b=ELKnzQuo/9p+gQdx6boNhJSlS9hxCoBxwQllUguj2I6BfaazYfYKqRGEIynbOqkcL4
         StQkmWFYiILis+K4pBHiZ3DKC4iKc5XdPTBiWOKyOvV6lIWWyrpvTmtbzCy00GMFy6PM
         Y2FEFwX0i5ajqalHT28Xoj/aVSKjfSVHhvLjz30S/NBwEPaZ7LlyiY0H9LoFrC8UnHir
         8Do9wvb8sKqCnRkCM6MssJwXsPB82i2wrZ6heWd1vxsWKihzPjxEI2pP4KS8ThcqnQWX
         IhHacUU+NTXAM9sWnPPG+zbzdh2ZmDi+n3R4/BZKZHIt7YIlipKINh7UCko4iuKTKHh0
         5AjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1789471918; x=1790076718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZWWxIYlBWABZ3GjM6t1BqbZ6aeOgozwkp5h4xrnqvNE=;
        b=UbMUTwnAjvW63PekRfDe+YrHlOXG/WpHXBH9RsoXyln8a/cr65Ni1KUnKejMtD5kNq
         QDSQ9meR8Blg7pOhoGk/l020BbHFjjtLJZnbrmV8tZFLnzyjrlPe0OKESm1mHrdkV+tn
         Cw1EjT9LoNC1DbDJznoWPm9I4M45u4o1afWjx+LFpx+m8IvxHIoEtcc9PIOaSx7TXJRv
         5B0v+WNJrvEzfcoWP3YpCIP36N7xVGpPi9J+VwFlhIJaqTlJwXgFzY+sHnH6V38aZEKa
         fouJYkI7p2m18RSCb2x+D9qYS40Zt0FAQdQWN7FEy1nIuCHvoKPhhB3OZC9nTtdxyEOv
         3a4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471918; x=1790076718;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZWWxIYlBWABZ3GjM6t1BqbZ6aeOgozwkp5h4xrnqvNE=;
        b=EofR36XOr9cX1o3T9usYj2zkHPsbAfuzLOfcLjmd8kufo0WBepcWfVJnTivKydkW6/
         z/wL8u2SPF3wDpEE/gTtEf+nTPkJno2JOLuwWw6yPXFW2lzFI7qFkHW+blpcgxJ2qR4H
         Y8e/pco8fXoGPM+BLpf088oxmG1knyJ0TVV/YiVZM2DLGtB1dH2nBUVZNAh3J4MzUkHJ
         t84HCywSTkEs3PKX9zxdnyXL2A1n8vb3kIxhftVGCSC531PfFo80kaMDlvGm+Vk6JMcn
         +R4ofXkOIekwQaBmzw+vQdvB2RBokwPjiTkvh+triqbpSj3hTNzSeE+oK6wsfPq1u4Ej
         1zuw==
X-Forwarded-Encrypted: i=1; AKwUvByZvrGygddQ3jS7UW2FsEXkY9fqiWk0xXlc6bbP4NIl6LsLR7PSAcKJJIK8vNkgDYtYtyWaNd2kxTg=@vger.kernel.org
X-Gm-Message-State: AFuF++mnt6RNlHyyUMkcOZmE7WV07Irhm3uxxHzrFNB1VsPtUIwUwaBN
	T1LDSyLO6bIk450pqLLu9a9KxPy1nxv5iVFViDG6WWrJ4QegW2jpXW1Ks6TnMLwoVAysgRQaQU1
	TQJWZSAdERndLC52/iAZR3mtu9VUHYmPkSX4t5kiGXw==
X-Gm-Gg: AYBFou2EWhKQ+IhCx1j8Ggl6THvuHy+68c4Kl2xk9JP8tP2x9QJYgASdWoVzRk2m67Z
	uLN+YumRat6iuknM14fKtvhukIsv2LNtJv+UcDG4jgKkOQbgyPwva261oTr4CPzrw3Er22pNTmD
	w9prfHP70Agft7BgX7VSs78EW8KaIK0AaRvPLY31ixCGY3zWJTO+uPEzYdHsuhduM4fP4RdEKQd
	XerlhmcY8GPTI1Y7dQ4EU3nUnIZbdL/neO8Y7t90clGydZhCZ+tQDvMdmZ66Qxwl6IWbQhL/+oj
	wFj9UBxV6Xu+G6nngZh8gWo3uVSRsMrKOOk1Bti/b+M/eC7eHRPC5VuVMMBvEpd7HRHI82Ks1VS
	U0Un2uJboInHcZFUIy5hh5zLYO4b+5VWF2SI=
X-Received: by 2002:a17:903:238b:b0:2d8:d4cc:5bb1 with SMTP id
 d9443c01a7336-2dd83867c8amr12011995ad.17.1789471917503; Tue, 15 Sep 2026
 04:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-3-robert.marko@sartura.hr> <bfcd57f8-ffca-4a44-a84f-12c46cb9fe76@microchip.com>
In-Reply-To: <bfcd57f8-ffca-4a44-a84f-12c46cb9fe76@microchip.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 15 Sep 2026 13:31:46 +0200
X-Gm-Features: AcwNN1UJvA458C1rRtNt9ddKHsmuV8Z1-WqiLjsIfnIGDe3K05sCIbO51uVztps
Message-ID: <CA+HBbNFQH-hTnqBOEAau2dP1+zKNsHDBcQA9dC5ofx2U5cbFDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mmc: sdhci-of-at91: add option to keep clocks enabled
To: Aubin Constans <aubin.constans@microchip.com>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, adrian.hunter@intel.com, ehristev@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:46=E2=80=AFPM Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> Hi Robert,
>
> On 07/09/2026 15:25, Robert Marko wrote:
> > sdhci_at91_set_clks_presets() both enables the controller clocks and
> > programs its capabilities and preset registers. This prevents callers f=
rom
> > restoring the registers without changing the clock enable counts.
> >
> > Move clock enablement to callers and add a SoC data flag for controller=
s
> > that must keep their clocks enabled. Use it in the runtime PM paths whi=
le
> > keeping register restoration separate from clock enablement.
>
> This change has been required for the SAMA7G54 MPU already, and implement=
ed by
> two complementary commits:
>
> https://github.com/linux4microchip/linux/commit/763a3c05c8f9d0feb279c6f30=
8fa5d48d14e07d3
> https://github.com/linux4microchip/linux/commit/b5bbc888fb39471d46fe0a4ff=
28f69533c265dd0
>
> At least they have been validated by test campaigns.
> If that existing work seemed OK for you and the LAN969x, then I could squ=
ash
> these two commits and submit the result.

Hi Aubin,
Yeah, I originally used those in our tree as well before trying to
simplify things for upstreaming.

Regards,
Robert

> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >
> >   drivers/mmc/host/sdhci-of-at91.c | 39 +++++++++++++++++++------------=
-
> >   1 file changed, 23 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-=
of-at91.c
> > index 7c4ac65f247d..b7e2a89da348 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -38,6 +38,7 @@
> >   struct sdhci_at91_soc_data {
> >          const struct sdhci_pltfm_data *pdata;
> >          bool baseclk_is_generated_internally;
> > +       bool keep_clks_on;
> >          unsigned int divider_for_baseclk;
> >   };
> >
> > @@ -164,7 +165,7 @@ static const struct of_device_id sdhci_at91_dt_matc=
h[] =3D {
> >   };
> >   MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
> >
> > -static int sdhci_at91_set_clks_presets(struct device *dev)
> > +static void sdhci_at91_set_clks_presets(struct device *dev)
> >   {
> >          struct sdhci_host *host =3D dev_get_drvdata(dev);
> >          struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > @@ -174,7 +175,6 @@ static int sdhci_at91_set_clks_presets(struct devic=
e *dev)
> >          unsigned int                    gck_rate, clk_base_rate;
> >          unsigned int                    preset_div;
> >
> > -       clk_prepare_enable(priv->hclock);
> >          caps0 =3D readl(host->ioaddr + SDHCI_CAPABILITIES);
> >          caps1 =3D readl(host->ioaddr + SDHCI_CAPABILITIES_1);
> >
> > @@ -222,11 +222,6 @@ static int sdhci_at91_set_clks_presets(struct devi=
ce *dev)
> >          preset_div =3D DIV_ROUND_UP(gck_rate, 50000000) - 1;
> >          writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
> >                 host->ioaddr + SDHCI_PRESET_FOR_DDR50);
> > -
> > -       clk_prepare_enable(priv->mainck);
> > -       clk_prepare_enable(priv->gck);
> > -
> > -       return 0;
> >   }
> >
> >   static int sdhci_at91_suspend(struct device *dev)
> > @@ -254,9 +249,11 @@ static int sdhci_at91_runtime_suspend(struct devic=
e *dev)
> >          if (host->tuning_mode !=3D SDHCI_TUNING_MODE_3)
> >                  mmc_retune_needed(host->mmc);
> >
> > -       clk_disable_unprepare(priv->gck);
> > -       clk_disable_unprepare(priv->hclock);
> > -       clk_disable_unprepare(priv->mainck);
> > +       if (!priv->soc_data->keep_clks_on) {
> > +               clk_disable_unprepare(priv->gck);
> > +               clk_disable_unprepare(priv->hclock);
> > +               clk_disable_unprepare(priv->mainck);
> > +       }
> >
> >          return 0;
> >   }
> > @@ -269,14 +266,23 @@ static int sdhci_at91_runtime_resume(struct devic=
e *dev)
> >          int ret;
> >
> >          if (priv->restore_needed) {
> > -               ret =3D sdhci_at91_set_clks_presets(dev);
> > -               if (ret)
> > -                       return ret;
> > +               if (!priv->soc_data->keep_clks_on)
> > +                       clk_prepare_enable(priv->hclock);
> > +
> > +               sdhci_at91_set_clks_presets(dev);
> > +
> > +               if (!priv->soc_data->keep_clks_on) {
> > +                       clk_prepare_enable(priv->mainck);
> > +                       clk_prepare_enable(priv->gck);
> > +               }
> >
> >                  priv->restore_needed =3D false;
> >                  goto out;
> >          }
> >
> > +       if (priv->soc_data->keep_clks_on)
> > +               goto out;
> > +
> >          ret =3D clk_prepare_enable(priv->mainck);
> >          if (ret) {
> >                  dev_err(dev, "can't enable mainck\n");
> > @@ -344,9 +350,10 @@ static int sdhci_at91_probe(struct platform_device=
 *pdev)
> >                  return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
> >                                       "failed to get multclk\n");
> >
> > -       ret =3D sdhci_at91_set_clks_presets(&pdev->dev);
> > -       if (ret)
> > -               return ret;
> > +       clk_prepare_enable(priv->hclock);
> > +       sdhci_at91_set_clks_presets(&pdev->dev);
> > +       clk_prepare_enable(priv->mainck);
> > +       clk_prepare_enable(priv->gck);
> >
> >          priv->restore_needed =3D false;
> >
> > --
> > 2.55.0
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
