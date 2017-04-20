From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: MMC block addressing mode.
Date: Thu, 20 Apr 2017 16:18:30 +0200
Message-ID: <CAPDyKFqfEQ6POgoSFL=t0nP62CB13DNL0m8m-Vzqaw0GMAV3qg@mail.gmail.com>
References: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f1cbb93e-68f0-df11-5e89-7b52e00a0b79@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Steven J. Hill" <Steven.Hill@cavium.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <david.daney@cavium.com>, Jan Glauber <jan.glauber@caviumnetworks.com>
List-Id: linux-mmc@vger.kernel.org

On 13 April 2017 at 21:49, Steven J. Hill <Steven.Hill@cavium.com> wrote:
> Uffe,
>
> The Cavium hardware requires knowledge of the card addressing mode.
> We need to either restore mmc_card_blockaddr(), or create another
> way to generate the same information. You previously suggested use
> of the 'blksz' value, however, it has the same value regardless of
> the card capacity. What would you suggest? Cheers.

Right. Can you explain what the Cavium hardware need it for?

Kind regards
Uffe
