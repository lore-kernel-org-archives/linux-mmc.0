From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/2] Add ACPI support to IPROC SDHCI
Date: Wed, 22 Aug 2018 11:48:14 +0200
Message-ID: <CAPDyKFq1u55-9WCXm_AJOqW=1_1ivg57Mgzp8D=ixAE2SAkpdg@mail.gmail.com>
References: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinath Mannam <srinath.mannam@broadcom.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, vikram.prakash@broadcom.com, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 5 August 2018 at 09:52, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> This patch series adds
>   - Feature to get generic device properties in the
>     place of DT properties.
>   - ACPI support to IPROC SDHCI varients
>
> This patch series is based off v4.18-rc3
>
> Changes from v3:
>   - Replaced separate device tree and ACPI get match data APIs
>     with single device_get_match_data API.
>
> Changes from v2:
>   - Added patch "Convert DT properties to generic device properties"
>     given by Adrian Hunter to this patch series because
>     "Add ACPI support to IPROC SDHCI" patch is depends on this.
>
> Changes from v1:
>   - Removed sdhci_iproc_data array change and add directly
>     into of and acpi id tables.
>   - Add a change to get match data directly.
>   - Removed clock-frequency property read change.
>   - Used sdhci_get_property to get properties.
>   - Verified with patch given by Adrian Hunter
>     mmc: sdhci-pltfm: Convert DT properties to generic device properties
>
> Adrian Hunter (1):
>   mmc: sdhci-pltfm: Convert DT properties to generic device properties
>
> Srinath Mannam (1):
>   mmc: host: iproc: Add ACPI support to IPROC SDHCI
>
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci-iproc.c | 59 ++++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci-pltfm.c | 68 +++++++++++++++++++++++++-----------------
>  drivers/mmc/host/sdhci-pltfm.h |  7 ++++-
>  4 files changed, 87 insertions(+), 48 deletions(-)
>
> --
> 2.7.4
>

Thanks, queued for v4.20!

Kind regards
Uffe
