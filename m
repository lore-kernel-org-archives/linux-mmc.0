From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Add PLL Enable support to internal
 clock setup
Date: Thu, 15 Aug 2019 16:07:17 +0300
Message-ID: <d13043b2-8945-7fda-2e67-2da592d681dd@intel.com>
References: <20190726020746.GB12042@people.danlj.org>
 <acc74e9e-ca41-a5dd-780a-615745d70101@intel.com>
 <20190812225611.GA30758@people.danlj.org>
 <d6432410-6431-efdb-4e28-a601493e4916@intel.com>
 <20190815120432.GA20438@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815120432.GA20438@people.danlj.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael K. Johnson" <johnsonm@danlj.org>
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

On 15/08/19 3:04 PM, Michael K. Johnson wrote:
> On Thu, Aug 15, 2019 at 02:27:44PM +0300, Adrian Hunter wrote:
>> On 13/08/19 1:56 AM, Michael K. Johnson wrote:
>>> The GL9750 and GL9755 chipsets, and possibly others, require PLL Enable
>>> setup as part of the internal clock setup as described in 3.2.1 Internal
>>> Clock Setup Sequence of SD Host Controller Simplified Specification
>>> Version 4.20.  This changes the timeouts to the new specification of
>>> 150ms for each step and is documented as safe for "prior versions which
>>> do not support PLL Enable."
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
>>
>> Did you mean for this patch to be "From:" Ben Chuang because otherwise
>> "Co-developed-by" the author is redundant.
> 
> Ben wrote the code and is the primary author. I helped with some
> changes to bring it closer to normal style, so I have definitely
> been a secondary co-developer. Ben's corporate email server adds a
> generic confidentiality notice outside his control, and we were
> informed that with that header on the email the patches could not
> be accepted.  We developed it in a git repository, so that I have
> not been "tainted" by the automatic confidentiality notice, and
> at Ben's request I have posted the work. To credit me as primary
> author would be fundamentally incorrect.
> 
> Are you saying that this work cannot be accepted until Ben chooses
> an alternative email provider besides his corporate email in order
> to avoid the spurious confidentiality notice, such that he is the
> sender of the email?
> 

No, there should be a "From:" line.  Here's an example:

	https://marc.info/?l=linux-mmc&m=155966548112475&q=raw

If you had committed your changes with Ben as the author (git commit
--author) then "git format-patch" would have added the correct "From:" line.
