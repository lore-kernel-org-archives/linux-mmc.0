From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Reset DMA before enabling IDMAC
Date: Thu, 9 Oct 2014 17:36:19 -0700
Message-ID: <CAD=FV=VQe-9c+QOYEmsuHwY+9qF1tkTgiakdSUWhUoWw6zuHSA@mail.gmail.com>
References: <1412618020-22278-1-git-send-email-sonnyrao@chromium.org>
	<CAGOxZ53bviLbuA27=1QjNUgxA_WMMP-6siV=DajuN8iSqsasMg@mail.gmail.com>
	<CAO3aYcqi0g=eJta33s5oM-tAAmAhe86VvHd43p5RJ7qMPZzfrg@mail.gmail.com>
	<CAGOxZ520EXdS9FoCVW7GPvheNSZu=xqc2makJY5D0c3zjVBkDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:54291 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaJJAgU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Oct 2014 20:36:20 -0400
Received: by mail-vc0-f177.google.com with SMTP id hq11so1898488vcb.36
        for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2014 17:36:19 -0700 (PDT)
In-Reply-To: <CAGOxZ520EXdS9FoCVW7GPvheNSZu=xqc2makJY5D0c3zjVBkDw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: =?UTF-8?B?RWRkaWUgQ2FpKOiUoeaeqyk=?= <eddie.cai@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Sonny Rao <sonnyrao@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Addy Ke <addy.ke@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Alim,

On Thu, Oct 9, 2014 at 3:19 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
> Thats fine, I think every vendor (most of them) has a custom
> implementation of dw_mmc, but they do have VERID register to check the
> dw_mmc version.
> The reason why I asked is, I have seen inconsistency in card
> enumeration on few controller version, and this patch alone does not
> help, and adding a call to dw_mci_idmac_reset() after DMA reset is
> needed. And this is what is recommended in the synopsys's data book
> also.
> Do you see any issue/side effect after adding dw_mci_idmac_reset()?

A quick test shows no problem with adding this to Sonny's patch:

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 66dc8fe..588b5b8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -481,6 +481,7 @@ static void dw_mci_idmac_start_dma(struct dw_mci
*host, unsigned int sg_len)

        /* Make sure to reset DMA in case we did PIO before this */
        dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET);
+       dw_mci_idmac_reset(host);

        /* Select IDMAC interface */
        temp = mci_readl(host, CTRL);

I'll start reboot tests now to see how it behaves...  I think Sonny is
out of the office for a few days so we might need to wait for a spin,
but I'll run with that change in the meantime and see how it behaves
for me.

Thanks!

-Doug
