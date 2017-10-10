From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
Date: Tue, 10 Oct 2017 10:35:48 +0200
Message-ID: <d6118956-6fb4-cf7c-010b-b53f1c76b0c3@gmail.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
 <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
 <e4e5fa8b-b6a5-dc70-fbfc-6328493cd073@gmail.com>
 <1507599473.19789.1.camel@mhfsdcap03>
 <CAPDyKFpzuctUJ7FB9thMi0h602iJZc=kbs7iaVb+0oNCC4K4ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpzuctUJ7FB9thMi0h602iJZc=kbs7iaVb+0oNCC4K4ng@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org



On 10/10/2017 09:19 AM, Ulf Hansson wrote:
> On 10 October 2017 at 03:37, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> On Mon, 2017-10-09 at 16:54 +0200, Matthias Brugger wrote:
>>>
>>> On 10/09/2017 01:35 PM, Chaotian Jing wrote:
>>>> the driver has updated to have an explicit compatible, so update
>>>> binding file according to the driver change.
>>>>
>>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>>>> index 3e0a97c..2bb585b 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
>>>> @@ -8,8 +8,8 @@ and the properties used by the msdc driver.
>>>>
>>>>    Required properties:
>>>>    - compatible: value should be either of the following.
>>>> -   "mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>>>> -   "mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
>>>> +   "mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
>>>> +   "mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
>>>
>>> You can merge this with patch 1.
>>
>> OK, will merge it in next patch.
> 
> No, please don't!
> 
> I would like DT documentation changes to be posted in separate
> patches. Moreover, those should be before driver changes, when you
> order the changes in your series.
> 
> In this way, the bindings can be reviewed and acked separately, which
> makes it more convenient.
> 

Sounds reasonable, sorry for the confusion.
