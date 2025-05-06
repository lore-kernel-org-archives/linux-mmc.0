Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41912D7AE9;
	Tue,  6 May 2025 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746499854; cv=none; b=pKGEnYWapEvE7ni+OjN1m+LcNPdDhOgKk9dzFk1FVnivrpDM7+b4apYM01tFlz5rGXNgWr//LcBg10hC3j/5fAU244qM1Ct6JugFMyuHGbE+s3Fqw/F/EWuaz86Xr689nlROwLi7ijGyJd6E9+BcKzsX031afMK6B/xxpFsoWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746499854; c=relaxed/simple;
	bh=lgG4+x1im+kvxkkhkTn2F2tgPQk5X5zTRxKiIi7JbI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r07y8cO8O756H9LfHB0s1uUeKUSRTKZNeeU6WN2mN79mrdTNhrRaty5NINz/VTOpf9wpYPDBuzBzvOQSd6l+hCud1gBKqbbaKbYAhWF3MEqZhS74UrgdPF9z/gXTvRA/RFDRcq9iNKFj0EkeYekQAxEtC39HqN2zDj02gxCp5O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M20V4wA2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M20V4wA2"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso198734566b.0;
        Mon, 05 May 2025 19:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746499850; x=1747104650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKAQxai1p4l/ajmTuuPe3EGBDWgRIxvRvaamovl7Omg=;
        b=M20V4wA2e8t12Q7GiD8iQh3KQqZvfOzctAOYefga7ZQLE9XIslx3saZ10kSA2yOvKY
         J6M2vcijErpP7EroV7OH7AlhrCU0W08H+F5iu7W8husizCDVjxRZ7Xu/wmD6vwKfFZRH
         aHmZ6K30KpRORKbsAnWb/yfPQFnqPYkE1aJi/a2KbAB6FOoi0vblSntOIXOEe2bPXSRb
         CSELJXg3dEJOL8o4h2Jq54uKAFi0LU8HKvCt3V8/jHx3wzwPOEePYfRUqU1J0KAW6fmP
         bmT7N/pdfPhRcGlBZU6IcpLkFh6IY3/UapJDo21mrLl7/einqOGrvGZ695nMeqeqQyzW
         MJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746499850; x=1747104650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKAQxai1p4l/ajmTuuPe3EGBDWgRIxvRvaamovl7Omg=;
        b=RmKubD/759nwEL3606JfG65mso0OdCjzSqoYUw+6dq1ku7aRrRj6FZxLBzrxgcAZnU
         gNSNXw5AdWFapWWI7Lnj1PMtWP1VsvpLru7jwAdey1ibgRsHhZEcksIlP9uH3oPOnL18
         TNmVQ9Aw2/l1HaS6Vua9sD1psROIf9kSWHSfcNMUwcfHmoCvdhraKh+D9d9cAX3E43yh
         zzKf6aXVPPNvqVVX7Ymrwtq1kbZkqJ4lSa6xutREgaD6IVlC4guQFi+O3o2cecUylfbs
         DwcWo+rVn0IYd5qThkdqXTlTFmHRVsaa8NlQeRWFIqkP5UPMvZVxGIfBOHMGpKfDQZE2
         Zpxg==
X-Forwarded-Encrypted: i=1; AJvYcCWCe3rpEjsyY1BlGxf9gTArMIzQpcISIrm/OOeJxsqAn4mxSsp9hXonfvQeaw0ozNsBeY2bpYZxF9OY@vger.kernel.org, AJvYcCXY81OH4K+u3gmf+iJLyFVnvj3EcUY1af6XStaKr+q/XWKDykV/4E2zOz1xNxPxPEyxfwFYaMqGtmip@vger.kernel.org
X-Gm-Message-State: AOJu0YwpHvC85wNYUi86cpj0PMvIp8A/9pmuY4/InwFHuVcxQr4tMnuE
	YS792xLYV/Aff3U4lWLq79D8qoUnM8xB2MYX9IBf3QlNUfEOlCUBlj/Nza2Q7bwFVRUbNnkfbRq
	IqHQjTZPfcXO50NqGagLAr9W0Dk6CZyR3umZ8Ig==
