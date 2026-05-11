Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643536D9F1
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509157; cv=pass; b=ZwSaUnqQiWJOrOo0yvhgtLQJlDvGhkfQuovUTrwp3AULaFglA/fydC2rbVsV7qKGaGQAcn669Sams3FFbRK8JR22yb7dnCvKKKUcfrY09lTDeue+0y0pn0AKBhNgCx9jVMYVE9QXCGPze47LNxWG5mlbZbWx2iEfpknXz4KHdGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509157; c=relaxed/simple;
	bh=chyr9r2q+8GfIEGOBMO3k5Usb8uN37WuSfVP5bZKiP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDnrbxAZx5k5PtQCnk+DArKlYECOCYEyPUfLQw4HTZkfi49IOw/tySHaprbkEqtqBJs7KGnin+cFxehD8PGyePw+0AHf+vwSWG5L+1FITDO9753e447r34J6Z5ECcw0bikXRMQPOZ/K8zgZG5TRvNtfFvC1aKxjOVBbjV7/ypUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUCWIdRj; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUCWIdRj"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7c04749d739so21733337b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 07:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778509155; cv=none;
        d=google.com; s=arc-20240605;
        b=DI1PMw7c6TZwadNTobiL+iPkUbOBqxLbdBEJu0AgV3jQRrqPvcUjSJt7yoR+4WCKSy
         K5lRuiYuYcDzv2pQxeSIy41JkCp1lHGuuGEw/xRa/piCeiM6MqzB+INJIDmEk+V5tUbA
         l6eMTw9iLTHNjNCgXCOHXkqOTmPJZDke9bB0O6W5xiV4WewsZYMMvtefctcMooKa7+Ca
         4QPIC/EO+M3flE2fpL+2kkMixmwZ9OPhlVgslE8MS/+tcl2gXVtjEaJ30KmriGRQSOW8
         4D7SUkmAqe40A1uxUyRsJ2PK2AaTzv0rm3xJtUjE3BoOWeIuNKvNx5uOVXEUMnh4tVRO
         oGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sx/YnEVNrxHuOocEcgji2QYRTI0Sowbuloof27UQFaM=;
        fh=IV9ROIWbX2jQWc3g1Mli2cJoxjVgb20j3wbiUfX6DSA=;
        b=DccsG8Al197zFqmPsTSO7Rkd5idyS8EKEmFEVhgvrvEDWyMl4VCLDr2VHVfJU7LQKU
         VjvyPCyiFwMUcDoxpmyMOlt4c3/2ddiX/nxeL3Q3yNi7mT7VDywUnHYCJtRYsNa1J+kV
         oo/7ktO+dhzNZW60LV/z50Anmikavk06qSUW8xlC5A1xE9VfOxXGNyrpjvWY4nGaCduI
         sk530ltsCqtOQZdKhjnOZGMP+DxfnXoWtzEY/APwN/01NbwHyGZLlypK72NjNUdamd0c
         la8NOlKJ/BMXQfsT0kl97cLzrWZh0KxGxnej12d/dQZknH3iyCMJgtFn0xxx+YhSOLXC
         7mjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778509155; x=1779113955; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sx/YnEVNrxHuOocEcgji2QYRTI0Sowbuloof27UQFaM=;
        b=mUCWIdRj/3mja3vUwdlzOKZeEDsFpa9KNDRjN/5qzV3mG9M8eIKoszLfJuN6i7DQ0X
         zMVuFSm2gcVzpw3XdaTWzfCX6oCYIHJ6hyDoP9t1J14OutpN00vA+lFxMWTqqaNVsUUt
         AB+in9ZMDVzv5gakIbuLm4ukV6IsVZfdJcFoB4rj04HthkSG4SywhHQiczfRUM/bwvUy
         cEzpy/eymnxXI6Zq5WGVUH/OW+GrIxcAmeK9R9ydU6DIC3tdE08oaeESEfRxrLzghmsp
         2voSmiVcUE8fTeqTeUyVZf38TyVTpqjDMn26ogrUM39IvH+XgU5Kkwf00+HXLDY7zMoA
         H+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509155; x=1779113955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sx/YnEVNrxHuOocEcgji2QYRTI0Sowbuloof27UQFaM=;
        b=NWZ3GPNLmDmG8M0caJqZ5Tlhf4FhESYWdzLojGdqL1OkgFi5z72RM8vaBw/SWn4GXL
         SppkPEffTe/uUXAtf1YZtq+8IJVyGe0NJcIpK/I72vZCR5WTWS3b9wUJJYpXZyVnb+tZ
         aXKjXrEAXzRcVE8FTDBo1GXgd5kL6m2VWUtsfyXeslYXCJCx7Fg5Mpu3Z9vvZo7SOGDI
         5RFq3WXTxEjOFEa1yLZ/Eatn2JOyq5KdaAv0ITqiVXfL+0zb2go0uIbuWNNkI3l+AZZ7
         O95DtslfW0Crl5Cv9tw1rKJne2cIFutYSpfqAki93yxVR9DjJLDdLDYST24FCJZN6kLZ
         l5kA==
