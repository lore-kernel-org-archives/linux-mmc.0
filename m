Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C2DC83F20
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjH3S3S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243241AbjH3K2c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2023 06:28:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA50C0
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 03:28:27 -0700 (PDT)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4C10C3FAD3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 10:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693391306;
        bh=0x71Jiks4crbLYMF8B7w24UzcWpOCQauPfqR/sxZV0g=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=O2moxJlEmlGdpqFC9Dg3y88GoKiJJYZgseQfhsQs+bR34UCx2sqB4Uv+bV3KurGXG
         5EED7y/QJbsEF15ym09VC4HxPDsfeLygZU/9tgqqKqf3JGauaUlNDR6+DAmI0elmcB
         ZCVAgHTT4B1sfY00vdwuJUj2k6ZCqTDteUZjAGHMWlxxjWwCyA2/9+qjkA8f6HqMQl
         qKsSxfMrK33V8j5aA1idlgGz3DFyqYMRve/TOyYsu6pFhJ8cQ4TcDWr/8rJbIOv3Ot
         O9agkUZYpGCeklJ62RaKeA3QvWLLZBXTYc49vPVnF8EmizNvcghQy8DadTY8aw3GiG
         UcPjomT+lRCag==
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-64a0166deb5so66844266d6.3
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 03:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391305; x=1693996105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0x71Jiks4crbLYMF8B7w24UzcWpOCQauPfqR/sxZV0g=;
        b=NTCC+f/sCy9RyjMIaaShmk6mrfptVAOx17G+rx+5RNspLKGf0TNsF9OxzAfakIiucH
         Lis5Ra5YwVrFnYIN5u6N7Ifb0PgPyu0AxvWR8xG13eBZeNO0iBU+35eGZnJPPYdlj6Am
         bfns4PzUGAUkWbkzV+vHdrI3saiDCLT3A08obUh8viKQJsEYVLyiAXGRJTNR5Gn9E+VP
         u0+7hK1v0jm3GPnWLR25JCwIL772JX5Yl4PXSEV+HSp/QlD0SKGrzPRI+IX0k8mcohyF
         uyOIxSDHPQup6RTFOKLi3co2sWXdi/SXoSv10q0g4cfmrl62HjoiaH6799LrweoosB4L
         OH3Q==
X-Gm-Message-State: AOJu0Yyu48Af5tYSXeFfm+EoNBrZDN7JdwW6DW73Zr4Oo0YRcaeE5nmz
        aagJz7FRS+2iP4FNm3AQu+QD3XVpbK587kKlSWRcYqFRaMyPRIGeguEYs0AJi8aZxbpVtPJyOpH
        eR0IMQF6uqIuqM2ma4hoKt/pFgRq5nEZyX+s5GAmufnHQWsmRiuqlTg==
X-Received: by 2002:ac8:4e89:0:b0:403:e958:b456 with SMTP id 9-20020ac84e89000000b00403e958b456mr2057146qtp.19.1693391305194;
        Wed, 30 Aug 2023 03:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUywKtZ9QBvF7SXkZ/+FtfBV0akTc4+5p56GkjMS3vEHZ1SMFeY9wEQ5cijc1CJI92RxPk+2KWSd+Z7E9kvN8=
X-Received: by 2002:ac8:4e89:0:b0:403:e958:b456 with SMTP id
 9-20020ac84e89000000b00403e958b456mr2057124qtp.19.1693391304908; Wed, 30 Aug
 2023 03:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230830031846.127957-1-william.qiu@starfivetech.com> <20230830031846.127957-3-william.qiu@starfivetech.com>
In-Reply-To: <20230830031846.127957-3-william.qiu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 30 Aug 2023 12:28:08 +0200
Message-ID: <CAJM55Z9CL8DN+uEhRoR7ZUuwtVudTUzA1+Q4Hn_rukCfT+SXeQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mmc: starfive: Change tuning implementation
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Aug 2023 at 05:21, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Before, we used syscon to achieve tuning, but the actual measurement
> showed little effect, so the tuning implementation was modified here,
> and it was realized by reading and writing the UHS_REG_EXT register.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  drivers/mmc/host/dw_mmc-starfive.c | 131 ++++++++---------------------
>  1 file changed, 37 insertions(+), 94 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
> index fd05a648a8bb..593c995e49f5 100644
> --- a/drivers/mmc/host/dw_mmc-starfive.c
> +++ b/drivers/mmc/host/dw_mmc-starfive.c
> @@ -20,14 +20,6 @@
>  #define ALL_INT_CLR            0x1ffff
>  #define MAX_DELAY_CHAIN                32
>
> -struct starfive_priv {
> -       struct device *dev;
> -       struct regmap *reg_syscon;
> -       u32 syscon_offset;
> -       u32 syscon_shift;
> -       u32 syscon_mask;
> -};
> -
>  static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>         int ret;
> @@ -44,117 +36,68 @@ static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>         }
>  }
>
> +static void dw_mci_starfive_hs_set_bits(struct dw_mci *host, u32 smpl_phase)

"set bits" is very generic. Maybe dw_mci_starfive_set_sample_phase()
or something more descriptive.

> +{
> +       /* change driver phase and sample phase */
> +       u32 mask = 0x1f;
> +       u32 reg_value;
> +
> +       reg_value = mci_readl(host, UHS_REG_EXT);
> +
> +       /* In UHS_REG_EXT, only 5 bits valid in DRV_PHASE and SMPL_PHASE */
> +       reg_value &= ~(mask << 16);
> +       reg_value |= (smpl_phase << 16);
> +       mci_writel(host, UHS_REG_EXT, reg_value);
> +
> +       /* We should delay 1ms wait for timing setting finished. */
> +       mdelay(1);
> +}

