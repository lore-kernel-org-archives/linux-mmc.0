From: Daniel Drake <dsd@laptop.org>
Subject: Re: SD8686 fast power-cycle problems
Date: Sat, 18 Jun 2011 10:33:46 +0100
Message-ID: <BANLkTiko7eZDhhyk_BxGN8haS37yCxihZQ@mail.gmail.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
	<1E37377F-AC54-43BC-AF01-53CA9FDE3A10@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53481 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1FRJdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Jun 2011 05:33:47 -0400
Received: by pzk9 with SMTP id 9so2365590pzk.19
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jun 2011 02:33:46 -0700 (PDT)
In-Reply-To: <1E37377F-AC54-43BC-AF01-53CA9FDE3A10@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Zhangfei Gao <zgao6@marvell.com>, Bing Zhao <bzhao@marvell.com>, Benson Chau <bchau@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 17 June 2011 19:49, Philip Rakity <prakity@marvell.com> wrote:
>
> sdio_reset is harmless to non-sdio devices. =A0Especially since it is=
 in the main power up path.
>
> I see no reason this should be done. =A0Can you prepare a patch ?

A patch to remove the sdio_reset() call from mmc_rescan_try_freq()? If
my understanding is correct, that one is needed, as you will need to
do a reset after failing to probe at one freq and then trying another
one.

Or do you mean a patch to add sdio_reset() into the runtime PM powerup
path? That would be harmless, would increase consistency between the
codepaths, and would solve this issue, so naturally has my vote :)

Thanks
Daniel
