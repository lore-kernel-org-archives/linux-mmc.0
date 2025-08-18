Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B78310635
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514561; cv=none; b=cA52hwm6qKR1eWsqFwdLH09nrGr9G1PHjSvavlbpABxAz0Dbw4hBuqaVFw/rl/35CR4LLM9P/25BjId/gOeu1wiak5uSzvaq4eo9LksCr/A2ofHRZxX06CgWJuTCkWX8LQQvhS9y+cNPuUf2Gl78ucxbZitu4erPla7FP1QdPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514561; c=relaxed/simple;
	bh=sOIU2ZdXZ30PUO6/t/v8RTOhBDo2zCO1Qai08v5DW+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIL1bqzoJ5wssI+UKsSbiFRKLNktT8mhPM6+JffqBaO1rkEez/sWDZ+PqmCqbpoI8WO6ruMhzVLHTU/0kfL3eFZnTlqyz9Tyvm16bmPOhpW/iHU8KiW96pkvtLGwpesZ9/2n8JWq77YUrkCyC9SZhnN4rWuciLU7aD0yUAcQ/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WVkm/PeI; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVkm/PeI"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d605c6501so33885047b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514559; x=1756119359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k/HO6iupLN965w11wO0JBgC0tXv2y+bu0/jt8pcQ3Ys=;
        b=WVkm/PeIK3yD7IkqLG1w0utoRN2dz+3H+EZOxwDNWD6XQkTBobTN9uNwZGpdTw5M1F
         UZhEzsCV75VGsURfzIwWkzni3a6Mhbc+QFfGMq2Qf/B/MBW8HDbujaH2U8xts1R5l+p5
         4RFmJl9t17K6CbX8pOCMXOMsQV7ZUJgDRyp0ylBNyy0fG4K5ZuCoxF/xs1Q9yiVZqxpA
         jgWqVt8+28Drhm3t6JGjoIPnvp3YiDAldSycJpjOPTQW7oPKN7x3b0qTtYxStQYdkf68
         vvpqb07UcDqYsi5MfL9NTTtl50it08jID0eb57Kh5u+gb+dnjzDTGIkph+Dt47NBXDfC
         3VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514559; x=1756119359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/HO6iupLN965w11wO0JBgC0tXv2y+bu0/jt8pcQ3Ys=;
        b=m2oeyRV8XSxYDuWsiDm2Zk2rMYoposV6w2b3/WaNHssxmHJcgue2DUzDO6pfUpgu3M
         m1mnqLo7SRpVLqsXa3pwimQ5zhKKsGsBCNVBXziydgYuMJjH7a2aoDrDuW+YfQmrvEUk
         waif5S8En+CpUK7viS3MkFcbPtkrAeOUBvGSqVqKThty78cYWI313w3ZZ7rmdAPI1wb0
         Rkwj4OXF0GTqvRDGAE5pP8BEU+X5hI5cmNVxtz7N9kOrmmmL9wf72xBV6+TmJmnMT1l/
         qQkGWTjRYtV6pj2pkIika90c8QFnDti3CGFABxLHQveqgrQvfMXQSw9jglGBzNMF34uA
         67Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWyNSihH0Kq65GDS7D9a7B6ZRXvQjy9+bzkwArZIICi2X2II3T1XuUv7uR2m6tCwyZUzf7guh9atmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5C5TVUiiiUHHGehFqZOKGI+BhP142PX0B6bf4PWg/r6eyx1zp
	FByCcFweL0eOemqWrgjfjV7iQ60jNCcK4/0SFZI9pYKUxC5i6Y1grD3IwUzVVyLxm1esqdPLi47
	xNSnC6wtDb5eczDpVQOHQGYhesQ7TGrNHJ5UALAVXfv+XR/ikXSbi
