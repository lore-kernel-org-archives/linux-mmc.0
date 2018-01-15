From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v5] RFT: mmc: sdhci: Implement an SDHCI-specific bounce
 buffer
Date: Mon, 15 Jan 2018 12:54:37 +0200
Message-ID: <f4418b92-2c60-3208-4aa0-cae14d443b8b@intel.com>
References: <20180112141907.18203-1-linus.walleij@linaro.org>
 <OF22397E1F.A032896A-ONC1258216.00217280-C1258216.0021AD1D@rittal.de>
 <CACRpkdYN2TLfsiTxcJ-Vx0yAzQv4hQsrhOe0biofzXYhx5KRDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYN2TLfsiTxcJ-Vx0yAzQv4hQsrhOe0biofzXYhx5KRDw@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=c3=aet_Th=c3=a9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 15/01/18 11:53, Linus Walleij wrote:
> On Mon, Jan 15, 2018 at 7:07 AM, Benjamin Beckmeyer
> <beckmeyer.b@rittal.de> wrote:
> 
>> Good morning,
>>
>>> - Requesting a test of this on i.MX. (Sorry Benjamin.)
>>
>> No worries. I did another test with your v5 patch, but it doesn't work.
> 
> Wow that is weird.
> 
> So v3 works.
> 
> And it's not the code that bails out if we have nr_segs == 1
> because that code path is not taken.
> 
> It is the 64K instead of 512K buffer that makes this happen,
> then.

That might be because you are not updating max_req_size.

> I guess I just respin v3 with the change that we fall back to
> 1 segment if we can's allocate coherent memory for the
> bounce buffer.

I would like to support pre_req() and post_req().  I have some code for that
if you are interested.
