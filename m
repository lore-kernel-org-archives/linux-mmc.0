From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 06/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
Date: Mon, 30 Jan 2017 11:40:48 +0200
Message-ID: <1f0cc488-75f0-cff3-1386-070717aa7220@intel.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
 <2e67332d-d8c3-fd24-1f81-72675a09927a@intel.com>
 <CAPDyKFqbjeKCHp40PALydquxdF-qBk156+iOS9TYYsquJ7fK7w@mail.gmail.com>
 <00e8d2dc-bc07-addc-a5d9-8604f143627f@intel.com>
 <CAPDyKFoF2QsTxKC7=PjHqOk106USQ-j9MtiyfC=Sqks8DnPDYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoF2QsTxKC7=PjHqOk106USQ-j9MtiyfC=Sqks8DnPDYQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Turquette <mturquette@baylibre.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk <linux-clk@vger.kernel.org>, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infra>
List-Id: linux-mmc@vger.kernel.org

On 30/01/17 11:10, Ulf Hansson wrote:
> On 28 January 2017 at 09:16, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 27/01/2017 5:12 p.m., Ulf Hansson wrote:
>>>
>>> On 26 January 2017 at 13:39, Adrian Hunter <adrian.hunter@intel.com>
>>> wrote:
>>>>
>>>> On 26/01/17 12:50, Ulf Hansson wrote:
>>>>>
>>>>> On 11 January 2017 at 18:19, Gregory CLEMENT
>>>>> <gregory.clement@free-electrons.com> wrote:
>>>>>>
>>>>>> +                       priv->init_card_type = MMC_TYPE_MMC;
>>>>>> +                       mmc->caps |= MMC_CAP_NONREMOVABLE;
>>>>>> +
>>>>>> +                       /*
>>>>>> +                        * Force to clear BUS_TEST to
>>>>>> +                        * skip bus_test_pre and bus_test_post
>>>>>> +                        */
>>>>>> +                       mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
>>>>>> +                       mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
>>>>>
>>>>>
>>>>> This cap is a bit strange. It was added several years ago by Adrian
>>>>> Hunter, but I am wondering about the reason to why it's needed.
>>>>>
>>>>
>>>> MMC_CAP2_HC_ERASE_SZ relates to EXT-CSD ERASE_GROUP_DEF.
>>>>
>>>> I think it was added to enable people to choose whether they wanted a
>>>> large
>>>> or small erase granularity.  That probably doesn't matter if the card
>>>> supports TRIM.
>>>>
>>>
>>> Huh, the erase/trim/discard code in the mmc core is really hairy. :-)
>>>
>>> In mmc_calc_max_discard() the following code/comment exists:
>>>
>>> /*
>>>  * Without erase_group_def set, MMC erase timeout depends on clock
>>>  * frequence which can change.  In that case, the best choice is
>>>  * just the preferred erase size.
>>>  */
>>> if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
>>>      return card->pref_erase;
>>>
>>>
>>> This makes me wonder.
>>>
>>> So, when we haven't enabled the high capacity erase groups in the
>>> EXT_CSD register (ext_csd.erase_group_def), we will use the pref_erase
>>> size.
>>>
>>> In the other case, as when having MMC_CAP2_HC_ERASE_SZ set (which will
>>> set ext_csd.erase_group_def),  we will instead  do some calculations
>>> to find out the max discards.
>>>
>>> Are you saying that these calculations doesn't matter much - or are
>>> you saying that we always want to do them?
>>
>>
>> No, I was saying that if you have TRIM then TRIM is preferred to ERASE so
>> the erase group size does not come into play when discarding, since ERASE
>> granularity is erase groups whereas TRIM granularity is sectors.
> 
> Right. Thanks for clarifying.
> 
>>
>> However ERASE_GROUP_DEF also affects the size of write protect groups.
> 
> In either case.
> 
> What do you think of removing MMC_CAP2_HC_ERASE_SZ? I don't like these
> kind of soft polices, it's better if we can decide on a common
> behaviour - whatever that is.

Changing the value of ERASE_GROUP_DEF could be a problem, for example the
spec. says:

"Similarly if the host set ERASE_GROUP_DEF bit for a device that the default
write protect was already set in some of the area in the previous power
cycle, then the device may show unknown behavior when host issue write
or erase commands to the device. In application, it is mandatory for host to
use same ERASE GROUP DEF value to the device all the time."

Whether or not there is anyone that would actually be affected is hard to know.
