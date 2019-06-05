From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH v2 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Date: Wed, 5 Jun 2019 09:54:48 +0200
Message-ID: <25fe1725-76fa-2739-1427-b0e8823ea4ae@broadcom.com>
References: <20190603183740.239031-1-dianders@chromium.org>
 <20190603183740.239031-3-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603183740.239031-3-dianders@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: brcm80211-dev-list.pdl@broadcom.com, linux-rockchip@lists.infradead.org, Double Lo <double.lo@cypress.com>, briannorris@chromium.org, linux-wireless@vger.kernel.org, Naveen Gupta <naveen.gupta@cypress.com>, Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, netdev@vger.kernel.org, brcm80211-dev-list@cypress.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

On 6/3/2019 8:37 PM, Douglas Anderson wrote:
> Normally when the MMC core sees an "-EILSEQ" error returned by a host
> controller then it will trigger a retuning of the card.  This is
> generally a good idea.
> 
> However, if a command is expected to sometimes cause transfer errors
> then these transfer errors shouldn't cause a re-tuning.  This
> re-tuning will be a needless waste of time.  One example case where a
> transfer is expected to cause errors is when transitioning between
> idle (sometimes referred to as "sleep" in Broadcom code) and active
> state on certain Broadcom WiFi cards.  Specifically if the card was
> already transitioning between states when the command was sent it
> could cause an error on the SDIO bus.
> 
> Let's add an API that the SDIO card drivers can call that will
> temporarily disable the auto-tuning functionality.  Then we can add a
> call to this in the Broadcom WiFi driver and any other driver that
> might have similar needs.
> 
> NOTE: this makes the assumption that the card is already tuned well
> enough that it's OK to disable the auto-retuning during one of these
> error-prone situations.  Presumably the driver code performing the
> error-prone transfer knows how to recover / retry from errors.  ...and
> after we can get back to a state where transfers are no longer
> error-prone then we can enable the auto-retuning again.  If we truly
> find ourselves in a case where the card needs to be retuned sometimes
> to handle one of these error-prone transfers then we can always try a
> few transfers first without auto-retuning and then re-try with
> auto-retuning if the first few fail.
> 
> Without this change on rk3288-veyron-minnie I periodically see this in
> the logs of a machine just sitting there idle:
>    dwmmc_rockchip ff0d0000.dwmmc: Successfully tuned phase to XYZ
> 
> Fixes: bd11e8bd03ca ("mmc: core: Flag re-tuning is needed on CRC errors")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Note that are are a whole boatload of different ways that we could
> provide an API for the Broadcom WiFi SDIO driver.  This patch
> illustrates one way but if maintainers feel strongly that this is too
> ugly and have a better idea then I can give it a shot too.  From a
> purist point of view I kinda felt that the "expect errors" really
> belonged as part of the mmc_request structure, but getting it into
> there meant changing a whole pile of core SD/MMC APIs.  Simply adding
> it to the host seemed to match the current style better and was a less
> intrusive change.

Hi Doug,

Sorry for bringing this up, but there used to be an issue with retuning 
in general, ie. the device handled tuning command 19 only once after 
startup. I guess that is no longer an issue given your results. I guess 
the problem goes away when you disable device sleep functionality. No 
what you want in terms of power consumption, but would be good to know. 
You can disable it with below patch.

Regards,
Arend
---
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c 
b/drivers
index 15a40fd..18e90bd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -307,7 +307,7 @@ struct rte_console {
  #define BRCMF_IDLE_ACTIVE      0       /* Do not request any SD clock 
change
                                          * when idle
                                          */
-#define BRCMF_IDLE_INTERVAL    1
+#define BRCMF_IDLE_INTERVAL    0

  #define KSO_WAIT_US 50
  #define MAX_KSO_ATTEMPTS (PMU_MAX_TRANSITION_DLY/KSO_WAIT_US)