X-Gm-Gg: ASbGncsvohErpXOVPeLoBfckiaOpW+Bps8pcaNsvIOmnmL932pmI8blgvS6O+i1zuI5
	qEQ0zk7u4wnuWormkhLFScNPNCNOwve0JUwgR3rBMqxVK8cIhFe7aDZ8Oxa0//i2RDQwY+TQwac
	DMty2QiUV9ffRUA7I0mEazwA==
X-Google-Smtp-Source: AGHT+IF+4pVbflN4JrN4GJ56a0VMGGqexrXBQQsRao4Z1wAYjE45lDWU/a1ufN5QyweHkRwdsnqHNpv2tCsiJoM7ngo=
X-Received: by 2002:a17:907:7f14:b0:ace:d442:e39f with SMTP id
 a640c23a62f3a-ad1a49fa658mr853876966b.33.1746499849710; Mon, 05 May 2025
 19:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744273956.git.zhoubinbin@loongson.cn> <8ff74bf9e821f5734462cebcc4b3fbaa09114e6c.1744273956.git.zhoubinbin@loongson.cn>
 <CAPDyKFqqPktwrYs70o9To4OKVWss6wM5kCg0OuXY-k2ReESwig@mail.gmail.com>
In-Reply-To: <CAPDyKFqqPktwrYs70o9To4OKVWss6wM5kCg0OuXY-k2ReESwig@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 6 May 2025 10:50:37 +0800
X-Gm-Features: ATxdqUGFunv93_H6jW_WmGYYgKhNZbfbRuW9cRDL7hRMQS1AWOVV1Vt0ftfBQaI
Message-ID: <CAMpQs4L_hFcz8O0B=s0rrAimRi5JCQ0V99Ui3u8ch0weu8KF4Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf:

Thanks for your review and sorry for the late reply.

On Mon, Apr 28, 2025 at 11:10=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
>
> On Thu, 10 Apr 2025 at 10:41, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
> >
> > The MMC controllers on the Loongson-2K series CPUs are similar,
> > except for the interface characteristics and the use of DMA controllers=
.
> >
> > This patch describes the MMC controllers on the Loongson-2K0500/2K1000,
> > with the distinguishing feature being the use of an externally shared
> > APBDMA engine.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>
> Overall this looks good to me. A few things though, please have a look be=
low.
>
> > ---
> >  MAINTAINERS                      |   2 +
> >  drivers/mmc/host/Kconfig         |  13 +
> >  drivers/mmc/host/Makefile        |   1 +
> >  drivers/mmc/host/loongson2-mmc.c | 636 +++++++++++++++++++++++++++++++
> >  drivers/mmc/host/loongson2-mmc.h | 177 +++++++++
> >  5 files changed, 829 insertions(+)
> >  create mode 100644 drivers/mmc/host/loongson2-mmc.c
> >  create mode 100644 drivers/mmc/host/loongson2-mmc.h
>
> I think we can put all code in the c-file, no need for a separate header =
file.

