Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11ECC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Mar 2022 13:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbiCONnu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiCONnt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 09:43:49 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E56E52E68
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 06:42:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y17so9406911ljd.12
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LDMVg49PPF+lVgu0yblB590k0qF8yLxLUpXrQVNt0Kc=;
        b=NOoShGxNutDSiVjhC4bSOCncijbFuS1K50e8QwcswaBOjWPdG37a0PE5aHo4ie+rYR
         +UetVQbr1jZ2/gmwgK6Rsd0xej9yMviRAejfhUYTyqkpgUVLABuMtvHSbbVFtxePkGVg
         uxAZfWlEk7yyAMhiLrHmgxDIHNKk2dL7wJ+nN0x1MwgM0HecwcyuIpfOcZF0r5IcifTd
         jyFzl7k2NXI5mU1M5Vc+5ts3qtR2OPOnxacdZk0EsSkq5OItI1aXKeHlp33aZGgAGnhd
         dqh8w+vdqX+WVtMD+BHIlKqml7FYpfLDvK8P56znWynz49emwpdPaTTixb0VOp0kUaLJ
         1BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LDMVg49PPF+lVgu0yblB590k0qF8yLxLUpXrQVNt0Kc=;
        b=Eg2kyUtZ3IRdcSnBF5n6SAtAx5Bp0b6GkBf+Ufpjk6y1oPcUYHVj6qOdqpywG8CrH/
         zgm5j42EYyoJ1M4Ql4yVJJRwCTRYv0Up/gQZuIA8ZK+s+vhxJ6/tUeYqZMWblorDfZZJ
         0waoew0xHtYjbOHk3WGpobMnbPV64/2aed5xq/mdlw/k+leqfRXhj/vKH8IgsOTCBfgG
         tcAac/G+lAlt/UhyW3gL3Uz+OXr6F1YTaY1WpbsC1RH7kZTvWUr8NdhfPRPfZl3zATiE
         M0Uiv88+F8QoRHMjTtejjPbhe3bveDyq2ThliErKTPgGOUX1qOuWxmPT1Py58SNl0tXj
         0rgA==
X-Gm-Message-State: AOAM532uw2bZKYIKztauVc7YJWRkveikuvVGo2nfpwm1INZieAHtq705
        MVRsnORk7H0NRRZ+IUEyXlFEQe2tDJeLnGZ5Aac/6w==
X-Google-Smtp-Source: ABdhPJzMIruKXLURZESH+lq6/K6+4mOgyv0+Pi2meUSyKtx2wJm31MMQsZtmrMXOtrfxSRBPmzBtvdCCcePNxvjSWJQ=
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e90 with SMTP id
 e9-20020a2e5009000000b00247d7383e90mr17508761ljb.229.1647351755630; Tue, 15
 Mar 2022 06:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646820083.git.marc.mattmueller@netmodule.com>
 <d68d8c8edda35a050a6e92b0ff1d57dd3e7c61d6.1646820083.git.marc.mattmueller@netmodule.com>
 <DM6PR04MB65751B0413F8A2FDC72F05B9FC0B9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFov8OUvC8KkWm=-e=M5B3y1Lc0Ci4UXQPD1Y6zQnBVuNQ@mail.gmail.com> <f0e7c1dde35f0aa035d991fdac2ed3d472452d92.camel@netmodule.com>
In-Reply-To: <f0e7c1dde35f0aa035d991fdac2ed3d472452d92.camel@netmodule.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 14:41:59 +0100
Message-ID: <CAPDyKFr0xat4T=TpQ7bhbGULsV-8JLfRkXj_4V3q_Odxo+h9tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: add reliable write setting to sysfs and
 update on read
To:     =?UTF-8?Q?Marc_Mattm=C3=BCller?= <marc.mattmueller@netmodule.com>
Cc:     "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Mar 2022 at 13:40, Marc Mattm=C3=BCller
<Marc.Mattmueller@netmodule.com> wrote:
>
> On Tue, 2022-03-15 at 10:39 +0100, Ulf Hansson wrote:
> > On Thu, 10 Mar 2022 at 15:08, Avri Altman <Avri.Altman@wdc.com>
> > wrote:
> > >
> > > > The mmc reliable write setting (from ext_csd) was not available
> > > > on the sysfs.
> > > > Thus, added rel_param and rel_write_set to sysfs and added the
> > > > update of
> > > > rel_write_set on sysfs read.
> > > Here also - why adding ABI when its already available via mmc-
> > > utils?
> > >
> > > Thanks,
> > > Avri
> >
> > FYI, I agree with Avri here. Please use mmc-utils.
> >
> > In case the values in sysfs become confusing as they may be outdated
> > at some point, perhaps we should consider dropping them?
> >
> > Kind regards
> > Uffe
>
> Hi,
> yes I was confused about having the lifetime values available in the
> sysfs but without having an update over time. The reliable write values
> were some kind of logic for me to add them as well. That's why I was
> hesitating first to create a single patch for all these values but as
> it concerns two different topics I decided to create a patchset.
>
> Nevertheless, if you propose to use the mmc-utils for the dynamic
> values, it is less confusing if you just keep only the static
> values and drop the dynamic ones.

Okay, that sounds reasonable - and thanks for clarifying.

Kind regards
Uffe

