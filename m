From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 1/8] pinctrl: sh-pfc: Implement pinconf power-source
 param for voltage switching
Date: Mon, 24 Aug 2015 10:45:49 +0200
Message-ID: <CACRpkdamQEhxGVC0r94yM=PNTSonB9NcyUgBQPTLyRm0egct+Q@mail.gmail.com>
References: <1435683177.23818.60.camel@codethink.co.uk>
	<1435683239.23818.61.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435683239.23818.61.camel@codethink.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 30, 2015 at 6:53 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:

> The pfc in the R8A7790 (and probably others in the R-Car gen 2 family)
> supports switching SDHI signals between 3.3V and 1.8V nominal voltage,
> and the SD driver should do that when switching to and from UHS modes.
>
> Add a flag for pins that have configurable I/O voltage and SoC
> operations to get and set the nominal voltage.  Implement the pinconf
> power-source parameter using these operations.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Patch applied with Laurent's ACK.

Yours,
Linus Walleij
