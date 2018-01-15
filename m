From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Mon, 15 Jan 2018 10:53:10 +0100
Message-ID: <CACRpkdYN2TLfsiTxcJ-Vx0yAzQv4hQsrhOe0biofzXYhx5KRDw@mail.gmail.com>
References: <20180112141907.18203-1-linus.walleij@linaro.org> <OF22397E1F.A032896A-ONC1258216.00217280-C1258216.0021AD1D@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <OF22397E1F.A032896A-ONC1258216.00217280-C1258216.0021AD1D@rittal.de>
Sender: stable-owner@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 15, 2018 at 7:07 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

> Good morning,
>
>> - Requesting a test of this on i.MX. (Sorry Benjamin.)
>
> No worries. I did another test with your v5 patch, but it doesn't work.

Wow that is weird.

So v3 works.

And it's not the code that bails out if we have nr_segs == 1
because that code path is not taken.

It is the 64K instead of 512K buffer that makes this happen,
then.

I guess I just respin v3 with the change that we fall back to
1 segment if we can's allocate coherent memory for the
bounce buffer.

Yours,
Linus Walleij
