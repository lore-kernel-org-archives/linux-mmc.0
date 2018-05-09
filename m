From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: brcmfmac: Add support for bcm43364 wireless chipset
Date: Wed,  9 May 2018 10:25:11 +0000 (UTC)
Message-ID: <20180509102511.E97F160FA8@smtp.codeaurora.org>
References: <1525416503-832-1-git-send-email-sean@lano.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1525416503-832-1-git-send-email-sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: arend.vanspriel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, franky.lin-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, hante.meuleman-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, chi-hsien.lin-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, wright.feng-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brcm80211-dev-list-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org> wrote:

> Add support for the BCM43364 chipset via an SDIO interface, as used in 
> e.g. the Murata 1FX module. 
> 
> The BCM43364 uses the same firmware as the BCM43430 (which is already 
> included), the only difference is the omission of Bluetooth. 
> 
> However, the SDIO_ID for the BCM43364 is 02D0:A9A4, giving it a MODALIAS 
> of sdio:c00v02D0dA9A4, which doesn't get recognised and hence doesn't 
> load the brcmfmac module. Adding the 'A9A4' ID in the appropriate place 
> triggers the brcmfmac driver to load, and then correctly use the 
> firmware file 'brcmfmac43430-sdio.bin'. 
> 
> 
> Signed-off-by: Sean Lanigan <sean-k1Xf6wIwYfsQrrorzV6ljw@public.gmane.org>
> Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Patch applied to wireless-drivers-next.git, thanks.

9c4a121e8263 brcmfmac: Add support for bcm43364 wireless chipset

-- 
https://patchwork.kernel.org/patch/10380047/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
