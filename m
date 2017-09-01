From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
Date: Fri, 1 Sep 2017 15:18:03 +0200
Message-ID: <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
References: <E1dnO3z-0000tI-7K@debutante> <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ravikumar Kattekola <rk@ti.com>, Sekhar Nori <nsekhar@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 31 August 2017 at 15:50, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Aug 31, 2017 at 05:37:34PM +0530, Kishon Vijay Abraham I wrote:
>
>> This patch should be merged along with the 1st patch of the series "mmc: host:
>> omap_hsmmc: Remove setting PBIAS voltage". Or else it'll break MMC with
>> omap_hsmmc driver.
>
> I can sign a tag if it's needed for a cross tree merge.

Easier if you could drop it and instead just provide an ack.

Unless you believes there may conflict in your regulator tree?

Kind regards
Uffe