X-Forwarded-Encrypted: i=1; AFNElJ8QrubrCAChqqyoyAblsne+4bamKYVV8lDL/fd+mhJWeu8j+qu36b2zR/mqOMn4nSYSc0gQG/t4fOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK2Uyq/F3CbFCpnjiwLnJ9OqnR6Xx/LpiEWMFEuOkMOYFhNPLs
	lNDyvdrKSv1kd9Pp5kn36OC8nl5tSv6w5MI1IaFp6bZUgx4RnctYh+xPTsDW2Gq5hKcyXGt4k3l
	LvOX2EE/DsPI99T8Foi+pYkzUwddkuyV3uXBl+WX/9Q==
X-Gm-Gg: Acq92OG5Y77LwALRrWTlx8gr0DY7AKUYUoRjLrhmpw+12UnUHkFIFZN0X/aZUXh4Lmg
	WnT2A+py8CxPYhy7N3LUvHMuKLvU7WwJySGyFe1Qd6WTyg7vQEt978cXtPYAL61CM+1LH2dvQBJ
	sVOyyifrLztEm4HeDe1mDMyuHhANPST1Gsqf5bk6ibnTRDEhtKDoDcv1Cmm2nwRUWNs3WEAzw9S
	NRhDnSXZen2BA9CNHFQAcGktEEyU9BfnngOB3AWnNj7A3cFhgpVMZQxiWOkXHaBOkTN25SXR/xQ
	FtjoYeQ8
X-Received: by 2002:a05:690c:d8d:b0:7b8:338d:7d80 with SMTP id
 00721157ae682-7bdf5e7cd8amr265357857b3.31.1778509155093; Mon, 11 May 2026
 07:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260413180551.3683969-1-florian.fainelli@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:18:37 +0200
X-Gm-Features: AVHnY4IGlFA91ynBULNr6dPOLoEKDPgPk6NXdAHHRF00QFrd3aOlB3nr-JfE3c4
Message-ID: <CAPDyKFooAH=Z2BEHq08Fu03uidgjuaDbwM-Y3Y3Xa8STV+ODzg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Kioxia 016G01 does not enter boot mode after SLEEP
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Avri Altman <avri.altman@sandisk.com>, Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, 
	Erick Shepherd <erick.shepherd@ni.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 20:06, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The Kioxia 016G01 eMMC device does not exit SLEEP mode when sending CMD0
> which prevents the system from properly resuming from S3 warm boot where
> the eMMC is necessary to pull in the boot components.

Is the bug confirmed by Kioxia?

If not, can you explain a bit more what is actually happening during
system resume?

>
> Add a quirk which prevents that specific device model from entering
> SLEEP mode. There are no differences in the power consumption observed.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c    | 3 ++-
>  drivers/mmc/core/quirks.h | 7 +++++++
>  include/linux/mmc/card.h  | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7c86efb1044a..8471115f7fc9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1958,7 +1958,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>
>  static bool mmc_card_can_sleep(struct mmc_card *card)
>  {
> -       return card->ext_csd.rev >= 3;
> +       return card->ext_csd.rev >= 3 &&
> +              !(card->quirks & MMC_QUIRK_BROKEN_SLEEP);
>  }
>
>  static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c057..dc6badf740f3 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -153,6 +153,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> +       /*
> +        * Some Kioxia eMMC devices will not go into boot mode on CMD0 arg
> +        * after going into SLEEP state.
> +        */
> +       MMC_FIXUP("016G01", CID_MANFID_TOSHIBA, 0x0100, add_quirk_mmc,
> +                 MMC_QUIRK_BROKEN_SLEEP),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index e9e964c20e53..3812e9e79541 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -329,6 +329,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>  #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY    (1<<17) /* Disable broken SD poweroff notify support */
>  #define MMC_QUIRK_NO_UHS_DDR50_TUNING  (1<<18) /* Disable DDR50 tuning */
> +#define MMC_QUIRK_BROKEN_SLEEP         (1<<19) /* Broken sleep mode */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.43.0
>
>
