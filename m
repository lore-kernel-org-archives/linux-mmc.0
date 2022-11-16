Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D2C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 13:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbiKPNGn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 08:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiKPNG1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 08:06:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9543AED
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 05:05:59 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k22so17423817pfd.3
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 05:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Cv588Bvi76L0mcRYpB43mfzM8aVkUH41fr9xnyuZk=;
        b=E49jHtoq9klKCtsK5b/aDkJEDwWlhujSTGhqkX1i+Yaglh/a7gYuqn640XaMH9YXjR
         /qIi2NFyFqW/jBsLkuHXjmxtE6xchFocekHbF1Qmgr0bDPVCxpnVJKT61gfeYHAOczeA
         RbsJrOW87i4MH1C04BOEWdpWtPg9ewvfxldfbk7xqa6FxSP59comhMtjBytSE6G3DZxq
         YQ+DEQjSEX+ZKtzKK/zrumG4zusL1rc92M47OJDn5wRf4sB4Rt3S3AMTxslAVmzxeq8A
         Ix5dnWngtEChuNX1Vk7JIRiwgK4FVsN7VDOJ8Bgls/5zFZvPxMx5Pq+LPO680X8plvav
         uplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1Cv588Bvi76L0mcRYpB43mfzM8aVkUH41fr9xnyuZk=;
        b=zjcZH4fS0DZvPxFtnaKOV2baXySdvh5/KNt1CIqZChBjIebrvTdpDLmsx/lQgYaUVY
         93fuoqedKVwamrRu0e2JZZblDTf4Hz9MxhzK6YbV3/aBLPSnw6NdCEIkAqguEfgQdyXM
         G2z6FhKvfnrV4hcG3p5T0HnMsorADSISMe/YVzBSyOYzsbgmKNvkPvHRpb99B2//ug/s
         N9mBPVMD5YY/MvC4TDzZSu/9U1ATmYofthIo0EyduJZvO6cx5fEbhv6JIcksREPzbShV
         01JRpiWP07zJvFGNwnYrpSxOq0lU5HYgUR/czynrunu9ZiB1EdIy1tiOIpkTFOCuA5WB
         mnpg==
X-Gm-Message-State: ANoB5pmPWyt+Tw5f3xDNRjdSIS3ZW1ol7sUgcPFjqPhPlJr3lf/rj0tZ
        B+9sX9oHHpWDwChhlhebO3Z7hS7umdDCuLgTg3OSuQ==
X-Google-Smtp-Source: AA0mqf6E25Iwm0aLBpX3+AHjPA+zg5fg0q8BSA6wix4zK5GRfsG2nVqbiY2284XFQcwXFnSWlMERWp61onfJ2fKediI=
X-Received: by 2002:aa7:924c:0:b0:566:9f68:c0ad with SMTP id
 12-20020aa7924c000000b005669f68c0admr23131650pfp.57.1668603955791; Wed, 16
 Nov 2022 05:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20221104095512.4068-1-chevron.li@bayhubtech.com>
 <CAPDyKFqaQyQ0rViHUZoN8NzcPu51utu4KhC2KsY4p2s_sua=kQ@mail.gmail.com> <SN1PR16MB22551227277A186B79ECA225F1079@SN1PR16MB2255.namprd16.prod.outlook.com>
In-Reply-To: <SN1PR16MB22551227277A186B79ECA225F1079@SN1PR16MB2255.namprd16.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 14:05:19 +0100
Message-ID: <CAPDyKFp4bDxtFeMcKVrGMySkZbN_eFCJuVEJwsfH834_4V8Sdw@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: fix card detect fail issue
 caused by CD# debounce timeout
To:     "Louis Lu(TP)" <louis.lu@bayhubtech.com>
Cc:     "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Nov 2022 at 07:04, Louis Lu(TP) <louis.lu@bayhubtech.com> wrote:
>
> Hi Uffe,
>
> May we check when this update patched will be phased in?

I realized that you probably want this to be applied as fix for
v6.1-rc, so I have moved the patch to the fixes branch. Moreover, I
will add a stable tag to it.

That means, the patch should show up in v6.1-rc6 next week and beyond
that, it should be tried to be picked up by maintainers of the
stable-kernels.

Kind regards
Uffe

>
> Thanks,
> Best Regards,
> Louis Lu
>
> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Tuesday, November 8, 2022 4:13 AM
> To: Chevron Li (WH) <chevron.li@bayhubtech.com>
> Cc: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; linux-kernel@vger=
.kernel.org; Shaper Liu (WH) <shaper.liu@bayhubtech.com>; XiaoGuang Yu (WH)=
 <xiaoguang.yu@bayhubtech.com>; Shirley Her(SC) <shirley.her@bayhubtech.com=
>; Louis Lu(TP) <louis.lu@bayhubtech.com>
> Subject: Re: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: fix card detect fail =
issue caused by CD# debounce timeout
>
> On Fri, 4 Nov 2022 at 10:55, Chevron Li <chevron.li@bayhubtech.com> wrote=
:
> >
> > The SD card is recognized failed sometimes when resume from suspend.
> > Because CD# debounce time too long then card present report wrong.
> > Finally, card is recognized failed.
> >
> > Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
>
> Applied for next, thanks!
>
> Kind regards
> Uffe
>
>
> > ---
> > Change in V1:
> > Adjust bayhub chip setting for CD# debounce time to minimum value
> > ---
> >  drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sd=
hci-pci-o2micro.c
> > index ad457cd9cbaa..bca1d095b759 100644
> > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> > @@ -32,6 +32,7 @@
> >  #define O2_SD_CAPS             0xE0
> >  #define O2_SD_ADMA1            0xE2
> >  #define O2_SD_ADMA2            0xE7
> > +#define O2_SD_MISC_CTRL2       0xF0
> >  #define O2_SD_INF_MOD          0xF1
> >  #define O2_SD_MISC_CTRL4       0xFC
> >  #define O2_SD_MISC_CTRL                0x1C0
> > @@ -877,6 +878,12 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chi=
p *chip)
> >                 /* Set Tuning Windows to 5 */
> >                 pci_write_config_byte(chip->pdev,
> >                                 O2_SD_TUNING_CTRL, 0x55);
> > +               //Adjust 1st and 2nd CD debounce time
> > +               pci_read_config_dword(chip->pdev, O2_SD_MISC_CTRL2, &sc=
ratch_32);
> > +               scratch_32 &=3D 0xFFE7FFFF;
> > +               scratch_32 |=3D 0x00180000;
> > +               pci_write_config_dword(chip->pdev, O2_SD_MISC_CTRL2, sc=
ratch_32);
> > +               pci_write_config_dword(chip->pdev, O2_SD_DETECT_SETTING=
, 1);
> >                 /* Lock WP */
> >                 ret =3D pci_read_config_byte(chip->pdev,
> >                                            O2_SD_LOCK_WP, &scratch);
> >
> > base-commit: ee6050c8af96bba2f81e8b0793a1fc2f998fcd20
> > --
> > 2.25.1
> >
