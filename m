From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: brcmfmac: add support for BCM43455 with modalias
 sdio:c00v02D0dA9BF
Date: Fri, 20 Jan 2017 09:48:14 +0000 (UTC)
Message-ID: <20170120094814.E2D30607CD@smtp.codeaurora.org>
References: <20170116101757.20483-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170116101757.20483-1-martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brcm80211-dev-list.pdl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, franky.lin-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, hante.meuleman-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> BCM43455 is a more recent revision of the BCM4345. Some of the BCM43455
> got a dedicated SDIO device ID which is currently not supported by
> brcmfmac.
> Adding the new sdio_device_id to brcmfmac is enough to get the BCM43455
> supported because the chip itself is already supported (due to BCM4345
> support in the driver).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> Acked-by: Arend van Spriel <arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Andreas Färber <afaerber-l3A5Bk7waGM@public.gmane.org>
> Tested-by: Andreas Färber <afaerber-l3A5Bk7waGM@public.gmane.org>

Patch applied to wireless-drivers-next.git, thanks.

a62a77881b1b brcmfmac: add support for BCM43455 with modalias sdio:c00v02D0dA9BF

-- 
https://patchwork.kernel.org/patch/9518447/

Documentation about submitting wireless patches and checking status
from patchwork:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
