From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 0/2] mmc: sdhci: potentially bad behavior when using vmmc
 supply
Date: Mon, 9 Nov 2015 14:14:37 +0100
Message-ID: <20151109131437.GB15706@odux.rfo.atmel.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFrNNyUrJemgA2OHL35EqpG74_1i9bCqkVkZZZMxNGrHgw@mail.gmail.com>
 <20151109074104.GB27482@odux.rfo.atmel.com>
 <CAPDyKFpC_mKXei14mdD=AYd6YBU0R4D1R=XWpf7BTgX4JDw24w@mail.gmail.com>
 <20151109102555.GA15706@odux.rfo.atmel.com>
 <CAPDyKFqrPNPrJN=9G7MfA0hVhJMecN0DqbOxqk1J57L819Zm3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqrPNPrJN=9G7MfA0hVhJMecN0DqbOxqk1J57L819Zm3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, pierre.samat@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 09, 2015 at 11:50:50AM +0100, Ulf Hansson wrote:
> [...]
> 
> >>
> >> This doesn't seems like a case where a gpio regulator should be used
> >> and I am not sure what problem it would solve. Beside to suppress the
> >> log warnings (actually those aren't warnings but informations).
> >>
> >> Isn't sdhci_do_start_signal_voltage_switch() doing what you need here?
> >>
> >
> > It is. I am only wondering the best way to describe the hardware:
> > - No regulator but I have the 'no vqmmc regulator not found' message which
> >   is a bit annoying and which can be interpreted as an issue for someone
> >   who has no knowledge about this stuff.
> 
> Hmm, should we turn them into debug messages? Both regulators are optional.
> 

I think so. From my point of view, it is useless to indicate that
something optionnal is missing.

> > - Describe the regulator since there is one on my board. But it is not a
> >   fixed regulator and even if it's close to a gpio one it is not.
> 
> If it's driven by SDHCI internal logic, I would leave it to that.
> There are no need to describe it at all.

Ok thanks for your help.

> 
> Kind regards
> Uffe
