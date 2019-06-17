From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] Add Support for MMC in J721E
Date: Mon, 17 Jun 2019 13:35:03 +0200
Message-ID: <CAPDyKFqt9N+Hn-VhEr0ANv3zXLGyjCDEDiBgEx8FpLFBBzT0EA@mail.gmail.com>
References: <20190604060914.10886-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190604060914.10886-1-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Nishanth Menon <nm@ti.com>, DTML <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 4 Jun 2019 at 08:09, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The following patches add driver support for MMC SDHCI interfaces on
> TI's J721E devices. The 8 bit and 4 bit instances have phys which are
> different from the am65x interfaces as well as different from each
> other which leads to 3 different compatibles and a bunch of flags for
> indicating the differences.
>
> Depends on Nishanth's initial J721E patches here:
> https://lore.kernel.org/patchwork/cover/1077382/
>
> Also depends on my fixes for AM65x driver here:
> https://lore.kernel.org/patchwork/cover/1079924/
>
> Tested with: j721e-evm and am65x-evm.
>
> DT patches will be added in a separate series.
>
> Faiz Abbas (4):
>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
>     controllers on TI's J721E devices.
>   mmc: sdhci_am654: Add Support for 8 bit IP on J721E
>   mmc: sdhci_am654: Add Support for 4 bit IP on J721E
>   arm64: defconfig: Add config for MMC on AM65x and J721E devices
>
>  .../devicetree/bindings/mmc/sdhci-am654.txt   |   9 +-
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/mmc/host/sdhci_am654.c                | 257 +++++++++++++-----
>  3 files changed, 204 insertions(+), 63 deletions(-)
>
> --
> 2.19.2
>

Patch 1->3 applied for next, patch is for arm-soc, thanks!

Kind regards
Uffe
