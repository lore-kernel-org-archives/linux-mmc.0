From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: Manually check card status after
 reset
Date: Tue, 6 Aug 2019 08:51:52 +0300
Message-ID: <408c03b6-720f-1211-6855-2c128a3d269d@intel.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <CAPDyKFpL1nHt1E1zgS-iDZf_KDWk2CN32Lvr+5Nmo8CtB2VCWg@mail.gmail.com>
 <20190607160553.GA185100@google.com>
 <CAPDyKFout6AY2Q92pYQ-KPH0NENq1-SkYivkDxjjb=uB=tKXuQ@mail.gmail.com>
 <20190610163252.GA227032@google.com>
 <fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com>
 <20190619145625.GA50985@google.com> <20190801151624.GA155392@google.com>
 <a9a8d3f5-d600-7c8d-8734-cf6a017849c5@intel.com>
 <20190805164917.GA93879@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805164917.GA93879@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, hongjiefang <hongjiefang@asrmicro.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

On 5/08/19 7:49 PM, Raul Rangel wrote:
> On Fri, Aug 02, 2019 at 07:58:20AM +0300, Adrian Hunter wrote:
>>
>> You seem not to have answered to my suggestion for a change to sdhci_reinit() here:
>>
>> 	https://lore.kernel.org/lkml/fcdf6cc4-2729-abe2-85c8-b0d04901c5ae@intel.com/
>>
> I thought I answered it here: https://lore.kernel.org/lkml/20190619145625.GA50985@google.com/#t
> 
> Did I miss something?

I didn't get that mail for some reason, sorry.

Please send out my patch and your second with my ack.
