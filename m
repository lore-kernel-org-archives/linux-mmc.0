Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABB1D6DD2;
	Fri, 13 Sep 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222702; cv=none; b=lPDBuXzThryHC8O3xxpz7Uv7RROCy7lLmyY/yvDwvRM5fbAlRTe8vIKvWeKY1JEAfpBkxGSmN57rGD+/wV8if7hbGQ6Y/fNHqMD6bdhhhW6qqrpZUNxs0PWxXF0s/o5UGPlFcce4k19MdcxGDPY4T23vyCyj4p1BN3IQCWTD4YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222702; c=relaxed/simple;
	bh=G5VHsIOLoJKNmC7286GRBcx0rCdULiEcjrB5VOnWl0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHptlBT4CFlaHURiz0+eSDi7kAJ6jdm9oSDWWsws1w6Sy7jVqFyvBaoet3i4yqT+JLTVOf17zzfSLvgMIUR13/rvL29DVLHKuZGmms/eKrXG3VDRPhoQs5llV5fp7mengTxYwUu0qWh90mgV/0Gmt4sAV7ZcQHPpvrVQbVnq9bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdYdgcLC; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdYdgcLC"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-502af8a83daso208404e0c.1;
        Fri, 13 Sep 2024 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726222699; x=1726827499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebt5rXmslUsVvxy3W6snrIYq9mWVtFtTEgHgaeetp0g=;
        b=JdYdgcLCktRHLB+YtCpN5saeZ1vi4HV4H8Jx7/c4RMCccVUvtxTMgMFPyUSzGH8KNQ
         cN8eiTzAd89m4xa0t+1YMoE/FOT/WdLv8yJIE1Jgr0+ViT0aO6rX5A9jWdtvNHuc4SI5
         I+qBuv3gm6mRyUvZWCEuDBbpW5DVVBRBcFKQWHiqdKYS8bpBa7rKe39gMsHN8sTBzw/b
         kjG2PnvuMzT9uvlTZkV0NrFZz+haBagSRf72ucpEq+267J0ibddWhsr/FqIPzDCmSbT7
         tpqSY2xSGVVJgcdad+ezAMy7RYqA9s8DekozebXwSKj0LRfhx/rImsiCwKg++sWq2bpZ
         qlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726222699; x=1726827499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebt5rXmslUsVvxy3W6snrIYq9mWVtFtTEgHgaeetp0g=;
        b=WRBFBV/O9cfCmnDGca+FxsSgqkAg07eUEWEAsBFZnc0BK3x5ZePgWQ1PNDwrF+M6XD
         sdGlQ296JmWHSlrS5yRagORujURQxnlTxgfZeZ44rDu9eawjPuM8WGDAy3pl+/E8zngn
         YlLSVH1EvNCRP/KFQUOLDcvaarm+P1T2lqicxnyfim9X4TAlibdxdSqpVS2pXsDHGKSG
         rCmu08f6yF5B4C3DGeW8zCGXCJ/qk54eDylwhsqKLx6NelGbAouk7fuivg5bNcbBZAQT
         icakoipSG415dWx+vUJvGilVfW8ZzDr3nLMnN5QSvXitOqcbX8rYtH51T/rZRrC+Bujq
         GUeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLJHlMkoRFMWmYn9O1doa1fYjeb+zWr60y0xHC3jx0mkV3+nfodSzblvHbBEZ8LiQsjCo11KSRxDFL@vger.kernel.org, AJvYcCXeHIQB4G89kd+OLwlJcRaQ11C8kjhR9Zk+zrlvegH8mZbn1QKnkNehX7VeDIxYehZMTri6/rGEvW7P5WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydyKxhTZicJXY8v74sPguqqYDq1Y8nXh3ALLV0pDOezqdlzELN
	KIfvdhH//UVgDNFaTEwB4e0DzmS/am9z6odVagSWdGqUTu5i1VVK9dK9/az9q19YCW1BL7tcWZv
	NERHJy5JbhOjhwFg9MhcH33IOlok=
X-Google-Smtp-Source: AGHT+IGDOtyEk6kex22svtjFmJ+gvyljjjrjs1ogs5EF68g89qMapcHyQTMxGSiF4/PpKyNaY1dMbhq606jzUe9rcm4=
X-Received: by 2002:a05:6122:1d0b:b0:4f6:a7f7:164d with SMTP id
 71dfb90a1353d-50344e2d40dmr1122489e0c.8.1726222699432; Fri, 13 Sep 2024
 03:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906102049.7059-1-victorshihgli@gmail.com>
 <20240906102049.7059-15-victorshihgli@gmail.com> <12073898-a98b-46dd-ad68-5d58340a7952@intel.com>