X-Gm-Gg: ASbGnctCDVR5K86ilLPhmmxG5T1mLslGJQneVmTJkoQy4A2Pe+5s9bJuSeSKF8AvAL3
	iARG2DZbPFjpr0F5BriZfuYKV6HA4j4aUqN1sINuk7/GUfvMDEWF+b1fmLCD70uGO6MQgrXEbWv
	bmgysm2ZjKXHdjATgDXOyMlQ3Vsu6AiStXtWkRIqCNlQOp2l1zOYfQDJsWrBnWqbOOQTuaDPiuU
	kOYsFFU
X-Google-Smtp-Source: AGHT+IFIPrxcz811eNpr86jBaQpMKMu1FIt3oGH+uBAySeRoGiwTIuWLQPXyZg1sLEVJAopx+gPjN2EJVanKHkFayC0=
X-Received: by 2002:a05:690c:7008:b0:71e:325e:5443 with SMTP id
 00721157ae682-71e6dd86391mr142978217b3.3.1755514558906; Mon, 18 Aug 2025
 03:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812030811.2426112-1-ricky_wu@realtek.com>
In-Reply-To: <20250812030811.2426112-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:22 +0200
X-Gm-Features: Ac12FXyeaWZhOxRAQ062gDRfdZHQAhdH5-1WubhFWa-aRaezoPHa1jPhcvbe0Ys
Message-ID: <CAPDyKFr+emHfakqJHYjd+17uWPyh8fdVB50CLJLkGz3yJCPO9g@mail.gmail.com>
Subject: Re: [PATCH v2] misc: rtsx: usb card reader: add OCP support
To: Ricky Wu <ricky_wu@realtek.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, chenhuacai@kernel.org, maximlevitsky@gmail.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 05:08, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> This patch adds support for Over Current Protection (OCP) to the Realtek
> USB card reader driver.
>
> The OCP mechanism protects the hardware by detecting and handling current
> overload conditions.
> This implementation includes:
>
> - Register configurations to enable OCP monitoring.
> - Handling of OCP interrupt events and associated error reporting.
> - Card power management changes in response to OCP triggers.
>
> This enhancement improves the robustness of the driver when operating in
> environments where electrical anomalies may occur, particularly with SD
> and MS card interfaces.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508061704.hwI8epAJ-lkp@intel.com/
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next and by removing the Reported-by/Closes tags, thanks!

Kind regards
Uffe


