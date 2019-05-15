From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: meson-gx: add ddr-access-quirk
 property
Date: Wed, 15 May 2019 14:43:56 +0200
Message-ID: <9a5d0be0-00de-2ced-de20-000c0b12b3c8@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
 <20190513091548.16674-2-narmstrong@baylibre.com>
 <CAPDyKFr9HVLNpqncs6YhGvqPdXCk6mtVSPVcWDvmnrKiNB+ACQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr9HVLNpqncs6YhGvqPdXCk6mtVSPVcWDvmnrKiNB+ACQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, DTML <devicetree@vger.kernel.org>, baylibre-upstreaming@groups.io, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15/05/2019 13:37, Ulf Hansson wrote:
> On Mon, 13 May 2019 at 11:16, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
>> makes any DDR access from the MMC controller fail.
>>
>> Add the amlogic,ddr-access-quirk property so signal this particular
>> controller has this bug and needs a quirk to work properly.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
>> index 13e70409e8ac..f8914dab06c6 100644
>> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
>> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
>> @@ -22,6 +22,10 @@ Required properties:
>>    clock rate requested by the MMC core.
>>  - resets     : phandle of the internal reset line
>>
>> +Optional properties:
>> +- amlogic,ddr-access-quirk: set when HW cannot access the DDR memory, like on
>> +  the G12A SDIO controller.
> 
> As stated on the other patch, may I suggest to use DRAM instead of DDR.

Indeed, may be more accurate.

> 
> Moreover, please mention that this is about the internal DMA support
> of the controller.

Ok

> 
>> +
>>  Example:
>>
>>         sd_emmc_a: mmc@70000 {
>> --
>> 2.21.0
>>
> 
> Kind regards
> Uffe
> 
