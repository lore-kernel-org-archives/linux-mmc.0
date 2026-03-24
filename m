Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0F3E63AF
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353580; cv=pass; b=LodDPswnTEWdDRF2dhE90qtGcWBuB5BagoxINpVnQE9+fN9/8wfCvsB92FrSpQM23bIK6jHwAJZYquEs05ICGLSRSWwhlHxjLjVvJmMwYj4rVvVHc4R2ViKwv7+POd087jKdzzovP/EBKUSw3EeVXHGliyMQlzPmB1tbFSFdGu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353580; c=relaxed/simple;
	bh=TwyGYxCeCrqU49q7U6WQE3A9PiZJMj+lKUEL9TuCDrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNSxibbLRS1GV5QUugVhvO3b/tcyTQ6S0BdrFboPFivC+opO7ZBQC5y5pFWyq0YlfNvi7yRXO3bl5qESSxwrVlhRMDP4ZgpxZ6a8rLUIfP1ln7Ge6fTke7/BgSRHcwVruu6/YXKsTNLDUOH2qB4iocV5oeGnld9yyxDM3C9kH6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=a2jaBNYN; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="a2jaBNYN"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79ac5de41d8so5061367b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 04:59:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774353577; cv=none;
        d=google.com; s=arc-20240605;
        b=Xx1A0utnJsUjQr0K4wxIWoLM3x4R3Mygrtqsi/guXm13XbvURgjEUUgDGJBHxSIBkE
         xup22G46oBlRff/7BteumissqFthYynp5E8K5QefSNQW5rt0JF3RePuSs46SIHMD3kMq
         sW1hOBz1YUUwF7lYMZ8SGVXY98lOHv1WBgvUPRSjkA4+xS+CiwgNQmUtbPFHItrt7Ak9
         uxYQXutxDTn7ZujsnUX7x4DfpGc79hExLpaPjbwF6X1eGLajApDE/Z0s03Iq0FkPXxxH
         3MmaW9P+A8OZU47yDLp7pGeBR/7vsRAmBT3YCqkHKf563wQBMWflavsHsh6iHGWOjrdt
         tLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rwrkAeRmIKG5gR5nurvO7SBRY6CV+kf2/58FkRLS2x0=;
        fh=0YJMrUyBmGK/zepQEpyEcG/AdZDB7EUzLRXyetjD3eQ=;
        b=V/g9O2rpsD+4Ff+iFzPgwAuvxBZujdVqvgnfWv9YzS1ZT/izt5g5FYwn/uTE4NOBpq
         7sLU+15EnoAbJVjLPQkOh2ZyG1QcYIFGGWybJwu0jSU7veBOZplN11eUPy+sB+xTe/2j
         YnAjnmiqXlUFsl4XMw63/8JzamZJ56RWlUlkzY00NTpZIFQfL/axhV4MV7vRGg5rD2DX
         SqxC8bqPqmszTcRLNKKvN2R2NGtVf9y2tDKKIi9J9YygqoUnkvns7APKX+g/sHb8quxb
         3QOCXYKsWJGc46D2XWtM/6yyXqX4eWzwcQw7eCtTxIeJ1URj65TNnN5JBJ/8KZhYG/84
         cPZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1774353577; x=1774958377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwrkAeRmIKG5gR5nurvO7SBRY6CV+kf2/58FkRLS2x0=;
        b=a2jaBNYNHelUpuQ3Rtj3QhILqBBJG1Pzvujof4lBjODBgJPP1kBDk9p1B2o0NT/j+J
         4ryNLObPgZswEkqXLN7hPH9/1Y8OkWKokHLLgeUoO41qwscZsRvpytwPYKIUojXyHre1
         9jmBJabyRKfh0+6b/M0BVffXDF03O3WqrY3yKO9ug0C1h4ZNiPWJ5Ek68tUzSxX3txk8
         2eM4Zolf4f5wX5Wb0Gid7KQ4UJsaOny2MEnplGosEwGGR4M+OZyko7uZDu2AAAjGZySl
         j+PccS1r644EgLNXUmSC+bw7GftJ2Yia5qsw+Nz0cLicXAEYTuocn6T036pU/FuxqA3B
         7qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353577; x=1774958377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwrkAeRmIKG5gR5nurvO7SBRY6CV+kf2/58FkRLS2x0=;
        b=MU33/Lxx6uPxp15dDc6nZMzWT1CPtuVfn+A+krg9xp03eqMYE7wEHcqgqyQcGEjpx2
         GtvEXqFDuBFYMkC01WFJnsUdmX0MB0zFtzFwDeapug83Hw3u+hlx2Iz1hSoGNo/TZojD
         XiEW4d8Kq/Oh8Ixrdq7Z+68TBOZZQmOxFDgkUXkMTEuJ4cB6NSiJGgchG9SiNKukXBBr
         XYquOoDQYiqyu8nsJyUbx0uxtF7OSMJ+UYV7HKkzCo7/j/qF7n7jhGHJHB6DSHyE1lg9
         b4FW+DOkMLkIxD2U09IXMeroZDfVuNk6d26kWBg89P5xRWpfPEAG7xboQfWfMACy0En8
         fEfw==
