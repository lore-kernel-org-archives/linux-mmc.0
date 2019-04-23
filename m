From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 15/24] dt-bindings: pinctrl: pinctrl-mt65xx: add support
 for MT8516
Date: Tue, 23 Apr 2019 16:24:44 +0200
Message-ID: <470d475e-b694-ab6a-5ff7-b5635af629bb@gmail.com>
References: <20190323211612.860-1-fparent@baylibre.com>
 <20190323211612.860-16-fparent@baylibre.com>
 <CACRpkdZZ6-+MVdK4bOP4SHxQ8uQ8zENcir7DSteHy4g+B5uySQ@mail.gmail.com>
 <b1e4eb6c-0d53-0307-99e4-9fef9e2b33d8@gmail.com>
 <CACRpkdZ8gq+hGRT6EAyP2w9K0jz5RAzWeZ6_UrW+v-BOjd-wbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ8gq+hGRT6EAyP2w9K0jz5RAzWeZ6_UrW+v-BOjd-wbg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Fabien Parent <fparent@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sean Wang <sean.wang@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com, Chaotian Jing <chaotian.jing@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, jjian.zhou@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-serial@
List-Id: linux-mmc@vger.kernel.org



On 23/04/2019 13:01, Linus Walleij wrote:
> On Tue, Apr 16, 2019 at 11:12 AM Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> 
>> Hi Linus,
>>
>> On 08/04/2019 22:44, Linus Walleij wrote:
>>> On Sat, Mar 23, 2019 at 10:17 PM Fabien Parent <fparent@baylibre.com> wrote:
>>>
>>>> Add binding documentation of pinctrl-mt65xx for MT8516 SoC.
>>>>
>>>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>>>
>>> Patch applied with Rob's ACK.
>>>
>>
>> I don't see this in your for-next branch. Did the patch got lost?
> 
> I usually push the devel branch to be tested by the build robots
> and then mix down the for-next branch.
> 
> Recent week(s) the build robot was not responding so it got delayed.
> 

I don't see it in the devel branch [1]. Can you please double check?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
