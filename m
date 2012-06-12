From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add check for IDMAC configuration
Date: Tue, 12 Jun 2012 09:55:01 +0100
Message-ID: <CAFbHwiQGGAKaoX3Pco_XgeyyX4oDmrmDGLH=_fkdaxv73J9Kgw@mail.gmail.com>
References: <1339474866-17805-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43367 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab2FLIzB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 04:55:01 -0400
Received: by pbbrp8 with SMTP id rp8so512062pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jun 2012 01:55:01 -0700 (PDT)
In-Reply-To: <1339474866-17805-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On Tue, Jun 12, 2012 at 5:21 AM, Girish K S
<girish.shivananjappa@linaro.org> wrote:
>
> In the Current dwmmc driver there is support for selecting IDMAC from
> the menu config option. If the support for IDMAC is enabled in the me=
nu
> config and Hardware configuration register's DMA_INTERFACE field is 0=
=2E
> Still the driver will try to do the DMA initialization.
>
> The dw_mci_idmac_init function currently implemented returns only suc=
cess
> indicating that the DMA initialization is always successful. The curr=
ent
> patch will add a ciheck for existance of the DMA IP and allow the
> DMA initialization.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 11 ++++++++++-
> =A01 files changed, 10 insertions(+), 1 deletions(-)

This looks ok in principle. I'm wondering if we should only allow
dma_support =3D=3D 0x01 (DW_DMA) in the IDMAC case? It's not clear from
the TRM what each of the DMA values means and I only have a system
with external DMA support at the moment.
