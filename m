From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] mmc: sdhci: restore behavior when setting VDD via
 external regulator
Date: Thu, 7 Jan 2016 13:17:22 +0200
Message-ID: <568E4942.7030800@intel.com>
References: <1449840989-563-1-git-send-email-jszhang@marvell.com>
 <CAPDyKFpVqQREdiKm42cM7OxXHDpJffp3OMN6GqLAkn-gep6xOw@mail.gmail.com>
 <20151218081138.GB15968@odux.rfo.atmel.com>
 <CAPDyKFqf=L=dwjLx5G7oU0_YLE3Ow39_b2+H7z0Gu_Lh-T+3Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqf=L=dwjLx5G7oU0_YLE3Ow39_b2+H7z0Gu_Lh-T+3Dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jisheng Zhang <jszhang@marvell.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 18/12/15 11:55, Ulf Hansson wrote:
> On 18 December 2015 at 09:11, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
>> Hi Ulf, Jisheng,
>>
>> On Fri, Dec 11, 2015 at 03:48:04PM +0100, Ulf Hansson wrote:
>>> + Ludovic (We had some discussions around this code recently as well)
>>>
>>> On 11 December 2015 at 14:36, Jisheng Zhang <jszhang@marvell.com> wrote:
>>>> After commit 52221610dd84 ("mmc: sdhci: Improve external VDD regulator
>>>> support"), for the VDD is supplied via external regulators, we ignore
>>>> the code to convert a VDD voltage request into one of the standard
>>>> SDHCI voltage levels, then program it in the SDHCI_POWER_CONTROL. This
>>>> brings two issues:
>>>>
>>>> 1. SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON quirk isn't handled properly any
>>>> more.

For the record, the way it was working made more sense to me i.e. if you
have control of an external regulator then you know the power is not
disrupted by runtime suspend.

Also AFAIK Intel is the only user of SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON, so I
am surprised you listed it as an issue that you have.
