From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix wakeup configuration
Date: Fri, 3 Jun 2016 10:33:35 +0200
Message-ID: <CAPDyKFogriRL64YmO-mTCHaYg647ms7BU79scDXZ+rxQY9Jk3w@mail.gmail.com>
References: <1463145362-7773-1-git-send-email-ludovic.desroches@atmel.com>
 <573EF90B.7000109@intel.com> <CAPDyKFoqG6pYujivi6Rop4orVLViN7Feq+iB7LXkbx6zURZ=Qw@mail.gmail.com>
 <573F5768.2070708@intel.com> <20160526123009.GA6744@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160526123009.GA6744@odux.rfo.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

On 26 May 2016 at 14:30, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> On Fri, May 20, 2016 at 09:28:56PM +0300, Adrian Hunter wrote:
>> On 20/05/2016 4:39 p.m., Ulf Hansson wrote:
>> > On 20 May 2016 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> > > On 13/05/16 16:16, Ludovic Desroches wrote:
>> > > > Activating wakeup event is not enough to get a wakeup signal. The
>> > > > corresponding events have to be enabled in the Interrupt Status Enable
>> > > > Register too. It follows the specification and is needed at least by
>> > > > sdhci-of-at91.
>> > > >
>> > > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> > >
>> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> >
>> > Is this material for stable and as a fix for 4.6?
>>
>> Not as far as I know.
>>
>
> System PM code for the Atmel SDHCI has not been submitted yet so no need
> to take it as a fix.
>

Thanks, applied for next!

Kind regards
Uffe
