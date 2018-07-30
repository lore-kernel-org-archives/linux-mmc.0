From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 00/10] Tegra SDHCI update the pad autocal procedure
Date: Mon, 30 Jul 2018 17:07:59 +0200
Message-ID: <CAPDyKFo+nv+9qYV=J5k-63cDhQO=L==87RLMj_7BnjEjUf5iEQ@mail.gmail.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 26 July 2018 at 14:26, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Hi all,
>
> Update the tegra_sdhci_pad_autocalib() pad drive strength calibration
> procedure to match the ones specified in the TRMs of the more recent
> SoCs. This was tested on Tegra186, Tegra210, and Tegra124, although it
> should not break things older generations either.
>
> This series depends on the "Tegra SDHCI enable 1.8 V signaling on
> Tegar210 and Tegra186" series posted earlier.

According to the cover letter of the above series, it states that it
depends on $subject series. A circular dependency. :-)

In fact, there should be no dependency at all or else there seems to
be a DT compatibility problem here...

Anyway, I think it actually makes sense to fold in all changes into
one series. Make sure the dt-doc changes comes first, then the driver
changes and finally arm64/dts changes. This should make it easy to
follow the review and I can pick the mmc parts and the soc maintainer
can pick the arm64/dts changes.

[...]

Kind regards
Uffe
