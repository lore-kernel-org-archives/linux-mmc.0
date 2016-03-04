From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: Set DMA mask
Date: Fri, 4 Mar 2016 15:09:31 +0900
Message-ID: <CAAVeFuL6xrtjyWTp2AF=4oMMg95QEX+jPoi9kOXUaouvDfb15g@mail.gmail.com>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
 <1456806764-16467-2-git-send-email-acourbot@nvidia.com> <12391836.3mgJ3uDMLr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12391836.3mgJ3uDMLr@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 2, 2016 at 6:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 01 March 2016 13:32:43 Alexandre Courbot wrote:
>>          */
>> -       if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))) {
>> +       if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)))
>>                 host->dma_mask = DMA_BIT_MASK(64);
>> -               mmc_dev(mmc)->dma_mask = &host->dma_mask;
>> -       }
>> +
>> +       if (host->dma_mask &&
>> +           dma_set_mask_and_coherent(mmc_dev(mmc), host->dma_mask))
>> +               pr_warn("%s: cannot set DMA mask\n", mmc_hostname(mmc));
>>
>
> Looks good,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Withdrawing this patch after discussing with Arnd. The test detects
devices that are not capable of DMA, so it makes no sense to call a
DMA function right after that.

A better solution to the problem this patch tried to solve is on the way.
