From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 0/2] dw_mmc: add multislot support
Date: Fri, 20 Apr 2018 10:56:46 +0200
Message-ID: <CAPDyKFqGNR_YV=adUKqzEuYk-ZV48MHW68Uyr=8nXBEvafGsWQ@mail.gmail.com>
References: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
 <CAPDyKFqxZLtx_=0UU9NgBnW0Vmw=456q2FFbMBK4LKEaF-ua7A@mail.gmail.com> <1524210132.4614.4.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524210132.4614.4.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "krzk@kernel.org" <krzk@kernel.org>, "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "kgene@kernel.org" <kgene@kernel.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 April 2018 at 09:42, Alexey Brodkin <Alexey.Brodkin@synopsys.com> wrote:
> Hi Ulf,
>
> On Fri, 2018-04-20 at 09:35 +0200, Ulf Hansson wrote:
>> [...]
>>
>> >
>> > 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
>> >  * Add missing slot switch to __dw_mci_start_request() function.
>> >  * Refactor set_ios function:
>> >    a) Calculate common clock which is
>> >       suitable for all slots instead of directly use clock value
>> >       provided by mmc core. We calculate common clock as the minimum
>> >       among each used slot clocks. This clock is calculated in
>> >       dw_mci_calc_common_clock() function which is called
>> >       from set_ios()
>> >    b) Disable clock only if no other slots are ON.
>> >    c) Setup clock directly in set_ios() only if no other slots
>> >       are ON. Otherwise adjust clock in __dw_mci_start_request()
>> >       function before slot switch.
>> >    d) Move timings and bus_width setup to separate funcions.
>> >  * Use timing field in each slot structure instead of common field in
>> >    host structure.
>> >  * Add locks to serialize access to registers.
>>
>> Sorry, but this is a hack to *try* to make multi-slot work and this
>> isn't sufficient. There were good reasons to why the earlier
>> non-working multi slot support was removed from dw_mmc.
>>
>> Let me elaborate a bit for your understanding. The core uses a host
>> lock (mmc_claim|release_host()) to serialize operations and commands,
>> as to confirm to the SD/SDIO/(e)MMC specs. The above changes gives no
>> guarantees for this. To make that work, we would need a "mmc bus lock"
>> to be managed by the core.
>>
>> However, inventing a "mmc bus lock" would lead to other problems
>> related to I/O scheduling for upper layers - it simply breaks. For
>> example, I/O requests for one card/slot can then starve I/O requests
>> reaching another card/slot.
>
> So are you saying that multi-slot support is a no go in general or it is only
> applicable to DW MMC (I really doubt that's a case)?

In general.

>
> BTW there're other controllers that seem to support multi-slot like Atmel etc.

Yeah, none of those are working - it just bad attempts to try to make
*something* work.

Kind regards
Uffe
