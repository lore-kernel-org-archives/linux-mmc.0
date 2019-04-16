From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 23/24] arm64: dts: mediatek: add dtsi for MT8516
Date: Tue, 16 Apr 2019 10:04:02 +0200
Message-ID: <24517390-0015-d804-8c57-4e1030edba02@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-24-fparent@baylibre.com>
 <CAL_Jsq+Q06O84-MTpgTWGG312VXm_vGOkjMCjtWuS0eZ-j_0yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+Q06O84-MTpgTWGG312VXm_vGOkjMCjtWuS0eZ-j_0yw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Fabien Parent <fparent@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Sean Wang <sean.wang@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, Wenzhen Yu <wenzhen.yu@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 28/03/2019 20:22, Rob Herring wrote:
> On Sat, Mar 23, 2019 at 4:17 PM Fabien Parent <fparent@baylibre.com> wrote:
>>
>> The MT8516 SoC provides the following peripherals: GPIO, UART, USB2,
>> SPI, eMMC, SDIO, NAND, Flash, ADC, I2C, PWM, Timers, IR, Ethernet, and
>> Audio (I2S, SPDIF, TDM).
>>
>> This commit is adding the basic dtsi file with the support of the
>> following IOs: GPIO, UART, SPI, eMMC, I2C, Timers.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h | 663 ++++++++++++++++++
>>  arch/arm64/boot/dts/mediatek/mt8516.dtsi      | 409 +++++++++++
>>  2 files changed, 1072 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8516.dtsi
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

Fabien, before taking this through my tree, I'd like to see the drivers merged.
Can you please resubmit taking into account the outcome of get_maintainers.pl
script. From my experience it is easier to send one series per driver, as it
makes the amount of emails every maintainer gets more manageable.

Regards,
Matthias
