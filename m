From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Thu, 12 Apr 2012 15:16:09 +0530
Message-ID: <4F86A461.4010006@linaro.org>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com> <m2399iqtgf.fsf@bob.laptop.org> <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com> <87bonxcjrh.fsf@laptop.org> <20120405220848.GF3785@atomide.com> <87obr57rmh.fsf@laptop.org> <alpine.DEB.2.00.1204051743360.10302@utopia.booyaka.com> <87k41t7n13.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87k41t7n13.fsf@laptop.org>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 04/06/2012 05:24 AM, Chris Ball wrote:
> Hi Paul,
> 
> On Thu, Apr 05 2012, Paul Walmsley wrote:
>> I'm really sorry for the long delay!
>>
>> On Thu, 5 Apr 2012, Chris Ball wrote:
>>
>>> Thanks.  Paul, just waiting for your Signed-off-by.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> Thanks, no problem!  Pushed to mmc-next for 3.4.
> 
> - Chris.
With this patch, I continuously get following message on my console.
(Tested on Origen board, based on EXYNOS4210).

mmc0: Too large timeout requested for CMD25!

So, with this change, should we update sdhci_calc_timeout() also?

-- 
Tushar Behera