X-Forwarded-Encrypted: i=1; AJvYcCV1FWEqwdiA2qFqjyh/o6tJvS1BiiY374RDnO618PDQoGl/FXi9zDt4xrWBm1X6vdmUwgA87GHQHuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkwTcL/cDTwwu+6cshTbJyQ+zaZi1cIUqEU2PjFxud6PubU77c
	tn+TXGyRdNu8eYgbzvw0LV90Xx5bHoV9xzc3hbsYHEVNZFw432jOZWtrheP8Dm31Y/bLMFOgocG
	dlpyptc+TN130f6R6lGpUNdJpCAXrhS43kQIwmrTY
X-Gm-Gg: ATEYQzzduFAj712sKkmn8H/+PaWwdkabYhxqIaIVz4tu+p2jvD2Cr9IauyQrV7Wuc/c
	0y0s/KaZtUx/aH6fagXYL1ndKv7rbV419qiSn1cKo9s7WQIJIwNNIvIV6ddW6LSJxOSi93pyRty
	1vWDV1QIDhXRA43vbRzOvNK49/cr4efZp3+bLJAMXyuyzFYKWBdcsDaYR6jKamGsO+D97jh/42r
	VxzgfTa51bl2bjWGEi9owyTOuSfUyO55JOyLLaDtNDjEcxxolN+hyke65k8ZokvXO0kUjR0TiFU
	9mcSbuSRHQeSg7vUf6SRDNYliZG9UMPzn4tzyZ9S
X-Received: by 2002:a05:690c:2605:b0:79a:7157:879 with SMTP id
 00721157ae682-79a90bf0fc3mr159866277b3.50.1774353577243; Tue, 24 Mar 2026
 04:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-2-sean@starlabs.systems> <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 24 Mar 2026 11:59:26 +0000
X-Gm-Features: AQROBzBKrF0tUR8r4RqTniPvzB5wt5HOZXKTpirhOOqqUDLPYcPDNb3VQl3-kuE
Message-ID: <CABtds-26cuCMZbRhAaioOOCcX=w6J_mpCxgxahjwz7QJEZqe5Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Uffe

Thanks for the feedback - to answer your questions:

> Would you mind elaborating on this so I can better understand the problem?

SD_CD is used for presence, but that's asserted by trays or blanking cards.

> What prevents the MMC core from handling this correctly?
>
> Don't some of the commands time out, eventually causing mmc_rescan() to bail out?

It does bail out, but SD_CD is still asserted, so it tries again. The
main thing this breaks is S3 entry - it's either slow (like 100
seconds), or never gets there.

> I guess one key piece of information I'm missing is what happens when the mmc_recsan() work tries to send commands to initialize a card, when there is no card inserted?

