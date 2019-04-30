From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 0/5] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Tue, 30 Apr 2019 14:06:45 +0200
Message-ID: <74b91eb4-e5a3-38b2-f732-29cdd058eb6a@st.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqbn=UcbwoH_z+yjrjvHQZaMtmsD=n0yrBV7DAK5VRJEQ@mail.gmail.com>
Content-Language: en-US
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
Cc: DTML <devicetree@vger.kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 4/30/19 1:13 PM, Ulf Hansson wrote:
> On Fri, 26 Apr 2019 at 09:46, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch series adds busy detect for stm32 sdmmc variant.
>> Some adaptations are required:
>> -Avoid to check and poll busy status when is not expected.
>> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>>   different.
>> -Add hardware busy timeout with MMCIDATATIMER register.
>>
>> V2:
>> -mmci_cmd_irq cleanup in separate patch.
>> -simplify the busy_detect_flag exclude
>> -replace sdmmc specific comment in
>> "mmc: mmci: avoid fake busy polling in mmci_irq"
>> to focus on common behavior
>>
>> Ludovic Barre (5):
>>    mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
>>    mmc: mmci: avoid fake busy polling in mmci_irq
>>    mmc: mmci: fix clear of busy detect status
>>    mmc: mmci: add hardware busy timeout feature
>>    mmc: mmci: add busy detect for stm32 sdmmc variant
>>
>>   drivers/mmc/host/mmci.c | 61 ++++++++++++++++++++++++++++++++++++++-----------
>>   drivers/mmc/host/mmci.h |  3 +++
>>   2 files changed, 51 insertions(+), 13 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
> Ludovic, just wanted to let you know that I am reviewing and testing
> this series.
> 
> However, while running some tests on Ux500 for validating the busy
> detection code, even without your series applied, I encounter some odd
> behaviors. I am looking into the problem to understand better and will
> let you know as soon as I have some more data to share.

Oops, don't hesitate to share your status, if I could help.

> 
> Kind regards
> Uffe
> 
