From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/4] mmc: add MMC_QUIRK_DISABLE_CD
Date: Wed, 5 Jan 2011 00:27:14 +0200
Message-ID: <AANLkTinEWsYBqgchwbjT2ZnoVYPcibJDF2Jt3v1AysUt@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-3-git-send-email-ohad@wizery.com> <4D239AAF.6090202@csr.com>
 <AANLkTikKDkE8eoRct_DN++dRTZ8uEMqUKN2GZdCngRKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:42389 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab1ADW1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 17:27:35 -0500
Received: by iyf40 with SMTP id 40so6833862iyf.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 14:27:34 -0800 (PST)
In-Reply-To: <AANLkTikKDkE8eoRct_DN++dRTZ8uEMqUKN2GZdCngRKQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Jan 5, 2011 at 12:13 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
>> Whether this pull up should be
>> enabled or disabled is determined by the board (not the card). =A0Th=
e
>> pull-up should be disabled if the board has a pull-up external to th=
e
>> card, otherwise it must remain enabled.
>
> Agree.

It might make more sense to use a host CAP though for this (i.e.
MMC_CAP_DISABLE_CD).

What do you think ?

Thanks,
Ohad.
