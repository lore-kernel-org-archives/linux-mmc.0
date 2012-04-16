From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: emmc power select failure
Date: Mon, 16 Apr 2012 15:25:55 +0530
Message-ID: <CANYdXnpBgpgOFv_rSg+tGTE_vppbV6XO66h5eyr9X2LUFk4T_A@mail.gmail.com>
References: <1721770.czJDhHnFDk@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37565 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2DPJzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Apr 2012 05:55:55 -0400
Received: by iagz16 with SMTP id z16so7218858iag.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Apr 2012 02:55:55 -0700 (PDT)
In-Reply-To: <1721770.czJDhHnFDk@ax5200p>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: linux-mmc@vger.kernel.org

Hi,
  is the 8bit bus width supported by the hardware ?

On Fri, Apr 13, 2012 at 11:29 PM, Marc Dietrich <marvin24@gmx.de> wrote=
:
> Hi,
>
> I'm running linux-next on a tegra-sdhci host which has a Toshiba
> THGBM2G6D2FBAI9 eMMC connected. During boot I get a "mmc1: power clas=
s
> selection to bus width 8 failed" warning.
>
> /sys/kernel/debug/mmc1# cat ios
> clock: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A048000000 Hz
> actual clock: =C2=A0 48000000 Hz
> vdd: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A020 (3.2 ~ 3.3 V)
> bus mode: =C2=A0 =C2=A0 =C2=A0 2 (push-pull)
> chip select: =C2=A0 =C2=A00 (don't care)
> power mode: =C2=A0 =C2=A0 2 (on)
> bus width: =C2=A0 =C2=A0 =C2=A03 (8 bits)
> timing spec: =C2=A0 =C2=A01 (mmc high-speed)
>
> Any hints?
>
> Thanks!
>
> Marc
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
regards,
Shashidhar Hiremath
