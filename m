From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] Tegra SDHCI rerun pad calibration periodically
Date: Mon, 27 Aug 2018 11:55:01 +0200
Message-ID: <CAPDyKFqJJhhJe-fNLs-_zCcZiYKb+JAgJHwEyZbbUbs69hvQaw@mail.gmail.com>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com> <20180823085014.GB28696@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823085014.GB28696@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Aapo Vienamo <avienamo@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2018 at 10:50, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Aug 20, 2018 at 12:23:31PM +0300, Aapo Vienamo wrote:
>> Hi all,
>>
>> This series implements pad drive strength recalibration. The calibration
>> is rerun to compensate possible changes in temperature. The calibration
>> procedure is rerun as part of mmc_host_ops.request before
>> sdhci_request() is run. The calibration is executed only if the 100 ms
>> recalibration interval has passed.
>>
>> This series depends on the "Tegra SDHCI add support for HS200 and UHS
>> signaling" series.
>>
>> Aapo Vienamo (2):
>>   mmc: sdhci: Export sdhci_request()
>>   mmc: tegra: Implement periodic pad calibration
>>
>>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>>  drivers/mmc/host/sdhci.c       |  3 ++-
>>  drivers/mmc/host/sdhci.h       |  1 +
>>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> Adrian, Ulf,
>
> Since this depends on the earlier, fairly large series, I could throw
> these on top of the branch I already have. That way you don't have to
> worry about the dependency yourself. Of course it's also fine if you
> want to apply this yourselves, in which case the series is:
>
> Acked-by: Thierry Reding <treding@nvidia.com>
>
> Thanks,
> Thierry

Feel free to put in top in your branch and send a PR. BTW, Adrian has
already acked these changes.

Kind regards
Uffe
