From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 0/4] mmc: mmci: add busy detect for stm32 sdmmc variant
Date: Thu, 11 Apr 2019 15:51:10 +0200
Message-ID: <6cae3029-b40c-d43c-0712-47a472e8b1af@st.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <5b9fe100-6147-d64f-f676-6a5370a03016@st.com>
 <CAPDyKFpRA4mP-SHt_JuWk-Ee7=2Jgv6jKFh_08n_V20czKyvNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpRA4mP-SHt_JuWk-Ee7=2Jgv6jKFh_08n_V20czKyvNg@mail.gmail.com>
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

hi Ulf

On 4/11/19 3:29 PM, Ulf Hansson wrote:
> On Thu, 11 Apr 2019 at 14:37, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>> Hi Ulf
>>
>> Just a gentleman ping about this series.
>> I sent this series at same time of dt_mode
>> (no dependence between both).
> 
> Thanks for pinging.
> 
> It's been a busy period, with travels etc. I am just catching up on
> everything and I will soon come back to this.

No problem, I saw lot of power group presentations at linaro connect :-)

> 
> I haven't tried to apply this on top of the other recent queued
> changes for mmci, but perhaps you can check if a rebase is needed?

I try on the last mmc next, rebase, build and stm32mp157 test OK

> Especially since I plan to run this on my ux500 board.
> 
> Kind regards
> Uffe
> 
>>
>> BR
>> Ludo
>>
>> On 3/5/19 5:10 PM, Ludovic Barre wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> This patch series adds busy detect for stm32 sdmmc variant.
>>> Some adaptations are required:
>>> -Avoid to check and poll busy status when is not expected.
>>> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>>>    different.
>>> -Add hardware busy timeout with MMCIDATATIMER register.
>>>
>>> Ludovic Barre (4):
>>>     mmc: mmci: avoid fake busy polling
>>>     mmc: mmci: fix clear of busy detect status
>>>     mmc: mmci: add hardware busy timeout feature
>>>     mmc: mmci: add busy detect for stm32 sdmmc variant
>>>
>>>    drivers/mmc/host/mmci.c | 67 +++++++++++++++++++++++++++++++++++++++----------
>>>    drivers/mmc/host/mmci.h |  3 +++
>>>    2 files changed, 57 insertions(+), 13 deletions(-)
>>>
