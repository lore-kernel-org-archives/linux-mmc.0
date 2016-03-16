From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when
 needed in ->probe()
Date: Wed, 16 Mar 2016 10:53:51 +0100
Message-ID: <CAPDyKFr8wrWYn2sy2rdKmmTkiLEuLOCarbL51gYr=xGJ_6C7SA@mail.gmail.com>
References: <1455195595-5121-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFqZkJGPgojY52H2=4JjdR9gvJCe99_ZCv98ZNs4eUdRrg@mail.gmail.com>
	<56DCF2AD.3000806@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34356 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964778AbcCPJxw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 05:53:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id p65so181488819wmp.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 02:53:52 -0700 (PDT)
In-Reply-To: <56DCF2AD.3000806@jinso.co.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On 7 March 2016 at 04:17, Nguyen Viet Dung <nv-dung@jinso.co.jp> wrote:
> Hi Ulf
>
> I have testted two cases use these patchs that you send.
>
> case01:
> [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when needed in
> ->probe()
> [PATCH 2/3] mmc: sh_mmcif: Restructure ->set_ios()
> [PATCH 3/3] mmc: sh_mmci: Get rid of wrapper function for regulators
>
> case02:
> [PATCH 1/3] mmc: sh_mmcif: Make sure the device stays active when needed in
> ->probe()
>
> The problem of mmcif is not resolved by both two cases.

Okay, thanks for testing!

Even if it doesn't solve you original issue after a system PM resumed
has been accomplished, does the driver still works as before? In other
words are cards detected properly and can data transfers be done?

The reason for my question, is that I think these patches makes some
nice cleanups of some of the PM related code in the driver. So unless
you see a *new* regression, I would like to apply them.

[...]

Kind regards
Uffe
