Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1B3E557B
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351663; cv=pass; b=nc4i7NrLra082Rm5tcwzJO6tKloRSDVwRqDYjP7uyQ9kSuW9N4Ejkv3E/afcxZdBIHKpdQmGkln1lrWurnbHR23HkWCgDDzyJAAqabRJTCph1YDJzCn/kJjuzXQbPNZmx6iJaISDOFbu/GDfE9rakikZWFZ6TbX1wytyg/zTUKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351663; c=relaxed/simple;
	bh=WruA/OrVVNW3Iw+4tW1fNO2rdHOdLZuA+/8z18XSPMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hy42T/CuSG/DZmeqqqT+EVEd3A7CWPmpIkaud7vGngHnqmvBh3OrogUiS0K247J84DpqdW3ARCtu9noAncj3Jr21gxJ6t7hsWla2/fS5DA+g1MDTm1WGiddURyoV32oM9YAr4Al8DGFRHs6YuyZwxykWdg5AOKAJd2Posxat5nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=diisVevO; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="diisVevO"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a298acb395so638594e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 04:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774351660; cv=none;
        d=google.com; s=arc-20240605;
        b=VmobpGYrR49e/A4bS6vC4zeKzCyYaikO6HMYyXUFlLndIgVkIQUnKwZKUnwftpwiUO
         4Ty/aM6Om+fIQaV5D5HRiz1T5WzotMIF5ZNewvIroMX3QLb7eV/BhPHryIYOD6WGMBow
         9F2IwD/U4lqPTp3gI0raPdFpF6DHpiwvmGC4Qp+HOUt6+SB2zKw4NkTD8KHy0FpF53Kg
         E87aTNFAZP2YFZCfSsE2hswJNIEysD5rtPeDaOFFxvQtXzM1aXH55Ai6BDW81xmxFCzf
         iaDxzCW8GFcV073411pYY26Um8HyEQsdCxGRRjVJsg+rEPijFV8K2gjm6d6XURU4sS0u
         nPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4oWPLNnwCY4tTjrlQ6BXH2xr3eR3EascbFqTHSP4CbQ=;
        fh=5lypQMGjiBundxChueuaCESXEtyOWFXSxP+uokJNMTI=;
        b=JpRpXWbeaWX1XQAwnBY2bGRTVHhQz9gGBOwMJbliGWV7C5L2a5gFx0xAC42B1yt7ER
         StupEfCXjwtv6j+fCiVUSBqyV5LizY2f8hEqh2+KI3jpAcvVrXaN2vVMp9MxSRckuX7W
         LlavbGLGG7FQXAzjvrTH238D8SWFqxSss4UZxot/XFvWohQks7+t15zx17cd5UIgI+IW
         kPJ5IEqOVDjrq8LxZWLtcGT3RN1RURW/cIA3Mi9+hm0wOsye9Ttpp93r71LP0Sx/7Uu7
         rzj6XNmiAgDdhRJb9pmU2iDcWsJFxG0+qfSPAKS0YhYARMHkyGtjvnktzG++apHG1JbA
         fJMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774351660; x=1774956460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4oWPLNnwCY4tTjrlQ6BXH2xr3eR3EascbFqTHSP4CbQ=;
        b=diisVevO/UdtT2i2RLv5WGCQYOuuUfV25bKgn+57mfeEvxq/hy248VCVDnpw9jD6Ns
         KtIRtw/SYN+lrvRt9QzNA6EIdNj1hPvkykM4XfbSJsCjl8m++LZTndJRn2bNnG0ZdsRu
         +6SbJhXFJo3/FWCqPmeJN1yr5xrJ6y4WitlvEr4fe0lOTB85iAU1P2LEpZGhXRRdRE1j
         /ojwPlanmoJfTMOYPxpRZJb51GnRjaMnPPF9sM49lHGAUOLu2AIb6MggNxrt49PgNOMS
         Nx4NQP9kwgdpnWuINDm8G2hxqS3+nS6F5dbrGLLNPwYvhxKxYtKtzK4E6lShRIRCDWyt
         B69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774351660; x=1774956460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oWPLNnwCY4tTjrlQ6BXH2xr3eR3EascbFqTHSP4CbQ=;
        b=JZBuJ45COZPOX0rxvIIVAp+sf0hdY0xniXbgwFqv5S3MjkfeKiwj8b+iwdLPUVPVr7
         Qwvi4Zmd9RZvZDeM4Op8KwrVbyG6rB6New2aRUTm2jNxx+LqPe36Omu3dv3glI5wned1
         dM+pcJvNjV2fZRdeKMBEhCHskWA451MzNgkOBlmjpAeumIBG+/luMgaVrdZ2nXVwP00a
         hMhMB3BgIq6Vz83MEYZGeshMYllKYEnyPjCgxVO90C6RlaqBJT8rpZDOyMoDR5ifUj1o
         Rci47aRjUE1j0C5hjQck9enMackDpvzBH/Qp4j/3byGSsQWmYChPsxHIVWP7dGHsQmiF
         MlQg==
X-Forwarded-Encrypted: i=1; AJvYcCXzl9i7rgVuyulSTlN7JNCVkSfWA+VbsXfnVPWBae8QjnCjIiacG8WVr74nxhFRpQv4/HzctXpda5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyge5id6YBM0wKu6lH8axryA9WidTLGtDX9GY+8ggdtrQsP8MVm
	qMNGEy9TFHaYiocAwm9hqyuUSRi/9Xl1WefysysQkvFj6KPaTtlrFCBMpA8aviJndjp+FzRPZHh
	6rqLqf5qUQQdwJ62uPwwRyeEsqNZYTKWyUgquPwgMxripsVOAYest3wo=
X-Gm-Gg: ATEYQzxtqjrblf9lOSE9/NULKqfdj/0EBaw54sYtRNa4iJKQrw+koLII1grdYUfG5tg
	05v1JlyCgiLUsu5MRwL0pZTrUAAhEVAwWl0gWKoDNl+N53xgueqAV93qs7TfYt590SMfwAIanDU
	bHXSXQYv07eifcJcSMLYZ7XePg9lvHYswiH+OfG6ChMaXBfvcbKWOEfJF2LkE5OBH9sCkra+UeX
	PRW3HnNVtH3i1gnuTDU5AmD38xDMttQTAuqDfDhaW5NwPj29lihD19udHURaihnXwO87gLhELT5
	JIvZbBTk
X-Received: by 2002:a05:6512:1392:b0:5a2:7bc2:a385 with SMTP id
 2adb3069b0e04-5a285b6da3emr4915169e87.38.1774351659405; Tue, 24 Mar 2026
 04:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-2-sean@starlabs.systems> <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 12:27:03 +0100
X-Gm-Features: AQROBzD9wpiJRGm1yGgxEmniFrNfluCYdjekj25opNnqy0ZAFzA_JVtfsPPebkQ
Message-ID: <CAPDyKFo-E9jfBwxorbwURQi89sCqRK-gUQO87KER8074+L7gdg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matthew Schwartz <matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"

+ Matthew (again)

On Tue, 24 Mar 2026 at 12:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
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
