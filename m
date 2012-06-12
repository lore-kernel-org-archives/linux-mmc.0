From: Will Newton <will.newton@gmail.com>
Subject: Re: [RESEND PATCH] mmc: dw_mmc: Add check for IDMAC configuration
Date: Tue, 12 Jun 2012 11:08:02 +0100
Message-ID: <CAFbHwiRXXbOzCPeb0jdrzjmq1aeisjRSY5xNwrQbeNYJx04UJg@mail.gmail.com>
References: <1339495102-4889-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41495 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab2FLKIC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 06:08:02 -0400
Received: by pbbrp8 with SMTP id rp8so591016pbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jun 2012 03:08:02 -0700 (PDT)
In-Reply-To: <1339495102-4889-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On Tue, Jun 12, 2012 at 10:58 AM, Girish K S
<girish.shivananjappa@linaro.org> wrote:
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
> =A0drivers/mmc/host/dw_mmc.c | =A0 15 +++++++++++++--
> =A01 files changed, 13 insertions(+), 2 deletions(-)

Ok, this version looks better.

Acked-by: Will Newton <will.newton@imgtec.com>