OK, I will do it.
>
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 32c3733a764a..e218a3e204ef 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13940,6 +13940,8 @@ M:      Binbin Zhou <zhoubinbin@loongson.cn>
> >  L:     linux-mmc@vger.kernel.org
> >  S:     Supported
> >  F:     Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> > +F:     drivers/mmc/host/loongson2-mmc.c
> > +F:     drivers/mmc/host/loongson2-mmc.h
> >
>
> [...]
>
> > +static irqreturn_t loongson2_mmc_irq(int irq, void *dev_id)
> > +{
> > +       struct loongson2_mmc_host *host =3D dev_id;
> > +       struct mmc_command *cmd;
> > +       unsigned long iflags;
> > +       u32 dsts, imsk;
> > +
> > +       regmap_read(host->regmap, LOONGSON2_MMC_REG_INT, &imsk);
> > +       regmap_read(host->regmap, LOONGSON2_MMC_REG_DSTS, &dsts);
> > +
> > +       if ((dsts & LOONGSON2_MMC_DSTS_IRQ) &&
> > +           (imsk & LOONGSON2_MMC_INT_SDIOIRQ)) {
> > +               regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_INT,
> > +                                  LOONGSON2_MMC_INT_SDIOIRQ,
> > +                                  LOONGSON2_MMC_INT_SDIOIRQ);
> > +
> > +               mmc_signal_sdio_irq(host->mmc);
>
> mmc_signal_sdio_irq() is the legacy interface for managing SDIO irqs.
>
> Please convert to use sdio_signal_irq() instead, along with the
> ->ack_sdio_irq() callback.

OK..
>
> > +               return IRQ_HANDLED;
> > +       }
> > +
> > +       spin_lock_irqsave(&host->lock, iflags);
> > +
> > +       if (host->state =3D=3D STATE_NONE || host->state =3D=3D STATE_F=
INALIZE ||
> > +           !host->mrq)
> > +               goto irq_out;
> > +
> > +       cmd =3D host->cmd_is_stop ? host->mrq->stop : host->mrq->cmd;
> > +       if (!cmd)
> > +               goto irq_out;
> > +
> > +       cmd->error =3D 0;
> > +
> > +       if (imsk & LOONGSON2_MMC_INT_CTIMEOUT) {
> > +               cmd->error =3D -ETIMEDOUT;
> > +               goto close_transfer;
> > +       }
> > +
> > +       if (imsk & LOONGSON2_MMC_INT_CSENT) {
> > +               if (host->state =3D=3D STATE_RSPFIN || host->state =3D=
=3D STATE_CMDSENT)
> > +                       goto close_transfer;
> > +
> > +               if (host->state =3D=3D STATE_XFERFINISH_RSPFIN)
> > +                       host->state =3D STATE_XFERFINISH;
> > +       }
> > +
> > +       if (!cmd->data)
> > +               goto irq_out;
> > +
> > +       if (imsk & (LOONGSON2_MMC_INT_RXCRC | LOONGSON2_MMC_INT_TXCRC))=
 {
> > +               cmd->data->error =3D -EILSEQ;
> > +               goto close_transfer;
> > +       }
> > +
> > +       if (imsk & LOONGSON2_MMC_INT_DTIMEOUT) {
> > +               cmd->data->error =3D -ETIMEDOUT;
> > +               goto close_transfer;
> > +       }
> > +
> > +       if (imsk & LOONGSON2_MMC_INT_DFIN) {
> > +               if (host->state =3D=3D STATE_XFERFINISH) {
> > +                       host->dma_complete =3D 1;
> > +                       goto close_transfer;
> > +               }
> > +
> > +               if (host->state =3D=3D STATE_XFERFINISH_RSPFIN)
> > +                       host->state =3D STATE_RSPFIN;
> > +       }
> > +
> > +irq_out:
> > +       regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, imsk);
> > +       spin_unlock_irqrestore(&host->lock, iflags);
> > +       return IRQ_HANDLED;
> > +
> > +close_transfer:
> > +       host->state =3D STATE_FINALIZE;
> > +       host->pdata->reorder_cmd_data(host, cmd);
> > +       regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, imsk);
> > +       spin_unlock_irqrestore(&host->lock, iflags);
> > +       return IRQ_WAKE_THREAD;
> > +}
>
> [...]
>
> > +
> > +static int loongson2_mmc_resource_request(struct platform_device *pdev=
,
> > +                                         struct loongson2_mmc_host *ho=
st)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       void __iomem *base;
> > +       int ret, irq;
> > +
> > +       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &host-=
>res);
> > +       if (IS_ERR(base))
> > +               return PTR_ERR(base);
> > +
> > +       host->regmap =3D devm_regmap_init_mmio(dev, base, &host->pdata-=
>regmap_config);
> > +       if (IS_ERR(host->regmap))
> > +               return PTR_ERR(host->regmap);
> > +
> > +       host->clk =3D devm_clk_get_optional_enabled(dev, NULL);
> > +       if (IS_ERR(host->clk))
> > +               return PTR_ERR(host->clk);
> > +
> > +       if (host->clk) {
> > +               ret =3D devm_clk_rate_exclusive_get(dev, host->clk);
> > +               if (ret)
> > +                       return PTR_ERR(host->clk);
> > +
> > +               host->rate =3D clk_get_rate(host->clk);
> > +       } else {
> > +               /* For ACPI, we get rate through clock-frequency attrib=
ute */
> > +               device_property_read_u64(dev, "clock-frequency", &host-=
>rate);
>
> Is ACPI supported too?
Yes, like on the Loongson-2K2000 platform, we support ACPI and FDT.
For ACPI, we also match by compatible strings, so the interface is the
same as for FDT, except that the in-node attribute descriptions are
not exactly the same, e.g. clock-frequency.

>
> > +       }
> > +
> > +       irq =3D platform_get_irq(pdev, 0);
> > +       if (irq < 0)
> > +               return irq;
> > +
> > +       ret =3D devm_request_threaded_irq(dev, irq, loongson2_mmc_irq,
> > +                                       loongson2_mmc_irq_worker,
> > +                                       IRQF_ONESHOT, "loongson2-mmc", =
host);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D host->pdata->setting_dma(host, pdev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +}
> > +
> > +static int loongson2_mmc_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       struct loongson2_mmc_host *host;
> > +       struct mmc_host *mmc;
> > +       int ret;
> > +
> > +       mmc =3D mmc_alloc_host(sizeof(*host), dev);
>
> We have devm_mmc_alloc_host() too, perhaps worth to use it to simplify
> the code a bit.

