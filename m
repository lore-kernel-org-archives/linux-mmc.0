From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 00/14] mmc: mmci: prepare dma callbacks with mmci_host_ops
Date: Wed, 5 Sep 2018 11:13:52 +0200
Message-ID: <5e9e5114-40d0-d178-4fdc-edfd5963c170@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqArwShaUZAit4fHa7F6UNC_z7Yc1GMpBuQcrkkwrB84g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqArwShaUZAit4fHa7F6UNC_z7Yc1GMpBuQcrkkwrB84g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 09/04/2018 12:00 PM, Ulf Hansson wrote:
> On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch series prepares and adds callbacks for dma transfert at
>> mmci_host_ops. This series is composed of 3 parts:
>> -Internalize specific needs of legacy dmaengine.
>> -Create and setup dma_priv pointer
>> -Create generic callbacks  which share some features
>> (like cookie...) and call specific needs
> 
> I have now reviewed part of this series and provided you with some
> comments, but will stop at this point.

thanks for your review

> 
> Overall, the comments are about renaming and picking better function
> names. Those comments should be easy to address in a new version.

yes, there is no problem for the naming, I will change following your
recommendations.

> 
> However, the other more important point is the number of variant
> callbacks you are adding. It's of course a balance to pick the right
> level, to get both flexibility but also to avoid open coding. In the
> end we don't want to get too many callbacks, but then it's better to
> share common mmci code for variants, through mmci.h.
> 
> Finally, I would like to see a patch on top adding the support for the
> new ST variant, so I can see how the callbacks and changes really are
> being used. Can you please add that?
> 

yes, I prepare a patch with sdmmc variant to show how callbacks are used.

About comment on patch 07/14:
 > So, having callbacks for dealing with dma_map|unmap() kind of
 > operations, becomes rather fine-grained and not very flexible.
 > Instead, what do you think of allowing the variant init function to
 > dynamically assign the ->pre_req() and the ->post_req() callbacks in
 > the struct mmc_host_ops. Common mmci functions to manage these
 > operations can instead be shared via mmci.h and called by the
 > variants.

I think we have the same goal or idea, regroup the common needs to avoid
too much specific drift.

I will try to describe the functions which are commons and the link to 
specific mmci_host_ops callbacks.

(I use function names of this series, but it's just for this example)

commons function used by mmci core:
-mmci_pre_request:
  check data and cookie, call common mmci_validate_data
  and mmci_prepare_data.

-mmci_post_request:
  check data and cookie then call common mmci_unprepare_data

-mmci_validate_data:
  check the common constraint of variants, call specific
  validate_data if defined.

-mmci_prepare_data:
  setup common next cookie, call specific prepare data if defined

-mmci_unprepare_data:
  clear the common cookie, call specific unprepare data if defined

-mmci_get_next_data:
  check cookie, call specific get_next_data if defined

-mmci_dma_setup:
  initialize common next_cookie, call specific dma_setup if defined

-mmci_dma_release
  just call dma_release if defined

-mmci_dma_start
  call common prepare data if not yet done (by next)
  call specific dma_start
  write common registers to start transfer and setup mmci mask

-mmci_dma_finalize:
  just call dma_finalize if defined

-mmci_dma_error
  just call dma_error if defined

mmci_host_ops specific:
struct mmci_host_ops
validate_data: 	could be use to check specific constraint of variant.
  		sdmmc has constraints on base & size for each element
		excepted the last element which has no constraint on
		size.
prepare_data: 	specific needs to prepare current or next data request.
		mmci: dma_map_sg on channel, use dmaengine api
		"dmaengine_prep_slave_sg" to queue a transfer
		sdmmc: dma_map_sg on sdmmc device and prepare the link
		list of internal dma
		
unprepare_data: specific needs to unprepare the data of request
		mmci: dma_unmap_sg on channel, use dmaengine api to
		terminate transfert.
		sdmmc: just unmap on sdmmc device.

get_next_data: 	manage specific needs to move on next data
		mmci: get next dmaengine descriptor and channel
		sdmmc: today, nothing

dma_setup: 	setup specific need if you use a Direct Memory Access
		mmci: use dmaengine api to request slave channel.
		sdmmc: alloc memory for link list, and define specific
		mmc->max_segs and mmc->max_seg_size.

dma_release: 	release specific resource if you use a Direct Memory
		access.
		mmci: use dmaengine api to release channel
		sdmmc: nothing

dma_start: 	set specific needs to start dma request
		mmci: use dmaengine api to submit and pending a dma
		transfert.
		sdmmc: set specific sdmmc registers to start an internal
		dma transfert

dma_finalize: 	set specific needs to finalize a request
		mmci: specific check on fifo status and
		channel/descriptor management.
		sdmmc: just clear a specific register of sdmmc

dma_error: 	specific error management.
		mmci: dmaengine api to terminate a transfer
		sdmmc: nothing

BR
Ludo

>>
>> This patch series must be applied on top of
>> "mmc: mmci: Add and implement a ->dma_setup() callback for qcom dml"
>>
>> Ludovic Barre (14):
>>    mmc: mmci: fix qcom dma issue during mmci init with new dma_setup
>>      callback
>>    mmc: mmci: internalize dma map/unmap into mmci dma functions
>>    mmc: mmci: internalize dma_inprogress into mmci dma functions
>>    mmc: mmci: introduce dma_priv pointer to mmci_host
>>    mmc: mmci: move mmci next cookie to mci host
>>    mmc: mmci: merge prepare data functions
>>    mmc: mmci: add prepare/unprepare_data callbacks
>>    mmc: mmci: add get_next_data callback
>>    mmc: mmci: modify dma_setup callback
>>    mmc: mmci: add dma_release callback
>>    mmc: mmci: add dma_start callback
>>    mmc: mmci: add dma_finalize callback
>>    mmc: mmci: add dma_error callback
>>    mmc: mmci: add validate_data callback
>>
>>   drivers/mmc/host/mmci.c          | 458 ++++++++++++++++++++++++---------------
>>   drivers/mmc/host/mmci.h          |  45 ++--
>>   drivers/mmc/host/mmci_qcom_dml.c |  15 +-
>>   3 files changed, 322 insertions(+), 196 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 
