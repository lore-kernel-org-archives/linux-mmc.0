From: Ludovic BARRE <ludovic.barre@st.com>
Subject: Re: [PATCH 02/19] mmc: mmci: merge qcom dml feature into mmci dma
Date: Fri, 13 Jul 2018 15:08:45 +0200
Message-ID: <ed45398d-552c-7bae-d77a-4e0d99b21759@st.com>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFqOOvbNc79hdWhdS4pxkYrh48At-BLuGmX0jDMER3Akdw@mail.gmail.com>
 <c09e8f7a-3bf7-abb3-b49c-011ae29f8d67@st.com>
 <CAPDyKFrN3GMez1vyc6xQUH_Qp7UrDj88rG9pAP_oTLHOB6k91g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFrN3GMez1vyc6xQUH_Qp7UrDj88rG9pAP_oTLHOB6k91g@mail.gmail.com>
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
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Gerald Baeza <gerald.baeza@st.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 07/13/2018 01:17 PM, Ulf Hansson wrote:
> On 11 July 2018 at 17:19, Ludovic BARRE <ludovic.barre@st.com> wrote:
>>
>>
>> On 07/05/2018 05:26 PM, Ulf Hansson wrote:
>>>
>>> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>>>>
>>>> From: Ludovic Barre <ludovic.barre@st.com>
>>>>
>>>> This patch integrates qcom dml feature into mmci_dma file.
>>>> Qualcomm Data Mover lite/local is already a variant of mmci dmaengine.
>>>>
>>>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>>>> ---
>>>>    drivers/mmc/host/Makefile        |   1 -
>>>>    drivers/mmc/host/mmci.c          |   1 -
>>>>    drivers/mmc/host/mmci.h          |  35 ++++++++
>>>>    drivers/mmc/host/mmci_dma.c      | 135 ++++++++++++++++++++++++++++-
>>>>    drivers/mmc/host/mmci_qcom_dml.c | 177
>>>> ---------------------------------------
>>>>    drivers/mmc/host/mmci_qcom_dml.h |  31 -------
>>>>    6 files changed, 169 insertions(+), 211 deletions(-)
>>>>    delete mode 100644 drivers/mmc/host/mmci_qcom_dml.c
>>>>    delete mode 100644 drivers/mmc/host/mmci_qcom_dml.h
>>>
>>>
>>> No, this is not the way to go. Instead I I think there are two options.
>>>
>>> 1) Keep mmci_qcom_dml.c|h and thus add new files for the stm32 dma
>>> variant.
>>>
>>> 2) Start by renaming mmci_qcom_dml.* to mmc_dma.* and then in the next
>>> step add the code for stm32 dma into the renamed files.
>>>
>>> I guess if there is some overlap in functionality, 2) may be best as
>>> it could easier avoid open coding. However, I am fine with whatever
>>> option and I expect that you knows what is best.
>>
>>
>> After patch 01 & 05 comments:
>> I will try to define a mmci_ops which contain some functions pointer
>> called by mmci.c (core).
>> A variant defines its mmci_ops.
>> where do you define the specific function:
>> -in a single file, mmci-ops.c or other (for the name, I'm not inspirated)
>> -or in specific file for each variant mmci-qcom.c or mmci-stm32.c
>>
>> following the comment (above), I think we define a single file?
> 
> If I understand the question, the problem is how we should assign the
> mmc host ops, which corresponds to the probed variant data!?
> 
> I took a stub at it and posted two patches which I think you should be
> able to build upon. Please have a look.

I review your patch on mmci_host_ops and init, I agree with your series,
I was going in the same direction.
The comment above was on file organization, what do you prefer?
-a single file with: all callback and all mmci_host_ops of each variant
-or each variant in specific file (like sdhci): mmci-qcom.c | 
mmci-stm32.c ...

> 
> [...]
> 
> Kind regards
> Uffe
> 
