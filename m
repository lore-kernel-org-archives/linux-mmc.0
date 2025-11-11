Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A830C606
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855616; cv=none; b=hMJ+z9MJuFz0Qae3fEUg0ai24lC+/1Gy7D0Y+8zNnPNTIwlG8ZoqiUgH9xFP+zc+RSCOdmnHGMpJKVybp4+AMrlDc2GA/bcDhL1FxFvCUE5kTdhNN+t0bE+3yGoWRlD2F1Wxb3PVVP6EIKX5ZfWNO6V2QIJ/WmuBsclA88ffT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855616; c=relaxed/simple;
	bh=5mTUkfp93KIsUYNPqsai3unKtQIPn3dnkpiQvDeXpp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URajEwTKOxCnh50l6pjUhTCPytMEiqQgllkwJE/Lpw/JxpvgpMFo1oB+8MVnJdBx3m8QVLzxPcx+7P2du93V2EKylWRtmnnP+N7nzTZxCQpRBmR5XD5V8jXfAvpNrZdGAyng3aag3oQAI5TGmISZiXyOadsFjOAhv9X0wbSUlaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcaDZzFa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcaDZzFa"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so4218642a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 02:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855613; x=1763460413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eIpbr52NCtLOGESOV71v7HUuxbB65gDsLsB8CBBOWw=;
        b=LcaDZzFajODeygfMZ3zJZCn44IOZolRDVoITTIorbMrIB0EJIdIhxNS51Yyoey0RrI
         xoOE7tDYJ2chDq9dn7LzQybLOoz4V+xE6ALm7K7M4SmTU2aIrk2wFyNynBfaxQ3/0k+R
         SEc5t+YVWgShbfqLcKPygU7r9lbjZQ5jYhph78xcsg/XOYDb6C+CYXXRfPoqQsnP5v0z
         jqo1QkUgT8nx+pUfz4vauniHtJn68gflvixpmKL4gbBnZ+gzr7kqjOZGJ2sSKcdbxGGP
         JHd3JNA3EASlzSDuc/VDN5ygXGQftiki7lmXVQ6SOh02Fd7fYYutwPhoONmIAKfsIyi5
         Bv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855613; x=1763460413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8eIpbr52NCtLOGESOV71v7HUuxbB65gDsLsB8CBBOWw=;
        b=pO7iebAAJDF168h7yy/zCiorxspM259U83QQIH7GzG2ki/3Q32Ui3YJljLk/cp8HYC
         tuIm3CzOu54PURbc14s6peL7gbiG8gfzmFf4T9ypkKlShqbUFJ0lw6NNLmnz7gWfTXbK
         uBUE2TALcwfTnHQlUKWFJpEqKoj64Wisi3uFRn+n0+agedJ4jwWHAABO0amT9Z7rrgYh
         Lb3raLbGTzIQ2eq4/8kl3OewuN5BgWNnB7wI2FMCbi15TSubGtm/4eQP7h2l4y6SXGZn
         e8MfpqxoaCaO2MxFWtg51jRkHSOnnwOB9+oB5H/j6A2jt0RKtER6HVb8E+uQuZW1BkJD
         5iHg==
X-Forwarded-Encrypted: i=1; AJvYcCWimk0yOkFO6Fz6RlWZCphrjr9K7PJhAjijpNXO72gTLOts7Rd9qkh8H5SyRQ8rB6gFO9iXnqnkgxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKsP0U+pNOsAqFtN+ERl3qslFc7oQqQGo0Natk+/vR8rohIRs
	dxacK3ATMej18d6+8kGJlbaBq/Xs/s0kRWeIex/h1fJv2duAZLOpqV9UpT60b4KgGFJdwubEQMh
	h/f1PhD0i2PhWhkMVT9aKxZ+1bh8AUAg=
X-Gm-Gg: ASbGncuUzJTQOxbN+lM5IsYvlrYSF/D6r3K9kssVTv9J2/IrmiLbzF/RVOqv7ZeahD9
	pB6Dd1uYuq2gtozl5Mon5L4qGuvslbrxfc41SZGDYGJTc9rwoC7gw1jG6Qq7UlkZAu5m9bXwaGD
	xnPRG5jza+taDziQxiVoDmHbR0jBCXU5ZofYCmmHpChcRUJBHUspOrEC/zf2nGoTqLrg5UTRk6t
	OQXc2PdvzUdEDNiSyiKBgqogWuhDt1DsydEpOd/AXfIdlPmbhKacYueglw=