>
> Kind regards
> Marc
>
> >
> > > > Signed-off-by: Marc Mattmueller <marc.mattmueller@netmodule.com>
> > > > ---
> > > >  drivers/mmc/core/mmc.c   | 29 +++++++++++++++++++++++++++++
> > > >  include/linux/mmc/card.h |  1 +
> > > >  include/linux/mmc/mmc.h  |  1 +
> > > >  3 files changed, 31 insertions(+)
> > > >
> > > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > index
> > > > d9537c894e33..a64d1ecb0de9 100644
> > > > --- a/drivers/mmc/core/mmc.c
> > > > +++ b/drivers/mmc/core/mmc.c
> > > > @@ -364,6 +364,10 @@ static int
> > > > mmc_update_ext_csd_runtime_params(struct mmc_card *card, u8
> > > > *ext_csd)  {
> > > >         int err =3D 0;
> > > >
> > > > +       /* eMMC v4.41 or later */
> > > > +       if (card->ext_csd.rev >=3D 5)
> > > > +               card->ext_csd.rel_wr_set =3D
> > > > ext_csd[EXT_CSD_WR_REL_SET];
> > > > +
> > > >         /* eMMC v5 or later */
> > > >         if (card->ext_csd.rev >=3D 7) {
> > > >                 card->ext_csd.pre_eol_info =3D
> > > > ext_csd[EXT_CSD_PRE_EOL_INFO];
> > > > @@ -587,6 +591,7 @@ static int mmc_decode_ext_csd(struct mmc_card
> > > > *card, u8 *ext_csd)
> > > >                 }
> > > >
> > > >                 card->ext_csd.rel_param =3D
> > > > ext_csd[EXT_CSD_WR_REL_PARAM];
> > > > +               card->ext_csd.rel_wr_set =3D
> > > > ext_csd[EXT_CSD_WR_REL_SET];
> > > >                 card->ext_csd.rst_n_function =3D
> > > > ext_csd[EXT_CSD_RST_N_FUNCTION];
> > > >
> > > >                 /*
> > > > @@ -820,6 +825,7 @@ MMC_DEV_ATTR(name, "%s\n", card-
> > > > > cid.prod_name);  MMC_DEV_ATTR(oemid, "0x%04x\n", card-
> > > > > >cid.oemid);
> > > > MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);  MMC_DEV_ATTR(rev,
> > > > "0x%x\n", card->ext_csd.rev);
> > > > +MMC_DEV_ATTR(rel_param, "0x%02x\n", card->ext_csd.rel_param);
> > > >  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
> > > > MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
> > > >                 card->ext_csd.enhanced_area_offset);
> > > > @@ -886,6 +892,27 @@ static ssize_t pre_eol_info_show(struct
> > > > device
> > > > *dev,
> > > >
> > > >  static DEVICE_ATTR_RO(pre_eol_info);
> > > >
> > > > +static ssize_t rel_write_set_show(struct device *dev,
> > > > +                                 struct device_attribute *attr,
> > > > +                                 char *buf) {
> > > > +       int err =3D 0;
> > > > +       struct mmc_card *card =3D mmc_dev_to_card(dev);
> > > > +
> > > > +       /* before eMMC v4.41 */
> > > > +       if (card->ext_csd.rev < 5)
> > > > +               return sprintf(buf, "%s\n", "-");
> > > > +
> > > > +       /* eMMC v4.41 or later */
> > > > +       err =3D mmc_update_csd(card);
> > > > +       if (err)
> > > > +               return (ssize_t)err;
> > > > +
> > > > +       return sprintf(buf, "0x%02x\n", card-
> > > > >ext_csd.rel_wr_set); }
> > > > +
> > > > +static DEVICE_ATTR_RO(rel_write_set);
> > > > +
> > > >  static ssize_t mmc_fwrev_show(struct device *dev,
> > > >                               struct device_attribute *attr,
> > > >                               char *buf) @@ -931,6 +958,8 @@
> > > > static struct attribute
> > > > *mmc_std_attrs[] =3D {
> > > >         &dev_attr_oemid.attr,
> > > >         &dev_attr_prv.attr,
> > > >         &dev_attr_rev.attr,
> > > > +       &dev_attr_rel_param.attr,
> > > > +       &dev_attr_rel_write_set.attr,
> > > >         &dev_attr_pre_eol_info.attr,
> > > >         &dev_attr_life_time.attr,
> > > >         &dev_attr_serial.attr,
> > > > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > > > index
> > > > 37f975875102..21c47893fcb4 100644
> > > > --- a/include/linux/mmc/card.h
> > > > +++ b/include/linux/mmc/card.h
> > > > @@ -48,6 +48,7 @@ struct mmc_ext_csd {
> > > >         u8                      sec_feature_support;
> > > >         u8                      rel_sectors;
> > > >         u8                      rel_param;
> > > > +       u8                      rel_wr_set;
> > > >         bool                    enhanced_rpmb_supported;
> > > >         u8                      part_config;
> > > >         u8                      cache_ctrl;
> > > > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > > > index
> > > > d9a65c6a8816..42afd442a70a 100644
> > > > --- a/include/linux/mmc/mmc.h
> > > > +++ b/include/linux/mmc/mmc.h
> > > > @@ -266,6 +266,7 @@ static inline bool mmc_ready_for_data(u32
> > > > status)
> > > >  #define EXT_CSD_BKOPS_START            164     /* W */
> > > >  #define EXT_CSD_SANITIZE_START         165     /* W */
> > > >  #define EXT_CSD_WR_REL_PARAM           166     /* RO */
> > > > +#define EXT_CSD_WR_REL_SET             167     /* R/W */
> > > >  #define EXT_CSD_RPMB_MULT              168     /* RO */
> > > >  #define EXT_CSD_FW_CONFIG              169     /* R/W */
> > > >  #define EXT_CSD_BOOT_WP                        173     /* R/W */
> > > > --
> > > > 2.20.1
