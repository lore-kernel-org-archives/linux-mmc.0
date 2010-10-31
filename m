From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 31 Oct 2010 17:08:18 +0200
Message-ID: <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com> <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37227 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab0JaPIi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Oct 2010 11:08:38 -0400
Received: by iwn10 with SMTP id 10so5957552iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 31 Oct 2010 08:08:38 -0700 (PDT)
In-Reply-To: <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sun, Oct 31, 2010 at 4:55 PM, Daniel Drake <dsd@laptop.org> wrote:
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * For native busses: =A0set card RCA and quit open dr=
ain mode.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (!powered_resume && !mmc_host_is_spi(host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_relative_addr(host, &=
card->rca);
>
> This returns -110

Quick question - how did you manage the power to the sd8686 ? Was it
possible to power it down after boot or was it always kept high ?

Thanks,
Ohad.

>
> Thanks,
> Daniel
>