X-Google-Smtp-Source: AGHT+IHzqwyPFKprtsRJVa0J02F8dtz2lAga9wlx+i8BAEE7q4KZv0PT8w3HVt0xrk5KjniMlleCFy5W+PPONR0YD+4=
X-Received: by 2002:a05:6402:278e:b0:640:ebca:e66c with SMTP id
 4fb4d7f45d1cf-6415e6e4612mr8859862a12.23.1762855612635; Tue, 11 Nov 2025
 02:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111072158.6686-1-linux.amoon@gmail.com> <b749faf3-b197-4b78-a918-501a639a8f4d@rock-chips.com>
 <CANAwSgTs1dqyF8UfizOP-8Yt4kxeRD+7ebZGkXuVbMe5HqT-XQ@mail.gmail.com> <85adb746-4ad8-425d-bea0-0e43f3158986@rock-chips.com>
In-Reply-To: <85adb746-4ad8-425d-bea0-0e43f3158986@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 11 Nov 2025 15:36:35 +0530
X-Gm-Features: AWmQ_bl0sy_ydB8cqR7HVHwHmbGBUmnqq_6eYot9GpcZJG2g2Q5p5xOKhf5pwmU
Message-ID: <CANAwSgQ4S3Cpm3C8zxCUW6D3P0mHON6j8tyfOD0wNATJoUC-Qg@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: Enable enhanced strobe for eMMC
 in HS400 for Rockchip
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn

On Tue, 11 Nov 2025 at 15:04, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> + Fukaumi-sang
>
> =E5=9C=A8 2025/11/11 =E6=98=9F=E6=9C=9F=E4=BA=8C 17:11, Anand Moon =E5=86=
=99=E9=81=93:
> > Hi Shawn,
> >
> > Thanks for your review comments.
> > On Tue, 11 Nov 2025 at 13:09, Shawn Lin <shawn.lin@rock-chips.com> wrot=
e:
> >>
> >> =E5=9C=A8 2025/11/11 =E6=98=9F=E6=9C=9F=E4=BA=8C 15:21, Anand Moon =E5=
=86=99=E9=81=93:
> >>> As per RK3588 TRM Part 2 section EMMC_EMMC_CTRL, Add code to enable
> >>> enhanced strobe mode, set the card type to eMMC in HS400 during clock
> >>> configuration. This bit instructs Host to sample the CMD line using d=
ata
> >>> strobe for HS400 mode.
> >>>
> >>
> >> Did you really test the latest kernel?
> > Yes, with the fio command, testing before and after this patch on a
> > Radxa Rock 5b eMMC.
>
>
> The commit msg says RK3588, but it already supported enhanced strobe...
>
> Quote a boot log from V6.18-rc5 of a RK3588 board without any patch:
>
> [    0.544447] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    0.545540] mmcblk0: mmc0:0001 BJTD4R 29.1 GiB
> [    0.548983]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8
> [    0.550874] mmcblk0boot0: mmc0:0001 BJTD4R 4.00 MiB
> [    0.552682] mmcblk0boot1: mmc0:0001 BJTD4R 4.00 MiB
> [    0.554334] mmcblk0rpmb: mmc0:0001 BJTD4R 4.00 MiB, chardev (509:0)
>
I was checking if the else part was true.
> So the whole patch makes no sense.
>
I've attempted configuration based on the TRM specification.
If it causes issues, feel free to disregard this patch.
Sorry for the noise.

$ sudo mmc extcsd read /dev/mmcblk0
[sudo] password for alarm:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Extended CSD rev 1.8 (MMC 5.1)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Card Supported Command sets [S_CMD_SET: 0x01]
HPI Features [HPI_FEATURE: 0x01]: implementation based on CMD13
Background operations support [BKOPS_SUPPORT: 0x01]
Max Packet Read Cmd [MAX_PACKED_READS: 0x3f]
Max Packet Write Cmd [MAX_PACKED_WRITES: 0x3f]
Data TAG support [DATA_TAG_SUPPORT: 0x01]
Data TAG Unit Size [TAG_UNIT_SIZE: 0x03]
Tag Resources Size [TAG_RES_SIZE: 0x00]
Context Management Capabilities [CONTEXT_CAPABILITIES: 0x05]
Large Unit Size [LARGE_UNIT_SIZE_M1: 0x07]
Extended partition attribute support [EXT_SUPPORT: 0x03]
Generic CMD6 Timer [GENERIC_CMD6_TIME: 0x0a]
Power off notification [POWER_OFF_LONG_TIME: 0x3c]
Cache Size [CACHE_SIZE] is 8192 KiB
Background operations status [BKOPS_STATUS: 0x00]
1st Initialisation Time after programmed sector [INI_TIMEOUT_AP: 0x1e]
Power class for 52MHz, DDR at 3.6V [PWR_CL_DDR_52_360: 0x00]
Power class for 52MHz, DDR at 1.95V [PWR_CL_DDR_52_195: 0x00]
Power class for 200MHz at 3.6V [PWR_CL_200_360: 0x00]
Power class for 200MHz, at 1.95V [PWR_CL_200_195: 0x00]
Minimum Performance for 8bit at 52MHz in DDR mode:
 [MIN_PERF_DDR_W_8_52: 0x00]
 [MIN_PERF_DDR_R_8_52: 0x00]
