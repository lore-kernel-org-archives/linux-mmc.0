Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8503F54DD
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353755; cv=pass; b=QlP7kQQUC8xfUsV0+oQtYu/5QdVt3bA6ILwov8taTWVeHs7l2ZyPawgfU3KNhcK8leBAtgKwJrdUiIkJLY1WzyOHXqzQ7ymEWGcDSOgJGcqwdpCgHFCbN2JgH7221V8My34+flcKkuBRpqKWqNyG7uudh2206E41oSqvcMnSKeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353755; c=relaxed/simple;
	bh=LOGgZmI1ov6loe+55SBWQv/R43MCeNoOZaMA2U7SzKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAxaqwj5QeIW+91m1jZzyt2q7O707p0U0xSgJzROyNfYiBgPZIX88MYJiBslL1JB9TJuqGAg08JhyT8YgJnd5YR93KDAzVjX7biJ30weOO5W6T4EjvmNs7CiwilxfwUJkPsG2cQ7bJtDbzI4rjQO7uWyx8xaNMP5CDExMSvxHN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=Kb7/1zfS; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="Kb7/1zfS"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad019bbd4so4649501d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 05:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774353750; cv=none;
        d=google.com; s=arc-20240605;
        b=ZIv48lctmXRgai6aQaiP/T5y2x+6BW0weMCQyC9RdZ+iyar2hHaXrdGBuxSYIPSExr
         UWj6y1PFzMCeQl9gF7BC/u05nABbBKfV1ENpDZ7fp51DSq+/ZXOjrTpBbTIwW1+AG6bc
         cZfJVqNXUkBEJv0S9M+T2GYZHkyvqV842lYkejmjv2RIr0jD84BDzwI6xbXuImdP0+AH
         /QHctYwzR9wT5CPeJc/InV93EMw0aPSomb6eq5/V3CfMqpccc/zTekPdiew6+FvU6u0v
         jGac77qpCqoQAQt88xoKv+rEhFxMMapSihvsutWbgn5ow6AQOEsye0Z4U5UD8luu1t+6
         vxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ksYiyDzdlQupkrf35BeyKrzRYwt997BQdwJudbMaAAU=;
        fh=/5amye+Zlb1QuO9OmzmBNuN/2D90NxjgnBz88VZGhas=;
        b=iBpa92ZYbmW+8ya21Ra6+g+dLIacNt8jsUpBl8lxsrOLzEFtKZOE56JrC+Iu1hgesb
         hx1fr5rhiOnBNv2gtD7KtkMYJ5j9g4JHXtbLx/5UYS84oYg2HWbVHpjiFZlchLrfAHGf
         DmehFGvHYroRPDoDaXg8zh7XKjnj1AEbdbZj6KJ9BPM0KB+i7WU6/MrCd5Jtr7PTAoiI
         254yulrLXRl8IaiP2ix+88QEhbsauEvwRhVv0BUWI6f7KYAuw+8gt9VuBLv8Ov6gXkVW
         a6yS+6IjDMsNWvQlCHZyQpHknmRtYOjnX2SHTVXPJ/+k/UBwulrJOE/N+9xuhLiWGW5r
         N9WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1774353750; x=1774958550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ksYiyDzdlQupkrf35BeyKrzRYwt997BQdwJudbMaAAU=;
        b=Kb7/1zfSTJ4VUoXL1ebJ0TZTLh+Jp8E0CDV/VM2XuOWfuafkVYhb9OnhRZFBqySGNF
         i4mPXNUVlB3rco9c3UF/ct83gJtbeW6BWuJFhLqdWFMKjQmLagyPr02UFO8iCXhrSzEH
         WS5akmXBUl75OJDpD5rxOPS/PVOROEsVvZpNKxhuJyeABb02qxqcCAeKeJ1I62WcTWsj
         f+54VMyExNCEIpfOGgDGhEVM6jzy6cjNgfEL+ZH3uAQMoDJZfqdL/lLY8coCplnfOXvO
         R0MsU6KiAgBdW/pMTLU8bW1eSsTDyWmkXTH57249BRLC44OUF2AmdFqQbOCDFCOhRy+W
         8mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353750; x=1774958550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksYiyDzdlQupkrf35BeyKrzRYwt997BQdwJudbMaAAU=;
        b=Ww5broIvXkPCEDn98EoKD1XxH54QsDtMiE8Fb9SQWyX2FnVkJURhDGpRHL4EfFmAVj
         ZoBuM8ryQRb4MuCMocZra0Cd7HpAv7ZzxNWpVjl3V+kv+VCmBA4hqfR6bAShJwIDF2+m
         3a+qWVpQt4Cwr2EA1DMb449Juy3y4KARwWz9nC01VtJJf58FmqvQ2SwwYjBKBAWnfv1u
         /UPB6qDu6BOY8qz1Hpf4lkxpPFDZcSSs3nQqXP5vP7kqryk7ClQvrViVyGX7WyT1kJJ+
         pPMDs6AsLAF6Qnbv4dnD1RUEFyXTBKpRFfSrARP/2tL5lhz1CWK17XNNFYEkpZbWQjD+
         TvKQ==
