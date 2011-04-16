From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Sat, 16 Apr 2011 18:00:23 -0500
Message-ID: <BANLkTi=BPfmCZp_1Y+prorVAvxdfnOJDLg@mail.gmail.com>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<1302950458-1969-5-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300EB44438C@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:58499 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759203Ab1DPXA1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 19:00:27 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GN0mcX016015
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 19:00:48 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3GN0kTU016009
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 19:00:48 -0400 (EDT)
Received: by wwb28 with SMTP id 28so4126342wwb.3
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 16:00:23 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB44438C@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>

On Sat, Apr 16, 2011 at 11:19 AM, Nath, Arindam <Arindam.Nath@amd.com> =
wrote:
> Hi Andrei,
> Since support for CMD20 and CMD23 have been added in Physical Layer S=
pec v3.01, IMO it is better to set scr->cmds based on the spec version,=
 rather than doing it unconditionally. Something like,
>
> + =A0 =A0 =A0 if (scr->sda_vsn =3D=3D SCR_SPEC_VER_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check if Physical Layer Spec v3.0 is=
 supported*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->sda_spec3 =3D UNSTUFF_BITS(resp, 4=
7, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (scr->sda_spec3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->cmds =3D UNSTUFF_B=
ITS(resp, 32, 2);
> + =A0 =A0 =A0 }
>

Sounds good.

A
