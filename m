From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
Date: Mon, 14 Nov 2016 11:37:57 +0200
Message-ID: <3682f94a-187a-b4f3-0b77-8804ee16c9ba@intel.com>
References: <1478880259-24943-1-git-send-email-michael@walle.cc>
 <DB6PR0401MB2536FBC12CD47AED152F4783F8BC0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
 <1c1e557a605312a4bf2a1feb44d940e9@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c1e557a605312a4bf2a1feb44d940e9@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>, "Y.B. Lu" <yangbo.lu@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, yangbo lu <yangbo.lu@freescale.com>
List-Id: linux-mmc@vger.kernel.org

On 14/11/16 10:50, Michael Walle wrote:
> Am 2016-11-14 04:00, schrieb Y.B. Lu:
>>> -----Original Message-----
>>> From: Michael Walle [mailto:michael@walle.cc]
>>> Sent: Saturday, November 12, 2016 12:04 AM
>>> To: linux-kernel@vger.kernel.org
>>> Cc: linux-mmc@vger.kernel.org; Ulf Hansson; Adrian Hunter; yangbo lu;
>>> Michael Walle
>>> Subject: [PATCH v2] mmc: sdhci-of-esdhc: fixup PRESENT_STATE read
>>>
>>> Since commit 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy
>>> cards in __mmc_switch()") the ESDHC driver is broken:
>>>   mmc0: Card stuck in programming state! __mmc_switch
>>>   mmc0: error -110 whilst initialising MMC card
>>>
>>> Since this commit __mmc_switch() uses ->card_busy(), which is
>>> sdhci_card_busy() for the esdhc driver. sdhci_card_busy() uses the
>>> PRESENT_STATE register, specifically the DAT0 signal level bit. But the
>>> ESDHC uses a non-conformant PRESENT_STATE register, thus a read fixup is
>>> required to make the driver work again.
>>>
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> Fixes: 87a18a6a5652 ("mmc: mmc: Use ->card_busy() to detect busy cards in
>>> __mmc_switch()")
>>> ---
>>> v2:
>>>  - use lower bits of the original value (that was actually a typo)
>>>  - add fixes tag
>>>  - fix typo
>>>
>>>  drivers/mmc/host/sdhci-of-esdhc.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-
>>> of-esdhc.c
>>> index fb71c86..f9c84bb 100644
>>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>>> @@ -66,6 +66,18 @@ static u32 esdhc_readl_fixup(struct sdhci_host *host,
>>>              return ret;
>>>          }
>>>      }
>>> +    /*
>>> +     * The DAT[3:0] line signal levels and the CMD line signal level is
>>> +     * not compatible with standard SDHC register. Move the
>>> corresponding
>>> +     * bits around.
>>> +     */
>>> +    if (spec_reg == SDHCI_PRESENT_STATE) {
>>> +        ret = value & ~0xf8000000;
>>
>> [Lu Yangbo-B47093] I think the bits which should be cleaned before
>> following '|=' are 0x01f00000 not 0xf8000000, right?
>> :)
> 
> Its neither 0x01f00000 nor 0xf8000000 :( I'll put the bits definition into
> the comment the next time, so everyone can review them. bit[31:24] are the
> line DAT[7:0] line signal level. bit[23] is command signal level. All other
> bits are the same as in the standard SDHC PRESENT_STATE register.
> 
> I want to keep all but the upper 9 bits from the original value, therefore,
> this should be the correct mask:
>     ret = value & ~0xff800000;

Why keep bits 22:20 ?  Isn't it more logical to keep 19:0 (i.e. ret = value
& 0xfffff)

> 
> -michael
> 
>>
>>> +        ret |= (value >> 4) & SDHCI_DATA_LVL_MASK;
>>> +        ret |= (value << 1) & 0x01000000;
>>> +        return ret;
>>> +    }
>>> +
>>>      ret = value;
>>>      return ret;
>>>  }
>>> -- 
>>> 2.1.4
> 
> 