X-Gm-Message-State: AOJu0YxUHSXhj0ka3PW+itLa4y/u7TVgOkJERReHUXQRRnUzINySjJ/N
	W7G4AWV0ZzZgGxXnoVx6gCt4lx5AO4Vo7j+4k9CxZTsjEBiHpEEH+Swt61wZJQMaZQj2QZoxdCh
	Or3TaHiqoB5RclcKkd32QBv+q4SlCyNjv6cfH3EVV
X-Gm-Gg: ATEYQzylriefFITV3zWy1JyesAn7/8aa40RLvdqlhulvbiSwlguRp6RNbP5q5k7QdUb
	G4oO/O4pQm4Sx9iEmx6X8gCsXzJmd909fCUj/u51VdD6gLHJlq5yWAXIKovBADkP1A7Kn0le1Ho
	OKWI2QyE5hIkrjBIeSM9LB9Q7MCiUM2TDJDGk42Hs8V/V6iXe/FTjRZXyYP34XtHQvJF7NLmnbr
	eNlgw+fa5AHRACaRaqq2VoAXE0abpdXTM1Fmg+Ar9fED0OZl6nJXoHsydXhZ/WJkrbPP/zydfxw
	aGvL3QXKMNpNk7u6Gt5Pcq/3QRQYf25yHokIWwEe
X-Received: by 2002:a53:b54f:0:b0:64a:ea66:bb53 with SMTP id
 956f58d0204a3-64eaa6bff0amr12193936d50.23.1774353749491; Tue, 24 Mar 2026
 05:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-3-sean@starlabs.systems> <CAPDyKFq35KvzVSNJwY=JsjWKXFTt6dX4hSdMMF6QkWAW1TkSdA@mail.gmail.com>
In-Reply-To: <CAPDyKFq35KvzVSNJwY=JsjWKXFTt6dX4hSdMMF6QkWAW1TkSdA@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 24 Mar 2026 12:02:18 +0000
X-Gm-Features: AQROBzAych8fNRxIQ3wjB1qUzSf4YetqOyW2DX4sGrldKMM8GH6lUPaqBBiV_0c
Message-ID: <CABtds-13f_AM4zZ=+o_gVeYeXVDAPh1NcTJ1zqOut29K-PoBQg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 2/6] mmc: rtsx_usb_sdmmc: start card power-up at 3.3V
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ricky Wu <ricky_wu@realtek.com>, Avri Altman <avri.altman@sandisk.com>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Right?

Yes, that's right


On Tue, 24 Mar 2026 at 11:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
> >
> > Some tray-based readers keep SD_CD asserted even without a card. The
> > rtsx_usb_sdmmc driver now validates insertion with a minimal probe
> > sequence. That probe must start with the SD pads in 3.3V mode.
> >
> > Like the old rts5139 driver (sd_init_power()), force the SD pads to
> > 3.3V and tune the SD18 regulator to 3.3V before powering up the card.
> > This avoids spurious probe timeouts when the reader is left in 1.8V
> > from a previous UHS session.
> >
> > Tested: Realtek RTS5129 (0bda:0129) + tray + Lexar 2TB SDXC
> > Tested: cold boot detects mmcblk0 (2026-02-24)
> > Tested: hotplug insert enumerates mmcblk0 (2026-02-23)
> > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> > ---
> >  drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > index ec3eeea78e95..6be98926387d 100644
> > --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> > @@ -1108,6 +1108,11 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
> >         }
> >         dev_dbg(sdmmc_dev(host), "%s\n", __func__);
> >         rtsx_usb_init_cmd(ucr);
> > +       /* Start SD init at 3.3V, like the old rts5139 driver. */
> > +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PAD_CTL,
> > +                        SD_IO_USING_1V8, SD_IO_USING_3V3);
> > +       rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, LDO_POWER_CFG,
> > +                        TUNE_SD18_MASK, TUNE_SD18_3V3);
>
> Ideally this should be managed by the ->start_signal_voltage_switch()
> callback that is set to sdmmc_switch_voltage().
>
> However, I understand that you may need this because of patch1, and
> because mmc_power_up() first calls mmc_set_initial_state() before it
> calls mmc_set_initial_signal_voltage().
>
> Right?
>
> >         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
> >         rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SHARE_MODE,
> >                         CARD_SHARE_MASK, CARD_SHARE_SD);
> > --
> > 2.51.0
>
> Kind regards
> Uffe
