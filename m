Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E53EF645
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352550; cv=pass; b=P7l73ecCno+uWiUMaoruiD0job4WqpMKuoFvdq4yhHLbtzXWNpaWTDRGHEUwNuOXMWQpk2T8aTy7SeFgDKIWUKibPlK6k7Qp8L20cUYfdGYCVEX7rWVY3u6j0bvAZ8XYn9d5GtWJ/wqSDDLgnSdSbWNjKBlWx8t4PSh14cAK+jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352550; c=relaxed/simple;
	bh=9bnbnPnmemL+8sLxwKr0T+GFslRiMdl+TYGrq2iHJNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxqbJoxfovRoCYXAXAwGSI0i1CRkKs4hVMyA+qB1rpba1LxTckGDReuvg3RHAtHNBsVAs98za3B7V/W/ja3Ke9OlrdZQIX7IwaoqrLou3sUx0+0c49NQef00c/rdiUpvlUP5G6aku2wm0aLDhKV1p9jrGVg6I3Bt+Jdj2+ld4RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A7J8zToJ; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7J8zToJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so5276334e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 04:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774352547; cv=none;
        d=google.com; s=arc-20240605;
        b=COwkzpdBUEzdLP3bJK17t1ClyWs1I2S4S3QxBsyOurXbIUnav0X1pDWR8oatRDMQf9
         PQvInVDon+yQsEC3vyCQRguvZVza7DMx28yuDKlAFE6WU95U9mLx79wGV+xkiUvDPl9E
         nECHVbvi2u2RrCyr52xOCaXt1JSfINJSeDQGJSZ3h60ugAYxChxUavJyM326DJQKKyyK
         tgtiWXBja+hdS4YGtFsWfq0Rd9jUjSSvYHFXSf2UuU4bm/+Sr7oPXye1vhTOnXmLu73e
         frs47pmfcDy43fA2EfG/c/RVGNtD+DRszxVcnuq0hznuE4XWM3L6RZfB7Hl+sRWkc2X5
         Pnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sAG9mFUBXjhe0H7Rn/TdI6ySXHSRwfH/d+S9PxhjH8o=;
        fh=NTAE6ejlPIdcKpnBqPkof5O30i8sOOs7HwZysRG1Mi8=;
        b=hC7GujV+94CUDD2uhA5LCXdIj8Wx+u72qi3D8TNqrExRbdJDgtdypx/UQU3UwJnukD
         g/L0nFxyCTlPYc625lRtUiBa15fa+PLdNYnYdyBQXit5vxScbTRaP61zV3rW/P0LRB2U
         sk2ww2Ceoq1OjW53e3fiMkfsMJMujl29M8G/A0qXETb6cEqX1FkGxCcKFLlzvkgjLybP
         6djckSrI++3wa0Gra4pH3v3MUj4wN9ld1IJ37LurVcCDO6RFQr4HCbS3nWfgFsOWF5f6
         rzNNeJInXFYUQppznRBqUy06T9u62ZXcBTd+LhdJfdzhXCByyAhFOYnZWujB16J/CDwN
         6HWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774352547; x=1774957347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sAG9mFUBXjhe0H7Rn/TdI6ySXHSRwfH/d+S9PxhjH8o=;
        b=A7J8zToJDAdpPBl2daZ7UfEDKVdJIMXvduRXm4/ViL2QcTgzXAEDm2CV0UR26QMZOa
         AlQy5O5kOzj0ONttNOlUVM7L27iN/WEkrDMiRUQv19M+cRENpNfk8efaDvLn6LlFWQXA
         XxR10pa0a2INWqnCCbF0rzFvbg56cNY3QXuOWGfgMp5mF29hJg8nJv+OwukE7gJ3Zbjy
         fh3pb3+TZ3OemV8O+DmlAi+pJoe8eT/W5dhwP5xb9MHMpk/v7d/6lI7MBCd7/7zTGmlz
         lz9AL1vIcQRiBu9wKiLk+l5zFQBBB9bPlEcbNs98PdEGcU45THNOzXIkb9IFRYeOPJem
         DfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352547; x=1774957347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAG9mFUBXjhe0H7Rn/TdI6ySXHSRwfH/d+S9PxhjH8o=;
        b=In+fQvuD2+pDghVWXirJEyGEVhs/23lWGNl45sJtfLWWv5i/dXfVE54THeG8wFjWSA
         bgkSYtEvtrIm5FHGimNzoONUNIWb05MsY+VW3MgLpDQ8cJNmM17AEpAoJKKcyzSwaTkR
         JUTTNA30cj3fA9xqxPFDiGREqeiWL+uG9exyvtwU4v966TEcoLHS3rMFuC2fGBv8RvwV
         1+93KqG2VXzRF+a43ukYeVe2WUX+ZKyLw9LnA+eHX0GDyZel1bSch2xaDXYA/Owf5DoC
         CLSqxkayJ+g8TG/VsGQdGSrSqC0Qt1Ke7ofCMCUlIEKV3JUHTUdON+H1wZRspl1KTzlL
         VDAw==
