Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F23E557B
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351619; cv=pass; b=ISsqoy2Lr8yoG93/qyU0rfvymE9ZDFsR2HTZpMr1TfOfTcaEq9iAE9V8cBXlAO/wzKyf/nqfXscmrKH+UWfIti2uHJHYeW5wjM6vH7Dyqce+PkzrAzWUKNP05DR5TZzwHqC5h210BEEpZIME6I8/t0Pr/vTMczAI9Wf8tM/X2vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351619; c=relaxed/simple;
	bh=dsSAS+4luK32a3XXe/6EzxGdBYJhxA4ndW2fFSOPp3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZbiSJIOMxI2jWRobjb3HBwUDEa787ss426Uc1tXYmqsj27kj20e905jkimHcYiwNgK/uwWw/n09ev53x71LJ8JDpw+jWFM9lnwcX7kfUSB5PbkaW6jSz5+MJDPY8HimjIQz7XsSrSx2mMCVx/HlaxNDB2iAxFgVRusim8ZbmJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YAUPyw6P; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAUPyw6P"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a279ce9475so5177645e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 04:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774351615; cv=none;
        d=google.com; s=arc-20240605;
        b=eaLtyncUOO/37DZA6VEBGTKImDgxpnbBm9mTTdau69l1uShse2fNkmk8ISIokI6oa/
         GeCSq1U95fWMuV/uLG5Ei104ZFEVdwJqUEE623HBKcVoA1RYUT6tFp8FQmr7tnTza5dg
         yW0/6YPU11xLiJsdVXHnWUttR5XTjR3+0xrPeGFMT23tKQerCAOmTbvVX9qTkK58X64F
         cVvw+QWGcq6wXQezmKzv6wBvEmF8u8XmI+7R87hcFNWj20PFvJ/uLoScbFRfTe9/sVau
         yhhGx17UmSyVT2WYk63qOHZjWtqv0ub4HtSC/trDZcFGt2xku3U/LRqKdXamiHkH60uc
         ToxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y+SchkN7o51EdvxQAveeLWkl2WKUDaJuclYpM8IY9R8=;
        fh=Gjju5xHnCbty6kv0HDwjmPeqIgfNtmX3DQL/DxlZ0dA=;
        b=eXmWa8EyaqsdESGFgCRQ6TG7n63HanomqrCo/F42FTSBUa9DTqGv9Sg8SKryiTjeq1
         SXrrL29XbwY2q1hG1l6iXQONsJIfN43UbVtucSY0iOf9PcDsfzpnfnVolxceXXaD3dw2
         rD7LP9RNPhhKioPjQ41X2lUXuKWpYzGshZ7c3TjAk/A9iYQQ4RVN5aBERepoM9NGKWAP
         totkaaD2LoNQsbPuPLhHwu8ASRUUQh0Qb9KhC7ZrLrj0ROLaECpPZoRlY78gZwyzFKqd
         57X9k2f8Rph9BQ3a5tWyrb3dyPHJDOFyF22U+elqGFogklT7i+3cQcqHkVP3Cc7kV46i
         PYGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774351615; x=1774956415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+SchkN7o51EdvxQAveeLWkl2WKUDaJuclYpM8IY9R8=;
        b=YAUPyw6PE/PxMGWxQYZTc37hUxajLhrMh8w287ZGWEiD73E9rxWylg3fkEyGnwAOnL
         kcNM+koYuybHgYPC7E88E1laUm8rDsc/vtd4Ahg1WyH/qE9j0mQaYaF6tAFeI1pZZ1EQ
         +oPNoM0P07Pa0f0r1fi6KgIwJn+38oVfcchMdJy8HjU4THhkkSp5rng2G98cPeVDD5yh
         ZBRof5q1YgG4nf/PDpiDovxYPbFDKAl0/J6Y+mFZnNSjuDvdHZQumX56497OFDsrQsFJ
         CnIhIgNh1IIZ73xpwndpILRJYSfE6LESCtMVUXR6MEzC+XpnrHt3HEQ6O43GoQSeQqPh
         jr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774351615; x=1774956415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+SchkN7o51EdvxQAveeLWkl2WKUDaJuclYpM8IY9R8=;
        b=n1h1WZWo4FjDk9IHlsQFGN0QNiPnHOsgEqtRX/h0ijDn7BeN5HHBfpGxmHrSUR05bj
         HNggJq5LcemV2Hl2+RX81k7FAubM/yW2ojO0BVNMi0APsrSIcjb0cG5oeBehtj8M/yA/
         Ht1DNiXFi9K/GP5l8cKrPEfsw8hjsZCYimIMKCvRc33E3U0yn9RxK0xKw5APX6VLlCKL
         4+wFOef+e2LKj7hxtEugSEpYgl3z3rK9qr2jBMM5iBtxgEWkcMe9JtMMihs/Fu1MjP/C
         Iqu1o62LCDibBNx+z4iBzo4GkNbKP8aM76fbgdqgU5780xnkph2khCz8wLvs6A6or4Qm
         fP4A==