TRIM Multiplier [TRIM_MULT: 0x05]
Secure Feature support [SEC_FEATURE_SUPPORT: 0x55]
Boot Information [BOOT_INFO: 0x07]
 Device supports alternative boot method
 Device supports dual data rate during boot
 Device supports high speed timing during boot
Boot partition size [BOOT_SIZE_MULTI: 0x20]
Access size [ACC_SIZE: 0x06]
High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x01]
 i.e. 512 KiB
High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x05]
Reliable write sector count [REL_WR_SEC_C: 0x01]
High-capacity W protect group size [HC_WP_GRP_SIZE: 0x10]
 i.e. 8192 KiB
Sleep current (VCC) [S_C_VCC: 0x07]
Sleep current (VCCQ) [S_C_VCCQ: 0x07]
Sleep/awake timeout [S_A_TIMEOUT: 0x16]
Sector Count [SEC_COUNT: 0x0733c000]
 Device is block-addressed
Minimum Write Performance for 8bit:
 [MIN_PERF_W_8_52: 0x00]
 [MIN_PERF_R_8_52: 0x00]
 [MIN_PERF_W_8_26_4_52: 0x00]
 [MIN_PERF_R_8_26_4_52: 0x00]
Minimum Write Performance for 4bit:
 [MIN_PERF_W_4_26: 0x00]
 [MIN_PERF_R_4_26: 0x00]
Power classes registers:
 [PWR_CL_26_360: 0x00]
 [PWR_CL_52_360: 0x00]
 [PWR_CL_26_195: 0x00]
 [PWR_CL_52_195: 0x00]
Partition switching timing [PARTITION_SWITCH_TIME: 0x0a]
Out-of-interrupt busy timing [OUT_OF_INTERRUPT_TIME: 0x05]
I/O Driver Strength [DRIVER_STRENGTH: 0x1f]
Card Type [CARD_TYPE: 0x57]
 HS400 Dual Data Rate eMMC @200MHz 1.8VI/O
 HS200 Single Data Rate eMMC @200MHz 1.8VI/O
 HS Dual Data Rate eMMC @52MHz 1.8V or 3VI/O
 HS eMMC @52MHz - at rated device voltage(s)
 HS eMMC @26MHz - at rated device voltage(s)
CSD structure version [CSD_STRUCTURE: 0x02]
Command set [CMD_SET: 0x00]
Command set revision [CMD_SET_REV: 0x00]
Power class [POWER_CLASS: 0x00]
High-speed interface timing [HS_TIMING: 0x03]
Enhanced Strobe mode [STROBE_SUPPORT: 0x01]  <-----here
Erased memory content [ERASED_MEM_CONT: 0x00]
Boot configuration bytes [PARTITION_CONFIG: 0x00]
> >
> > $ dmesg | grep mmc
> > [   16.321495] [     T60] mmc0: SDHCI controller on fe2e0000.mmc
> > [fe2e0000.mmc] using ADMA
> > [   16.425317] [     T72] mmc0: new HS400 Enhanced strobe MMC card at
> > address 0001
> > [   16.449670] [     T72] mmcblk0: mmc0:0001 SLD64G 57.6 GiB
> > [   16.550133] [     T72]  mmcblk0: p1 p2
> > [   16.577289] [     T72] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
> > [   16.641182] [     T72] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB
> > [   16.699865] [     T72] mmcblk0rpmb: mmc0:0001 SLD64G 4.00 MiB,
> > chardev (234:0)
> >
> >> HS400ES for Rockchip platform has been supported for 3 years..
> >>
> > The only modification made was to enable the strobe bit in the eMMC con=
trol.
>
> sdhci_dwcmshc_rk35xx_ops->dwcmshc_set_uhs_signaling=EF=BC=88=EF=BC=89 set=
 it... please
> check the code.
>
Ok, I will check this.
> >> please see commit c6f361cba51c536e7a6af31973c6a4e5d7e4e2e4
> >>
> > Based on my analysis and the RK3568 TRM, neither the RK3566 nor the
> > RK2568 supports
> > HS200 or HS400 modes.
>
> There is no a chip called RK2568, so I assume you meant RK3568?
Typo needs to check my eyesight.
> RK3566/RK3568 support HS200, but not HS400=EF=BC=88HS400ES also=EF=BC=89,=
 so we didn't
> add properties in the DT. This is not because of the code, but the
> chip design reason.
>
Ok understood.

Thanks
-Anand
