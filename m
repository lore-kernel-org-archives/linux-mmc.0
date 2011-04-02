From: Russ Knize <Russ.Knize@motorola.com>
Subject: Re: [PATCH] mmc: power class support
Date: Fri, 1 Apr 2011 19:44:24 -0500
Message-ID: <AANLkTinX4GvBPGXjn36sOv5h_n07jNyJpM3hW46zUD0+@mail.gmail.com>
References: <AANLkTin_=jScYXaXNStx-RfmBopbY43fuV8ZdhcS4M3K@mail.gmail.com> <AANLkTinNGxQgfyph9PXh9cZdxQ+QFZwTw8=NpW-pPXpE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:33351 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab1DBAoq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2011 20:44:46 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p320h6YD018878
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 20:43:06 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p320fj6A018715
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 1 Apr 2011 20:43:06 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so4508898wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2011 17:44:44 -0700 (PDT)
In-Reply-To: <AANLkTinNGxQgfyph9PXh9cZdxQ+QFZwTw8=NpW-pPXpE@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

OK.  Anything else?

Russ W. Knize
Mobile Devices Android Platform
Desk: 847-523-9381
Mobile: 224-622-1391



On Fri, Apr 1, 2011 at 7:28 PM, Andrei Warkentin <andreiw@motorola.com>=
 wrote:
> Hi Russ,
>
> On Fri, Apr 1, 2011 at 10:58 AM, Russ Knize <Russ.Knize@motorola.com>=
 wrote:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Ignore switch err=
ors from buggy cards that actually
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* do switch success=
fully.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_set_power_=
class(host, max_dtr, bus_width);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -E=
BADMSG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto f=
ree_card;
>> +
>
> 1) host->card is not yet set at this moment, you probably want to pas=
s
> card to mmc_set_power_class as well .
> 2) It seems like you will call mmc_set_power_class even if bus_width
> =3D=3D MMC_BUS_WIDTH_1. Is that supposed to work? 7.6.3 seems to impl=
y
> power classes only apply to 4-bit and 8-bit bus widths. As does the
> paragraph on top of Page 138 of eMMC 4.41 spec, which says that for
> 1-bit bus configuration the default applies (class 0).
> 3) Since the current code supports DDR modes, you probably want to
> extend support for PWR_CL_DDR_52_(360|195) as well.
>
> Just curious, for the cards reporting switch errors but nonetheless
> switching to the power class, do they update the EXT_CSD field?
>
> A
>
