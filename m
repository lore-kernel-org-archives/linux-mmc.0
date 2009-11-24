From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH][mmc/host]:Blackfin SD Host Controller Driver
Date: Tue, 24 Nov 2009 11:35:56 -0500
Message-ID: <8bd0f97a0911240835j1d360b39tda688e551052c5c7@mail.gmail.com>
References: <1259077143-25864-1-git-send-email-cliffcai.sh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44747 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758123AbZKXQgO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2009 11:36:14 -0500
In-Reply-To: <1259077143-25864-1-git-send-email-cliffcai.sh@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cliffcai.sh@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cliff.cai@analog.com

On Tue, Nov 24, 2009 at 10:39,  <cliffcai.sh@gmail.com> wrote:
> From: Cliff Cai <cliffcai.sh@gmail.com>
>
> Signed-off-by: Cliff Cai <cliffcai.sh@gmail.com>

you dropped some people's s-o-b tags

> +out4:
> + =C2=A0 =C2=A0 =C2=A0 free_irq(host->irq, host);

you didnt address the feedback given last time here:
    You need a mmc_remove_host() here.
-mike
