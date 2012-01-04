From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
Date: Wed, 04 Jan 2012 16:37:25 +0100
Message-ID: <4F047235.2090503@samsung.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
 <20111107211726.GC28491@ponder.secretlab.ca>
 <CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>, kgene.kim@samsung.com
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Hi Kgene, Thomas

On 11/08/2011 04:23 PM, Thomas Abraham wrote:
> Hi Grant,
> 
> On 8 November 2011 02:47, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Thu, Nov 03, 2011 at 02:06:03AM +0530, Thomas Abraham wrote:
>>> Add device tree based discovery support for Samsung's sdhci controller
>>>
>>> Cc: Ben Dooks <ben-linux@fluff.org>
>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>> ---
>>> +Example:
>>> +     sdhci@12530000 {
>>> +             compatible = "samsung,exynos4210-sdhci";
>>> +             reg = <0x12530000 0x100>;
>>> +             interrupts = <139>;
>>> +             samsung,sdhci-bus-width = <4>;
>>> +             linux,mmc_cap_4_bit_data;
>>
>> Following on from my reply on patch 5, this is an example of exactly
>> what I'm talking about.  This node both sets bus-width to '4', and
>> sets the 4_bit_data flag.  Don't you think that the driver would be
>> smart enough to set the 4_bit_data flag when the bus width was set to
>> 4?
> 
> Yes, that is true. I will modify the driver based on your comments and
> resubmit this patch.

Are we going to have those patches in 3.3-rc1 or only in 3.4 ?

--
Regards,
Sylwester
