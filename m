From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v9 07/16] mmc: sdhci-msm: Add get_min_clock() and
 get_max_clock() callback
Date: Thu, 27 Apr 2017 13:29:22 +0300
Message-ID: <9650e710-3d96-51ea-3aef-2d97b07b08e0@linaro.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <1479710246-26676-8-git-send-email-riteshh@codeaurora.org>
 <20170426214443.GA32019@hector.attlocal.net>
 <CAPDyKFoHeuEpD3BmtTjsHEjz+w1dj0uD-OM3PokPpnTjNJ562A@mail.gmail.com>
 <20170427095216.GA624@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170427095216.GA624@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, jeremymc@redhat.com, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 04/27/2017 12:52 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 27, 2017 at 11:03:08AM +0200, Ulf Hansson wrote:
>> +Greg
>> -trimmed cc
>>
>> On 26 April 2017 at 23:44, Andy Gross <andy.gross@linaro.org> wrote:
>>> On Mon, Nov 21, 2016 at 12:07:17PM +0530, Ritesh Harjani wrote:
>>>> This add get_min_clock() and get_max_clock() callback
>>>> for sdhci-msm. sdhci-msm min/max clocks may be different
>>>> hence implement these callbacks.
>>>>
>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>
>>> This patch needs to be picked up for stable as 4.9 is currently broken w.r.t.
>>> MMC on Qualcomm platforms.
>>>
>>> Fixes: d84be51d1c1d ("mmc: sdhci-msm: Enable few quirks")
>>>
>>> Regards,
>>>
>>> Andy Gross
>>
>> I did a quick investigation around this.
>>
>> So for some reason Greg decided to pick up the original commit,
>> a0e3142869d2 ("mmc: sdhci-msm: Enable few quirks"), for 4.9 stable
>> [1], even if that patch wasn't sent or tagged for stable.
>> It was a mistake, as simple as that - and I should also have spotted
>> it when Greg posted his stable-review series, sorry.
>>
>> For clarification, the original commit a0e3142869d2 ("mmc: sdhci-msm:
>> Enable few quirks"), is present in 4.10 together with $subject patch.
>> So the regression is present only in 4.9 stable.
>>
>> Greg, can you pick up @subject patch for stable according to Andy's
>> suggestion or you want some of us to re-post it to stable?
> 
> Sorry about this.  What git commit should I take for this from Linus's
> tree for the 4.9-stable tree?  Or if there isn't one, I'll be glad to
> just revert this.
> 

Thanks Greg and Ulf,

A revert of d84be51d1c1d ("mmc: sdhci-msm: Enable few quirks") would be
the best solution.

The other option is to pick 80031bdeb764 ("mmc: sdhci-msm: Add
get_min_clock() and get_max_clock() callback").

BR,
Georgi
