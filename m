From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH 02/14] mmc: mmci: Don't pretend all variants to have
 MCI_STARBITERR flag
Date: Mon, 15 Jan 2018 17:27:13 +0000
Message-ID: <5ffa4035-0cde-119e-b53e-1af6daab83cc@st.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
 <1515759368-16946-3-git-send-email-patrice.chotard@st.com>
 <CAPDyKFpqENchQs7c1BSJnorTgidbwHFAHByHJU3t9TV6uHurxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpqENchQs7c1BSJnorTgidbwHFAHByHJU3t9TV6uHurxA@mail.gmail.com>
Content-Language: en-US
Content-ID: <553B1ECD78F2A74EBFA23238CD394A0C@st.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Alexandre TORGUE <alexandre.torgue@st.com>, Andrea Merello <andrea.merello@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf

On 01/15/2018 01:32 PM, Ulf Hansson wrote:
> On 12 January 2018 at 13:15,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> This patch prepares for supporting the STM32 variant that
>> has no such bit in the status register.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 3125dc0..7e56f85 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -83,6 +83,8 @@
>>    * @qcom_dml: enables qcom specific dma glue for dma transfers.
>>    * @reversed_irq_handling: handle data irq before cmd irq.
>>    * @mmcimask1: true if variant have a MMCIMASK1 register.
>> + * @start_err: true is the variant has STARTBITERR bit inside MMCISTATUS
>> + *            register.
>>    */
>>   struct variant_data {
>>          unsigned int            clkreg;
>> @@ -113,6 +115,7 @@ struct variant_data {
>>          bool                    qcom_dml;
>>          bool                    reversed_irq_handling;
>>          bool                    mmcimask1;
>> +       bool                    start_err;
> 
> To be consistent with how we implement support for similar variant
> variations, I would prefer to have this being a u32. Something along
> the lines of how the "busy_detect_flag" is being used.

OK i will update this in v2

Thanks

Patrice

> 
> Otherwise this looks good to me.
> 
> [...]
> 
> Kind regards
> Uffe
> 