In-Reply-To: <12073898-a98b-46dd-ad68-5d58340a7952@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 13 Sep 2024 18:18:03 +0800
Message-ID: <CAK00qKBoCk09y2DtojPPpP_y9grBuArMS5gh9zH+DGPff7vV8A@mail.gmail.com>
Subject: Re: [PATCH V21 14/22] mmc: sdhci-uhs2: add set_ios()
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	Lucas.Lai@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 4:08=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 6/09/24 13:20, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > This is a sdhci version of mmc's set_ios operation.
> > THis is used to handle basic IO bus setting.
> > It covers both UHS-I and UHS-II.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Doesn't seem to compile:
>
> drivers/mmc/host/sdhci-uhs2.c:275:12: error: =E2=80=98sdhci_uhs2_set_ios=
=E2=80=99 defined but not used [-Werror=3Dunused-function]
>   275 | static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_io=
s *ios)
>       |            ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:244: drivers/mmc/host/sdhci-uhs2.o] =
Error 1
> make[4]: *** [scripts/Makefile.build:485: drivers/mmc/host] Error 2
> make[3]: *** [scripts/Makefile.build:485: drivers/mmc] Error 2
> make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
> make[1]: *** [/home/ahunter/git/review/Makefile:1925: .] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
>
>
> Please check all patches compile.
>
>

Hi, Adrian

I will correct this issue and check all patches in the next version.

Thanks, Victor Shih