X-Forwarded-Encrypted: i=1; AJvYcCVKU0gFyk1rxjvCQg510Mgcj7rtLLauALYBPCYFZxO1ZqJ4wep9a/euknYEvn8kj4l51AhEJ9Q0eX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxoSwot4kHW97J7afSVUcTANHJNQn8Cl8q0ABr0NT/GRUmtxOR
	unMvmjIdLpPoBx5n2LLXijr8L7NlUPjIwO3DiLf3DpCOMeHHQhNgfDaAt3b8y3UMV/+6c2vH/Pq
	os6BVHHV3WTL/hKfe/O9OhDIrHNnnfL27y+yKFF91qUz2SZMS5giUlPzZyA==
X-Gm-Gg: ATEYQzzX/ELMkFBzMj0vwvk7nsvCbIg9c6rfTSiz5zM5T3VbtyoYtK+Td69sWJ/hM8q
	L07xtVVdEsp31jo9BtJtRCbTq9MOt2uICtf9iOo4IDXI9z3HoseHjUepSoTLp3fECKjFphJtR1o
	sxuPfAp2iFPx1M/U0wYg9b1HU/1bmV0eyX7mc3KxLxXT7T0KqBzyNtPecfIxMquhtqMvDd1lyGZ
	Ls1n9LmNPZgAsWddI2bnN1SrEYsp4Z6ukOFKuK1krxVmppcn+jX17VPPdKYCZOLN5uqmorguiVC
	aJ9//hAf
X-Received: by 2002:a05:6512:220f:b0:5a1:742d:277f with SMTP id
 2adb3069b0e04-5a2961ffafdmr1081786e87.11.1774351614392; Tue, 24 Mar 2026
 04:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-2-sean@starlabs.systems>
In-Reply-To: <20260312121559.19197-2-sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 12:26:18 +0100
X-Gm-Features: AQROBzCLlT0ssScoUIT3MKqeU25zR69LveWYILymSjFtU4Zk_Ykt9qF1lihy88U
Message-ID: <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Matthew Schwartz

On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
>
> Some Realtek USB SD readers with a tray can assert SD_CD even when no
> card is present. This can make the MMC core believe a card exists and
> trigger unnecessary initialization and suspend/shutdown failures.

Would you mind elaborating on this so I can better understand the problem?

>
> Debounce the CD signal and validate a newly detected card by probing for
> a response (CMD0 + CMD8/CMD55/CMD1) before reporting it present. Also
> treat SD_INT as a removal indication even if SD_CD stays asserted.

What prevents the MMC core from handling this correctly?

Don't some of the commands time out, eventually causing mmc_rescan()
to bail out?

>
> Tested: Realtek RTS5129 (0bda:0129), tray inserted, no card (2026-02-24)
> Tested: Realtek RTS5129 (0bda:0129), tray + SDXC card, mmcblk0 (2026-02-24)
>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>

I have looped in Matthew who recently worked on some similar problems
for the PCI variant [1] of the driver. Perhaps he and Ricky have some
input on this series too.

[1]
https://lore.kernel.org/all/20260105060236.400366-1-matthew.schwartz@linux.dev/

Please see a few more comments below.

> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 156 ++++++++++++++++++++++++++++--
>  1 file changed, 148 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 84674659a84d..ec3eeea78e95 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -19,6 +19,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/jiffies.h>
>
>  #include <linux/rtsx_usb.h>
>  #include <linux/unaligned.h>
> @@ -30,6 +31,9 @@
>  #define RTSX_USB_USE_LEDS_CLASS
>  #endif
>
> +#define RTSX_USB_SD_CD_DEBOUNCE_CNT    2
> +#define RTSX_USB_SD_INSERT_RETRY_MS    1000
> +
>  struct rtsx_usb_sdmmc {
>         struct platform_device  *pdev;
>         struct rtsx_ucr *ucr;
> @@ -46,6 +50,8 @@ struct rtsx_usb_sdmmc {
>         bool                    card_exist;
>         bool                    initial_mode;
>         bool                    ddr_mode;
> +       u8                      cd_debounce;
> +       unsigned long           next_insert_check;
>
>         unsigned char           power_mode;
>         u16                     ocp_stat;
> @@ -72,6 +78,13 @@ static inline void sd_clear_error(struct rtsx_usb_sdmmc *host)
>         rtsx_usb_clear_fsm_err(ucr);
>  }
>
> +static int sd_set_bus_width(struct rtsx_usb_sdmmc *host,
> +                           unsigned char bus_width);
> +static int sd_set_timing(struct rtsx_usb_sdmmc *host,
> +                        unsigned char timing, bool *ddr_mode);
> +static int sd_power_on(struct rtsx_usb_sdmmc *host);
> +static int sd_power_off(struct rtsx_usb_sdmmc *host);
> +
>  #ifdef DEBUG
>  static void sd_print_debug_regs(struct rtsx_usb_sdmmc *host)
>  {
> @@ -768,12 +781,94 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
>         return 0;
>  }
>
> +static bool sdmmc_validate_insert_locked(struct rtsx_usb_sdmmc *host)
> +{
> +       struct rtsx_ucr *ucr = host->ucr;
> +       struct mmc_command cmd = { };
> +       int err = 0;
> +       bool probe_powered = false;
> +       bool ddr_mode = false;
> +
> +       /*
> +        * Some readers with a tray assert the mechanical SD_CD pin even when no
> +        * card is present. Only report a card present when it responds to a
> +        * minimal reset/probe sequence, similar to the old rts5139 behavior.
> +        *
> +        * Must be called with ucr->dev_mutex held.
> +        */
> +       if (host->power_mode == MMC_POWER_OFF) {
> +               err = sd_power_on(host);
> +               if (err)
> +                       return false;
> +               probe_powered = true;
> +
> +               /* Issue clock signals to card for at least 74 clocks. */
> +               rtsx_usb_write_register(ucr, SD_BUS_STAT,
> +                                       SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
> +               usleep_range(200, 400);
> +               rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0);
> +       }
> +
> +       /*
> +        * Ensure the interface is in a safe, legacy / initial-clock mode before
> +        * probing for a response. The MMC core may not have configured ios yet.
> +        */
> +       err = sd_set_bus_width(host, MMC_BUS_WIDTH_1);
> +       if (err)
> +               goto out;
> +
> +       err = sd_set_timing(host, MMC_TIMING_LEGACY, &ddr_mode);
> +       if (err)
> +               goto out;
> +
> +       ucr->cur_clk = 0;
> +       err = rtsx_usb_switch_clock(ucr, 400000, SSC_DEPTH_512K,
> +                                   true, true, false);
> +       if (err)
> +               goto out;
> +
> +       cmd.opcode = MMC_GO_IDLE_STATE;
> +       cmd.arg = 0;
> +       cmd.flags = MMC_RSP_NONE | MMC_CMD_BC;
> +       sd_send_cmd_get_rsp(host, &cmd);
> +
> +       /* SD v2.0+: CMD8 */
> +       cmd.opcode = SD_SEND_IF_COND;
> +       cmd.arg = 0x1aa;
> +       cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
> +       sd_send_cmd_get_rsp(host, &cmd);
> +       if (!cmd.error)
> +               goto out;
> +
> +       /* SD v1.x: CMD55 */
> +       cmd.opcode = MMC_APP_CMD;
> +       cmd.arg = 0;
> +       cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> +       sd_send_cmd_get_rsp(host, &cmd);
> +       if (!cmd.error)
> +               goto out;
> +
> +       /* MMC: CMD1 */
> +       cmd.opcode = MMC_SEND_OP_COND;
> +       cmd.arg = 0;
> +       cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
> +       sd_send_cmd_get_rsp(host, &cmd);
> +
> +out:
> +       if (probe_powered)
> +               sd_power_off(host);
> +       return !err && !cmd.error;
> +}

No, the above code doesn't belong in an MMC host driver.

I will try to guide you toward a better solution, but first I need to
understand the problem better.

I guess one key piece of information I'm missing is what happens when
the mmc_recsan() work tries to send commands to initialize a card,
when there is no card inserted?

> +
>  static int sdmmc_get_cd(struct mmc_host *mmc)
>  {
>         struct rtsx_usb_sdmmc *host = mmc_priv(mmc);
>         struct rtsx_ucr *ucr = host->ucr;
>         int err;
>         u16 val;
> +       u8 pend;
> +       bool sd_int = false;
> +       bool cd_raw = false;
>
>         if (host->host_removal)
>                 return -ENOMEDIUM;
> @@ -782,28 +877,71 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>
>         /* Check SD card detect */
>         err = rtsx_usb_get_card_status(ucr, &val);
> -
> -       mutex_unlock(&ucr->dev_mutex);
> -
> -       /* Treat failed detection as non-exist */
>         if (err)
> -               goto no_card;
> +               goto no_card_unlock;
>
>         /* get OCP status */
>         host->ocp_stat = (val >> 4) & 0x03;
>
> -       if (val & SD_CD) {
> -               host->card_exist = true;
> +       cd_raw = !!(val & SD_CD);
> +
> +       /* Use SD_INT as a reliable removal indication on some tray readers. */
> +       err = rtsx_usb_read_register(ucr, CARD_INT_PEND, &pend);
> +       if (!err) {
> +               sd_int = !!(pend & SD_INT);
> +               if (sd_int)
> +                       rtsx_usb_write_register(ucr, CARD_INT_PEND,
> +                                               SD_INT, SD_INT);
> +       }
> +
> +       if (!cd_raw) {
> +               host->cd_debounce = 0;
> +               host->next_insert_check = 0;
> +               goto no_card_unlock;
> +       }
> +
> +       /*
> +        * rts5139-style: when a card is already known present, treat SD_INT as
> +        * a removal event even if SD_CD stays high (e.g. tray-based readers).
> +        */
> +       if (host->card_exist) {
> +               if (sd_int) {
> +                       host->cd_debounce = 0;
> +                       host->next_insert_check = 0;
> +                       goto no_card_unlock;
> +               }
> +               mutex_unlock(&ucr->dev_mutex);
>                 return 1;
>         }
>
> -no_card:
> +       /* Debounce mechanical CD before probing for a response. */
> +       if (host->cd_debounce < RTSX_USB_SD_CD_DEBOUNCE_CNT) {
> +               host->cd_debounce++;
> +               goto no_card_unlock;
> +       }
> +
> +       /* Avoid pounding the bus with probes if CD is stuck asserted. */
> +       if (time_before(jiffies, host->next_insert_check))
> +               goto no_card_unlock;
> +
> +       if (!sdmmc_validate_insert_locked(host)) {
> +               host->next_insert_check = jiffies +
> +                       msecs_to_jiffies(RTSX_USB_SD_INSERT_RETRY_MS);
> +               goto no_card_unlock;
> +       }
> +
> +       host->card_exist = true;
> +       mutex_unlock(&ucr->dev_mutex);
> +       return 1;
> +
> +no_card_unlock:
>         /* clear OCP status */
>         if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
>                 rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
>                 host->ocp_stat = 0;
>         }
>         host->card_exist = false;
> +       mutex_unlock(&ucr->dev_mutex);
>         return 0;
>  }
>
> @@ -1359,6 +1497,8 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
>
>         host->power_mode = MMC_POWER_OFF;
>         host->ocp_stat = 0;
> +       host->cd_debounce = 0;
> +       host->next_insert_check = 0;
>  }
>
>  static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
> --
> 2.51.0

Kind regards
Uffe
