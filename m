From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v6] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Mon, 22 Jan 2018 11:36:08 +0100
Message-ID: <CACRpkdZhQ+Vmo7c_Yq2vDBn_SJ7qLLDCiOAx_M2ScTSC1ZOoNA@mail.gmail.com>
References: <20180119145303.4097-1-linus.walleij@linaro.org>
 <OFE718A5EC.F4E3005B-ONC125821D.00225D5B-C125821D.00229F17@rittal.de>
 <CACRpkdYZMa7-F8pR8rKHKfXgqRMFknniLDr-vtQ-BW2fZLk+qw@mail.gmail.com>
 <OF64BA4616.A552893D-ONC125821D.002E9E83-C125821D.002EFBB2@rittal.de>
 <CACRpkdatPkr0Y-FvegwXMJB41nmN-KArXhwpZj0nR9f7SyyvmQ@mail.gmail.com> <OF8563613A.5338B5FD-ONC125821D.0036DEFF-C125821D.0036DF00@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <OF8563613A.5338B5FD-ONC125821D.0036DEFF-C125821D.0036DF00@rittal.de>
Sender: stable-owner@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jan 22, 2018 at 10:59 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:
>> OK that doesn't work. Scratch that patch. What about this instead?
>
> That is working.

OK so it was just my random abuse of the DMA API.
Sorry for my shitty code that of course works fine on
the DMA-coherent x86...

> I did some quick testing with time and dd again.

OK :)

I'll fold this patch into the original, tag with your Tested-by
and send out as non-RFC.

Yours,
Linus Walleij