X-Gm-Message-State: AOJu0Yw6xigKzaiunAFXTI2OG1+NpYt1GZyhrlQZw7GTafm2EhFFItDC
	s3CPP/9oyesA0H397YIylME3Of7uxNHAYezt9/HkmXWmiNKtvreEv8Vq7yjsod/5Zz2bM8VIcL3
	TiPXQrI/Nxe45HD9B8frUzqOaPTFWX5/ZCEBNcTodAw==
X-Gm-Gg: ATEYQzzFdgu+sGbVmjRthL/MSKKE7N0tdiikrQKv+40QnTv05GVAWFXP2cKmldDcN9I
	V2tHnZO1bQnmw+ddvB4rxjj49ckmAUXSFognvnzLxWgZxjcbThK/mVhZG06OoxNJcf7nNMKNHrI
	PkYLvKWlxIaYifDMx85UGhIQE59pxXKBFd/2tO/ywjnGWHma6DxspoL7ynpScF/OlvS6HnW2er/
	Dn2pMct5yJjavazezhZSACL7pbHq5HTev7XGHoa2qEo86+PlzLm6jV4U7kOC7ryPYlSSSdUhkyx
	Qy8YVXW6
X-Received: by 2002:a05:6512:1247:b0:5a2:787a:fa54 with SMTP id
 2adb3069b0e04-5a285af8cb6mr5475819e87.18.1774352547416; Tue, 24 Mar 2026
 04:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-3-sean@starlabs.systems>
In-Reply-To: <20260312121559.19197-3-sean@starlabs.systems>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 12:41:51 +0100
X-Gm-Features: AQROBzCh6Q_E3FILrTGsSYqkWGfhof0Yk6wI0j5kyDxaflAT8SYmmlah1I69Rnc
Message-ID: <CAPDyKFq35KvzVSNJwY=JsjWKXFTt6dX4hSdMMF6QkWAW1TkSdA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 2/6] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ricky Wu <ricky_wu@realtek.com>, Avri Altman <avri.altman@sandisk.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
>
> Some tray-based readers keep SD_CD asserted even without a card. The
> rtsx_usb_sdmmc driver now validates insertion with a minimal probe
> sequence. That probe must start with the SD pads in 3.3V mode.
>
> Like the old rts5139 driver (sd_init_power()), force the SD pads to
> 3.3V and tune the SD18 regulator to 3.3V before powering up the card.
> This avoids spurious probe timeouts when the reader is left in 1.8V
> from a previous UHS session.
>
> Tested: Realtek RTS5129 (0bda:0129) + tray + Lexar 2TB SDXC
> Tested: cold boot detects mmcblk0 (2026-02-24)
> Tested: hotplug insert enumerates mmcblk0 (2026-02-23)
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index ec3eeea78e95..6be98926387d 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1108,6 +1108,11 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
>         }
>         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
>         rtsx_usb_init_cmd(ucr);
> +       /* Start SD init at 3.3V, like the old rts5139 driver. */
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PAD_CTL,
> +                        SD_IO_USING_1V8, SD_IO_USING_3V3);
> +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, LDO_POWER_CFG,
> +                        TUNE_SD18_MASK, TUNE_SD18_3V3);

Ideally this should be managed by the ->start_signal_voltage_switch()
callback that is set to sdmmc_switch_voltage().

However, I understand that you may need this because of patch1, and
because mmc_power_up() first calls mmc_set_initial_state() before it
calls mmc_set_initial_signal_voltage().

Right?

>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
>         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SHARE_MODE,
>                         CARD_SHARE_MASK, CARD_SHARE_SD);
> --
> 2.51.0

Kind regards
Uffe
