From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [RFC v2 00/13] usb/mmc/power: Fix USB/LAN when TFTP booting
Date: Tue, 13 Dec 2016 13:34:02 +0100
Message-ID: <b34f49c8-6b37-cabf-2a0f-c8d465c53159@xs4all.nl>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <c956e27e-7e01-2a2f-0e35-796c4a6556ae@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <c956e27e-7e01-2a2f-0e35-796c4a6556ae@xs4all.nl>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Try again, this time with Krzysztof's new email address...

On 13/12/16 13:20, Hans Verkuil wrote:
> Hi Krzysztof,
>
> This still seems to be broken with the latest 4.9 kernel, right?
>
> Has there been any progress on this? Do you have an updated patch series
> for me to use?
>
> Regards,
>
>     Hans
>
> On 05/05/16 14:34, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> This is a different, second try to fix usb3503+lan on Odroid U3 board
>> if it was initialized by bootloader (e.g. for TFTP boot).
>>
>> First version:
>> http://www.spinics.net/lists/linux-usb/msg140042.html
>>
>>
>> Problem
>> =======
>> When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
>> the usb3503 and LAN smsc95xx do not show up in "lsusb". Hard-reset
>> is required, e.g. by suspend to RAM. The actual TFTP boot does
>> not have to happen. Just "usb start" from U-Boot is sufficient.
>>
>
>
