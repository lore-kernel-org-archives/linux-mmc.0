From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
Date: Wed, 5 Dec 2018 17:00:28 +0100
Message-ID: <4d5b86fa-aa89-5b19-1fee-ecdbc57f6d20@st.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
 <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpLTEwrBagJrd98Zyrd_pwJa9Zkgsi+geZainQV+OgpOQ@mail.gmail.com>
 <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp06tiMVgKyKLLKKwGtDPkAKuGWo=NaS+j=3oWGq-UV_A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-mmc@vger.kernel.org



On 12/5/18 3:23 PM, Ulf Hansson wrote:
> On Tue, 20 Nov 2018 at 10:42, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 7 November 2018 at 10:30, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>
>>> Refer to "4.15 set block count command" of sd specification:
>>> Host needs to issue CMD12 if any error is detected in
>>> the CMD18 and CMD25 operations.
>>>
>>> In sbc case, the data->stop is fill by framework.
>>>
>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>> ---
>>>   drivers/mmc/host/mmci.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>>> index 82bab35..13fa640 100644
>>> --- a/drivers/mmc/host/mmci.c
>>> +++ b/drivers/mmc/host/mmci.c
>>> @@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>>                          /* The error clause is handled above, success! */
>>>                          data->bytes_xfered = data->blksz * data->blocks;
>>>
>>> -               if (!data->stop || host->mrq->sbc) {
>>> +               if (!data->stop || (host->mrq->sbc && !data->error))
>>>                          mmci_request_end(host, data->mrq);
>>> -               } else {
>>> +               else
>>>                          mmci_start_command(host, data->stop, 0);
>>
>> This looks correct to me!
>>
>> Although, just wanted to double check that you tested this for a case
>> where we have host->mrq->sbc set and got an error in data->error? I
>> guess it can be tricky, so I was thinking of manually trying to
>> instruct the code, to set an error in data->error, at some point to
>> trigger this code. That would at least give us some confidence that it
>> works as expected.
> 
> I did some manual tests to trigger the error path. As far as I can
> tell, it works as expected and I observes that the core is able to
> recover and re-send the request.

Ulf, very thanks for the tests, and sorry for my busy status.
I will send as soon as possible the 2/2 with your recommendation (I will 
more spare time for upstream)

> 
> [...]
> 
> So, I have added my tested-by tag and applied this for next. Thanks!
> 
> In regards to patch2/2 I am awaiting your update.
> 
> Kind regards
> Uffe
> 
