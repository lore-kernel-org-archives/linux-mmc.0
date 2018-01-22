From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Mon, 22 Jan 2018 09:16:10 +0100
Message-ID: <CACRpkdYZMa7-F8pR8rKHKfXgqRMFknniLDr-vtQ-BW2fZLk+qw@mail.gmail.com>
References: <20180119145303.4097-1-linus.walleij@linaro.org> <OFE718A5EC.F4E3005B-ONC125821D.00225D5B-C125821D.00229F17@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <OFE718A5EC.F4E3005B-ONC125821D.00225D5B-C125821D.00229F17@rittal.de>
Sender: stable-owner@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 22, 2018 at 7:18 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

> I tested it a few moments ago and to make it short: it doesn't work.

Annoying ... since the i.MX and x86 PCI version so clearly differs
here I'm left to trial and error over the mailing list.

> mmc1 bounce up to 128 segments into one, max segment size 65536 bytes
> mmc1: SDHCI controller on 53fb8000.esdhc [53fb8000.esdhc] using DMA

Could it be that this SDMA has this problem of not being
able to send things aligned on even 64K pages? (Off-by-one
error in the hardware.)

Could you try this on top of the patch?

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 25b5e598ee6d..6b436f0e0925 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3323,7 +3323,7 @@ static int sdhci_allocate_bounce_buffer(struct
sdhci_host *host)
      * has diminishing returns, this is probably because SD/MMC
      * cards are usually optimized to handle this size of requests.
      */
-    bounce_size = SZ_64K;
+    bounce_size = SZ_64K-1;
     /*
      * Adjust downwards to maximum request size if this is less
      * than our segment size, else hammer down the maximum

The code should report that it bounces 127 segments into 1 instead.

Yours,
Linus Walleij
