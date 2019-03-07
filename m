From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] mmc: mmci: avoid fake busy polling
Date: Thu, 7 Mar 2019 10:39:15 +0100
Message-ID: <CACRpkdaYn0qQZZRqTrLnUc_syVROSNP0M5doM9BJNMOL5Zx0=g@mail.gmail.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
 <1551802205-32188-2-git-send-email-ludovic.Barre@st.com> <CAPDyKFo_O36=N9wM2jFnUvkga1TFjPMibr+0MRU6bLOpq7nH7g@mail.gmail.com>
 <5b531f55-b8a0-5a83-4a7c-727013a66820@st.com> <CAPDyKFp=AO27hmG9u8JHrRa3JW7RNMbxC8+vMb2y_qGo=mLWQg@mail.gmail.com>
 <15ce68e6-136f-7e9b-553c-968a0653a9b8@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15ce68e6-136f-7e9b-553c-968a0653a9b8@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic BARRE <ludovic.barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, DTML <devicetree@vger.kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 6, 2019 at 11:09 AM Ludovic BARRE <ludovic.barre@st.com> wrote:

> I could have a snowball board, I don't remember if it a ux500v1 or v2?

I think they are all v2.

> This board has been removed of u-boot mainline, do you have a specific
> repository for snowball or what branch do you advise?
> do you have a snowball wiki (up-to-date) for flashing...

I have some information here:
https://dflund.se/~triad/krad/ux500/

I'd be surprised if you don't have U-boot or fastboot on the board
already.

Yours,
Linus Walleij
