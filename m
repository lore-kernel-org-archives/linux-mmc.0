From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc-host: Fine-tuning for one function
Date: Wed, 27 Jan 2016 15:15:07 +0100
Message-ID: <CAPDyKFrDuon00_ts-EgmtS1WJnC_sCBVwFyOeSZBB5FjpzFv7A@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net>
	<5682F3AC.7050107@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34970 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932680AbcA0OPI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 09:15:08 -0500
Received: by mail-yk0-f180.google.com with SMTP id y137so18710409yka.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 06:15:07 -0800 (PST)
In-Reply-To: <5682F3AC.7050107@users.sourceforge.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Sascha Sommer <saschasommer@freenet.de>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On 29 December 2015 at 21:57, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 29 Dec 2015 21:54:14 +0100
>
> A few update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (2):
>   Delete unnecessary variable initialisations in sdricoh_init_mmc()
>   Less checks in sdricoh_init_mmc() after error detection
>
>  drivers/mmc/host/sdricoh_cs.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> --
> 2.6.3
>

Thanks, applied for next - with some minor change to the prefix of the
commit message header.

Kind regards
Uffe
