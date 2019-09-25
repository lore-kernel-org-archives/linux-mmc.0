From: ppvk@codeaurora.org
Subject: Re: [RFC 1/2] mmc: sdhci-msm: Add support for bus bandwidth voting
Date: Wed, 25 Sep 2019 11:54:11 +0530
Message-ID: <d10c21360d4830c864374a57c491c21c@codeaurora.org>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
 <1567774037-2344-2-git-send-email-ppvk@codeaurora.org>
 <616c7a8c-a1cf-2043-4ea4-f452ee90f083@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <616c7a8c-a1cf-2043-4ea4-f452ee90f083@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, asutoshd@codeaurora.org, vbadigan@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>, Andy Gross <agross@kernel.org>, linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2019-09-12 18:26, Georgi Djakov wrote:
> Hi Pradeep,
> 
> Thanks for the patch!
> 
> On 9/6/19 15:47, Pradeep P V K wrote:
>> Vote for the MSM bus bandwidth required by SDHC driver
>> based on the clock frequency and bus width of the card.
>> Otherwise,the system clocks may run at minimum clock speed
>> and thus affecting the performance.
>> 
>> This change is based on Georgi Djakov [RFC]
>> (https://lkml.org/lkml/2018/10/11/499)
> 
> I am just wondering whether do we really need to predefine the 
> bandwidth values
> in DT? Can't we use the computations from the above patch or is there 
> any
> problem with that approach?
> 
> Thanks,
> Georgi

Hi Georgi,

By using the direct required bandwidth(bw / 1000) values, it will not 
guarantee
that all the NOC clocks are running in the same voltage corner as 
required,
which is very crucial for power concern devices like Mobiles etc.
Also, it will not guarantee that the value passed is in proper Clock 
Plans domain
there by effecting the requested Bandwidth.
I think, you already aware of these consequences on using direct 
bandwidth values for
RPMh based devices.

The value the we passed in DT will make sure that all the NOC clocks 
between the end points
are running in the same voltage corners as required and also it will 
guarantee that
the requested BW's for the clients are obtained.

Hence the reason for passing the predefined bandwidth values in DT.

Thanks and Regards,
Pradeep
