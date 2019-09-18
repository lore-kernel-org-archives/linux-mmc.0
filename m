From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V9 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
Date: Wed, 18 Sep 2019 14:07:51 +0300
Message-ID: <781dc676-4903-5ab2-84d1-b5357c11dccd@intel.com>
References: <cover.1568184581.git.benchuanggli@gmail.com>
 <2d08c47490a349d7ee5682749f68604adc62f19f.1568184581.git.benchuanggli@gmail.com>
 <20190918104734.GA3320@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190918104734.GA3320@people.danlj.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael K. Johnson" <johnsonm@danlj.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "ben.chuang@genesyslogic.com.tw Ben Chuang" <benchuanggli@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 18/09/19 1:47 PM, Michael K. Johnson wrote:
> I see that the first four patches made it into Linus's kernel
> yesterday. Is there any chance of this final patch that actually
> enables the hardware making it into another pull request still
> intended for 5.4?  Waiting on additional acked-by on Ben's work
> addressing all the review comments?
> 
> Thanks.
> 
> On Wed, Sep 11, 2019 at 03:23:44PM +0800, Ben Chuang wrote:
>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>
>> Add support for the GL9750 and GL9755 chipsets.
>>
>> Enable v4 mode and wait 5ms after set 1.8V signal enable for GL9750/
>> GL9755. Fix the value of SDHCI_MAX_CURRENT register and use the vendor
>> tuning flow for GL9750.
> 

It is OK by me:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