They fail, and we use that result.
On Tue, 24 Mar 2026 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + Matthew Schwartz
>
> On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
> >
> > Some Realtek USB SD readers with a tray can assert SD_CD even when no
> > card is present. This can make the MMC core believe a card exists and
> > trigger unnecessary initialization and suspend/shutdown failures.
>
> Would you mind elaborating on this so I can better understand the problem?
>
> >
> > Debounce the CD signal and validate a newly detected card by probing for
> > a response (CMD0 + CMD8/CMD55/CMD1) before reporting it present. Also
> > treat SD_INT as a removal indication even if SD_CD stays asserted.
>
> What prevents the MMC core from handling this correctly?
>
> Don't some of the commands time out, eventually causing mmc_rescan()
> to bail out?
>
> >
> > Tested: Realtek RTS5129 (0bda:0129), tray inserted, no card (2026-02-24)
> > Tested: Realtek RTS5129 (0bda:0129), tray + SDXC card, mmcblk0 (2026-02-24)
> >
> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
>
> I have looped in Matthew who recently worked on some similar problems
> for the PCI variant [1] of the driver. Perhaps he and Ricky have some
> input on this series too.
>
> [1]
> https://lore.kernel.org/all/20260105060236.400366-1-matthew.schwartz@linux.dev/
>
> Please see a few more comments below.
>
> > ---
> >  drivers/mmc/host/rtsx_usb_sdmmc.c | 156 ++++++++++++++++++++++++++++--
> >  1 file changed, 148 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > index 84674659a84d..ec3eeea78e95 100644
> > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/scatterlist.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> > +#include <linux/jiffies.h>
> >
> >  #include <linux/rtsx_usb.h>
> >  #include <linux/unaligned.h>
> > @@ -30,6 +31,9 @@
> >  #define RTSX_USB_USE_LEDS_CLASS
> >  #endif
> >
> > +#define RTSX_USB_SD_CD_DEBOUNCE_CNT    2
> > +#define RTSX_USB_SD_INSERT_RETRY_MS    1000
> > +
> >  struct rtsx_usb_sdmmc {
> >         struct platform_device  *pdev;
> >         struct rtsx_ucr *ucr;
> > @@ -46,6 +50,8 @@ struct rtsx_usb_sdmmc {
> >         bool                    card_exist;
> >         bool                    initial_mode;
> >         bool                    ddr_mode;
> > +       u8                      cd_debounce;
> > +       unsigned long           next_insert_check;
> >
> >         unsigned char           power_mode;
> >         u16                     ocp_stat;
> > @@ -72,6 +78,13 @@ static inline void sd_clear_error(struct rtsx_usb_sdmmc *host)
> >         rtsx_usb_clear_fsm_err(ucr);
> >  }
> >
> > +static int sd_set_bus_width(struct rtsx_usb_sdmmc *host,
> > +                           unsigned char bus_width);
> > +static int sd_set_timing(struct rtsx_usb_sdmmc *host,
> > +                        unsigned char timing, bool *ddr_mode);
> > +static int sd_power_on(struct rtsx_usb_sdmmc *host);
> > +static int sd_power_off(struct rtsx_usb_sdmmc *host);
> > +
> >  #ifdef DEBUG
> >  static void sd_print_debug_regs(struct rtsx_usb_sdmmc *host)
> >  {
> > @@ -768,12 +781,94 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
> >         return 0;
> >  }
> >
> > +static bool sdmmc_validate_insert_locked(struct rtsx_usb_sdmmc *host)
> > +{
> > +       struct rtsx_ucr *ucr = host->ucr;
> > +       struct mmc_command cmd = { };
> > +       int err = 0;
> > +       bool probe_powered = false;
> > +       bool ddr_mode = false;
> > +
> > +       /*
> > +        * Some readers with a tray assert the mechanical SD_CD pin even when no
> > +        * card is present. Only report a card present when it responds to a
> > +        * minimal reset/probe sequence, similar to the old rts5139 behavior.
> > +        *
> > +        * Must be called with ucr->dev_mutex held.
> > +        */
> > +       if (host->power_mode == MMC_POWER_OFF) {
> > +               err = sd_power_on(host);
> > +               if (err)
> > +                       return false;
> > +               probe_powered = true;
> > +
> > +               /* Issue clock signals to card for at least 74 clocks. */
> > +               rtsx_usb_write_register(ucr, SD_BUS_STAT,
> > +                                       SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
> > +               usleep_range(200, 400);
> > +               rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0);
> > +       }
> > +
> > +       /*
> > +        * Ensure the interface is in a safe, legacy / initial-clock mode before
> > +        * probing for a response. The MMC core may not have configured ios yet.
> > +        */
> > +       err = sd_set_bus_width(host, MMC_BUS_WIDTH_1);
> > +       if (err)
> > +               goto out;
> > +
> > +       err = sd_set_timing(host, MMC_TIMING_LEGACY, &ddr_mode);
> > +       if (err)
> > +               goto out;
> > +
> > +       ucr->cur_clk = 0;
> > +       err = rtsx_usb_switch_clock(ucr, 400000, SSC_DEPTH_512K,
> > +                                   true, true, false);
> > +       if (err)
> > +               goto out;
> > +
> > +       cmd.opcode = MMC_GO_IDLE_STATE;
> > +       cmd.arg = 0;
> > +       cmd.flags = MMC_RSP_NONE | MMC_CMD_BC;
> > +       sd_send_cmd_get_rsp(host, &cmd);
> > +
> > +       /* SD v2.0+: CMD8 */
> > +       cmd.opcode = SD_SEND_IF_COND;
> > +       cmd.arg = 0x1aa;
> > +       cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
> > +       sd_send_cmd_get_rsp(host, &cmd);
> > +       if (!cmd.error)
> > +               goto out;
> > +
> > +       /* SD v1.x: CMD55 */
> > +       cmd.opcode = MMC_APP_CMD;
> > +       cmd.arg = 0;
> > +       cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > +       sd_send_cmd_get_rsp(host, &cmd);
> > +       if (!cmd.error)
> > +               goto out;
> > +
> > +       /* MMC: CMD1 */
> > +       cmd.opcode = MMC_SEND_OP_COND;
> > +       cmd.arg = 0;
> > +       cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
> > +       sd_send_cmd_get_rsp(host, &cmd);
> > +
> > +out:
> > +       if (probe_powered)
> > +               sd_power_off(host);
> > +       return !err && !cmd.error;
> > +}
>
> No, the above code doesn't belong in an MMC host driver.
>
> I will try to guide you toward a better solution, but first I need to
> understand the problem better.
>
> I guess one key piece of information I'm missing is what happens when
> the mmc_recsan() work tries to send commands to initialize a card,
> when there is no card inserted?
>
> > +
> >  static int sdmmc_get_cd(struct mmc_host *mmc)
> >  {
> >         struct rtsx_usb_sdmmc *host = mmc_priv(mmc);
> >         struct rtsx_ucr *ucr = host->ucr;
> >         int err;
> >         u16 val;
> > +       u8 pend;
> > +       bool sd_int = false;
> > +       bool cd_raw = false;
> >
> >         if (host->host_removal)
> >                 return -ENOMEDIUM;
> > @@ -782,28 +877,71 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
> >
> >         /* Check SD card detect */
> >         err = rtsx_usb_get_card_status(ucr, &val);
> > -
> > -       mutex_unlock(&ucr->dev_mutex);
> > -
> > -       /* Treat failed detection as non-exist */
> >         if (err)
> > -               goto no_card;
> > +               goto no_card_unlock;
> >
> >         /* get OCP status */
> >         host->ocp_stat = (val >> 4) & 0x03;
> >
> > -       if (val & SD_CD) {
> > -               host->card_exist = true;
> > +       cd_raw = !!(val & SD_CD);
> > +
> > +       /* Use SD_INT as a reliable removal indication on some tray readers. */
> > +       err = rtsx_usb_read_register(ucr, CARD_INT_PEND, &pend);
> > +       if (!err) {
> > +               sd_int = !!(pend & SD_INT);
> > +               if (sd_int)
> > +                       rtsx_usb_write_register(ucr, CARD_INT_PEND,
> > +                                               SD_INT, SD_INT);
> > +       }
> > +
> > +       if (!cd_raw) {
> > +               host->cd_debounce = 0;
> > +               host->next_insert_check = 0;
> > +               goto no_card_unlock;
> > +       }
> > +
> > +       /*
> > +        * rts5139-style: when a card is already known present, treat SD_INT as
> > +        * a removal event even if SD_CD stays high (e.g. tray-based readers).
> > +        */
> > +       if (host->card_exist) {
> > +               if (sd_int) {
> > +                       host->cd_debounce = 0;
> > +                       host->next_insert_check = 0;
> > +                       goto no_card_unlock;
> > +               }
> > +               mutex_unlock(&ucr->dev_mutex);
> >                 return 1;
> >         }
> >
> > -no_card:
> > +       /* Debounce mechanical CD before probing for a response. */
> > +       if (host->cd_debounce < RTSX_USB_SD_CD_DEBOUNCE_CNT) {
> > +               host->cd_debounce++;
> > +               goto no_card_unlock;
> > +       }
> > +
> > +       /* Avoid pounding the bus with probes if CD is stuck asserted. */
> > +       if (time_before(jiffies, host->next_insert_check))
> > +               goto no_card_unlock;
> > +
> > +       if (!sdmmc_validate_insert_locked(host)) {
> > +               host->next_insert_check = jiffies +
> > +                       msecs_to_jiffies(RTSX_USB_SD_INSERT_RETRY_MS);
> > +               goto no_card_unlock;
> > +       }
> > +
> > +       host->card_exist = true;
> > +       mutex_unlock(&ucr->dev_mutex);
> > +       return 1;
> > +
> > +no_card_unlock:
> >         /* clear OCP status */
> >         if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
> >                 rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
> >                 host->ocp_stat = 0;
> >         }
> >         host->card_exist = false;
> > +       mutex_unlock(&ucr->dev_mutex);
> >         return 0;
> >  }
> >
> > @@ -1359,6 +1497,8 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
> >
> >         host->power_mode = MMC_POWER_OFF;
> >         host->ocp_stat = 0;
> > +       host->cd_debounce = 0;
> > +       host->next_insert_check = 0;
> >  }
> >
> >  static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
> > --
> > 2.51.0
>
> Kind regards
> Uffe
