From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Mon, 22 Jan 2018 09:53:14 +0100
Message-ID: <CACRpkdatPkr0Y-FvegwXMJB41nmN-KArXhwpZj0nR9f7SyyvmQ@mail.gmail.com>
References: <20180119145303.4097-1-linus.walleij@linaro.org>
 <OFE718A5EC.F4E3005B-ONC125821D.00225D5B-C125821D.00229F17@rittal.de>
 <CACRpkdYZMa7-F8pR8rKHKfXgqRMFknniLDr-vtQ-BW2fZLk+qw@mail.gmail.com> <OF64BA4616.A552893D-ONC125821D.002E9E83-C125821D.002EFBB2@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:39204 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753506AbeAVIxR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jan 2018 03:53:17 -0500
Received: by mail-it0-f50.google.com with SMTP id 68so8926742ite.4
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jan 2018 00:53:16 -0800 (PST)
In-Reply-To: <OF64BA4616.A552893D-ONC125821D.002E9E83-C125821D.002EFBB2@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>

On Mon, Jan 22, 2018 at 9:33 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:
> Hey Linus,
>
>> Annoying ... since the i.MX and x86 PCI version so clearly differs
>> here I'm left to trial and error over the mailing list.
>
> I know, can I do something that it makes it easier for you?

It's just how it is. Let's use mails and brains for debugging :D

>> Could you try this on top of the patch?
>
> Built in and here is the output. I think, it's what you want,
> but it doesn't work either.

OK that doesn't work. Scratch that patch. What about this instead?

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 25b5e598ee6d..416e94dead4f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -523,7 +523,7 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
         dma_sync_single_for_device(host->mmc->parent,
                        host->bounce_addr,
                        host->bounce_buffer_size,
-                       DMA_TO_DEVICE);
+                       mmc_get_dma_dir(data));
         /* Just a dummy value */
         sg_count = 1;
     } else {
@@ -2422,6 +2422,12 @@ static bool sdhci_request_done(struct sdhci_host *host)
                         data->sg_len,
                         host->bounce_buffer,
                         length);
+                } else {
+                    dma_sync_single_for_cpu(
+                        host->mmc->parent,
+                        host->bounce_addr,
+                        host->bounce_buffer_size,
+                        mmc_get_dma_dir(data));
                 }
             } else {
                 /* Unmap the raw data */


Yours,
Linus Walleij