This is good news and I will do it.
>
> > +       if (!mmc) {
> > +               dev_err(dev, "Failed to alloc mmc host\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, mmc);
> > +
> > +       host =3D mmc_priv(mmc);
> > +       host->mmc =3D mmc;
> > +       host->state =3D STATE_NONE;
> > +       spin_lock_init(&host->lock);
> > +
> > +       host->pdata =3D device_get_match_data(dev);
> > +       if (!host->pdata) {
> > +               dev_err(dev, "Failed to get match data\n");
> > +               ret =3D -EINVAL;
> > +               goto free_host;
> > +       }
> > +
> > +       ret =3D loongson2_mmc_resource_request(pdev, host);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to request resource\n");
> > +               goto free_host;
> > +       }
> > +
> > +       mmc->ops =3D &loongson2_mmc_ops;
> > +       mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
>
> How is power to the card controlled for these platforms?
>
> The preferred way is to use the regulator API to manage this - and the
> mmc core also provides a couple of helper functions for this, like
> mmc_regulator_get_supply(), for example.

Emm, I will try to use this API.
>
> > +       mmc->f_min =3D DIV_ROUND_UP(host->rate, 256);
> > +       mmc->f_max =3D host->rate;
> > +       mmc->max_blk_count =3D 4095;
> > +       mmc->max_blk_size =3D 4095;
> > +       mmc->max_req_size =3D mmc->max_blk_count * mmc->max_blk_size;
> > +       mmc->max_segs =3D 1;
> > +       mmc->max_seg_size =3D mmc->max_req_size;
> > +
> > +       ret =3D mmc_of_parse(mmc);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to parse device node\n");
> > +               goto free_dma;
> > +       }
> > +
> > +       ret =3D mmc_add_host(mmc);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to add mmc host.\n");
> > +               goto free_dma;
> > +       }
> > +
> > +       return 0;
> > +
> > +free_dma:
> > +       host->pdata->release_dma(host, dev);
> > +free_host:
> > +       mmc_free_host(mmc);
> > +       return ret;
> > +}
> > +
>
> [...]
>
> Kind regards
> Uffe

--=20
Thanks.
Binbin
