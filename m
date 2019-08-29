From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 0/5] Add Genesys Logic GL975x support
Date: Thu, 29 Aug 2019 15:33:57 +0200
Message-ID: <CAPDyKFpL0AibOOu571J6Trad=SddxFZ5JaMLRu23K4-OkcEEZw@mail.gmail.com>
References: <20190827003145.2249-1-benchuanggli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827003145.2249-1-benchuanggli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chuang <benchuanggli@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael K. Johnson" <johnsonm@danlj.org>, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 02:32, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The patches modify internal clock setup to match SD Host Controller
> Simplified Specifications 4.20 and support Genesys Logic GL9750/GL9755 chipsets.
>
> V6:
>  - export sdhci_abot_tuning() function symbol
>  - use C-style comments
>  - use BIT, FIELD_{GET,PREP} and GENMASK to define bit fields of register
>  - use host->ops->platform_execute_tuning instead of mmc->ops->execute_tuning
>  - call sdhci_reset() instead of duplicating the code in sdhci_gl9750_reset
>  - remove .hw_reset
>  - use condition define CONFIG_MMC_SDHCI_IO_ACCESSORS for read_l

Applied patch 1-4, deferring patch5 for another version to fix Adrian's comment.

Kind regards
Uffe
