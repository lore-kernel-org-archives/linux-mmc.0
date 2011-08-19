From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] mmc: sdhi: initialise mmc_data->flags before use
Date: Fri, 19 Aug 2011 12:04:06 +0900
Message-ID: <CANqRtoRx5MC-smUjuYBgpstcm49_PqwXqG=YEe+dkqVte7eQ9w@mail.gmail.com>
References: <1313716027-19470-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63233 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab1HSDEH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2011 23:04:07 -0400
In-Reply-To: <1313716027-19470-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 10:07 AM, Simon Horman <horms@verge.net.au> wro=
te:
> This corrects a logic error that I introduced in
> "mmc: sdhi: Add write16_hook"
>
> Reported-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
> =A0drivers/mmc/host/sh_mobile_sdhi.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)

Hi Simon,

Thanks for providing a fix for this issue. Correct me if I'm wrong,
but I believe this patch is suitable for 3.1-rc. So it would be great
to have it merged rather soon as a fix instead of delaying it to 3.2.

Thanks,

/ magnus
