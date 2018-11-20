From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 2/4] mmc: sdhci-omap: Add variable to indicate host is
 tuning
Date: Tue, 20 Nov 2018 18:28:06 +0530
Message-ID: <c3379377-54d3-b9bf-c910-11b8987b7e2c@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-3-faiz_abbas@ti.com>
 <CAPDyKFqkscm9ZhJhk7SWFc_tmqqqXSx5_t2tzEL-DV6aE+Q=KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqkscm9ZhJhk7SWFc_tmqqqXSx5_t2tzEL-DV6aE+Q=KA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi Uffe,

On 19/11/18 6:48 PM, Ulf Hansson wrote:
> On 19 November 2018 at 12:16, Faiz Abbas <faiz_abbas@ti.com> wrote:
>> Add a variable in sdhc_omap_host to indicate whether a tuning
>> operation is ongoing.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> 
> Please squash this into patch3 as it seems a bit silly to keep this a
> separate change.
> 

Ok. Squashing 2 and 3.

Thanks,
Faiz