> ...
>
> v2: move ocp check in power_on flow
> ---
>  drivers/memstick/host/rtsx_usb_ms.c |  5 ++++-
>  drivers/misc/cardreader/rtsx_usb.c  |  7 ++++++
>  drivers/mmc/host/rtsx_usb_sdmmc.c   | 33 ++++++++++++++++++++++++++---
>  include/linux/rtsx_usb.h            | 11 ++++++++++
>  4 files changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index 3878136227e4..9389e9643c24 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -216,7 +216,10 @@ static int ms_power_off(struct rtsx_usb_ms *host)
>
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_CLK_EN, MS_CLK_EN, 0);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_OE, MS_OUTPUT_EN, 0);
> -
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL,
> +                       POWER_MASK, POWER_OFF);
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL,
> +                       POWER_MASK | LDO3318_PWR_MASK, POWER_OFF | LDO_SUSPEND);
>         err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
>         if (err < 0)
>                 return err;
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
> index d007a4455ce5..1830e9ed2521 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -552,6 +552,10 @@ static int rtsx_usb_reset_chip(struct rtsx_ucr *ucr)
>         ret = rtsx_usb_send_cmd(ucr, MODE_C, 100);
>         if (ret)
>                 return ret;
> +       /* config OCP */
> +       rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_DETECT_EN, MS_OCP_DETECT_EN);
> +       rtsx_usb_write_register(ucr, OCPPARA1, 0xF0, 0x50);
> +       rtsx_usb_write_register(ucr, OCPPARA2, 0x7, 0x3);
>
>         /* config non-crystal mode */
>         rtsx_usb_read_register(ucr, CFG_MODE, &val);
> @@ -722,6 +726,9 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>                         if (val & (SD_CD | MS_CD)) {
>                                 device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
>                                 return -EAGAIN;
> +                       } else {
> +                               /* if the card does not exists, clear OCP status */
> +                               rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
>                         }
>                 } else {
>                         /* There is an ongoing operation*/
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index c5f6b9df066b..e1ed39c657c3 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -48,7 +48,7 @@ struct rtsx_usb_sdmmc {
>         bool                    ddr_mode;
>
>         unsigned char           power_mode;
> -
> +       u16                     ocp_stat;
>  #ifdef RTSX_USB_USE_LEDS_CLASS
>         struct led_classdev     led;
>         char                    led_name[32];
> @@ -785,6 +785,9 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>
>         mutex_unlock(&ucr->dev_mutex);
>
> +       /* get OCP status */
> +       host->ocp_stat = (val >> 4) & 0x03;
> +
>         /* Treat failed detection as non-exist */
>         if (err)
>                 goto no_card;
> @@ -795,6 +798,11 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>         }
>
>  no_card:
> +       /* clear OCP status */
> +       if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
> +               rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
> +               host->ocp_stat = 0;
> +       }
>         host->card_exist = false;
>         return 0;
>  }
> @@ -818,7 +826,11 @@ static void sdmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 cmd->error = -ENOMEDIUM;
>                 goto finish_detect_card;
>         }
> -
> +       /* check OCP stat */
> +       if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
> +               cmd->error = -ENOMEDIUM;
> +               goto finish_detect_card;
> +       }
>         mutex_lock(&ucr->dev_mutex);
>
>         mutex_lock(&host->host_mutex);
> @@ -952,6 +964,10 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
>         struct rtsx_ucr *ucr = host->ucr;
>         int err;
>
> +       if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
> +               dev_dbg(sdmmc_dev(host), "over current\n");
> +               return -EIO;
> +       }
>         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
>         rtsx_usb_init_cmd(ucr);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
> @@ -977,9 +993,19 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
>
>         usleep_range(800, 1000);
>
> +       rtsx_usb_init_cmd(ucr);
> +       /* WA OCP issue: after OCP, there were problems with reopen card power */
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK, POWER_ON);
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, FPDCTL, SSC_POWER_MASK, SSC_POWER_DOWN);
> +       err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
> +       if (err)
> +               return err;
> +       msleep(20);
> +       rtsx_usb_write_register(ucr, FPDCTL, SSC_POWER_MASK, SSC_POWER_ON);
> +       usleep_range(180, 200);
>         rtsx_usb_init_cmd(ucr);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL,
> -                       POWER_MASK|LDO3318_PWR_MASK, POWER_ON|LDO_ON);
> +                       LDO3318_PWR_MASK, LDO_ON);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_OE,
>                         SD_OUTPUT_EN, SD_OUTPUT_EN);
>
> @@ -1332,6 +1358,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
>         mmc->max_req_size = 524288;
>
>         host->power_mode = MMC_POWER_OFF;
> +       host->ocp_stat = 0;
>  }
>
>  static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
> diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
> index f267a06c6b1e..276b509c03e3 100644
> --- a/include/linux/rtsx_usb.h
> +++ b/include/linux/rtsx_usb.h
> @@ -99,6 +99,17 @@ extern int rtsx_usb_card_exclusive_check(struct rtsx_ucr *ucr, int card);
>  #define CD_MASK                (SD_CD | MS_CD | XD_CD)
>  #define SD_WP          0x08
>
> +/* OCPCTL */
> +#define MS_OCP_DETECT_EN               0x08
> +#define        MS_OCP_INT_EN                   0x04
> +#define        MS_OCP_INT_CLR                  0x02
> +#define        MS_OCP_CLEAR                    0x01
> +
> +/* OCPSTAT */
> +#define MS_OCP_DETECT                  0x80
> +#define MS_OCP_NOW                     0x02
> +#define MS_OCP_EVER                    0x01
> +
>  /* reader command field offset & parameters */
>  #define READ_REG_CMD           0
>  #define WRITE_REG_CMD          1
> --
> 2.25.1
>
