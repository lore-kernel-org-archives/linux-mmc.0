From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during
 tuning
Date: Tue, 20 Nov 2018 12:58:06 +0530
Message-ID: <4ff41f24-e152-521e-3fd7-0083b0d4ff98@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-2-faiz_abbas@ti.com>
 <CAPDyKFo==Up-pTGZcjMvKWY70-m7i44A5Yr_qJjtpBFjWK8J5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo==Up-pTGZcjMvKWY70-m7i44A5Yr_qJjtpBFjWK8J5g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Uffe

On 19/11/18 6:48 PM, Ulf Hansson wrote:
> On 19 November 2018 at 12:16, Faiz Abbas <faiz_abbas@ti.com> wrote:
>> Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
>> disabled DCRC interrupts during tuning. This write to the interrupt
>> enable register gets overwritten in sdhci_prepare_data() and the
>> interrupt is not in fact disabled. Fix this by disabling the interrupt
>> in the host->ier variable.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> Should we have fixes/stable tag?
> 

Ok. Will add that.

Thanks,
Faiz
