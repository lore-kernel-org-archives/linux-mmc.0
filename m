From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] mmc: power class support
Date: Fri, 1 Apr 2011 19:28:28 -0500
Message-ID: <AANLkTinNGxQgfyph9PXh9cZdxQ+QFZwTw8=NpW-pPXpE@mail.gmail.com>
References: <AANLkTin_=jScYXaXNStx-RfmBopbY43fuV8ZdhcS4M3K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:46080 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab1DBA2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 20:28:31 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p320QpjQ016877
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 20:26:51 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p320KOd0015679
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 20:26:50 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so4479652wyb.15
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2011 17:28:28 -0700 (PDT)
In-Reply-To: <AANLkTin_=jScYXaXNStx-RfmBopbY43fuV8ZdhcS4M3K@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russ Knize <Russ.Knize@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Russ,

On Fri, Apr 1, 2011 at 10:58 AM, Russ Knize <Russ.Knize@motorola.com> w=
rote:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Ignore switch erro=
rs from buggy cards that actually
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* do switch successf=
ully.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_power_c=
lass(host, max_dtr, bus_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EB=
ADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fr=
ee_card;
> +

1) host->card is not yet set at this moment, you probably want to pass
card to mmc_set_power_class as well .
2) It seems like you will call mmc_set_power_class even if bus_width
=3D=3D MMC_BUS_WIDTH_1. Is that supposed to work? 7.6.3 seems to imply
power classes only apply to 4-bit and 8-bit bus widths. As does the
paragraph on top of Page 138 of eMMC 4.41 spec, which says that for
1-bit bus configuration the default applies (class 0).
3) Since the current code supports DDR modes, you probably want to
extend support for PWR_CL_DDR_52_(360|195) as well.

Just curious, for the cards reporting switch errors but nonetheless
switching to the power class, do they update the EXT_CSD field?

A