This implementation could use some cleanup. Eg. why do we need the
mask variable?
How about something like this:

#define STARFIVE_SMPL_PHASE     GENMASK(20, 16)

u32 reg_value = mci_read(host, UHS_REG_EXT);
reg_value &= ~STARFIVE_SMPL_PHASE;
reg_value |= FIELD_PREP(STARFIVE_SMPL_PHASE, smpl_phase);
mci_writel(host, UHS_REG_EXT, reg_value);
...

>  static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>                                              u32 opcode)
>  {
>         static const int grade  = MAX_DELAY_CHAIN;
>         struct dw_mci *host = slot->host;
> -       struct starfive_priv *priv = host->priv;
> -       int rise_point = -1, fall_point = -1;
> -       int err, prev_err = 0;
> +       int err = -1;

This variable is always set later so doesn't need initialization and
is better called 'ret' as it's the return value of the function, and
not necessarily an error.

> +       int smpl_phase, smpl_raise = -1, smpl_fall = -1;
>         int i;
> -       bool found = 0;
> -       u32 regval;
> -
> -       /*
> -        * Use grade as the max delay chain, and use the rise_point and
> -        * fall_point to ensure the best sampling point of a data input
> -        * signals.
> -        */
> +
>         for (i = 0; i < grade; i++) {
> -               regval = i << priv->syscon_shift;
> -               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> -                                               priv->syscon_mask, regval);
> -               if (err)
> -                       return err;
> +               smpl_phase = i;

This can now be written

for (sampl_phase = 0; sampl_phase < grade; sampl_phase++)

> +               dw_mci_starfive_hs_set_bits(host, smpl_phase);
>                 mci_writel(host, RINTSTS, ALL_INT_CLR);
>
>                 err = mmc_send_tuning(slot->mmc, opcode, NULL);
> -               if (!err)
> -                       found = 1;
> -
> -               if (i > 0) {
> -                       if (err && !prev_err)
> -                               fall_point = i - 1;
> -                       if (!err && prev_err)
> -                               rise_point = i;
> -               }
>
> -               if (rise_point != -1 && fall_point != -1)
> -                       goto tuning_out;
> -
> -               prev_err = err;
> -               err = 0;
> -       }
> -
> -tuning_out:
> -       if (found) {
> -               if (rise_point == -1)
> -                       rise_point = 0;
> -               if (fall_point == -1)
> -                       fall_point = grade - 1;
> -               if (fall_point < rise_point) {
> -                       if ((rise_point + fall_point) >
> -                           (grade - 1))
> -                               i = fall_point / 2;
> -                       else
> -                               i = (rise_point + grade - 1) / 2;
> -               } else {
> -                       i = (rise_point + fall_point) / 2;
> +               if (!err && smpl_raise < 0) {
> +                       smpl_raise = i;
> +               } else if (err && smpl_raise >= 0) {
> +                       smpl_fall = i - 1;
> +                       break;
>                 }
> +       }
>
> -               regval = i << priv->syscon_shift;
> -               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> -                                               priv->syscon_mask, regval);
> -               if (err)
> -                       return err;
> -               mci_writel(host, RINTSTS, ALL_INT_CLR);
> +       if (i >= grade && smpl_raise >= 0)
> +               smpl_fall = grade - 1;
>
> -               dev_info(host->dev, "Found valid delay chain! use it [delay=%d]\n", i);
> -       } else {
> +       if (smpl_raise < 0) {
>                 dev_err(host->dev, "No valid delay chain! use default\n");
> +               dw_mci_starfive_hs_set_bits(host, 0);
>                 err = -EINVAL;
> +       } else {
> +               smpl_phase = (smpl_raise + smpl_fall) / 2;
> +               dw_mci_starfive_hs_set_bits(host, smpl_phase);
> +               dev_dbg(host->dev, "Found valid delay chain! use it [delay=%d]\n", smpl_phase);
> +               err = 0;
>         }

Maybe something like:

  if (smpl_raise < 0) {
    smpl_phase = 0;
    dev_err(host->dev, "No valid delay chain, using default\n");
    ret = -EINVAL;
    goto out;
  }

  smpl_phase = (smpl_raise + smpl_fall) / 2;
  dev_dbg(...);
  ret = 0;

out:
  dw_mci_starfive_hs_set_bits(host, smpl_phase);
  mci_writel(host, RINTSTS, ALL_INT_CLR);
  return ret;
>  }
>
> -static int dw_mci_starfive_parse_dt(struct dw_mci *host)
> -{
> -       struct of_phandle_args args;
> -       struct starfive_priv *priv;
> -       int ret;
> -
> -       priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> -       if (!priv)
> -               return -ENOMEM;
> -
> -       ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
> -                                               "starfive,sysreg", 3, 0, &args);
> -       if (ret) {
> -               dev_err(host->dev, "Failed to parse starfive,sysreg\n");
> -               return -EINVAL;
> -       }
> -
> -       priv->reg_syscon = syscon_node_to_regmap(args.np);
> -       of_node_put(args.np);
> -       if (IS_ERR(priv->reg_syscon))
> -               return PTR_ERR(priv->reg_syscon);
> -
> -       priv->syscon_offset = args.args[0];
> -       priv->syscon_shift  = args.args[1];
> -       priv->syscon_mask   = args.args[2];
> -
> -       host->priv = priv;
> -
> -       return 0;
> -}
> -
>  static const struct dw_mci_drv_data starfive_data = {
>         .common_caps            = MMC_CAP_CMD23,
>         .set_ios                = dw_mci_starfive_set_ios,
> -       .parse_dt               = dw_mci_starfive_parse_dt,
>         .execute_tuning         = dw_mci_starfive_execute_tuning,
>  };
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
