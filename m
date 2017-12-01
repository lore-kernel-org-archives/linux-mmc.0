From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] R-Car D3 (r8a77995) SDHI (eMMC) integration
Date: Fri, 1 Dec 2017 09:57:13 +0100
Message-ID: <CAPDyKFpiMqOqLR_X+BN1jM-ZfXKE4txtODd56aw6csU-2vd+dg@mail.gmail.com>
References: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com> <20171201082048.faekfpx4jrqs3kft@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171201082048.faekfpx4jrqs3kft@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 1 December 2017 at 09:20, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Nov 29, 2017 at 05:06:44PM +0100, Ulrich Hecht wrote:
>> Hi!
>>
>> This integrates the SDHI hardware on R-Car D3 and enables the Draak board's
>> eMMC drive.
>>
>> This revision dumps the two patches that have been applied already, fixes
>> the sdhi2_pins voltage, removes the redundant SDHI compatible string and
>> makes the internal DMAC whitelisting pattern more conservative.
>>
>> CU
>> Uli
>>
>>
>> Ulrich Hecht (2):
>>   mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
>>   arm64: dts: r8a77995: draak: enable SDHI2
>
> Hi Ulrich,
>
> what is the effect of applying patch 2/2 without patch 1/2?
> I see that 1/2 has been accepted but ideally I'd like to apply
> 2/2 to a branch without 1/2 present.

If there is a problem with that, I can take it with your ack. Just tell me.

Kind regards
Uffe
