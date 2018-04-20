From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] ARM64: dts: meson-axg: enable the eMMC controller
Date: Fri, 20 Apr 2018 08:55:47 +0200
Message-ID: <CAPDyKFpcmO7LYuyuNPcYmzeDyq_AXDH5W4Y9dByTL-B+DGZSqg@mail.gmail.com>
References: <20180408113647.13543-1-yixun.lan@amlogic.com> <7ho9if3wo3.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ho9if3wo3.fsf@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Yixun Lan <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nan Li <nan.li@amlogic.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@caione.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Jerome Brunet <jbrunet@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Heiner Kallweit <hkallweit1@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 19 April 2018 at 19:58, Kevin Hilman <khilman@baylibre.com> wrote:
> Yixun Lan <yixun.lan@amlogic.com> writes:
>
>> From: Nan Li <nan.li@amlogic.com>
>>
>> The IP of eMMC controller in AXG is similiar to Meson-GX series.
>> Here we add the initial support of the HS200 mode with
>> clock running at 166MHz (to be safe), since we found some eMMC chip
>> fail to run at 200MHz due to tunning phase error.
>>
>> Signed-off-by: Nan Li <nan.li@amlogic.com>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>
> Applied to v4.18/dt64
>
>> ---
>> Hi Kevin
>>   Please note this patch actually depend on the eMMC driver here [0].
>>   Still a few problem to solve, to improve the tuning phase driver to make
>> the clock running at 200MHz, and to further support the HS400 mode.
>> Anyway, this patch itself is quite independent.
>
> The driver changes are queued for v4.18 also.  Good!

Right, may I consider that as an ack? :-)

Kind regards
Uffe

>
> Kevin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
