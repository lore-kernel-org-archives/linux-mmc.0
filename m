From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 4/4] ARM: tegra: fix Venice2 VQMMC regulators
Date: Tue, 15 Apr 2014 12:31:25 -0600
Message-ID: <534D7AFD.7080807@wwwdotorg.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org> <1397526163-20126-5-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397526163-20126-5-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 04/14/2014 07:42 PM, Andrew Bresticker wrote:
> VDDIO_SDMMC3 is the VQMMC supply, not the VMMC supply, for the SD
> slot.  Add 1.8V_VDDIO as the VQMMC supply for the eMMC.

Is there documentation re: what vmmc-supply and vqmmc-supply actually
refer to? I looked a long while ago and couldn't find any, and didn't
get an answer when I asked.

Neither
Documentation/devicetree/bindings/mmc/{mmc.txt,nvidia,tegra20-sdhci.txt}
seem to say:-(
