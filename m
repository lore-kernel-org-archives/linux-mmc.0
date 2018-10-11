From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH V6 00/23] mmc: mmci: add sdmmc variant for stm32
Date: Thu, 11 Oct 2018 14:17:28 +0200
Message-ID: <00baaa9b-f630-1e59-0074-7d6fd35eff06@st.com>
References: <1539000535-13261-1-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFp0oHHS=bkXj_AbiLmbNxW07pFnk-4m9kwQtYkh_ogKgw@mail.gmail.com>
 <cb919bf8-caa2-b2fe-fee4-ae2f0f4c04b5@st.com>
 <CAPDyKFp4DEtavAqDg-ymaCcus+Hddv0OrgfS54HsTX+aWdzN+w@mail.gmail.com>
 <CAPDyKFqTNUihEk-i+t4OU1Eq5iBS57XZ4d8P2QbecgW_uT6NnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqTNUihEk-i+t4OU1Eq5iBS57XZ4d8P2QbecgW_uT6NnA@mail.gmail.com>
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

On 10/11/2018 12:33 PM, Ulf Hansson wrote:
> On 9 October 2018 at 13:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 9 October 2018 at 09:54, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>> hi Ulf
>>>
>>> On 10/09/2018 09:30 AM, Ulf Hansson wrote:
>>>>
>>>> Applied for next, thanks!
>>>>
>>>> FYI, I made little fixup of the help text in the Kconfig for the last
>>>> patch.
>>>
>>>
>>> Thanks for your review.
>>> Did you had a feedback on Qcom platform tests?
>>
>> Nope. I am leaving the tests for Qcom platforms to be done by
>> kernelci, let's see what the reports are.
> 
> FYI:
> 
> https://kernelci.org/boot/id/5bbdcd2b59b5147001b435a4/
> 
> Looks good!

Thanks for the boot tests on qcom

BR
Ludo

> 
> Kind regards
> Uffe
> 