> > ---
> >
> > Updates in V14:
> >  - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
> >    sdhci_uhs2_set_ios().
> >
> > Updates in V13:
> >  - Add judgment condition for power mode in the __sdhci_uhs2_set_ios().
> >  - Modify comment message.
> >
> > Updates in V9:
> >  - Simplity the turning_on_clk in sdhci_set_ios().
> >
> > Updates in V8:
> >  - Add the judgment formula for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED=
_B
> >    and MMC_TIMING_SPEED_B_HD in __sdhci_uhs2_set_ios().
> >  - Add the switch case for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
> >    and MMC_TIMING_SPEED_B_HD in sdhci_get_preset_value().
> >  - mmc_opt_regulator_set_ocr() to instead of mmc_regulator_set_ocr()
> >    in sdhci_uhs2_set_ios().
> >
> > Updates in V7:
> >  - Remove unnecessary functions.
> >
> > Updates in V6:
> >  - Modify return value in some functions.
> >  - Remove unnecessary functions.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-uhs2.c | 95 +++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h |  1 +
> >  drivers/mmc/host/sdhci.c      | 55 ++++++++++++--------
> >  drivers/mmc/host/sdhci.h      |  2 +
> >  4 files changed, 132 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs=
2.c
> > index 8bd2baa79d76..abb56ab8f916 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.c
> > +++ b/drivers/mmc/host/sdhci-uhs2.c
> > @@ -207,6 +207,101 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *ho=
st, struct mmc_command *cmd)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
> >
> > +/**
> > + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable regis=
ter
> > + * @host:    SDHCI host
> > + * @clear:   bit-wise clear mask
> > + * @set:     bit-wise set mask
> > + *
> > + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> > + */
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set)
> > +{
> > +     u32 ier;
> > +
> > +     ier =3D sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
> > +     ier &=3D ~clear;
> > +     ier |=3D set;
> > +     sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
> > +     sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> > +
> > +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios =
*ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     u8 cmd_res, dead_lock;
> > +     u16 ctrl_2;
> > +
> > +     /* UHS2 Timeout Control */
> > +     sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> > +
> > +     /* change to use calculate value */
> > +     cmd_res |=3D FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead=
_lock);
> > +
> > +     sdhci_uhs2_clear_set_irqs(host,
> > +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
> > +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
> > +                               0);
> > +     sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> > +     sdhci_uhs2_clear_set_irqs(host, 0,
> > +                               SDHCI_UHS2_INT_CMD_TIMEOUT |
> > +                               SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
> > +
> > +     /* UHS2 timing. Note, UHS2 timing is disabled when powering off *=
/
> > +     ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +     if (ios->power_mode !=3D MMC_POWER_OFF &&
> > +         (ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A ||
> > +          ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_A_HD ||
> > +          ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B ||
> > +          ios->timing =3D=3D MMC_TIMING_UHS2_SPEED_B_HD))
> > +             ctrl_2 |=3D SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
> > +     else
> > +             ctrl_2 &=3D ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
> > +     sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +     host->timing =3D ios->timing;
> > +
> > +     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> > +             sdhci_enable_preset_value(host, true);
> > +
> > +     if (host->ops->set_power)
> > +             host->ops->set_power(host, ios->power_mode, ios->vdd);
> > +     else
> > +             sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> > +
> > +     sdhci_set_clock(host, host->clock);
> > +}
> > +
> > +static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *io=
s)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +
> > +     pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> > +              mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd=
, ios->timing);
> > +
> > +     if (!mmc_card_uhs2(mmc)) {
> > +             sdhci_set_ios(mmc, ios);
> > +             return 0;
> > +     }
> > +
> > +     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > +             return 0;
> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (ios->power_mode =3D=3D MMC_POWER_OFF) {
> > +                     mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, =
0);
> > +                     mmc_regulator_set_vqmmc2(mmc, ios);
> > +             }
> > +             return -1;
> > +     }
> > +
> > +     sdhci_set_ios_common(mmc, ios);
> > +
> > +     __sdhci_uhs2_set_ios(mmc, ios);
> > +
> > +     return 0;
> > +}
> > +
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
> > index 9bd3f610cf8c..f6649a518842 100644
> > --- a/drivers/mmc/host/sdhci-uhs2.h
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -181,5 +181,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
> >  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> >  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,=
 unsigned short vdd);
> >  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_comman=
d *cmd);
> > +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32=
 set);
> >
> >  #endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 366c3d30dba6..63fa1714930a 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -47,8 +47,6 @@
> >  static unsigned int debug_quirks =3D 0;
> >  static unsigned int debug_quirks2;
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool en=
able);
> > -
> >  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_com=
mand *cmd);
> >
> >  void sdhci_dumpregs(struct sdhci_host *host)
> > @@ -1877,6 +1875,12 @@ static u16 sdhci_get_preset_value(struct sdhci_h=
ost *host)
> >       case MMC_TIMING_MMC_HS400:
> >               preset =3D sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
> >               break;
> > +     case MMC_TIMING_UHS2_SPEED_A:
> > +     case MMC_TIMING_UHS2_SPEED_A_HD:
> > +     case MMC_TIMING_UHS2_SPEED_B:
> > +     case MMC_TIMING_UHS2_SPEED_B_HD:
> > +             preset =3D sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> > +             break;
> >       default:
> >               pr_warn("%s: Invalid UHS-I mode selected\n",
> >                       mmc_hostname(host->mmc));
> > @@ -2323,24 +2327,9 @@ static bool sdhci_presetable_values_change(struc=
t sdhci_host *host, struct mmc_i
> >              (sdhci_preset_needed(host, ios->timing) || host->drv_type =
!=3D ios->drv_type);
> >  }
> >
> > -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >       struct sdhci_host *host =3D mmc_priv(mmc);
> > -     bool reinit_uhs =3D host->reinit_uhs;
> > -     bool turning_on_clk =3D false;
> > -     u8 ctrl;
> > -
> > -     host->reinit_uhs =3D false;
> > -
> > -     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > -             return;
> > -
> > -     if (host->flags & SDHCI_DEVICE_DEAD) {
> > -             if (!IS_ERR(mmc->supply.vmmc) &&
> > -                 ios->power_mode =3D=3D MMC_POWER_OFF)
> > -                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > -             return;
> > -     }
> >
> >       /*
> >        * Reset the chip on each power off.
> > @@ -2357,8 +2346,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct m=
mc_ios *ios)
> >               sdhci_enable_preset_value(host, false);
> >
> >       if (!ios->clock || ios->clock !=3D host->clock) {
> > -             turning_on_clk =3D ios->clock && !host->clock;
> > -
> >               host->ops->set_clock(host, ios->clock);
> >               host->clock =3D ios->clock;
> >
> > @@ -2374,6 +2361,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct =
mmc_ios *ios)
> >                       mmc->max_busy_timeout /=3D host->timeout_clk;
> >               }
> >       }
> > +}
> > +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> > +
> > +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +     struct sdhci_host *host =3D mmc_priv(mmc);
> > +     bool reinit_uhs =3D host->reinit_uhs;
> > +     bool turning_on_clk;
> > +     u8 ctrl;
> > +
> > +     host->reinit_uhs =3D false;
> > +
> > +     if (ios->power_mode =3D=3D MMC_POWER_UNDEFINED)
> > +             return;
> > +
> > +     if (host->flags & SDHCI_DEVICE_DEAD) {
> > +             if (!IS_ERR(mmc->supply.vmmc) &&
> > +                 ios->power_mode =3D=3D MMC_POWER_OFF)
> > +                     mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +             return;
> > +     }
> > +
> > +     turning_on_clk =3D ios->clock !=3D host->clock && ios->clock && !=
host->clock;
> > +
> > +     sdhci_set_ios_common(mmc, ios);
> >
> >       if (host->ops->set_power)
> >               host->ops->set_power(host, ios->power_mode, ios->vdd);
> > @@ -2942,7 +2954,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u3=
2 opcode)
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
> >
> > -static void sdhci_enable_preset_value(struct sdhci_host *host, bool en=
able)
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> >  {
> >       /* Host Controller v3.00 defines preset value registers */
> >       if (host->version < SDHCI_SPEC_300)
> > @@ -2970,6 +2982,7 @@ static void sdhci_enable_preset_value(struct sdhc=
i_host *host, bool enable)
> >               host->preset_enabled =3D enable;
> >       }
> >  }
> > +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
> >
> >  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *m=
rq,
> >                               int err)
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 0f78708d0c70..5c66927210bd 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -848,6 +848,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask);
> >  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)=
;
> >  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
> >  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> > +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> > +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
> >  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
> >  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
> >                                     struct mmc_ios *ios);
>
