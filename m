From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 5/5] mmc: sdhci-of-arasan: implement enhanced strobe callback
Date: Thu, 19 May 2016 17:11:40 -0700
Message-ID: <CAD=FV=VU7cY+jQ3Tys5vLY_=pP-w5-cKxNTs5JBRxkwr+nVjmQ@mail.gmail.com>
References: <1462871343-32361-1-git-send-email-shawn.lin@rock-chips.com> <1462871407-32566-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462871407-32566-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, May 10, 2016 at 2:10 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Currently sdhci-arasan 5.1 can support enhanced strobe function,
> and we now limit it just for "arasan,sdhci-5.1". Add
> mmc-hs400-enhanced-strobe in DT to enable the function if we'r sure

nit:s/we'r/we're/

[ ... ]
> @@ -79,6 +81,21 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>         }
>  }
>
> +static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
> +                                       struct mmc_ios *ios)
> +{
> +       u32 vendor;
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
> +       if (ios->enhanced_strobe)
> +               vendor |= VENDOR_ENHANCED_STROBE;
> +       else
> +               vendor &= (~VENDOR_ENHANCED_STROBE);

nit: no extra parentheses:

  vendor &= ~VENDOR_ENHANCED_STROBE;


Other than the nits this patch looks good to me.  Feel free to add my
Reviewed-by when nits fixed.

-Doug
