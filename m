From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Date: Fri, 2 Aug 2019 07:58:20 +0300
Message-ID: <a9a8d3f5-d600-7c8d-8734-cf6a017849c5@intel.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
 <20190619145625.GA50985@google.com> <20190801151624.GA155392@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801151624.GA155392@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

On 1/08/19 6:16 PM, Raul Rangel wrote:
> On Wed, Jun 19, 2019 at 08:56:25AM -0600, Raul Rangel wrote:
>> Your patch looks good. I tried it out and got over 57k insertion/removal
>> iterations. Do you want me to send out your patch, or do you want to do
>> it?
>>
>> Just to recap, the patch you proposed + the AMD SDHCI specific patch fix
>> the problem.
>>
> 
> Just pinging the thread again to see what you would prefer. I can send
> the patch with you in the Signed-off. Or if you would prefer to not
> update the sdhci driver at all, I can add the logic into the AMD
> specific patch.
> 
> I would like to get this in so it lands by 5.4.

You seem not to have answered to my suggestion for a change to sdhci_reinit() here:

	https://lore.kernel.org/lkml/fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com/
