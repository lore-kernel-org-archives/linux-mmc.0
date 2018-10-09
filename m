From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/6] mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY
Date: Tue, 9 Oct 2018 09:35:13 +0200
Message-ID: <CAPDyKFrt=6da_r3EwX0UxmHkHU0wLN9BME1XTsapU8YjBXpdsQ@mail.gmail.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com> <20181004111451.9539-6-faiz_abbas@ti.com>
 <CAPDyKFpRU1bQB6LMt30c8hGhTYnYp7FBVOz092TEzkiXfoDdgQ@mail.gmail.com> <f1979ee5-404b-4397-8acb-837fbda83eec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1979ee5-404b-4397-8acb-837fbda83eec@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 9 October 2018 at 09:35, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Hi Uffe,
>
> On Tuesday 09 October 2018 01:00 PM, Ulf Hansson wrote:
>> On 4 October 2018 at 13:14, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>> The current arasan sdhci PHY configuration isn't compatible
>>> with the PHY on TI's AM654 devices.
>>>
>>> Therefore, add a new compatible, AM654 specific quirks
>>> and a new AM654 specific set_clock function which
>>> configures the PHY in a sane way.
>>>
>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>
>> Applied for next, thanks!
>>
>
> Do I need to repost these in the v2 ?

No. It's okay if you drop them from the series.

Kind regards
Uffe
