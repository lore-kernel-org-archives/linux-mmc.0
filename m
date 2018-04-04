From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
Date: Wed, 4 Apr 2018 13:50:08 +0200
Message-ID: <CAPDyKFqOn7AfDw31DisPrXbHQqEAiNg=1=OneUa_wvCi7i1xKw@mail.gmail.com>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
 <CAG2=9p8y9bMsZ8u0gaumW9B7t3GEAhJ6ChQcE8qg_to_T7wwXg@mail.gmail.com>
 <CAPDyKFp_MYRTQmLcfkrZe+Ux9ZBZQgsAaZSzzLteVYS7sW0VCw@mail.gmail.com> <3099c108-6acc-fd54-2aa4-dc323f566291@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3099c108-6acc-fd54-2aa4-dc323f566291@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Billows Wu <billows.wu@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 4 April 2018 at 13:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 04/04/18 13:17, Ulf Hansson wrote:
>> On 4 April 2018 at 11:05, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
>>> Hi Ulf,
>>>
>>> Do you have some comments on this patch-set?
>>
>> No objections from my side of the series, however I am relying on
>> Adrian's ack before I pick any of the patches.
>
> We don't have any drivers that enable v4 mode.  Really we need that, so that
> we are supporting features that are actually in use.  Equally some evidence
> of testing would be expected.

Right, this makes perfect sense to me as well!

Kind regards
Uffe
